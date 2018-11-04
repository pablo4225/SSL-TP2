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

primaria: ID {$$ = leerVariable($1); }
        | CONSTANTE { $$=$1; }
        | PARENIZQUIERDO expresion PARENDERECHO { $$=$2; }
        ;

%%
struct{
    char Nombre[32];
    int Valor;
}variables[30];

int yyerror(char *s) {
  printf("Error: no se reconoce el programa.\n");
}

void escanearVariable(char *id) {
    int valorVariable;
    printf("\nIngrese un valor para %s:", id);
    scanf("%d", &valorVariable);
    escribirVariable(id, valorVariable);
}

void modVariable(char *Name,int Val){
    int x;
    x = buscarVariable(Name);
    if (x!=55){
        variables[x].Valor=Val;
    }
}
int buscarVariable(char *Name){
    for(int i=0;i<30;i++){
        if (strcmp(Name,variables[i].Nombre)==0){
            return i;
        }
    }
            return 55;

    }

void escribirVariable(char *Name,int Val){
    int x;
    int i;
     i = buscarVariable(Name);
     if (i==55){
        x = buscarVariable("");
        if (x!=55){
            // puts("entro y copia\n");
            strcpy(variables[x].Nombre,Name);
            variables[x].Valor=Val;
        }
     }
     if(i!=55){
        modVariable(Name,Val);
     }
}

int leerVariable (char *Name){   // Esta funcion se usa como X = leerVariable(nombre) y te retorna el valor de dicha variable
    int x;
     x = buscarVariable(Name);
     return variables[x].Valor;
}

int main(void) {
  yyparse();
}