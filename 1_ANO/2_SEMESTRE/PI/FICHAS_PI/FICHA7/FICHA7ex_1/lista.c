#include <stdio.h>
#include <stdlib.h> //para poder usar o malloc
#include "lista.h"

/*
1(a):
Na main:

{

Lint a;

//10, 5 e 15
a = malloc(sizeof(Nodo));  //alocar memória para a estrutura de Nodos
a -> valor = 10;
a -> prox = malloc(sizeof(Nodo));
a -> prox -> valor = 5;
a -> prox -> prox = malloc(sizeof(Nodo));
a -> prox -> prox -> valor = 15;
a -> prox -> prox -> prox = NULL;

}

*/

int iguais (LInt a, LInt b) {
	// testa se duas listas são iguais
	while (a != NULL && b != NULL && a->valor == b->valor) {
		a = a->prox; b = b->prox;
	}
	return (a==NULL && b==NULL);
}

LInt cons (LInt l, int x) {
	LInt r = malloc (sizeof (struct slist));
	//Também se podia por *Nodo r = ...

	r->valor = x;
	r->prox  = l;

	return r; 
} //Esta é a função em que se tem de criar uma nova struct
// se tivermos NULL vai crachar

int cons1 (LInt *l, int x) {
	// a invocacao 
	// cons1 (&a, x) 
	// deve corresponder a fazer 
	// a = cons (a,x)
	// além disso retorna 1 se a alocação de memória não for possivel
    // ... completar 
    LInt r = malloc (sizeof (struct slist));
	//Também se podia por *Nodo r = ...
	if (r==NULL) return 1;
    r->valor = x;
	r->prox  = *l;
	*l = r;
	return 0;
}//Para testar a função invocar cons1(&a,7)---por exemplo
//Melhor pq permite devolver código de erro

LInt tail (LInt l) {
	LInt tmp = l;
	l = l->prox;
	free (tmp);
	return l;
}

int tail1 (LInt *l) {
	// a invocação 
	// tail1 (&a) 
	// deve corresponder a fazer 
	// a = tail (a)
	// além disso retorna 1 se a lista for vazia
    // ... completar 
    LInt tmp = *l;
    if (tmp == NULL) return 1; //if(!tmp) return 1
	*l = tmp ->prox;
	free (tmp);
	return 0;
}

LInt initRec (LInt l) {
	// definição em Haskell:
	// init [x] = []
	// init (x:xs) = x:init xs
	if (l->prox==NULL) {
		free (l); l=NULL;
	} 
	else l->prox = initRec (l->prox);
	return l;
}

//NOTA: As funções recursivas ocupam muito mais memória que as funções iterativas

LInt init (LInt l) {
	// completar com uma definição equivalente mas não recursiva
	// ...
	 LInt aux, r;
    //fazer um ciclo q de alguma forma vai avançar pela lista
    //Assumir q a lista é não vazia
    
    //casa em q a lista só tem um elemento
    if (l -> prox == NULL){
        free(l);
        r = NULL;
    } else {
        for (aux  = l; aux -> prox -> prox  != NULL ; aux = aux -> prox){
         free(aux -> prox);
         aux -> prox = NULL;
         r = l;
        }
    }
    return r;
}

int init1 (LInt *l) {
	// a invocação 
	// init1 (&a) 
	// deve corresponder a fazer 
	// a = init1 (a)
	// além disso retorna 1 se a lista for vazia
    // ... completar 
    //fazer um ciclo q de alguma forma vai avançar pela lista
    //Assumir q a lista é não vazia
    if(*l == NULL) return 1;
    
    //colocar o l a apontar para o campo prox do penúltimo nodo
    while ((*l)-> prox != NULL){
        l = &((*l)-> prox); 
    }
    free(*l);
    *l = NULL;
    return 0;
    
    //de apontador para apontador, já não precisamos de ver 2 casos, como vimos em cima
}

LInt snocRec (LInt l, int x) {
 	// definição em Haskell
 	// snoc [] x = [x]
 	// snoc (h:t) x = h:(snoc t x)
 	if (l==NULL) { 
 		l = malloc (sizeof (struct slist));
 		l->valor = x;
 		l->prox  = NULL;
 	} else l->prox = snocRec (l->prox, x);

 	return l;
 }
 
LInt snoc (LInt l, int x) {
 	// completar com uma definição equivalente mas não recursiva
	// ...
	return NULL;
}

int snoc1 (LInt *l, int x) {
	// a invocacao 
	// snoc1 (&a, x) 
	// deve corresponder a fazer 
	// a = snoc (a,x)
	// além disso retorna 1 se a alocação de memória não for possivel
 
    // ... completar 

	return 1;
}

LInt concatRec (LInt a, LInt b) {
	// definição em Haskell
	// [] ++ bs = bs
	// (a:as) ++ bs = a:(as ++ bs)
	if (a==NULL) a = b;
	else a->prox = concatRec (a->prox,b);
	return a;
}

LInt concat (LInt a, LInt b) {
 	// completar com uma definição equivalente mas não recursiva
	// ...
	LInt aux = a;
	
	if (a == NULL ) return b;
	
	while (aux -> prox != NULL)
	  aux = aux -> prox;
	  
	aux -> prox = b;
	
	return a;
}

void concat1 (LInt *a, LInt b){
	// a invocacao 
	// concat1 (&a, b) 
	// deve corresponder a fazer 
	// a = concat (a,b)
 
    // ... completar 
    
    //*a = concat (*a, b);
    
    while (*a != NULL){
        a = & ((*a) -> prox);
    }
    
    //*a deveria passar a apontar para a lista b
    //a contem o endereço do campo peox do último nó
    
    *a = b;
}
