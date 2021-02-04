#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
} *ABin;


//17_18


//====PARTE A==========================//

// 1

int retiraNeg (int v[], int N) {
    int i = 0;
    while(i < N) {
        if(v[i] < 0) {
            N--;
            for(int j = i; j < N; j++) v[j] = v[j+1];
        }
        else i++;
    }
    return N;
}

// 2

int difConsecutivos (char s[]){
    int answer = 0;
    for(int i = 0; s[i]; i++) {
        int len = 0;
        for(int j = i; s[j]; j++) {
            int in_prev = 0;
            for(int k = i; k < j; k++) {
                if(s[k] == s[j]) in_prev = 1;
            }
            if(!in_prev) len++;
            else break;
        }
        if(len > answer) answer = len;
    }
    return answer;
}

// 3

int maximo (LInt l) { 
    int max = !l->prox ? l->valor : maximo(l->prox);
    return max > l->valor ? max : l->valor;
}

// 4

int removeAll (LInt *l, int x) {
    int n = 0;
    while(*l) {
        if((*l)->valor == x) {
            LInt temp = (*l);
            (*l) = (*l)->prox;
            free(temp);
            n++;
        }
        else l = &((*l)->prox);
    }
    return n;
}

// 5

LInt arrayToList (int v[], int N) {
    if(!N) return NULL;
    LInt new = malloc(sizeof(struct slist));
    new->valor = *v;
    new->prox = arrayToList(v+1,N-1);
    return new;
}


//=========AUXILIAR=================================//



ABin newABin (int r, ABin e, ABin d){
    ABin a = malloc (sizeof (struct nodo));
    
    a->valor = r;
    a->esq = e; a->dir = d;
    
    return a;
}

ABin fromArray (int v[], int N){
   ABin r = NULL, e, d;
   int m = N/2;
   
   if (N>0) {
     e = fromArray (v, m);
     d = fromArray (v+m+1, N-m-1);
     r = newABin (v[m], e, d);
   }
   return r;
}

int toArray (ABin a, int v[], int N) {
  int r=0;
  
  if (a != NULL && N>0) {
     r += toArray (a->esq, v+r, N-r);
     if (r < N) v[r++] = a->valor;
     r += toArray (a->dir, v+r, N-r);
  }
  return r;
}


//============Parte B===================================//

//1


int auxiliar1(ABin a, int x)
{
    int i = 1;
    if(a)
    {
        if ( x < a->valor )
        {
            i = auxiliar1(a->esq, a->valor);
            i *= auxiliar1(a->dir, a->valor);
        }
        else i = 0;
    }
    return i;
}

int minheapOK (ABin a) 
{
    int i = 1;
    if( a )
    {
        i = auxiliar1(a->esq, a->valor);
        i *= auxiliar1(a->dir, a->valor);
    }
    return i;
}

//========OU===============================//

int minheapOK (ABin a) {
    if(!a) return 1;
    int l = a->esq ? minheapOK(a->esq) && a->valor < a->esq->valor : 1;
    int r = a->dir ? minheapOK(a->dir) && a->valor < a->dir->valor : 1;
    return l && r;
}

//2

int max(int a, int b) {return a > b ? a : b; }

int maxHeap (ABin a) {
    int l = a->esq ? maxHeap(a->esq) : a->valor;
    int r = a->dir ? maxHeap(a->dir) : a->valor;
    return max(l,r);
}

//3

void removeMin (ABin *a) {
    if(!(*a)->esq) {
        ABin temp = (*a);
        (*a) = temp->dir;
        free(temp);
    }
    else if(!(*a)->dir) {
        ABin temp = (*a);
        (*a) = temp->esq;
        free(temp);
    }
    else if((*a)->esq->valor < (*a)->dir->valor) {
        (*a)->valor = (*a)->esq->valor;
        removeMin(&((*a)->esq));
    }
    else {
        (*a)->valor = (*a)->dir->valor;
        removeMin(&((*a)->dir));
    }
}

//4

void heapSort (int v[], int N) {
    ABin *tree = malloc(sizeof(ABin));
    *tree = NULL;
    for(int i = 0; i < N; i++) add(tree,v[i]);
    for(int i = 0; i < N; i++) {
        v[i] = (*tree)->valor;
        removeMin(tree);
    }
}



//5

int kMaior (int v[], int N, int k) {
    ABin tree = NULL;
    for(int i = 0; i < N; i++) {
        if(i < k) add(&tree,v[i]);
        else {
            if(v[i] > tree->valor) {
                add(&tree,v[i]);
                removeMin(&tree);
            }
        }
    }
    return tree->valor;
}

















//=============COMO TESTAR ALGUMAS FUNÇÕES=================//


int main () {
	  
	    //int nula, teste;  
	  
	    //ABin Nula = NULL;
	    
	    ABin l = newABin(35, NULL, NULL);
	    
	    ABin r = newABin(22, NULL, NULL);
	    
	    ABin minheap = newABin(20,l,r); 
	    
	    

	    //int a[10] = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50};
	    
	    //int existe;
	
	    //ABin arv1 = fromArray (a, 5);//, arv2//;
	    
	    //existe = procura (12, arv1);
	    
	    // toArray (arv1, b, 10);
	    
	    //arv2 = insere (arv1, 18);
	    
	    
	    //nula = minheapOK (Nula);
	    
	    //teste = minheapOK (arv1);
	    
	    removeMin (&minheap);
	    
	
	    return 0;
}






//=========================================================//

//=============16/17

typedef struct slist {
  int valor;
  struct slist *prox;
} *LInt;

typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
} *ABin;

typedef struct chunk {
  int vs [MAXc];
  struct chunk *prox;
} *CList;

typedef struct stackC {
  CList valores;
  int sp;
} StackC;

int push (StackC *s, int x) {
    if(s->sp >= MAXc) {
        CList new = malloc(sizeof(struct chunk));
        if(!new) return 1;
        new->vs[0] = x;
        new->prox = s->valores;
        s->valores = new;
        s->sp = 1;
    }
    else s->valores->vs[(s->sp)++] = x;
    return 0;
}

int main() {
  
  
  

  return 0;
}