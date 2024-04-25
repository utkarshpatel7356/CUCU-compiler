%{
        #include <stdio.h>
        #include <string.h>
        #include "cucu.tab.h"
        #define YYSTYPE char *
%}
%%
int[ ]|char[ ][*]    {fprintf(yyout,"Type : %s\n",yytext);yylval.str=strdup(yytext); return TYPE;}
"if"    {fprintf(yyout,"If : %s\n",yytext);yylval.str=strdup(yytext); return IF;}
"else"  {fprintf(yyout,"Else : %s\n",yytext);yylval.str=strdup(yytext); return ELSE;}
"while" {fprintf(yyout,"While : %s\n",yytext);yylval.str=strdup(yytext); return WHILE;}
"return" {fprintf(yyout,"Return : %s\n",yytext);yylval.str=strdup(yytext); return RETURN;}
[a-zA-Z_]+[a-zA-Z0-9_]* {fprintf(yyout,"Identifier : %s\n",yytext);yylval.str=strdup(yytext); return IDENTIFIER;}
";"     {fprintf(yyout,"Semicolon : %s\n",yytext); return SEMICOLON;}
","     {fprintf(yyout,"Comma : %s\n",yytext); return COMMA;}
"("     {fprintf(yyout,"Left Parenthesis : %s\n",yytext); return LPAREN;}
")"     {fprintf(yyout,"Right Parenthesis : %s\n",yytext); return RPAREN;}
"{"     {fprintf(yyout,"Left Brace : %s\n",yytext); return LBRACE;}
"}"     {fprintf(yyout,"Right Brace : %s\n",yytext); return RBRACE;}
"["     {fprintf(yyout,"Left Bracket : %s\n",yytext); return LBRACKET;}
"]"     {fprintf(yyout,"Right Bracket : %s\n",yytext); return RBRACKET;}
[ ]+    ;
"="     {fprintf(yyout,"Assignment : %s\n",yytext); return ASSIGNMENT;}
[0-9]+  {fprintf(yyout,"Integer : %s\n",yytext);yylval.number=atoi(yytext); return INTEGER;}
"+"     {fprintf(yyout,"Addition : %s\n",yytext); return ADDITION;}
"-"     {fprintf(yyout,"Subtraction : %s\n",yytext); return SUBTRACTION;}
"*"     {fprintf(yyout,"Multiplication : %s\n",yytext); return MULTIPLICATION;}
"/"     {fprintf(yyout,"Division : %s\n",yytext); return DIVISION;}
"&"     {fprintf(yyout,"And : %s\n",yytext); return AND;}
"=="    {fprintf(yyout,"Equal : %s\n",yytext); return EQUAL;}
"!="    {fprintf(yyout,"Not Equal : %s\n",yytext); return NOTEQUAL;}
"<"     {fprintf(yyout,"Less Than : %s\n",yytext); return LESSTHAN;}
"<="    {fprintf(yyout,"Less Than or Equal : %s\n",yytext); return LESSTHANEQUAL;}
">"     {fprintf(yyout,"Greater Than : %s\n",yytext); return GREATERTHAN;}
">="    {fprintf(yyout,"Greater Than or Equal : %s\n",yytext); return GREATERTHANEQUAL;}
(\/\*([^*]|\n)*\*\/) {};
\/\/.* {};
. {yyerror("Invalid character");}
%%
