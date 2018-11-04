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
    return 0;
}

void ModVariable(char *Name,int Val){
    int x;
    x= BuscarVariable(Name);
    if (x!=55){
        variables[x].Valor=Val;
    }
    printf("Variable modificada %s %d  en posicion %d \n",variables[x].Nombre,variables[x].Valor,x);
}
int BuscarVariable(char *Name){
    for(int i=0;i<30;i++){
           // printf("%d \n",i);
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
            printf("Nueva Variable %s %d en posicion %d \n",variables[x].Nombre,variables[x].Valor,x);
        }
     }
     if(i!=55){
        ModVariable(Name,Val);
     }
   //  printf("%d \n",x);

}
int leerVariable (char *Name){   // Esta funcion se usa como X = leerVariable(nombre) y te retorna el valor de dicha variable
    int x;
     x= BuscarVariable(Name);
     printf("Leyendo la Variable %s cuyo valor es %d en posicion %d\n",variables[x].Nombre,variables[x].Valor,x);
     return variables[x].Valor;
}
