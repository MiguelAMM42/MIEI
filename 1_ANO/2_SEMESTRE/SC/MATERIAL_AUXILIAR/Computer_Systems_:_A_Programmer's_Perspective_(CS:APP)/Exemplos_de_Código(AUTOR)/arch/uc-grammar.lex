/* Lex File for Y86 Microcode Assembler */

 #include "uc.h"
 static char *uc_field;


Asrc          DI|R1a|R1b|%esp|PC|T|None
Bsrc          DI|R1a|R1b|%esp|T|None
Adest         DO|PCAO|AO|None
Bdest         R1a|R1b|PC|%esp|AO|None
PCT           Y|N
Alub          B|1|2|4|-4
Aluop         Fun|Add|None
Memop         Read|Write|IR|None
Nextop        Chain|Disp|BC|Halt
Pos           "."pos

Letter        [a-zA-Z]
Digit         [0-9]
Ident         {Letter}({Letter}|{Digit})*
Blank         [ \t]
Newline       [\n]
Char          [^\n]

/* General Format:
   Label Asrc Bsrc Adest Bdest PCT Alub Aluop Memop Nextop Next
*/
%x ERR S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 POS
%%

^{Blank}*#{Char}*{Newline}  {lineno++;}
^{Blank}*{Newline}          { lineno++;}

^{Blank}*{Pos}{Blank}*      {; BEGIN POS;}
<POS>{Digit}+               { set_pos(atol(yytext)); BEGIN S12;}
<POS>None                   { set_no_pos(); BEGIN S12;}
<POS>Char                   {; BEGIN ERR;}

^{Blank}+                   { ; BEGIN S1;}
^{Ident}                    { assign_label(yytext); BEGIN S2;}
<S1>{Ident}                 { assign_label(yytext); BEGIN S2;}
<S1>{Char}                  {uc_field = "Label" ; BEGIN ERR;}

<S2>{Blank}+               ;
<S2>{Asrc}                 { assign_asrc(yytext); BEGIN S3;}
<S2>{Char}                 { uc_field = "A Source"; BEGIN ERR;}

<S3>{Blank}+               ;
<S3>{Bsrc}                 { assign_bsrc(yytext); BEGIN S4;}
<S3>{Char}                 {uc_field = "B Source"; BEGIN ERR;}

<S4>{Blank}+                ;
<S4>{Adest}                 { assign_adest(yytext); BEGIN S5;}
<S4>{Char}                  {uc_field = "A Dest"; BEGIN ERR;}

<S5>{Blank}+                ;
<S5>{Bdest}                 { assign_bdest(yytext); BEGIN S6;}
<S5>{Char}                  {uc_field = "B Dest"; BEGIN ERR;}

<S6>{Blank}+                ;
<S6>{PCT}                   { assign_pct(yytext); BEGIN S7;}
<S6>{Char}                  {uc_field = "PCT"; BEGIN ERR;}

<S7>{Blank}+                ;
<S7>{Alub}                  { assign_alub(yytext); BEGIN S8;}
<S7>{Char}                  {uc_field = "ALU B"; BEGIN ERR;}

<S8>{Blank}+                ;
<S8>{Aluop}                 { assign_aluop(yytext); BEGIN S9;}
<S8>{Char}                  {uc_field = "ALU Operation"; BEGIN ERR;}

<S9>{Blank}+                ;
<S9>{Memop}                 { assign_memop(yytext); BEGIN S10;}
<S9>{Char}                  {uc_field = "Mem Operation"; BEGIN ERR;}

<S10>{Blank}+                ;
<S10>{Nextop}                 { assign_nextop(yytext); BEGIN S11;}
<S10>{Char}                  {uc_field = "Next Operation"; BEGIN ERR;}

<S11>{Blank}+                ;
<S11>{Ident}                 { assign_next(yytext); BEGIN S12;}
<S11>{Char}                  {uc_field = "Next label"; BEGIN ERR;}

<S12>{Blank}*#{Char}*{Newline} {lineno++; BEGIN 0;}
<S12>{Blank}*{Newline}       {lineno++; BEGIN 0;}

<ERR>{Char}*{Newline}        {bad_line(uc_field); lineno++; BEGIN 0;}

%%

