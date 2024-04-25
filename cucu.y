%{
        #include <stdio.h>
        #include <string.h>
        FILE *out;
        extern FILE *yyin,*yyout;
%}
%union{
        int number;
        char *str;
}
%token <str> TYPE
%token <str> IF
%token <str> ELSE
%token <str> WHILE
%token <str> RETURN
%token <str> IDENTIFIER
%token <number> INTEGER
%token SEMICOLON COMMA LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET ASSIGNMENT ADDITION SUBTRACTION MULTIPLICATION DIVISION AND EQUAL NOTEQUAL LESSTHAN LESSTHANEQUAL GREATERTHAN GREATERTHANEQUAL
%%
program: functionDefinition
        | functionDeclaration
        | variableDeclaration
        ;
variableDeclaration:TYPE expression SEMICOLON {fprintf(out,"Type : %s \n",$1);}
        | TYPE expression SEMICOLON program {fprintf(out,"Type : %s \n",$1);}
        | TYPE IDENTIFIER SEMICOLON {fprintf(out,"Variable : %s , of Type : %s \n",$2,$1);}
        | TYPE IDENTIFIER SEMICOLON program {fprintf(out,"Variable : %s , of Type : %s \n",$2,$1);}
        ;
functionDeclaration:TYPE IDENTIFIER LPAREN functionArguments RPAREN SEMICOLON program {fprintf(out,"Function Declared: %s , of Return Type : %s\n",$2,$1);}
        ;
functionDefinition:TYPE IDENTIFIER LPAREN functionArguments RPAREN LBRACE functionBody RBRACE program{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        |TYPE IDENTIFIER LPAREN RPAREN LBRACE functionBody RBRACE program{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        |TYPE IDENTIFIER LPAREN RPAREN LBRACE RBRACE program{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        |TYPE IDENTIFIER LPAREN functionArguments RPAREN LBRACE functionBody RBRACE{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        |TYPE IDENTIFIER LPAREN RPAREN LBRACE functionBody RBRACE{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        |TYPE IDENTIFIER LPAREN RPAREN LBRACE RBRACE{fprintf(out,"Function Defined: %s , of Return Type : %s\n",$2,$1);}
        ;
functionArguments:TYPE IDENTIFIER {fprintf(out,"Argument : %s , of Type : %s\n",$2,$1);}
        | TYPE IDENTIFIER COMMA functionArguments {fprintf(out,"Argument : %s , of Type : %s\n",$2,$1);}
        ;
functionBody: statements
        ;       
statements: statements statement
        | statement
        ;
statement: expression SEMICOLON {fprintf(out,"Expression : \n");}
        | RETURN SEMICOLON {fprintf(out,"Return\n");}
        | RETURN expression SEMICOLON {fprintf(out,"Return : \n");}
        | RETURN IDENTIFIER SEMICOLON {fprintf(out,"Return : %s\n",$2);}
        | TYPE IDENTIFIER LBRACKET expression RBRACKET SEMICOLON {fprintf(out,"Array : %s\n",$2);}
        | RETURN expression  {fprintf(out,"Return : \n");}
        | IF LPAREN expression RPAREN LBRACE statements RBRACE {fprintf(out,"If\n");}
        | IF LPAREN expression RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE {fprintf(out,"If Else\n");}
        | WHILE LPAREN expression RPAREN LBRACE statements RBRACE {fprintf(out,"While\n");}
        | IDENTIFIER LPAREN RPAREN SEMICOLON {fprintf(out,"Function : %s\n",$1);}
        | IDENTIFIER LPAREN expression RPAREN SEMICOLON {fprintf(out,"Function : %s\n",$1);}
        | IDENTIFIER LPAREN callingArguments RPAREN SEMICOLON {fprintf(out,"Function : %s\n",$1);}
        | IDENTIFIER SEMICOLON {fprintf(out,"Variable : %s\n",$1);}
        | IDENTIFIER ASSIGNMENT expression SEMICOLON {fprintf(out,"Variable : %s\n ASSIGNMENT %s\n",$1);}
        | TYPE IDENTIFIER SEMICOLON {fprintf(out,"Variable : %s , of Type : %s\n",$2,$1);}
        | TYPE IDENTIFIER ASSIGNMENT expression SEMICOLON {fprintf(out,"Variable : %s , of Type : %s\n EXPRESSION : %s\n",$2,$1);}
        | ;
callingArguments:IDENTIFIER {fprintf(out,"Argument : %s\n",$1);}
        | IDENTIFIER COMMA callingArguments {fprintf(out,"Argument : %s\n",$1);}
        | INTEGER {fprintf(out,"Value : %s\n",$1);}
        | INTEGER COMMA callingArguments {fprintf(out,"Value : %s\n",$1);}
        | IDENTIFIER LBRACKET expression RBRACKET {fprintf(out,"Array : %s\n",$1);}
        | IDENTIFIER LBRACKET expression RBRACKET COMMA callingArguments {fprintf(out,"Array : %s\n",$1);}
        ;
expression: expr
        | IDENTIFIER ASSIGNMENT expression {fprintf(out,"Variable : %s\n ASSIGNMENT %s\n",$1);}
        ;
expr: relationalExpression
        | expr EQUAL relationalExpression {fprintf(out,"EXPRESSION:EQUALITY CHECK\n");}
        | expr NOTEQUAL relationalExpression {fprintf(out,"EXPRESSION:INEQUALITY CHECK\n");}
        | expr LESSTHAN relationalExpression {fprintf(out,"EXPRESSION:LESS THAN CHECK\n");}
        | expr LESSTHANEQUAL relationalExpression {fprintf(out,"EXPRESSION:LESS THAN EQUAL CHECK\n");}
        | expr GREATERTHAN relationalExpression {fprintf(out,"EXPRESSION:GREATER THAN CHECK\n");}
        | expr GREATERTHANEQUAL relationalExpression {fprintf(out,"Expression :GREATER THAN EQUAL CHECK\n");}
        ;
relationalExpression: relationalExpression ADDITION val1 {fprintf(out,"Expression : ADDITION\n");}
        | relationalExpression SUBTRACTION val1 {fprintf(out,"Expression :SUBTRACTION\n");}
        | val1
        ;
val1:val1 MULTIPLICATION val2 {fprintf(out,"Expression : MULTIPLICATION\n");}
        | val1 DIVISION val2 {fprintf(out,"Expression : DIVISION\n");}
        | val2
        ;
val2: val2 AND val3 {fprintf(out,"Expression : LOGICAL AND\n");}
        | val3
        ;
val3: IDENTIFIER {fprintf(out,"Variable : %s\n",$1);}
        | INTEGER {fprintf(out,"Value : %s\n",$1);}
        | LPAREN expr RPAREN {fprintf(out,"Expression : PARENTHESIS\n");}
        ;
%%
yywrap(){
        return 1;
}
void yyerror(char *s){
        yyout=fopen("Lexer.txt","w");
        fprintf(yyout,"Error: %s\n",s);
        out=fopen("Parser.txt","w");
        fprintf(out,"Error: %s\n",s);   
}
main (int argc[], char *argv[]){
        yyin=fopen(argv[1],"r");
        yyout=fopen("Lexer.txt","w");
        out=fopen("Parser.txt","w");
        yyparse();
}
