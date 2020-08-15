/* $Id$ */

/* ---------------------------------------------------------
 *  Author:
 *
 *  Khalil Amiri
 *  amiri+@cs.cmu.edu
 *
 *  CS213 - Fall 99 - Lab assignment 3
 * ---------------------------------------------------------
 *
 *  Modified by:
 *  Tiankai Tu
 *  tutk+@cs.cmu.edu
 *  
 *  CS213 - Fall 00 - Lab assigment 4
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <string.h>
#include <float.h>
#include <time.h>

#include "ftime.h"
#include "memlib.h"
#include "malloc.h"
#include "dump.h"

#include "tracefiles.h"

/* magic numbers */
#define SPACE_UTIL_METRIC_WEIGHT .65
#define AVG_LIBC_THROUGHPUT 150E3

/* test data structures */
typedef struct range_t {
    struct range_t *next;
    char *lo, *hi;
} range_t;

typedef struct {
    enum {ALLOC, FREE, REALLOC} type;
    long index;
    long size;
} memop_t;

typedef struct {
    int  weight;
    long num_blocks;
    long num_ops;
    long suggested_heap_size;
    memop_t *ops;
    char **blocks;
    size_t *block_sizes;
} trace_t;

typedef struct{
    double perf_index;
    double utilization;
    double throughput;
}Statistics;

/* Command-line options */
static int verbose = 1;
static int comp2libc = 0;
static double ftime_tolerance = 0.05;
static int dump = 0;
static int randomtag;

/* static functions*/
static void generate_randomtag();
static int add_range (char *lo, long size);
static void remove_range (char *lo);
static void remove_range_for_realloc(char *lo);
static void clear_ranges (void);

static trace_t *read_trace (char *filename);
static void free_trace (trace_t *trace);

static void correctness (trace_t *trace);
static void efficiency (trace_t *trace);
static void dump_write (trace_t *trace);
static void speed_funct (void);
static void speed (trace_t *ptrace);
static void libc_speed_funct (void);
static double libc_speed(trace_t *ptrace);

static void usage(void);

/*****************
 * Range routines
 *****************/

static range_t *ranges = NULL;

/* Check if a pointer is 4-byte aligned */
#define IS_ALIGNED(p)  ((((unsigned long)(p))%8) == 0)

static void generate_randomtag()
{
    int seed;

    seed = time(NULL);
    srand(seed);
    randomtag = rand()+1;
    return;
}
    
static int add_range (char *lo, long size)
{
    char *hi = lo + size - 1;
    range_t *p;

    assert(size > 0);

    /* Check alignment */
    if (!IS_ALIGNED(lo)) {
        fprintf(stderr, "Misaligned region returned\n");
        if (verbose)
            fprintf(stderr, "Address: %p\n", lo);
        return 0;
    }

    /* Region lies within heap */
    if (lo < dseg_lo || lo > dseg_hi || hi < dseg_lo || hi > dseg_hi) {
        fprintf(stderr, "Region lies outside heap area\n");
        if (verbose) {
            fprintf(stderr, "Region: %p - %p\n", lo, hi);
            fprintf(stderr, "Heap: %p - %p\n", dseg_lo, dseg_hi);
        }
        return 0;
    }

    /* Region does not overlap any other region */
    for (p = ranges;  p != NULL;  p = p->next) {
        if ((lo >= p->lo && lo <= p-> hi) ||
            (hi >= p->lo && hi <= p->hi)) {
            fprintf(stderr, "Region overlap detected\n");
            if (verbose) {
                fprintf(stderr, "Region 1: %p - %p\n", lo, hi);
                fprintf(stderr, "Region 2: %p - %p\n", p->lo, p->hi);
            }
            return 0;
        }
    }

    p = (range_t *)malloc(sizeof(range_t));
    p-> next = ranges;
    p->lo = lo;
    p->hi = hi;
    ranges = p;
    return 1;
}

static void remove_range (char *lo)
{
    range_t *p, **prevpp = &ranges;

    for (p = ranges;  p != NULL; p = p->next) {
        if (p->lo == lo) {
            int size = p->hi - p->lo + 1;

            *prevpp = p->next;
            
            /* Clobber region again (zero 
             * miswritten control records) */
            memset(p->lo,0,size);

            free(p);
            break;
        }
        prevpp = &(p->next);
    }
}


