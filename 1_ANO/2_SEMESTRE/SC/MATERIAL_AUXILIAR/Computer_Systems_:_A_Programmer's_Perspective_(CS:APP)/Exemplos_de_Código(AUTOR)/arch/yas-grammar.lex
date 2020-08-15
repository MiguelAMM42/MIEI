/* Grammar for Y86 Assembler */
 #include "yas.h"
 int atoh(char *);

Instr         rrmovl|rmmovl|mrmovl|irmovl|addl|subl|andl|xorl|jmp|jle|jl|je|jne|jge|jg|call|ret|pushl|popl|"."byte|"."word|"."long|"."pos|"."align|halt
Letter        [a-zA-Z]
Digit         [0-9]
Ident         {Letter}({Letter}|{Digit})*
Hex           [0-9a-fA-F]
Blank         [ \t]
Newline       [\n]
Char          [^\n]
Reg           %eax|%ecx|%edx|%ebx|%esi|%edi|%esp|%ebp

%x ERR COM
%%

^{Char}*{Newline}      { save_line(yytext); REJECT;} /* Snarf input line */
#{Char}*{Newline}      {finish_line(); lineno++;}
"/*"{Char}*{Newline}   {finish_line(); lineno++;}
{Blank}*{Newline}      {finish_line(); lineno++;}


{Blank}+          ;
"$"+              ;
{Instr}           add_instr(yytext);
{Reg}             add_reg(yytext);
[-]?{Digit}+      add_num(atoi(yytext));
"0"[xX]{Hex}+     add_num(atoh(yytext));
[():,]             add_punct(*yytext);
{Ident}           add_ident(yytext);
{Char}            {; BEGIN ERR;}
<ERR>{Char}*{Newline} {fail("Invalid line"); lineno++; BEGIN 0;}
%%

int atoh(char *s)
{
  return(strtol(s, NULL, 16));
}
