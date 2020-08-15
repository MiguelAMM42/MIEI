#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include "isa.h"

/* Bytes Per Line = Block size of memory */
#define BPL 32

#define REG_CNT 8
struct {
  char *name;
  int id;
} reg_table[8] = 
{
  {"%eax",   REG_EAX},
  {"%ecx",   REG_ECX},
  {"%edx",   REG_EDX},
  {"%ebx",   REG_EBX},
  {"%esi",   REG_ESI},
  {"%edi",   REG_EDI},
  {"%esp",   REG_ESP},
  {"%ebp",   REG_EBP}
};

reg_id_t find_register(char *name)
{
  int i;
  for (i = 0; i < REG_CNT; i++)
    if (!strcmp(name, reg_table[i].name))
      return reg_table[i].id;
  return 0xF;
}

char *reg_name(reg_id_t id)
{
  return reg_table[id].name;
}

#define HPACK(hi,lo) ((((hi)&0xF)<<4)|((lo)&0xF))

instr_t instruction_set[] = 
{
  {"rrmovl", HPACK(I_MOVL, MV_RR), 2, R_ARG, 1, 1, R_ARG, 1, 0 },
  /* arg1hi indicates number of bytes */
  {"irmovl", HPACK(I_MOVL, MV_IR), 6, I_ARG, 2, 4, R_ARG, 1, 0 },
  {"rmmovl", HPACK(I_MOVL, MV_RM), 6, R_ARG, 1, 1, M_ARG, 1, 0 },
  {"mrmovl", HPACK(I_MOVL, MV_MR), 6, M_ARG, 1, 0, R_ARG, 1, 1 },
  {"addl",   HPACK(I_ALU, A_ADD), 2, R_ARG, 1, 1, R_ARG, 1, 0 },
  {"subl",   HPACK(I_ALU, A_SUB), 2, R_ARG, 1, 1, R_ARG, 1, 0 },
  {"andl",   HPACK(I_ALU, A_AND), 2, R_ARG, 1, 1, R_ARG, 1, 0 },
  {"xorl",   HPACK(I_ALU, A_XOR), 2, R_ARG, 1, 1, R_ARG, 1, 0 },
  /* arg1hi indicates number of bytes */
  {"jmp",    HPACK(I_JMP, J_YES), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"jle",    HPACK(I_JMP, J_LE), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"jl",     HPACK(I_JMP, J_L), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"je",     HPACK(I_JMP, J_E), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"jne",    HPACK(I_JMP, J_NE), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"jge",    HPACK(I_JMP, J_GE), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"jg",     HPACK(I_JMP, J_G), 6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"call",   HPACK(I_CALL, 0),    6, I_ARG, 2, 4, NO_ARG, 0, 0 },
  {"ret",    HPACK(I_BYTE, BY_RET), 1, NO_ARG, 0, 0, NO_ARG, 0, 0 },
  {"pushl",  HPACK(I_PUSHL, 0) , 2, R_ARG, 1, 0, NO_ARG, 0, 0 },
  {"popl",   HPACK(I_POPL, 0) ,  2, R_ARG, 1, 0, NO_ARG, 0, 0 },
  {"halt",   HPACK(I_BYTE, BY_HALT), 1, NO_ARG, 0, 0, NO_ARG, 0, 0 },
  /* For allocation instructions, arg1hi indicates number of bytes */
  {".byte",  0x00, 1, I_ARG, 0, 1, NO_ARG, 0, 0 },
  {".word",  0x00, 2, I_ARG, 0, 2, NO_ARG, 0, 0 },
  {".long",  0x00, 4, I_ARG, 0, 4, NO_ARG, 0, 0 },
  {NULL,     0   , 0, NO_ARG, 0, 0, NO_ARG, 0, 0 }
};

instr_t invalid_instr =
  {"XXX",     0   , 0, NO_ARG, 0, 0, NO_ARG, 0, 0 };