static void remove_range_for_realloc(char *lo)
{
    range_t *p, **prevpp = &ranges;

    for (p = ranges;  p != NULL; p = p->next) {
        if (p->lo == lo) {

            *prevpp = p->next;
            free(p);
            break;
        }
        prevpp = &(p->next);
    }
}

static void clear_ranges (void)
{
    range_t *p, *pnext;

    for (p = ranges;  p != NULL;  p = pnext) {
        pnext = p->next;
        free(p);
    }

    ranges = NULL;
}


/*********************
 * Tracefile routines
 *********************/

static trace_t *read_trace (char *filename)
{
    FILE *tracefile;
    trace_t *trace = (trace_t *)malloc(sizeof(trace_t));
    long num_blocks, num_ops;

    tracefile = fopen(filename, "r");
    if (tracefile != NULL) {

        char type[10];
        unsigned index, size;
        unsigned max_index = 0;
        unsigned op_index;

        fscanf(tracefile, "%ld", &(trace->suggested_heap_size));
        fscanf(tracefile, "%ld", &num_blocks);
        fscanf(tracefile, "%ld", &num_ops);
        fscanf(tracefile, "%d", &(trace->weight));
        trace->num_blocks = num_blocks;
        trace->num_ops = num_ops;

        trace->ops = (memop_t *)malloc(num_ops * sizeof(memop_t));

        trace->blocks = (char **)malloc(num_blocks * sizeof(char *));
        trace->block_sizes = (size_t *)malloc(num_blocks * sizeof(size_t));

        index = 0;
        op_index = 0;
        while (fscanf(tracefile, "%s", type) != EOF) {

            switch(type[0]) {
            case 'a':
                fscanf(tracefile, "%u %u", &index, &size);
                trace->ops[op_index].type = ALLOC;
                trace->ops[op_index].index = index;
                trace->ops[op_index].size = size;
                max_index = (index > max_index) ? index : max_index;
                break;
            case 'r':
                fscanf(tracefile, "%u %u", &index, &size);
                trace->ops[op_index].type = REALLOC;
                trace->ops[op_index].index = index;
                trace->ops[op_index].size = size;
                max_index = (index > max_index) ? index : max_index;
                break;
            case 'f':
                fscanf(tracefile, "%ud", &index);
                trace->ops[op_index].type = FREE;
                trace->ops[op_index].index = index;
                break;
            default:
                fprintf(stderr, "Bogus type character\n");
                exit(-1);
            }
            op_index++;

        }
        fclose(tracefile);

        assert(max_index == num_blocks-1);
        assert(num_ops == op_index);

        if (verbose) {
            printf("Read tracefile: %s\n", filename);
            printf("Blocks: %ld\n", num_blocks);
            printf("Operations: %ld\n", num_ops);
            printf("Weight: %d\n\n", trace->weight);
        }

        return trace;
    }

    return NULL;
}

static void free_trace (trace_t *trace)
{
    free(trace->ops);
    free(trace->blocks);
    free(trace->block_sizes);
    free(trace);
}

/********************
 * Testing functions
 ********************/

/* Test correctness */

