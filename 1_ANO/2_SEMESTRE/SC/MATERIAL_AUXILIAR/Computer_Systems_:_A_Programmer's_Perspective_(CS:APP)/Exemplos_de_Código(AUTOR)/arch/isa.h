/* Instruction Set definition for V86 Architecture */

/**************** Registers *************************/
typedef enum { REG_EAX, REG_ECX, REG_EDX, REG_EBX,
	       REG_ESI, REG_EDI, REG_ESP, REG_EBP } reg_id_t;

/* Find register ID given its name */
reg_id_t find_register(char *name);
/* Return name of register given its ID */
char *reg_name(reg_id_t id);

/**************** Instruction Encoding **************/

/* Different argument types */
typedef enum { R_ARG, M_ARG, I_ARG, NO_ARG } arg_t;

/* Different instruction types */
typedef enum { I_BYTE, I_MOVL, I_ALU, I_JMP, I_CALL, I_PUSHL, I_POPL } itype_t;

/* Different 1 byte instructions */
typedef enum { BY_HALT, BY_RET } byte_t; 

/* Different move types */
typedef enum { MV_RR, MV_IR, MV_RM, MV_MR } move_t;

/* Different ALU operations */
typedef enum { A_ADD, A_SUB, A_AND, A_XOR } alu_t;

/* Different Jump conditions */
typedef enum { J_YES, J_LE, J_L, J_E, J_NE, J_GE, J_G } jump_t;


/* Table used to encode information about instructions */
typedef struct {
  char *name;
  char code; /* Byte code for instruction+op */
  int bytes;
  arg_t arg1;
  int arg1pos;
  int arg1hi;  /* 0/1 for register argument, # bytes for allocation */
  arg_t arg2;
  int arg2pos;
  int arg2hi;  /* 0/1 */
} instr_t, *instr_ptr;

instr_ptr find_instr(char *name);

/* Return invalid instruction for error handling purposes */
instr_ptr bad_instr();

/***********  Implementation of Memory *****************/
typedef unsigned char data_t;

/* Represent a memory as an array of bytes */
typedef struct {
  int len;
  int maxaddr;
  data_t *contents;
  } mem_rec, *mem_t;

/* Create a memory with cnt bytes */
mem_t init_mem(int cnt);
void free_mem(mem_t m);

/* Make a copy of a memory */
mem_t copy_mem(mem_t oldm);
/* Print the differences between two memories */
int diff_mem(mem_t oldm, mem_t newm, FILE *outfile);


/*** In the following functions, a return value of 1 means success ***/

/* Load memory from .vo file */
int load_mem(mem_t m, FILE *infile, int report_error);

/* Get byte from memory */
int get_byte_val(mem_t m, int pos, data_t *dest);

/* Get 4 bytes from memory */
int get_word_val(mem_t m, int pos, int *dest);

/* Set byte in memory */
int set_byte_val(mem_t m, int pos, data_t val);

/* Set 4 bytes in memory */
int set_word_val(mem_t m, int pos, int val);

/* Print contents of memory */
void dump_memory(FILE *outfile, mem_t m, int pos, int cnt);

/********** Implementation of Register File *************/

mem_t init_reg();
void free_reg();

/* Make a copy of a register file */
mem_t copy_reg(mem_t oldr);
/* Print the differences between two register files */
int diff_reg(mem_t oldr, mem_t newr, FILE *outfile);


int get_reg_val(mem_t r, reg_id_t id);
void set_reg_val(mem_t r, reg_id_t id, int val);
void dump_reg(FILE *outfile, mem_t r);



/* ****************  ALU Function **********************/

/* Compute ALU operation */
int compute_alu(alu_t op, int arg1, int arg2);

typedef unsigned char cc_t;

#define GET_ZF(cc) (((cc) >> 2)&0x1)
#define GET_SF(cc) (((cc) >> 1)&0x1)
#define GET_OF(cc) (((cc) >> 0)&0x1)

#define PACK_CC(z,s,o) (((z)<<2)|((s)<<1)|((o)<<0))

/* Compute condition code.  */
cc_t compute_cc(alu_t op, int arg1, int arg2);

/* Generated printed form of condition code */
char *cc_name(cc_t c);

/* **************** Exception types *******************/

typedef enum {EXC_NONE, EXC_HALT, EXC_ADDR, EXC_INSTR} exc_t;

/* Describe Exception Condition */
char *exc_name(exc_t e);

/* **************** ISA level implementation *********/

typedef struct {
  int pc;
  mem_t r;
  mem_t m;
  cc_t cc;
} state_rec, *state_ptr;

state_ptr new_state(int memcnt);
void free_state(state_ptr s);

state_ptr copy_state(state_ptr s);
int diff_state(state_ptr olds, state_ptr news, FILE *outfile);

/* Determine if branch should be taken */
int take_branch(cc_t cc, int bcond);

/* Execute single instruction.  Return exception condition. */
exc_t step_state(state_ptr s, FILE *error_file);

