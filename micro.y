%{
#include <math.h>
%}

%union{
        double VALOR;
}

%token  <VALOR> NUMERO 
%token  SUMA    RESTA
%token  PARENIZQUIERDO  PARENDERECHO
%token  PUNTOYCOMA
%token  FIN
%token  FDT

%left   SIMB_MAS    SIMB_MENOS

%type <VALOR> Expresion
%start objetivo

%%

objetivo: programa FDT

programa: INICIO listaSentencias FIN

listaSentencias: sentencia {sentencia}

sentencia:  ID ASIGNACION expresion PUNTOYCOMA
         | LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA
         | ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA

listaIdentificadores: ID {COMA ID}

listaExpresiones: expresion {COMA expresion}

expresion: primaria {operadorAditivo primaria}

primaria: ID
        | CONSTANTE
        | PARENIZQUIERDO expresion PARENDERECHO

operadorAditivo: SUMA
               | RESTA




Input:	Linea
	| Input Linea
    ;

Linea:	FIN
        | Expresion FIN                { printf("Resultado: %f\n",$1); }
        ;

Expresion:	NUMERO                        { $$=$1; }
        | Expresion SIMB_MAS Expresion    { $$=$1+$3; }
        | Expresion SIMB_MENOS Expresion   { $$=$1-$3; }
        | Expresion MULTI Expresion   { $$=$1*$3; }
        | Expresion DIVIDIR Expresion  { $$=$1/$3; }
        | SIMB_MENOS Expresion %prec NEGADO    { $$=-$2; }
        | Expresion POTENCIA Expresion   { $$=pow($1,$3); }
        | PARENT_IZQUIERDO Expresion PARENT_DERECHO { $$=$2; }
        ;

%%
int yyerror(char *s) {
  printf("Error: no se reconoce la operacion.\n");
}

int main(void) {
  yyparse();
}