static void correctness (trace_t *trace)
{
    long i;

    mem_reinit(0);
    clear_ranges();
    mm_init();

    for (i = 0;  i < trace->num_ops;  i++)
        switch (trace->ops[i].type) {
        case ALLOC:
          {
            int index = trace->ops[i].index;
            int size = trace->ops[i].size;

            char *p = mm_malloc(size);

            /* Test returned region (misalignment,
             * overlap, miswritten control data) */
            if (!add_range(p, size)) {
                fprintf(stderr, "Failed correctness test!\n");
                if (verbose)
                    fprintf(stderr, "Operation: %ld (out of %ld)\n", 
			    i, trace->num_ops);
                fprintf(stderr, "Please run your program under gdb.\n\n");
                exit(1);
            }

	    memset(p,(randomtag+index)&(0x7f),size);
            /* Remember region */
            trace->blocks[index] = p;
            trace->block_sizes[index] = size;
            break;
          }
        case REALLOC:
          {
            int index = trace->ops[i].index;
            int newsize = trace->ops[i].size;
	    int oldsize = trace->block_sizes[index];
	    int realchecksum=0,expectedchecksum=0;
	    int ind;

	    char *newp , *oldp;

	    oldp = trace->blocks[index];
	    
            newp = mm_realloc(oldp,newsize);

	    /* Remove old region from list*/
	    /* tricky: dependent on individual implementation
	       may wipe out something useful */
	    remove_range_for_realloc(oldp);

            if (!add_range(newp, newsize)) {
                fprintf(stderr, "Failed correctness test!\n");
                if (verbose)
                    fprintf(stderr, "Operation: %ld (out of %ld)\n", 
			    i, trace->num_ops);
                fprintf(stderr, "Please run your program under gdb.\n\n");
                exit(1);
            }
	    
	    /* fill the new gap*/
	    if (oldsize < newsize) memset(newp+oldsize,(randomtag+index)&(0x7f),(newsize-oldsize));
	    
	    for (ind = 0; ind<newsize; ind++) realchecksum += newp[ind];
	    expectedchecksum = newsize * ((randomtag+index)&(0x7f));

	    if ( realchecksum != expectedchecksum ){
	      fprintf(stderr, "Failed correctness test!\n");
	      if (verbose)
		fprintf(stderr,"Operation: %ld (out of %ld)\n",
			i, trace->num_ops);
	      fprintf(stderr, "Please run your program under gdb.\n\n");
	      exit(1);
	    }

            /* Remember region */
            trace->blocks[index] = newp;
	    trace->block_sizes[index] = newsize;
            break;
          }
        case FREE:
          {
            int index = trace->ops[i].index;
            char *block = trace->blocks[index];

            /* Remove region from list */
            remove_range(block);

            mm_free(block);


            break;
          }
        }

    printf("Correctness test passed\n\n");
}

/* Test efficiency */

/* Values calculated by efficiency();
 * too many to be a return value */
double max_utilization, min_utilization;
double overall_utilization;
long   max_total_size, memory_used;

static void efficiency (trace_t *trace)
{   
    int total_size = 0;
    long i;

    mem_reinit(0);
    clear_ranges();
    mm_init();

    /* Initialize statistics */
    max_utilization = 0.0;
    min_utilization = DBL_MAX;
    max_total_size = 0;

    for (i = 0;  i < trace->num_ops;  i++)
        switch (trace->ops[i].type) {
        case ALLOC:
          {
            int index = trace->ops[i].index;
            int size = trace->ops[i].size;
            double utilization;

            char *p = mm_malloc(size);

            /* Remember region and size */
            trace->blocks[index] = p;
            trace->block_sizes[index] = size;

            /* Keep track of current total size
             * of all allocated blocks */
            total_size += size;

            /* Update statistics */
            max_total_size = (total_size > max_total_size) ?
                             total_size : max_total_size;
            utilization = (double)total_size / (double)mem_usage();
            max_utilization = (utilization > max_utilization) ?
                              utilization : max_utilization;
            min_utilization = (utilization < min_utilization) ?
                              utilization : min_utilization;

            break;
          }
	case REALLOC:
	  {
	    int index = trace->ops[i].index;
            int newsize = trace->ops[i].size;
	    int oldsize = trace->block_sizes[index];
	    
	    char *newp, *oldp;
	    double utilization;

	    oldp = trace->blocks[index];
            newp = mm_realloc(oldp,newsize);

	    /* Remember region and size */
            trace->blocks[index] = newp;
            trace->block_sizes[index] = newsize;

            /* Keep track of current total size
             * of all allocated blocks */
            total_size += (newsize - oldsize);

            /* Update statistics */
            max_total_size = (total_size > max_total_size) ?
                             total_size : max_total_size;
            utilization = (double)total_size / (double)mem_usage();
            max_utilization = (utilization > max_utilization) ?
                              utilization : max_utilization;
            min_utilization = (utilization < min_utilization) ?
                              utilization : min_utilization;

            break;
          }
        case FREE:
          {
            int index = trace->ops[i].index;
            char *block = trace->blocks[index];
            int size = trace->block_sizes[index];

            mm_free(block);

            /* Keep track of current total size
             * of all allocated blocks */
            total_size -= size;

            /* Update statistics */

            break;
          }
        }

    memory_used = mem_usage();
    overall_utilization = (double)max_total_size / (double)memory_used;

    printf("Efficiency measurements completed\n");
    if (verbose) {
        printf("Maximum total size: %ld\n", max_total_size);
        printf("Final heap size: %ld\n", mem_usage());
        printf("Overall utilization: %6.3f%%\n", 100.0*overall_utilization);
    }
    printf("\n");
}

