#include <stdio.h>
#include <stdlib.h>
#include <string.h> //libraria a incluir para usar o strlen



int reverse(int x){
	int resto;
	int reverse = 0;
	while (x != 0) {
        resto = x % 10;
        reverse = reverse * 10 + resto;
        x = x / 10; 
	}
	return reverse;

}

/*Um exemplo prático desta função é quando temos x = 12:
12 != 0 é verdade, por isso, calculámos o resto da divisão de x por 10, que dá 2.
Nesse momento, terremos que o reverse é 2.
x passa a ser igual a 12 / 10, que em C dá 1(Só podemos colocar uma vez 10 em 12).
O valor 1 v olta a entrar no ciclo pois x!=12 continua TRUE
O resto passa a ser 1.
O reverse passa a ser : 2*10 + 1.
Depois x passa a ser 0 e já não entra no ciclo.
É returnado o valor 21
*/


int isVogal(char c){

	if(c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'||
	c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') return 1; //é TRUE : é vogal
	else return 0; //é FALSE : não é vogal

}


int vogal (char *t){
	int novoTam;
	int tamanho = strlen(t);
	int i, j;
	char *novaString = ""; //Uma string vazia onde ficará a string com o novo tamanho

	for (i = 0; i < tamanho; i++) { 
        if (isVogal(t[i])) { 
            novaString += t[i]; 
        } 
        novaString += t[i]; 
    } 

    novoTam = strlen(novaString);

    for (j= 0; j < novoTam; j++) t[j]= novaString[j];

    return novoTam;


}


typedef struct dlist{
	int valor;
	struct dlist *ant, *prox;
}*Dlist


int DLIntOk (DList l){
	int flag = 1;
	if ((l -> ant) != NULL) flag = 0; //Se tivermos algo antes do nodo mais à esquerda,então está mal construída
	DList proximo = l -> prox -> prox;
	else{
		while((proximo -> prox) != NULL ){
			if ((proximo->ant) == NULL) flag = 0;// Teriamos "ant" a NULL no meio da lista
			proximo = proximo -> prox;
		} 
		else{
			while ((proximo -> prox) != NULL) proximo = proximo -> prox;
			if ((proximo -> prox)== NULL && (proximo -> prox -> prox)!=NULL) flag = 0;
		}

	}
	return flag ;
}


void imprimeAte (ABin a , int x){
	if (!(a -> dir)) printf("%d \n", x);
	else{
		ABin dir = a -> dir
		while (dir){
			if ((dir -> esq -> valor) > x ) {
				imprimeAte(dir -> esq);
				imprimeAte(dir -> dir);
			} else imprimeAte(dir -> dir);


		}
	}
}



int existeCam (ABin a, int x){
	if (!a) return 0;
	if (a -> valor == x) return 1;
	if (a -> valor > x) return existeCam(a -> esq,x);
	else return existeCam(a-> dir,x);
}

int caminho (ABin a, int x, LInt *p){
	int caminho = existeCam(a, x);


	if (caminho == 1){ 
        while (a -> valor != x){
        	(*p) -> valor = a -> valor;
        	if (a-> valor > x) {
        		p = &((*p)-> prox);
        		a = a -> esq;
        		caminho (a,x,&p);
        	}
        	else{
        		p = &((*p)-> prox);
        		a = a -> dir;
        		caminho (a,x,&p);

        	}
        }     
    } 
       
    else (*p) = NULL;


	return caminho;

}

#include <ctype.h>
//esta libraria deve ser incluida para usar a "isdigit_"

int valida(char s[]){
	int valida = 1;
	int i = 0;
	while(s[i]){
		if(!(isdigit(s[i]))  &&  s[i]!='('  && s[i] != ')' ) {
			valida = 1;
			i ++;
		} else if(s[i] == ')' && (!isdigit(s[i+1]))) valida = 0;

	}
	return valida;
}





#include <iostream>
using namespace std;

void gen_compressed_str(string str) 
{ 
    int len = str.length(); 
    for (int i = 0; i < len; i++) { 
  
        // Count occurrences of current character 
        int count = 1; 
        while (i < len - 1 && str[i] == str[i + 1]) { 
            count++; 
            i++; 
        }
        // Print character and its count
        if (count == 1)
        {
          cout << str[i];
        }
        else
        {
          cout << str[i] << count;
        }
         
    } 
} 

int main() {
  
  string str = "wwwwaaadexxxxxxywww"; 
  gen_compressed_str(str); 
}



void descomprime(char i[], char o[]){
	int i = 0;
	while(!(isdigit(i[i]))  &&  i[i]!='('  && i[i] != ')' ){
		o[i] = i[i];
		i++;
	}
	else{

	} 

	






void posorderaux(ABin tree, LInt * list) {
    if(tree) {
        LInt new = malloc(sizeof(struct lligada));
        new->valor = tree->valor;
        new->prox = (*list);
        (*list) = new;
        posorderaux(tree->dir,list);
        posorderaux(tree->esq,list);
    }
}

DifList imprime (ABin a) {
	DifList ans;
	LInt * list = malloc(sizeof (struct lligada));
    *list = NULL;
    posorderaux(tree,list);
    ans-> front = list -> valor;
    LInt copia = list;
    while ((copia -> prox) ! NULL) copia = copia -> prox
    ans -> last = copia;
    return ans;
}

//Colocar numa lista ligada o resultado de percorrer em posOrder a arvore binaria e
//depois colocar o primeiro nodo e o ultimo na DifList