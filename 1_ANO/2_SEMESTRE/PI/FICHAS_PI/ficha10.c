#include<stdio.h>
#include<stdlib.h>
#include<string.h>



typedef struct aluno {
    int numero;
    char *nome;
    int nota;
} Aluno;


typedef struct arv {
    Aluno aluno;
    struct arv *esq, *dir;
} *Turma;


int read(Turma *t, FILE *f) {
    char n[100];
    int r, nt;   
    
    if (fscanf(f, "%d %s %d\n", &r, n, &nt)) {
        *t = malloc(sizeof(struct arv));
        ((*t)->aluno).numero = r;
        ((*t)->aluno).nota = nt;
        ((*t)->aluno).nome = strdup(n);
        read(&((*t)->esq), f);
        read(&((*t)->dir), f);
    }
    else {
        fscanf(f, "%s", n);
        if(strcmp(n, "vazia") == 0){
            *t = NULL;
        }
    }
    return 1;              
}

int write(Turma t, FILE *f) {
    if(f) {
        if(t) {
            fprintf(f, "%d %s %d\n", 
                t->aluno.numero, 
                t->aluno.nome, 
                t->aluno.nota);
            write(t->esq, f);
            write(t->dir, f);
        }
        else
            fprintf(f, "vazia\n");
        return 1;
    }
    else
        return 0;
}

void printTurma(Turma t) {
    if(t) {
        printf("%d %s %d\n", 
                t->aluno.numero, 
                t->aluno.nome, 
                t->aluno.nota);
        printTurma(t->esq);
        printTurma(t->dir);
    }
}




int main() {
    Turma t = NULL;
    FILE *f = fopen("turma2.txt", "r");
    FILE *f2 = fopen("turma2w.txt", "w");
    if(f)
        if(read(&t, f)){
            printTurma(t);
            write(t, f2);
        }

    fclose(f);
    fclose(f2);
    return 1;
}