/* Trace creation */

static void dump_write (trace_t *trace)
{   
    long i;

    mem_reinit(0);
    clear_ranges();
    mm_init();


    for (i = 0;  i < trace->num_ops;  i++)
        switch (trace->ops[i].type) {
        case ALLOC:
          {
            int index = trace->ops[i].index;
            int size = trace->ops[i].size;

            char *p = mm_malloc(size);

            /* Remember region and size */
            trace->blocks[index] = p;
            trace->block_sizes[index] = size;

            /* Write dump entry (do after malloc, so
             * sbrk dump entry will be written */
            dump_printf("m %ld %ld\n", (long)(p - dseg_lo), (long)size);

            break;
          }
        case REALLOC:
	  {
	    int index = trace->ops[i].index;
            int newsize = trace->ops[i].size;

	    char *newp, *oldp;

	    oldp = trace->blocks[index];
            newp = mm_realloc(oldp,newsize);

            /* Remember region and size */
            trace->blocks[index] = newp;
            trace->block_sizes[index] = newsize;

            /* Write dump entry (do after realloc, so
             * sbrk dump entry will be written */
            dump_printf("r %ld %ld\n", (long)(newp - dseg_lo), (long)newsize);

            break;
          }
        case FREE:
          {
            int index = trace->ops[i].index;
            char *block = trace->blocks[index];
            int size = trace->block_sizes[index];

            mm_free(block);

            /* Write dump entry */
            dump_printf("f %ld %ld\n", (long)(block - dseg_lo), (long)size);

            break;
          }
        }

    printf("Dump written\n\n");
}

/* Time speed */

static trace_t *trace;

static void speed_funct (void)
{
    long i;

    mem_reinit(0);
    mm_init();


    for (i = 0;  i < trace->num_ops;  i++)
        switch (trace->ops[i].type) {
        case ALLOC:
          {
            int index = trace->ops[i].index;
            int size = trace->ops[i].size;

            char *p = mm_malloc(size);

            trace->blocks[index] = p;
            break;
          }
	case REALLOC:
	  {
	    int index = trace->ops[i].index;
            int newsize = trace->ops[i].size;

	    char *newp, *oldp;

	    oldp = trace->blocks[index];
            newp = mm_realloc(oldp,newsize);

            trace->blocks[index] = newp;
            break;
          }
        case FREE:
          {
            int index = trace->ops[i].index;
            char *block = trace->blocks[index];

            mm_free(block);
            break;
          }
        }
}

/* Values calculated by speed();
 * too many to be a return value */
double execution_time;
double optimal_time;

static void speed (trace_t *ptrace)
{
    trace = ptrace;
    execution_time = ftime(speed_funct, ftime_tolerance);

    printf("Timing complete\n");
    if (verbose) {
       printf("Running time: %10.3f sec (error tolerance: %.3f)\n", 
               execution_time, ftime_tolerance);
       printf("Throughput: %10.3f thousand-ops/sec\n",
	      (double)ptrace->num_ops/execution_time * 1E-3);
    }
    printf("\n");
}


static void libc_speed_funct (void)
{
    long i;


    for (i = 0;  i < trace->num_ops;  i++)
        switch (trace->ops[i].type) {
        case ALLOC:
          {
            int index = trace->ops[i].index;
            int size = trace->ops[i].size;

            char *p = malloc(size);

            trace->blocks[index] = p;
            break;
          }
	case REALLOC:
	  {
	    int index = trace->ops[i].index;
            int newsize = trace->ops[i].size;

	    char *newp, *oldp;

	    oldp = trace->blocks[index];
            newp = realloc(oldp,newsize);

            trace->blocks[index] = newp;
            break;
          }
        case FREE:
          {
            int index = trace->ops[i].index;
            char *block = trace->blocks[index];

            free(block);
            break;
          }
        }
}


