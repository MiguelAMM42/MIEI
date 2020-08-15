/* Microcode Encodings for V86 Processor */

/* A, B Src, B Dest */
typedef enum 
  { BUS_AO, BUS_DI, BUS_ESP, BUS_R1A, BUS_R1B, BUS_PC, BUS_T, BUS_NONE }
  bus_t;

/* A Dest */
typedef enum { AD_AO, AD_PCAO, AD_DO, AD_NONE } adest_t;

/* ALU B Src */
typedef enum { ALUB_B, ALUB_1, ALUB_2, ALUB_4, ALUB_M4 } alub_t;

/* Should PC be loaded from T? */
typedef enum { PCTN, PCTY } pct_t;

/* ALU Operation */
typedef enum { ALU_NONE, ALU_ADD, ALU_FUN } aluop_t; 

/* Memory operation */
typedef enum { MEM_NONE, MEM_READ, MEM_WRITE, MEM_IR } memop_t;

/* Next State computation */
typedef enum { NS_NORM, NS_HALT, NS_DISP, NS_BC } nextstate_t;

/* Declaration of a microinstruction */
typedef struct {
  char *name; /* Name of state */
  int     loc;  /* Must match position in microcode array */
  bus_t   asrc;
  bus_t   bsrc;
  adest_t adest;
  bus_t   bdest;
  pct_t   pct;
  alub_t  alub;
  aluop_t aluop;
  memop_t memop;
  nextstate_t nextcomp;  
  int     nextdest;  /* Nominal destination */
} uinstr_rec, *uinstr_ptr;

/* Maximum number of microinstructions */
#define UCNTMAX 128
extern int ucnt;
/* The microcode */
extern uinstr_rec ucode[];

/* Parser for Y86 Microcode Assembler */

extern int lineno;
extern int ucnt;

void set_pos(int);
void set_no_pos();

void assign_label(char *);
void assign_asrc(char *);
void assign_bsrc(char *);
void assign_adest(char *);
void assign_bdest(char *);
void assign_pct(char *);
void assign_alub(char *);
void assign_aluop(char *);
void assign_memop(char *);
void assign_nextop(char *);
void assign_next(char *);

void bad_line(char *);

int read_uc(char *filename);
