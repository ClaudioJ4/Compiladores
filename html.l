%option noyywrap
%option nodefault
%option yylineno

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}

nome                [a-zA-Z]+|[Hh][1-6]
prop_nome           [a-zA-Z_][a-zA-Z0-9_]*
prop_conteudo       "([^\"\\]|\\.)*"
propriedade         {prop_nome}={prop_conteudo}?

tag_abertura        "<"{nome}({propriedade})*">"
tag_fechamento      "</"{nome}">"
tag_isolada         "<"{nome}({propriedade})*"\/>"

conteudo_pagina     "([^<]+|<(?!\/?{nome}\\b))+"

%%

{tag_abertura}          printf("Tag de abertura encontrada: %s\n", yytext);
{tag_fechamento}        printf("Tag de fechamento encontrada: %s\n", yytext);
{tag_isolada}           printf("Tag isolada encontrada: %s\n", yytext); 
{conteudo_pagina}       printf("Conteúdo da página: %s\n", yytext); 

<<EOF>>	exit(0);


%%

int main() {
    FILE* yyin = fopen("html.txt", "r");
    if (yyin == NULL) {
        printf("Failed to open input file.\n");
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}