instr_ptr find_instr(char *name)
{
  int i;
  for (i = 0; instruction_set[i].name; i++)
    if (strcmp(instruction_set[i].name,name) == 0)
      return &instruction_set[i];
  return NULL;
}

instr_ptr bad_instr()
{
  return &invalid_instr;
}


mem_t init_mem(int cnt)
{
  mem_t result = (mem_t) malloc(sizeof(mem_rec));
  cnt = ((cnt+BPL-1)/BPL)*BPL;
  result->len = cnt;
  result->contents = (data_t *) calloc(cnt, 1);
  return result;
}

void free_mem(mem_t m)
{
  free((void *) m->contents);
  free((void *) m);
}

mem_t copy_mem(mem_t oldm)
{
  mem_t newm = init_mem(oldm->len);
  memcpy(newm->contents, oldm->contents, oldm->len);
  return newm;
}

int diff_mem(mem_t oldm, mem_t newm, FILE *outfile)
{
  int pos;
  int cnt = oldm->len;
  int diff = 0;
  if (newm->len < cnt)
    cnt = newm->len;
  for (pos = 0; pos < cnt; pos += 4) {
    int ov, nv;
    get_word_val(oldm, pos, &ov);
    get_word_val(newm, pos, &nv);
    if (nv != ov) {
      diff = 1;
      if (outfile)
	fprintf(outfile, "0x%.4x:\t0x%.8x\t0x%.8x\n", pos, ov, nv);
    }
  }
  return diff;
}

int hex2dig(char c)
{
  if (isdigit(c))
    return c - '0';
  if (isupper(c))
    return c - 'A' + 10;
  else
    return c - 'a' + 10;
}

#define LINELEN 4096
int load_mem(mem_t m, FILE *infile, int report_error)
{
  /* Read contents of .vo file */
  char buf[LINELEN];
  char c, ch, cl;
  int lineno = 0;
  int bytepos = 0;
  while (fgets(buf, LINELEN, infile)) {
    int cpos = 0;
    lineno++;
    /* Skip white space */
    while (isspace(buf[cpos]))
      cpos++;

    if (buf[cpos] != '0' ||
	(buf[cpos+1] != 'x' && buf[cpos+1] != 'X'))
      continue; /* Skip this line */      
    cpos+=2;

    /* Get address */
    bytepos = 0;
    while (isxdigit((c=buf[cpos]))) {
      cpos++;
      bytepos = bytepos*16 + hex2dig(c);
    }

    while (isspace(buf[cpos]))
      cpos++;

    if (buf[cpos++] != ':') {
      if (report_error) {
	fprintf(stderr, "Error reading file. Expected colon\n");
	fprintf(stderr, "Line %d:%s\n", lineno, buf);
	fprintf(stderr, "Reading '%c' at position %d\n", buf[cpos], cpos);
      }
      return 0;
    }

    while (isspace(buf[cpos]))
      cpos++;

    /* Get code */
    while (isxdigit((ch=buf[cpos++])) && isxdigit((cl=buf[cpos++]))) {
      int byte = 0;
      if (bytepos >= m->len) {
	if (report_error) {
	  fprintf(stderr, "Error reading file. Invalid address. 0x%x\n",
		  bytepos);
	  fprintf(stderr, "Line %d:%s\n", lineno, buf);
	}
	return 0;
      }
      byte = hex2dig(ch)*16+hex2dig(cl);
      m->contents[bytepos++] = byte;
    }
  }
  return 1;
}

int get_byte_val(mem_t m, int pos, data_t *dest)
{
  if (pos < 0 || pos >= m->len)
    return 0;
  *dest = m->contents[pos];
  return 1;
}

int get_word_val(mem_t m, int pos, int *dest)
{
  int i, val;
  if (pos < 0 || pos + 4 > m->len)
    return 0;
  val = 0;
  for (i = 0; i < 4; i++)
    val = val | m->contents[pos+i]<<(8*i);
  *dest = val;
  return 1;
}

int set_byte_val(mem_t m, int pos, data_t val)
{
  if (pos < 0 || pos >= m->len)
    return 0;
  m->contents[pos] = val;
  return 1;
}

