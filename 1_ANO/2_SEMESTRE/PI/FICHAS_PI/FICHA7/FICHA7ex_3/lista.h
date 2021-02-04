typedef struct slist {
	int valor;
	struct slist * prox;
} *LInt;

LInt fromArray (int v[], int N);
void freeLInt (LInt l);
void printLInt (LInt l);
