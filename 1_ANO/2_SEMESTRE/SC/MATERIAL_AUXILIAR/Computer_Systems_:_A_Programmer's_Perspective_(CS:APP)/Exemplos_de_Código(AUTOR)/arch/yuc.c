/* Simulate a microcoded implementation of the Y86 processor */

#include <stdio.h>
#include <stdlib.h>
#include "uc.h"
#include "isa.h"

/* Status of instruction interpreter */
/* Either initializing, part way through instruction, or done with instruction */
typedef enum { II_INIT0, II_INIT1, II_PARTIAL, II_COMPLETE } iistatus_t;

typedef struct {
  state_ptr is;
  int ao;
  int t;
  int dout;
  int di;
  unsigned char ir0;
  unsigned char ir1;
  int uptr; /* Microinstruction pointer */
  int icnt; /* How many total microinstructions have been executed */
  iistatus_t iistatus;
} ustate_rec, *ustate_ptr;

ustate_ptr new_ustate(state_ptr is)
{
  ustate_ptr result = (ustate_ptr) malloc(sizeof(ustate_rec));
  result->is = copy_state(is);
  result->ao = 0;
  result->t = 0;
  result->dout = 0;
  result->di = 0;
  result->ir0 = 0;
  result->ir1 = 0;
  result->uptr = 0;
  result->icnt = 0;
  result->iistatus = II_INIT0;
  return result;
}

void free_ustate(ustate_ptr us)
{
  free_state(us->is);
  free((void *) us);
}

/* Print name of current microstate */
char *uptr_name(ustate_ptr us)
{
  char *name;
  if (us->uptr < 0 || us->uptr >= UCNTMAX)
    return "INVALID";
  name = ucode[us->uptr].name;
  return name ? name : "INVALID";
}

/* Encode 11 different dispatch possibilities */
int dispatch(itype_t i, arg_t a) {
  if (i == I_MOVL)
    return a+7; /* 7--10 */
  if (i == I_BYTE)
    return a; /* 0-1 */
  return i;
}


