%{
    #include <math.h>
%}

%union{
        int valor;
        char valorString[32];
}

%token  <valor> CONSTANTE
%token  SUMA    RESTA
%token  PARENIZQUIERDO  PARENDERECHO
%token  PUNTOYCOMA
%token  FIN
%token  FDT

%left   SUMA    RESTA
%left   ASIGNACION

%type <valor> Expresion
%start programa

%%

programa: INICIO listaSentencias FIN;

listaSentencias: sentencia
               | sentencia listaSentencias
               ;

sentencia: ID ASIGNACION expresion PUNTOYCOMA
         | LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA
         | ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA
         ;

listaIdentificadores: ID
                    | ID COMA listaIdentificadores
                    ;

listaExpresiones: expresion
                | expresion COMA listaExpresiones
                ;

expresion: primaria { $$=$1 }
         | primaria SUMA primaria { $$=$1+$3 }
         | primaria RESTA primaria { $$=$1-$3; printf }
         ;

primaria: ID    { $$=$1; }
        | CONSTANTE { $$=$1; }
        | PARENIZQUIERDO expresion PARENDERECHO { $$=$2; }
        ;

%%
int yyerror(char *s) {
  printf("Error: no se reconoce el programa.\n");
}

int main(void) {
  yyparse();
}