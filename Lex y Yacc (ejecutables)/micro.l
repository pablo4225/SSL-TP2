%{
#include "micro.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%option noyywrap

espacio         [ \t]+
digito          [0-9]
constante 		{digito}+
identificador	[a-zA-Z][0-9a-zA-Z]*

%%

{espacio}       { /* Ignoramos espacios en blanco */ }

"leer"			return(LEER);
"escribir"		return(ESCRIBIR);
"inicio"		return(INICIO);
"fin"			return(FIN);
{identificador}	{
					strcpy(yylval.valorString,yytext);
					return(ID);
				}
{constante}		{
					yylval.valor = atoi(yytext);
					return(CONSTANTE);
				}
":="			return(ASIGNACION);
"+"           	return(SUMA);
"-"           	return(RESTA);
","				return(COMA);
"("           	return(PARENIZQUIERDO);
")"           	return(PARENDERECHO);
";"				return(PUNTOYCOMA);

%%