/* Execute single microinstruction */
exc_t step_ustate(ustate_ptr us, FILE *error_file)
{
  int aval = 0;
  int bval = 0;
  int alub = 0;
  
  itype_t hi0 = (us->ir0 >> 4) & 0xF;
  alu_t lo0 = us->ir0 & 0xF;
  reg_id_t hi1 = (us->ir1 >> 4) & 0xF;
  reg_id_t lo1 = us->ir1 & 0xF;

  mem_t r = us->is->r;
  mem_t m = us->is->m;

  int pc = us->is->pc;
  cc_t cc = us->is->cc;

  uinstr_ptr u;

  /* Fetch the microinstruction */
  if (us->uptr < 0 || us->uptr >= UCNTMAX) {
    fprintf(error_file, "Invalid micronstruction address 0x%x\n", us->uptr);
    return EXC_INSTR;
  }
  u = ucode+us->uptr;
  /* Make sure it's a real instruction */
  if (!u->name) {
    fprintf(error_file, "Invalid micronstruction address 0x%x\n", us->uptr);
    return EXC_INSTR;
  }

  /* Get value for abus */
  switch (u->asrc) {
  case BUS_ESP:
    aval = get_reg_val(r, REG_ESP);
    break;
  case BUS_R1A:
    aval = get_reg_val(r, hi1);
    break;
  case BUS_R1B:
    aval = get_reg_val(r, lo1);
    break;
  case BUS_PC:
    aval = pc;
    break;
  case BUS_T:
    aval = us->t;
    break;
  case BUS_NONE:
    aval = 0;
    break;
  case BUS_DI:
    aval = us->di;
    break;
  case BUS_AO:
  default:
    fprintf(error_file, "UPC '%s': Invalid A source 0x%x\n", uptr_name(us), u->asrc);
    return EXC_INSTR;
  }

  /* Get value for b bus */
  switch (u->bsrc) {
  case BUS_DI:
    bval = us->di;
    break;
  case BUS_ESP:
    bval = get_reg_val(r, REG_ESP);
    break;
  case BUS_R1A:
    bval = get_reg_val(r, hi1);
    break;
  case BUS_R1B:
    bval = get_reg_val(r, lo1);
    break;
  case BUS_T:
    bval = us->t;
    break;
  case BUS_NONE:
    bval = 0;
    break;
  case BUS_PC:
  case BUS_AO:
  default:
    fprintf(error_file, "UPC '%s': Invalid B source 0x%x\n", uptr_name(us), u->bsrc);
    return EXC_INSTR;
  }

  /* Update the A destination(s) */
  switch (u->adest) {
  case AD_DO:
    us->dout = aval;
    break;
  case AD_PCAO:
    pc = us->is->pc = aval;
    /* Fall through */
  case AD_AO:
    us->ao = aval;
    break;
  case AD_NONE:
    break;
  default:
    fprintf(error_file, "UPC '%s': Invalid A destination 0x%x\n", uptr_name(us), u->adest);
    return EXC_INSTR;
  }
  
  /* Update the B destination */
  switch(u->bdest) {
  case BUS_ESP:
    set_reg_val(r, REG_ESP, bval);
    break;
  case BUS_R1A:
    set_reg_val(r, hi1, bval);
    break;
  case BUS_R1B:
    set_reg_val(r, lo1, bval);
    break;
  case BUS_PC:
    pc = us->is->pc = bval;
    break;
  case BUS_AO:
    us->ao = bval;
    break;
  case BUS_NONE:
    break;
  case BUS_T:
  case BUS_DI:
  default:
    fprintf(error_file, "UPC '%s': Invalid B destination 0x%x\n", uptr_name(us), u->bdest);
    return EXC_INSTR;
  }

  /* Check whether to update the PC from T */
  if (u->pct == PCTY) {
    pc = us->is->pc = us->t;
  }

  /* Get the 2nd alu operand */
  switch(u->alub) {
  case ALUB_B:
    alub = bval;
    break;
  case ALUB_1:
    alub = 1;
    break;
  case ALUB_2:
    alub = 2;
    break;
  case ALUB_4:
    alub = 4;
    break;
  case ALUB_M4:
    alub = -4;
    break;
  default:
    fprintf(error_file, "UPC '%s': Invalid B operand 0x%x\n", uptr_name(us), u->alub);
    return EXC_INSTR;
  }

  /* Do the ALU stuff */
  switch(u->aluop) {
  case ALU_ADD:
    us->t = compute_alu(A_ADD, aval, alub);
    break;
  case ALU_FUN:
    us->t = compute_alu(lo0, aval, alub);
    cc = us->is->cc = compute_cc(lo0, aval, bval);
    break;
  case ALU_NONE:
    break;
  default:
    fprintf(error_file, "UPC '%s': Invalid ALU operation 0x%x\n", uptr_name(us), u->aluop);
    return EXC_INSTR;
  }

  /* Do the Memory Stuff */
  switch(u->memop) {
  case MEM_READ:
    if (!get_word_val(m, us->ao, &us->di)) {
      fprintf(error_file, "UPC '%s': Invalid Read address 0x%x\n", uptr_name(us), us->ao);
      return EXC_ADDR;
    }
    break;
  case MEM_WRITE:
    if (!set_word_val(m, us->ao, us->dout)) {
      fprintf(error_file, "UPC '%s': Invalid Write address 0x%x\n", uptr_name(us), us->ao);
      return EXC_ADDR;
    }
    break;
  case MEM_IR:
    if (!get_byte_val(m, us->ao, &us->ir0)) {
      fprintf(error_file, "UPC '%s': Invalid Instruction address 0x%x\n", uptr_name(us), us->ao);
      return EXC_ADDR;
    }
    if (!get_byte_val(m, us->ao+1, &us->ir1)) {
      fprintf(error_file, "UPC '%s': Invalid Instruction address 0x%x\n", uptr_name(us), us->ao+1);
      return EXC_ADDR;
    }
    /* Update the dispatching information */
    hi0 = (us->ir0 >> 4) & 0xF;
    lo0 = us->ir0 & 0xF;

    break;
  case MEM_NONE:
    break;
  default:
    fprintf(error_file, "UPC '%s': Invalid Memory operation 0x%x\n", uptr_name(us), u->memop);
    return EXC_INSTR;
  }

  /* Now decide what to do next */
  switch(u->nextcomp) {
  case NS_NORM:
    us->uptr = u->nextdest;
    us->iistatus = II_PARTIAL;
    break;
  case NS_DISP:
    us->uptr = u->nextdest | dispatch(hi0,lo0);
    if (us->iistatus == II_INIT0)
      us->iistatus = II_INIT1;
    else
      us->iistatus = II_COMPLETE;
    break;
  case NS_BC:
    us->uptr = u->nextdest | take_branch(cc, lo0);
    us->iistatus = II_PARTIAL;
    break;
  case NS_HALT:
    us->uptr = 0;
    us->iistatus = II_COMPLETE;
    return EXC_HALT;
  default:
    fprintf(error_file, "UPC '%s': Invalid Next state computation 0x%x\n", uptr_name(us), u->nextcomp);
    return EXC_INSTR;
  }
  us->icnt ++;
  return EXC_NONE;
}

