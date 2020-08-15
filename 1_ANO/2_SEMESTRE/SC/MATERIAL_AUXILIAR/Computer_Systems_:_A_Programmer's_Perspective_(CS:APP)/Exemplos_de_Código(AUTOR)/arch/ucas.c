/* A Microcode Assembler for the Y86 */

#include <stdlib.h>
#include <stdio.h>

#include "uc.h"

int lineno = 1;
static int upos = 0;
/* Am I in the middle of a contiguously allocated block? */
static int contiguous = 0;

/* Have I encountered an error? */
static int found_error = 0;

/* The microcode */
uinstr_rec ucode[UCNTMAX];
/* Create temporary storage of symbolic next state fields until
   can resolve addresses
*/
char *udest[UCNTMAX];
/* Line number on which each microinstruction occurs */
int  uline[UCNTMAX];

typedef struct{
  char *name;
  int val;
} assoc_rec, *assoc_ptr;

/* Names for the Bus fields */
static assoc_rec bus_names[] = 
{
  {"AO", BUS_AO},
  {"DI", BUS_DI},
  {"%esp", BUS_ESP},
  {"R1a", BUS_R1A},
  {"R1b", BUS_R1B},
  {"PC", BUS_PC},
  {"T", BUS_T},
  {"None", BUS_NONE},
  {NULL,0}
};

/* Names for the A Destination field */
static assoc_rec ad_names[] = 
{
  {"AO", AD_AO},
  {"PCAO", AD_PCAO},
  {"DO", AD_DO},
  {"None", AD_NONE},
  {NULL,0}
};

/* Names for the PCT field */
static assoc_rec pct_names[] =
{
  {"N", PCTN},
  {"Y", PCTY},
  {NULL,0}
};

/* Names for the ALU B input */
static assoc_rec alub_names[] = 
{
  {"B", ALUB_B},
  {"1", ALUB_1},
  {"2", ALUB_2},
  {"4", ALUB_4},
  {"-4", ALUB_M4},
  {NULL,0}
};

/* Names for the ALU Operation */
static assoc_rec aluop_names[] = 
{
  {"None", ALU_NONE},
  {"Add", ALU_ADD},
  {"Fun", ALU_FUN},
  {NULL,0}
};

/* Names for the Memory Operation */
static assoc_rec memop_names[] = 
{
  {"None", MEM_NONE},
  {"Read", MEM_READ},
  {"Write", MEM_WRITE},
  {"IR", MEM_IR},
  {NULL,0}
};

/* Names for the Next State Operation */
static assoc_rec nextop_names[] = 
{
  {"Chain", NS_NORM},
  {"Halt", NS_HALT},
  {"Disp", NS_DISP},
  {"BC", NS_BC},
  {NULL,0}
};

/* Given a name, find its value.  Return -1 when not found */
int find_assoc_val(assoc_ptr assoc, char *name)
{
  int i;
  for (i = 0; assoc[i].name; i++)
    if (!strcmp(name, assoc[i].name))
      return assoc[i].val;
  return -1;
}

/* Given a value, find its name.  Return NULL when not found */
char *find_assoc_name(assoc_ptr assoc, int val)
{
  int i;
  for (i = 0; assoc[i].name; i++)
    if (assoc[i].val == val)
      return assoc[i].name;
  return NULL;
}

static void uc_error(char *msg)
{
  fprintf(stdout, "Error line %d, pos %d, instruction %s: %s\n",
	  lineno, upos, ucode[upos].name ? ucode[upos].name : "None", msg);
  found_error = 1;
}

static void uc_initialize()
{
  int ui;
  /* Use null pointer as name to indicate unused instruction */
  for (ui = 0; ui < UCNTMAX; ui++) {
    ucode[ui].name = NULL;
    udest[ui] = NULL;
  }
  upos = 0;
  lineno = 1;
  found_error = 0;
  contiguous = 0;
}

