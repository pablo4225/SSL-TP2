%{
    #include <stdio.h>
    #include <math.h>
    #include <stdlib.h>
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

programa: INICIO listaSentencias FIN { imprimirVariables(); }

listaSentencias: sentencia
               | sentencia listaSentencias
               ;

sentencia: ID ASIGNACION expresion PUNTOYCOMA { escribirVariable($1,$3); }
         | LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PUNTOYCOMA
         | ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PUNTOYCOMA { printf("\n"); }
         ;

listaIdentificadores: ID { escanearVariable($1); }
                    | listaIdentificadores COMA ID { escanearVariable($3); }
                    ;

listaExpresiones: expresion { printf("%d", $1); }
                | listaExpresiones COMA expresion { printf(" %d ", $3); }
                ;

expresion: primaria { $$=$1; }
         | primaria SUMA expresion { $$=$1+$3; }
         | expresion RESTA primaria { $$=$1-$3; }
         ;

primaria: ID { $$ = leerVariable($1); /*Aca lee los id*/ }
        | CONSTANTE { $$=$1; }
        | PARENIZQUIERDO expresion PARENDERECHO { $$=$2; }
        ;

%%

#define MAX_VARIABLES 30
#define MAX_NOMBRE 32
#define NO_ENCONTRADO 55
struct{
    char nombre[MAX_NOMBRE];
    int valor;
}variables[MAX_VARIABLES];

extern FILE *yyin; // Se agrega para que pueda enviarse un puntero a un archivo y ser parseado

int yyerror(char *s) {
  printf("Error: no se reconoce el programa.\n");
}

void escanearVariable(char *id) {
    int valorVariable;
    printf("\nIngrese un valor para %s: ", id);
    scanf("%d", &valorVariable);
    escribirVariable(id, valorVariable);
}

void modVariable(char *Name,int Val){
    int x;
    x = buscarVariable(Name);
    if (x!=NO_ENCONTRADO){
        variables[x].valor=Val;
    }
}
int buscarVariable(char *Name){
    for(int i=0; i<MAX_VARIABLES; i++){
        if (strcmp(Name,variables[i].nombre)==0){
            return i;
        }
    }
    return NO_ENCONTRADO;
}

void escribirVariable(char *Name,int Val){
    int x;
    int i;
    i = buscarVariable(Name); 
     if (i==NO_ENCONTRADO){
        x = buscarVariable("");
        if (x!=NO_ENCONTRADO){
            strcpy(variables[x].nombre,Name);
            variables[x].valor=Val;
        }
     }
     if(i!=NO_ENCONTRADO){
        modVariable(Name,Val);
     }     
}

int leerVariable (char *Name){   // Esta funcion se usa como X = leerVariable(nombre) y te retorna el valor de dicha variable
    int x;
    x = buscarVariable(Name);
    return variables[x].valor;
}

void imprimirVariables(void)
{
    int i;
    printf("\nVARIABLES\n");
    printf("NOMBRE | Valor\n");

    for(i=0; i < MAX_VARIABLES; i++) {
        if (strlen(variables[i].nombre)!= 0)
        printf("%s | %d\n", variables[i].nombre, variables[i].valor);
    }
}

int main(int argc, char *argv[]) {
    FILE *punteroArchivo;
    if (argc == 2) {
        // viene una ruta por parámetro
        punteroArchivo = fopen(argv[1],"r");
        yyin = fopen(argv[1],"r");
        yyparse();
        fclose(punteroArchivo);
    }
    else {
        yyparse();    
    }    
}

