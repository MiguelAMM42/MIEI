typedef struct slist {
    int valor;
    struct slist * prox;
} Nodo, *LInt;

LInt fromArray (int v[], int N);
void freeLInt (LInt l);
void printLInt (LInt l);



typedef struct dlist *DLInt;

typedef struct dlist {
    int valor;
    DLInt ant, prox;
} NodoD;

DLInt singular (int x);
void inicio (DLInt *l);
void fim (DLInt *l);
void concat (DLInt *a, DLInt b);
LInt toLInt (DLInt l);
DLInt fromLInt (LInt l);

void freeDLInt (DLInt l);
void printDLInt (DLInt l);