/* Make the final pass, resolving next state names */
static void uc_finalize()
{
  int ui, uj;
  for (ui = 0; ui < UCNTMAX; ui++) {
    if (ucode[ui].name) {
      char *dest = udest[ui];
      /* Try to find microinstruction with matching label */
      int found = 0;
      lineno = uline[ui];
      for (uj = 0; uj < UCNTMAX && !found; uj++)
	if (!strcmp(dest, ucode[uj].name)) {
	  ucode[ui].nextdest = uj;
	  found = 1;
	}
      if (!found)
	uc_error("Unknown next state");
    }
  }
}

void set_pos(int p)
{
  upos = p;
  contiguous = 1;
  if (ucode[p].name)
    uc_error("Already placed instruction at this address");
}

void set_no_pos()
{
  contiguous = 0;
  for (upos = 0; upos < UCNTMAX; upos++)
    if (ucode[upos].name == NULL)
      return;
  uc_error("Overflowed microcode memory");
}

static char *save_string(char *s)
{
  char *t = (char *) malloc(strlen(s)+1);
  strcpy(t, s);
  return t;
}

void assign_label(char *name)
{
  if (ucode[upos].name)
    uc_error("Already placed instruction at this address");
  ucode[upos].name = save_string(name);
  ucode[upos].loc = upos;
}

void assign_asrc(char *name)
{
  int val = find_assoc_val(bus_names, name);
  if (val < 0)
    uc_error("Invalid A Source name");
  else
    ucode[upos].asrc = val;
}

void assign_bsrc(char *name)
{
  int val = find_assoc_val(bus_names, name);
  if (val < 0)
    uc_error("Invalid B Source name");
  else
    ucode[upos].bsrc = val;
}

void assign_adest(char *name)
{
  int val = find_assoc_val(ad_names, name);
  if (val < 0)
    uc_error("Invalid A Destination name");
  else
    ucode[upos].adest = val;
}

void assign_bdest(char *name)
{
  int val = find_assoc_val(bus_names, name);
  if (val < 0)
    uc_error("Invalid B Dest name");
  else
    ucode[upos].bdest = val;
}

void assign_pct(char *name)
{
  int val = find_assoc_val(pct_names, name);
  if (val < 0)
    uc_error("Invalid PCT");
  else
    ucode[upos].pct = val;
}

void assign_alub(char *name)
{
  int val = find_assoc_val(alub_names, name);
  if (val < 0)
    uc_error("Invalid ALU B Source name");
  else
    ucode[upos].alub = val;
}

void assign_aluop(char *name)
{
  int val = find_assoc_val(aluop_names, name);
  if (val < 0)
    uc_error("Invalid ALU Operation name");
  else
    ucode[upos].aluop = val;
}

void assign_memop(char *name)
{
  int val = find_assoc_val(memop_names, name);
  if (val < 0)
    uc_error("Invalid Memory Operation name");
  else
    ucode[upos].memop = val;
}

void assign_nextop(char *name)
{
  int val = find_assoc_val(nextop_names, name);
  if (val < 0)
    uc_error("Invalid Next State Operation name");
  else
    ucode[upos].nextcomp = val;
}

void assign_next(char *name)
{
  udest[upos] = save_string(name);
  
  /* Now find the next line */
  upos++;
  if (!contiguous) {
    for (; upos < UCNTMAX && ucode[upos].name; upos++)
      ;
  }
  if (upos >= UCNTMAX)
    uc_error("Overflowed microcode memory");
}


void bad_line(char *field)
{
  char buf[256];
  sprintf(buf, "Bad %s", field);
  uc_error(buf);
}

extern FILE *yyin;
int yylex();

int yywrap()
{
  return 1;
}


/* Read microcode from named file.  Return 1 if successful */
int read_uc(char *filename)
{
  uc_initialize();
  yyin = fopen(filename, "r");
  if (!yyin)
    uc_error("Can't open microcode file");
  yylex();
  fclose(yyin);

  uc_finalize();

  return !found_error;
}
