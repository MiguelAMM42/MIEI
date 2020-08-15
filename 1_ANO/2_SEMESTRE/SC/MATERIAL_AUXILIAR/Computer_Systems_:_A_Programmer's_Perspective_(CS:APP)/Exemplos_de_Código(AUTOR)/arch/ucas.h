/* Parser for Y86 Microcode Assembler */

extern int lineno;

void set_org(int);
void set_noorg();


void assign_label(char *);
void assign_asrc(char *);
void assign_bsrcl(char *);
void assign_adest(char *);
void assign_bdest(char *);
void assign_pct(char *);
void assign_alub(char *);
void assign_aluop(char *);
void assign_memop(char *);
void assign_nextop(char *);
void assign_next(char *);

