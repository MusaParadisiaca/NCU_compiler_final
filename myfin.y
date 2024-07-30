%{
	#include <string.h>
	#include <stdio.h>
	void yyerror(const char *);
%}
%union {
	int ival;
        int bol;
}
%token <ival> number
%token <ival> pt
%token <ival> b
%token <ival> and
%token <ival> or
%token <ival> not
/*%token <ival> t
%token <ival> f*/
%token <ival> ptb
%token <ival> mod
%type <ival> abexp
%type <ival> obexp
%type <ival> exp
%type <ival> STMT
%type <ival> printn
%type <ival> oper
%type <ival> boper
%type <ival> boper2
%type <ival> boper3
%type <ival> boper4
%type <ival> nb
%type <ival> plus
%type <ival> minus
%type <ival> MUL
%type <ival> divide
%type <ival> modulus
/*%type <ival> biger
%type <ival> smaller
%type <ival> eql*/
%type <ival> plusexp
%type <ival> mulexp


%%
PROG : STMTS;
STMTS :	STMT STMTS
	| STMT
	;
STMT : printn
	| exp
	;
printn : '(' pt exp ')' {printf("%d\n",$3);}
	| '(' ptb boper ')' 
	| '(' ptb b ')' {if($3==1){printf("%s\n","#t");}else{printf("%s\n","#f");}}
	;
exp : number
	| oper
	;
boper :  '(' and b abexp ')' {$$=$3 & $4;if($$==1){printf("%s\n","#t");}else{printf("%s\n","#f");}}
	| '(' or b obexp ')' {$$=$3 | $4;if($$==1){printf("%s\n","#t");}else{printf("%s\n","#f");}/*printf("%d\n",$4);*/}
	| '(' not nb ')' {$$=!$3;if($$==1){printf("%s\n","#t");}else{printf("%s\n","#f");} }
	;
boper2 : '(' and b abexp ')' {$$=$3 & $4;/*printf("%d\n",$$);*/}
	| '(' or b obexp ')' {$$=$3 | $4;}
	| '(' not b ')' {$$=!$3;/*printf("%d\n",$$);*/}
	;
nb : b
	| boper3
	| boper4
	;
boper3 : boper2 boper3 {$$=$1 | $2;}
	| boper2
	;
boper4 : boper2 boper4 {$$=$1 & $2;}
	| boper2
	;
abexp : b abexp {$$=$1 & $2;}
	| b
	| boper4
	;
obexp : b obexp {$$=$1 | $2;}
	| b
	| boper3
	;
oper : plus
	|minus
	|divide
	|MUL
	|modulus
	/*|biger
	|smaller
	|eql*/
	;
plus : '(' '+' exp plusexp ')' {$$=$3+$4;}
	;
plusexp : exp plusexp {$$=$1+$2;}
	| exp {$$=$1;}
	;
minus : '('  '-' exp exp ')' {$$=$3-$4;}
	;
MUL : '(' '*' exp mulexp ')' {$$=$4*$3;}
	;
mulexp : exp mulexp {$$=$1*$2;}
	| exp {$$=$1;}
	;
divide : '(' '/' exp exp ')' {$$=$3/$4;}
	;
modulus : '(' mod exp exp ')' {$$=$3%$4;}
	;
/*biger : '(' '>' exp exp ')' {}*/
%%
void yyerror (const char *message)
{
	printf("syntax error : %s\n",message);
}
int main(int argc, char** argv)
{
    yyparse();
    return 0;
}