/* Have I completed a full instruction? */
static int instr_finished(ustate_ptr us, FILE *error_file)
{
  return us->iistatus == II_COMPLETE;
}

/* Use microcoded implementation to execute one ISA instruction */
/* If s provided, will check that states are consistent */
exc_t ustep_state(ustate_ptr us, state_ptr s, FILE *error_file)
{
  int lim = 10;
  exc_t exc;
  do {
    if (--lim == 0) {
      if (error_file)
	fprintf(error_file,
		"UPC '%s': Too many microcycles for one instruction\n",
		uptr_name(us));
      return EXC_INSTR;
    }
    exc = step_ustate(us, error_file);

  } while (exc == EXC_NONE && !instr_finished(us, error_file));

  if (s) {
    step_state(s, error_file);
    if (diff_state(s, us->is, NULL)) {
      if (error_file) {
	fprintf(error_file, "Discrepancy between ISA model & microcode model\n");
	diff_state(s, us->is, error_file);
      }
      return EXC_INSTR;
    }
  }

  return exc;
}


/* Simulate upto maxstep instructions using microcode */
exc_t urun(state_ptr s, int maxstep, int check, FILE *error_file)
{
  int step;
  ustate_ptr us = new_ustate(s);
  exc_t exc = EXC_NONE;

  for (step = 0; step < maxstep && exc == EXC_NONE; step++) {
    exc = ustep_state(us, check ? s : NULL, error_file);
  }
  if (error_file) {
    fprintf(error_file, "Ran %d instructions in %d microcycles\n", step, us->icnt);
  }
  free_ustate(us);
  return exc;
}

void usage(char *pname)
{
  printf("Usage: %s code_file ucode_file [max_steps]\n", pname);
  exit(0);
}

int main(int argc, char *argv[])
{
  FILE *code_file;
  int max_steps = 10000;

  state_ptr s = new_state(1024);
  mem_t saver = copy_reg(s->r);
  mem_t savem;

  exc_t e = EXC_NONE;

  if (argc < 3 || argc > 4)
    usage(argv[0]);
  code_file = fopen(argv[1], "r");
  if (!code_file) {
    fprintf(stderr, "Can't open code file '%s'\n", argv[1]);
    exit(1);
  }

  if (!load_mem(s->m, code_file, 1)) {
    printf("Exiting\n");
    return 1;
  }

  if (!read_uc(argv[2])) {
    printf("Exiting\n");
    return 1;
  }

  savem = copy_mem(s->m);
  
  if (argc > 3)
    max_steps = atoi(argv[3]);

  e = urun(s, max_steps, 1, stdout);

  printf("Stopped at PC = 0x%x.  Exception '%s', CC %s\n",
	 s->pc, exc_name(e), cc_name(s->cc));

  printf("Changes to registers:\n");
  diff_reg(saver, s->r, stdout);

  printf("\nChanges to memory:\n");
  diff_mem(savem, s->m, stdout);

  free_state(s);
  free_reg(saver);
  free_mem(savem);

  return 0;
}
