#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct{
    char Nombre[32];
    int Valor;
}variables[30];

int main()
{

    escribirVariable("caca",5);
    escribirVariable("Pablo",3);
    escribirVariable("Gonza",44);
    escribirVariable("caca",30);
    printf("%d", leerVariable("caca"));
    return 0;
}

void ModVariable(char *Name,int Val){
    int x;
    x= BuscarVariable(Name);
    if (x!=55){
        variables[x].Valor=Val;
    }
}
int BuscarVariable(char *Name){
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
     i= BuscarVariable(Name);
     if (i==55){
        x =BuscarVariable("");
        if (x!=55){
            // puts("entro y copia\n");
            strcpy(variables[x].Nombre,Name);
            variables[x].Valor=Val;
        }
     }
     if(i!=55){
        ModVariable(Name,Val);
     }

}
int leerVariable (char *Name){   // Esta funcion se usa como X = leerVariable(nombre) y te retorna el valor de dicha variable
    int x;
     x= BuscarVariable(Name);
     return variables[x].Valor;
}
