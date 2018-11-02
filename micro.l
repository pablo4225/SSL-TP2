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

{espacio}           { /* Ignoramos espacios en blanco */ }
"exit"|"quit"|"bye"	{printf("Terminando programa\n");exit(0);}

{identificador}		{

						yyval.valorString = yytext;

						if (!strcmp(yytext,"leer"))
							return(LEER);

						if (!strcmp(yytext,"escribir"))
							return(ESCRIBIR);
						
						/* Si no es ni leer, ni escribir, es ID */
						return(ID);
					}
{constante}			{
						yyval.valor = atoi(yytext);
						return(CONSTANTE);
					}
"leer"			return(LEER);
"escribir"		return(ESCRIBIR);
":="			return(ASIGNACION)
"+"           	return(SUMA);
"-"           	return(RESTA);
","				return(COMA);
"("           	return(PARENIZQUIERDO);
")"           	return(PARENDERECHO);
";"				return(PUNTOYCOMA);

%%
