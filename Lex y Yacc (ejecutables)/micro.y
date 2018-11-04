%{
    #include <math.h>
%}

%union{
        int valor;
        char valorString[32];
}

%token  <valor> CONSTANTE
%token  <valorString> SENTENCIA
%token  COMA
%token  LEER
%token  ESCRIBIR
%token  INICIO
%token  <valorString> ID
%token  SUMA    RESTA
%token  PARENIZQUIERDO  PARENDERECHO
%token  PUNTOYCOMA
%token  FIN
%token  FDT

%left   SUMA    RESTA
%left   ASIGNACION

%type   <valor> expresion
%type   <valor> primaria

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

listaIdentificadores: ID { escanearVariable($1); }
                    | listaIdentificadores COMA ID { escanearVariable($3); }
                    ;

listaExpresiones: expresion { printf("Valor reducido: %d\n",$1); }
                | expresion COMA listaExpresiones
                ;

expresion: primaria { $$=$1; }
         | primaria SUMA primaria { $$=$1+$3; }
         | primaria RESTA primaria { $$=$1-$3; }
         ;

primaria: ID
        | CONSTANTE { $$=$1; }
        | PARENIZQUIERDO expresion PARENDERECHO { $$=$2; }
        ;

%%
int yyerror(char *s) {
  printf("Error: no se reconoce el programa.\n");
}

void escanearVariable(char *id) {
    int valorVariable;
    printf("\nIngrese un valor para %s:", id);
    scanf("%d", &valorVariable);
    actualizarVariable(id, valorVariable);
}

void actualizarVariable(char *nombreVariable, int valorVariable)
{
    printf("%s := %d\n", nombreVariable, valorVariable);
}
int main(void) {
  yyparse();
}