static double libc_speed(trace_t *ptrace)
{
    double libc_throughput;

    trace = ptrace;

    optimal_time = ftime(libc_speed_funct, ftime_tolerance);
    libc_throughput = (double)ptrace->num_ops/optimal_time *(1E-3);

    printf("Timing complete\n");
    if (verbose) {
       printf("Running time:  %6.3f (error tolerance: %.3f)\n", 
               optimal_time, ftime_tolerance);
       printf("Throughput:  %10.3f thousand-ops/sec \n",libc_throughput); 
    }
    printf("\n");
    return libc_throughput;
}


static void usage(void) 
{
    
    fprintf(stderr, "Usage: malloc [-ffile] [-h] [-c|C] [-v|-q]");
    fprintf(stderr," [-ttolerance] [-d]\n");
    
    fprintf(stderr, "Options\n");
    fprintf(stderr, "\t -f fname: use fname as the trace file\n");
    fprintf(stderr, "\t -h: print this help message\n");
    fprintf(stderr, "\t -c: run libc malloc (in addition to your malloc)");
    fprintf(stderr,"\n\t on each trace and report stats\n");
    fprintf(stderr, "\t -C: run libc malloc only and report stats\n");
    fprintf(stderr, "\t -t tol: Specify an error tolerance for the time measurements (default:0.05)\n");
    fprintf(stderr, "\n\t on measurement errors.");
    fprintf(stderr,"\n\t -d: dump trace of your allocator (malloc/free/sbrk) to a file \n");
    fprintf(stderr, "\t -v: verbose mode\n");
    fprintf(stderr, "\t -q: quiet mode\n");
}



/*******
 * Main
 *******/

