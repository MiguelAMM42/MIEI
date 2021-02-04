typedef struct nodo {
  int valor;
  struct nodo *esq, *dir;
  } *ABin;
 
//Vou codificar o caminho
//0 é esquerda
//1 é direita
void imprime(ABin t)
{
 printf ("%d", t->valor);
 int esq = 1;
 int * dire [100];
 dire[0] = 0;
 aux (t->esq, dire, 1);
 dire[0] = 1;
 aux (t->dir, dire, 1);
}

void aux(ABin t, int v[], int dim)
{
  if (t->esq == NULL){
    int i;
    for (i = 0; i< dim; i++) {
      if (v[0] == 0)printf ("<");
      else printf (">");
    }
                             
    printf (">%d", t->valor);
  }
  if (t->esq != NULL) {
        v[dim] = 0;
        aux (t->esq, v, dim++);

  }
  if (t->dir == NULL) return;
  else {
    v[dim] = 1;
    aux (t->dir, v, dim++);
}







void pad (char *texto, int p, int N)
{
 int i;
 int temp;
 int dim;
 for (dim = 0; texto[dim] != '\0'; dim++);
 for (i = 0; texto[i] != '\0'; i++)
  {
    if (texto[i] == ' ') {
                          temp = i;
                          for (temp = i; temp < dim; temp++)
                              texto [dim+N+temp] = texto[dim+temp];
                          dim += N;
                          temp = i;
                          while (temp < N+i) {
                                        texto[temp] = ' ';
                                        temp++;
                                            }
                          i += temp;
                          }
  }
}




int length (char *t) {
    int i = 0;
    while (t[i]) i ++;
}

void adiciona (char *texto, int posicao, char c) {
    int tamanho = length (texto);
    while (tamanho != posicao) {
        texto[tamanho + 1] = texto[tamanho];
        tamanho --;
    }
    texto[posicao] = c;
}

void pad (char *texto, int p, int N) {
    int i = 0;
    int espacos = N;
    while (texto[i]) {
        if (texto[i] == 32) {
            while (N) {
                adiciona (texto, i, 32);
                N --;
            }
        }
        i ++;
    }
}








Considere o tipo LInt para representar listas de inteiros.

typedef struct slist { int valor; struct slist *prox;} *LInt;

Defina uma função LInt anterior(LInt l) que devolve o endereço do nó anterior ao nó apontado por l numa lista ligada circular 
(i.e. uma lista em que o campo prox do último elemento tem o valor do endereço do primeiro elemento).


LInt anterior(LInt l){
  if(!l) return NULL;
  else{
    LInt aux = (l -> prox);

  }
}






Defina uma função char *atRank (Palavras p, int k) que, recebendo um conjunto de palavras nesta representação (e com o campo quantos de cada nodo correctamente calculado) calcula a palavra que se encontra na posição k (isto é, a palavra para a qual existem exactamente k palavras menores do que ela).  

No caso de k ser superior ao número de palavras do conjunto a função deverá retornar NULL.



char *arRank(Palavras p, int k){
  if ( k > (p-> quantos)) return NULL;
}





int acrescenta (Palavras *e, char *p)
{
  int res;
  if (*e == NULL) {
    Palavras nov = malloc (sizeof (struct nodo));
    nov->raiz = p;
    nov->quantos = 1;
    nov->esq = NULL;
    nov->dir = NULL;
    *e = nov;
    res = 1;
  }
  else{
    int val = strcmp ((*e)->raiz, p) ;
    if (val == 0) res = 0;
    else {
      if (val < 0)  res = acrescenta ((*e)->esq, p); 
      else res = acrescenta ((*e)->dir, p);
    }
  }
  return res;
}









LInt anterior (LInt l) {
    int first = l -> valor;
    while ((l -> prox) -> valor != first){
      l = l -> prox;
    } 
    return l;
}


int capicua (DLint l) {
    NodoD *inicio = l.front;
    NodoD *atras = l.last;
    while (l.front != inicio) {
        if ((atras -> ant) -> valor != (inicio -> prox) -> valor) return 0; //não é capicua
        atras = atras -> ant; //"avaçamos" para trás
        inicio = inicio -> prox; //avançamos para a frente
    }
    return 1;
}