int set_word_val(mem_t m, int pos, int val)
{
  int i;
  if (pos < 0 || pos + 4 > m->len)
    return 0;
  for (i = 0; i < 4; i++) {
    m->contents[pos+i] = val & 0xFF;
    val >>= 8;
  }
  return 1;
}

void dump_memory(FILE *outfile, mem_t m, int pos, int cnt)
{
  int i, j;
  while (pos % BPL) {
    pos --;
    cnt ++;
  }

  cnt = ((cnt+BPL-1)/BPL)*BPL;

  if (pos+cnt > m->len)
    cnt = m->len-pos;

  for (i = 0; i < cnt; i+=BPL) {
    int val = 0;
    fprintf(outfile, "0x%.4x:", pos+i);
    for (j = 0; j < BPL; j+= 4) {
      get_word_val(m, pos+i+j, &val);
      fprintf(outfile, " %.8x", val);
    }
  }
}


mem_t init_reg()
{
  return init_mem(32);
}

void free_reg(mem_t r)
{
  free_mem(r);
}

mem_t copy_reg(mem_t oldr)
{
  return copy_mem(oldr);
}

int diff_reg(mem_t oldr, mem_t newr, FILE *outfile)
{
  int pos;
  int cnt = oldr->len;
  int diff = 0;
  if (newr->len < cnt)
    cnt = newr->len;
  for (pos = 0; pos < cnt; pos += 4) {
    int ov, nv;
    get_word_val(oldr, pos, &ov);
    get_word_val(newr, pos, &nv);
    if (nv != ov) {
      diff = 1;
      if (outfile)
	fprintf(outfile, "%s:\t0x%.8x\t0x%.8x\n",
		reg_table[pos/4].name, ov, nv);
    }
  }
  return diff;
}

int get_reg_val(mem_t r, reg_id_t id)
{
  int val;
  if (id == 0xF)
    return 0;
  get_word_val(r,id*4, &val);
  return val;
}

void set_reg_val(mem_t r, reg_id_t id, int val)
{
  if (id != 0xF)
    set_word_val(r,id*4,val);
}
     
void dump_reg(FILE *outfile, mem_t r) {
  reg_id_t id;
  for (id = 0; id < 8; id++) {
    fprintf(outfile, "   %s  ", reg_table[id].name);
  }
  fprintf(outfile, "\n");
  for (id = 0; id < 8; id++) {
    int val;
    get_word_val(r, id*4, &val);
    fprintf(outfile, " %x", val);
  }
  fprintf(outfile, "\n");
}

int compute_alu(alu_t op, int argA, int argB)
{
  int val = 0;
  switch(op) {
  case A_ADD:
    val = argA+argB;
    break;
  case A_SUB:
    val = argB-argA;
    break;
  case A_AND:
    val = argA&argB;
    break;
  case A_XOR:
    val = argA^argB;
  default:
    val = 0;
  }
  return val;
}

cc_t compute_cc(alu_t op, int argA, int argB)
{
  int val = compute_alu(op, argA, argB);
  int zero = (val == 0);
  int sign = (val < 0);
  int ovf;
  switch(op) {
  case A_ADD:
    ovf = (argA < 0 == argB < 0) && (val < 0 != argA < 0);
    break;
  case A_SUB:
    ovf = (argA > 0 == argB < 0) && (val < 0 != argB < 0);
    break;
  case A_AND:
  case A_XOR:
    ovf = 0;
    break;
  default:
    ovf = 0;
  }
  return PACK_CC(zero,sign,ovf);
    
}

char *cc_names[8] = {
"NZ NS NO",
"NZ NS  O",
"NZ  S NO",
"NZ  S  O",
" Z NS NO",
" Z NS  O",
" Z  S NO",
" Z  S  O"};

char *cc_name(cc_t c)
{
  int ci = c;
  if (ci < 0 || ci > 7)
    return "????????";
  else
    return cc_names[c];
}

/* Exception types */