int main (int argc, char *argv[])
{
    char **fname;
    char c;
    char **tracefiles = NULL;
    int loopi;
    int num_tracefiles = 0;

    double total_time = 0;
    double total_opt_time = 0;
    double total_ops=0;
    double sum_overall_utilization =0;
    double avg_utilization, avg_throughput, avg_opt_throughput;

    /* NOTE: shall not appear in the src given to the student*/
    Statistics* stat;

    generate_randomtag();

    while ((c = getopt(argc, argv, "f:hcCvqt:d")) != EOF)
        switch (c) {
        case 'f':
            ++num_tracefiles;
            tracefiles = realloc(tracefiles, (num_tracefiles + 1)*sizeof(char *));
            tracefiles[num_tracefiles-1] = strdup(optarg);
            tracefiles[num_tracefiles] = NULL;
            break;
        case 'c':
            comp2libc = 1;
            break;
        case 'C':
            comp2libc = 2;
            break;
        case 'd':
            dump = 1;
            break;
        case 't':
            ftime_tolerance = atof(optarg);
            break;
        case 'v':
            verbose = 1;
            break;
        case 'q':
            verbose = 0;
            break;
        case 'h':
	    usage();
            exit(0);
        default:
            fprintf(stderr, "Unknown option; use -h for help\n");
            exit(1);
        }
    if (tracefiles == NULL) {
        tracefiles = default_tracefiles;
        num_tracefiles = sizeof(default_tracefiles) / sizeof(char *) - 1;
    }
    stat = (Statistics *)calloc(num_tracefiles,sizeof(Statistics));				  

    if (comp2libc <2) {
	/* Print team info */
	printf("Teamname: %s\n", team.team);
	printf("Member 1: %s\n", team.name1);
	printf("Email 1: %s\n", team.email1);
	if (*team.name2 || *team.email2) {
	    printf("Member 2: %s\n", team.name2);
	    printf("Email 2: %s\n", team.email2);
	}
	printf("\n");
	
	if (verbose)
	    printf("Running in verbose mode (use -q for quiet mode)...\n\n");
	
	/* Initialize memlib */
	
	mem_init();
    }

    /* initilize stats */
    total_opt_time = 0.0;
    loopi = 0;

    /* Perform tests */
    for (fname = tracefiles;  *fname;  fname++) {
        trace_t *trace;
	double utilization;
	double throughput;
	double p1, p2, perf_index;

        trace = read_trace(*fname);
        if (trace == NULL) {
            fprintf(stderr, "Failed to load tracefile %s\n", *fname);
            fprintf(stderr, "Will try next one...\n\n");
            --num_tracefiles;
            continue;
        }
	
	total_ops += (double) trace->num_ops;

	/* 
	   test student malloc
	*/
	if (comp2libc < 2) {
	    printf("---- Your Malloc ----------\n");
	    correctness(trace);
	    
	    efficiency(trace);
	    sum_overall_utilization += overall_utilization;
	    utilization = overall_utilization;

	    speed(trace);
	    total_time += execution_time;
	    throughput = (double)trace->num_ops/execution_time;
	    
	    p1 = SPACE_UTIL_METRIC_WEIGHT * utilization; 
	    if (throughput > AVG_LIBC_THROUGHPUT) {
	      p2 = (double)(1.0-SPACE_UTIL_METRIC_WEIGHT);
	    } 
	    else {
	      p2 = ( (double) (1.0 - SPACE_UTIL_METRIC_WEIGHT) ) * 
	          throughput/AVG_LIBC_THROUGHPUT;
	       }
	    perf_index = p1 + p2;
	    perf_index *= 100;

	    stat[loopi].perf_index = perf_index;
	    stat[loopi].utilization = utilization;
	    stat[loopi].throughput = throughput;

	    if (dump) {
	      dump_start(dump_filename(*fname));
	      dump_write(trace);
	      dump_stop();
	    }	    
	}
 
	/* 
	   test libc malloc
	*/
	if (comp2libc) {
	    printf("---- LIBC Malloc ----------\n");
	    libc_speed(trace);
	    total_opt_time += optimal_time;
	}
        free_trace(trace);
	loopi++;
    }
    printf("All tracefiles read!\n\n");

    /* 
       compute/report libc malloc stats
    */
    if (comp2libc) {

	avg_opt_throughput  = total_ops / total_opt_time;

	printf("OVERALL STATISTICS (LIBC MALLOC):\n");
	printf("---------------------------------\n");
	printf("Number of trace files: %d\n", 
	       num_tracefiles);
	printf("All correctness tests passed\n");
	printf("\n");
	printf("Time: %6.3f, total ops: %ld\n",
	       total_opt_time, (long) total_ops);
	printf("Average throughput (LIBC): %6.3f tops)\n", 
	       1E-3*avg_opt_throughput);
	printf("\n");
    }

    /* 
       compute/report student malloc stats
    */
    if (comp2libc < 2) {
        double perf_index = 0.0;
	double p1,p2;

	avg_utilization =  sum_overall_utilization / (double) num_tracefiles;
	avg_throughput  = total_ops / total_time;       

	p1 = SPACE_UTIL_METRIC_WEIGHT * avg_utilization; 
	if (avg_throughput > AVG_LIBC_THROUGHPUT) {
	  p2 = (double)(1.0-SPACE_UTIL_METRIC_WEIGHT);
	} 
	else {
	  p2 = ( (double) (1.0 - SPACE_UTIL_METRIC_WEIGHT) ) * 
	    avg_throughput/AVG_LIBC_THROUGHPUT;
	}
	perf_index = p1 + p2;
	perf_index *= 100;

	
	/* Print final statistics */
	printf("OVERALL STATISTICS (YOUR MALLOC):\n");
	printf("---------------------------------\n");
	printf("Number of trace files: %d\n", 
	       num_tracefiles);
	printf("All correctness tests passed\n");
	printf("\n");
	printf("Average overall utilization: %6.3f%%\n", 
	       100 * avg_utilization);
	printf("Time: %6.3f, total ops: %ld\n",
	       total_time, (long) total_ops);	
	printf("Average throughput: %6.3f tops\n", 
	       1E-3*avg_throughput);
	printf(">Performance index: %7.3f\n", perf_index);
	printf("[Note: Performance index is valid only if");
	printf(" you use the default trace set]\n");
	printf("goodbye!\n\n");
    } 


    exit(0);
}


