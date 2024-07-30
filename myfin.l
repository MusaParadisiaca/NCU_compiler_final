%{
  #include "myfin.tab.h"
%}
sep ("\t"|"\n"|"\r"|" ")
num 0|-?[1-9][0-9]*
/*op ("mod"|"("|")"|"+"|"-"|"*"|"/"|">"|"<"|"="|"and"|"or"|"not")*/
/*out "print-num"*/
ot .
%%
{sep} {}
"#t" {yylval.ival=1;return(b);}
"#f" {yylval.ival=0;return(b);}
"and" {return(and);}
"or" {return(or);}
"not" {return(not);}
{num} {yylval.ival = atoi(yytext);return(number);}
"print-num" {return(pt);}
"print-bool" {return(ptb);}
"+"|"-"|"*"|"/"|">"|"<"|"="|"("|")" {return(yytext[0]);}
"mod" {return(mod);}
%%