char *exc_names[] = {"None", "Halt", "Address", "Instruction"};

char *exc_name(exc_t e)
{
  if (e < 0 || e > EXC_INSTR)
    return "Invalid Exception";
  return exc_names[e];
}

/**************** Implementation of ISA model ************************/

state_ptr new_state(int memcnt)
{
  state_ptr result = (state_ptr) malloc(sizeof(state_rec));
  result->pc = 0;
  result->r = init_reg();
  result->m = init_mem(memcnt);
  result->cc = 0;
  return result;
}

void free_state(state_ptr s)
{
  free_reg(s->r);
  free_mem(s->m);
  free((void *) s);
}

state_ptr copy_state(state_ptr s) {
  state_ptr result = (state_ptr) malloc(sizeof(state_rec));
  result->pc = s->pc;
  result->r = copy_reg(s->r);
  result->m = copy_mem(s->m);
  result->cc = s->cc;
  return result;
}

int diff_state(state_ptr olds, state_ptr news, FILE *outfile) {
  int diff = 0;

  if (olds->pc != news->pc) {
    diff = 1;
    if (outfile) {
      fprintf(outfile, "pc:\t0x%.8x\t0x%.8x\n", olds->pc, news->pc);
    }
  }
  if (olds->cc != news->cc) {
    diff = 1;
    if (outfile) {
      fprintf(outfile, "cc:\t%s\t%s\n", cc_name(olds->cc), cc_name(news->cc));
    }
  }
  if (diff_reg(olds->r, news->r, outfile))
    diff = 1;
  if (diff_mem(olds->m, news->m, outfile))
    diff = 1;
  return diff;
}


/* Branch logic */
int take_branch(cc_t cc, int bcond) {
  int zf = GET_ZF(cc);
  int sf = GET_SF(cc);
  int of = GET_OF(cc);
  int jump = 0;
    
  switch((jump_t) bcond) {
  case J_YES:
    jump = 1;
    break;
  case J_LE:
    jump = (sf^of)|zf;
    break;
  case J_L:
    jump = sf^of;
    break;
  case J_E:
    jump = zf;
    break;
  case J_NE:
    jump = zf^1;
    break;
  case J_GE:
    jump = sf^of^1;
    break;
  case J_G:
    jump = (sf^of^1)&(zf^1);
    break;
  default:
    jump = 0;
    break;
  }
  return jump;
}


