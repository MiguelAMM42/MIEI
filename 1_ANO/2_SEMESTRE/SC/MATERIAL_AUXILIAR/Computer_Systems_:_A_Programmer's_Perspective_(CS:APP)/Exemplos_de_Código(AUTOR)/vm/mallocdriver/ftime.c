/* Utility for timing function evaluations */

#include <stdio.h>
#include <sys/time.h>
#include <limits.h>

#include "ftime.h"

/* Detect whether running on Alpha */
#ifdef __alpha
#define IS_ALPHA 1
#else
#define IS_ALPHA 0
#endif

/* Do I want clock speed info? */
#define VERBOSE !IS_ALPHA

#define MAX_ETIME 86400   

#define DYNAMIC_ACCURACY 1

/* 
 * Timing routines
 */

#if DYNAMIC_ACCURACY > 0

/* static variable that holds the initial value of the interval timer */
static struct itimerval first_u; /* user time */
static struct itimerval first_r; /* real time */
static struct itimerval first_p; /* prof time*/

/* init the timer */
static void init_etime(void)
{
    first_u.it_interval.tv_sec = 0;
    first_u.it_interval.tv_usec = 0;
    first_u.it_value.tv_sec = MAX_ETIME;
    first_u.it_value.tv_usec = 0;
    setitimer(ITIMER_VIRTUAL, &first_u, NULL);

    first_r.it_interval.tv_sec = 0;
    first_r.it_interval.tv_usec = 0;
    first_r.it_value.tv_sec = MAX_ETIME;
    first_r.it_value.tv_usec = 0;
    setitimer(ITIMER_REAL, &first_r, NULL);
   
    first_p.it_interval.tv_sec = 0;
    first_p.it_interval.tv_usec = 0;
    first_p.it_value.tv_sec = MAX_ETIME;
    first_p.it_value.tv_usec = 0;
    setitimer(ITIMER_PROF, &first_p, NULL);
}

/* return elapsed real seconds since call to init_etime */
static double get_etime(void) {
    struct itimerval v_curr;
    struct itimerval r_curr;
    struct itimerval p_curr;

    getitimer(ITIMER_VIRTUAL, &v_curr);
    getitimer(ITIMER_REAL,&r_curr);
    getitimer(ITIMER_PROF,&p_curr);

    return (double) ((first_p.it_value.tv_sec - r_curr.it_value.tv_sec) +
		     (first_p.it_value.tv_usec - r_curr.it_value.tv_usec)*1e-6);
}


/* Need to compute value of timer delay */
static double delta_t = 0.0;

double ftime_default(test_funct P, double E)
{
  int cnt = 1;
  double tmin;
  double tmeas = 0.0;

  /* Make sure timer interval has been computed */
  if (delta_t == 0.0) {
    double start;
    init_etime();
    start = get_etime();
    while ((delta_t = get_etime() - start) <= 1e-6)
      ;
  }

  tmin = delta_t / E + delta_t;


  while (tmeas < tmin) {
    int c = cnt;
    double start = get_etime();
    while (c-- > 0) {
      P();
    }
    tmeas = get_etime() - start;
    if (tmeas < tmin)
      cnt += cnt;
  }
  return tmeas / cnt;
}

#else /* DYNAMIC_ACCURACY > 0 */

/* Quicker and less accurate timing version. Uses fixed repeat count
   and uses gettimeofday. On Linux it is accurate to the microsecond
   thanks to an implementation using the Pentium cycle counters */

#define REP_COUNT 10

double ftime_default(test_funct P, double E)
{
    int cnt = REP_COUNT;
    struct timeval stv, etv;
    double diff;

    gettimeofday(&stv, NULL);
    while (cnt) {
	P();
	cnt--;
    }
    gettimeofday(&etv,NULL);
    diff = 1E3*(etv.tv_sec - stv.tv_sec) + 1E-3*(etv.tv_usec-stv.tv_usec);
    diff /= REP_COUNT;
    return (1E-3*diff);
}

#endif /* DYNAMIC_ACCURACY > 0 */