/* Execute single instruction.  Return exception condition. */
exc_t step_state(state_ptr s, FILE *error_file)
{
  int argA, argB;
  data_t byte0 = 0;
  data_t byte1 = 0;
  itype_t hi0;
  alu_t  lo0;
  reg_id_t hi1, lo1;
  int val, dval;
  int okd = 1;
  int ok1 = 1;

  if (!get_byte_val(s->m, s->pc, &byte0)) {
    if (error_file)
      fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc);
    return EXC_ADDR;
  }

  hi0 = (byte0>>4)&0xF;
  lo0 = byte0&0xF;

  ok1 = get_byte_val(s->m, s->pc+1, &byte1);

  hi1 = (byte1>>4)&0xF;
  lo1 = byte1&0xF;

  switch (hi0) {
  case I_BYTE:
    s->pc+=1;
    switch ((byte_t) lo0) {
    case BY_HALT:
      return EXC_HALT;
      break;
    case BY_RET:
      /* Return Instruction.  Pop address from stack */
      dval = get_reg_val(s->r, REG_ESP);
      if (!get_word_val(s->m, dval, &val)) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid stack address 0x%x\n", s->pc, dval);
	return EXC_ADDR;
      }
      set_reg_val(s->r, REG_ESP, dval + 4);
      s->pc = val;
      break;
    default:
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction 0x%.2x\n", s->pc, byte0);
      return EXC_INSTR;
    }
    break;
  case I_MOVL:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc += 2;
    okd = get_word_val(s->m, s->pc, &dval);
    switch((move_t) lo0) {
      int val;
    case MV_RR:
      if (hi1 >= 8) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, hi1);
	return EXC_INSTR;
      }
      if (lo1 >= 8) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, lo1);
	return EXC_INSTR;
      }
      val = get_reg_val(s->r, hi1);
      set_reg_val(s->r, lo1, val);
      break;
    case MV_IR:
      if (!okd) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid instruction address", s->pc);
	return EXC_INSTR;
      }
      s->pc += 4;
      val = 0;
      if (lo1 >= 8) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, lo1);
	return EXC_INSTR;
      }
      set_reg_val(s->r, lo1, dval);
      break;
    case MV_RM:
      if (!okd) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc);
	return EXC_INSTR;
      }
      s->pc += 4;
      if (hi1 >= 8) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, hi1);
	return EXC_INSTR;
      }
      if (lo1 < 8) 
	dval += get_reg_val(s->r, lo1);
      val = get_reg_val(s->r, hi1);
      if (!set_word_val(s->m, dval, val)) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid data address 0x%x\n", s->pc, dval);
	return EXC_ADDR;
      }
      break;
    case MV_MR:
      if (!okd) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid instruction addres\n", s->pc);
	return EXC_INSTR;
      }
      s->pc += 4;
      if (hi1 >= 8) {
	if (error_file)
	  fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, hi1);
	return EXC_INSTR;
      }
      if (lo1 < 8) 
	dval += get_reg_val(s->r, lo1);
      if (!get_word_val(s->m, dval, &val))
	return EXC_ADDR;
      set_reg_val(s->r, hi1, val);
      break;
    default:
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction 0x%.2x\n", s->pc, byte0);
      return EXC_INSTR;
      break;
    }
    break;

  case I_ALU:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc+=2;
    argA = get_reg_val(s->r, hi1);
    argB = get_reg_val(s->r, lo1);
    val = compute_alu(lo0, argA, argB);
    set_reg_val(s->r, lo1, val);
    s->cc = compute_cc(lo0, argA, argB);
    break;

  case I_JMP:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc+=2;
    if (!get_word_val(s->m, s->pc, &dval)) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc);
      return EXC_ADDR;
    }
    if (take_branch(s->cc, lo0))
      s->pc = dval;
    else
      s->pc+=4;
    break;
  case I_CALL:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc+=2;
    if (!get_word_val(s->m, s->pc, &dval)) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc);
      return EXC_ADDR;
    }
    s->pc+=4;
    val = get_reg_val(s->r, REG_ESP) - 4;
    set_reg_val(s->r, REG_ESP, val);
    if (!set_word_val(s->m, val, s->pc)) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid stack address 0x%x\n", s->pc, val);
      return EXC_ADDR;
    }
    s->pc = dval;
    break;
  case I_PUSHL:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc+=2;
    if (lo1 >= 8) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, lo1);
      return EXC_INSTR;
    }
    val = get_reg_val(s->r, lo1);
    dval = get_reg_val(s->r, REG_ESP) - 4;
    set_reg_val(s->r, REG_ESP, dval);
    if  (!set_word_val(s->m, dval, val)) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid stack address 0x%x\n", s->pc, dval);
      return EXC_ADDR;
    }
    break;
  case I_POPL:
    if (!ok1) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid instruction address\n", s->pc+1);
      return EXC_ADDR;
    }
    s->pc+=2;
    if (lo1 >= 8) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid register ID 0x%.1x\n", s->pc, lo1);
      return EXC_INSTR;
    }
    dval = get_reg_val(s->r, REG_ESP);
    set_reg_val(s->r, REG_ESP, dval+4);
    if (!get_word_val(s->m, dval, &val)) {
      if (error_file)
	fprintf(error_file, "PC = 0x%x, Invalid stack address 0x%x\n", s->pc, dval);
      return EXC_ADDR;
    }
    set_reg_val(s->r, lo1, val);
    break;
  default:
    if (error_file)
      fprintf(error_file, "PC = 0x%x, Invalid instruction %.2x\n", s->pc, byte0);
    return EXC_INSTR;
  }
  return EXC_NONE;
}
