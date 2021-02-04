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


int readx(Turma *t, FILE *f) {
	if(f) {
		int nr, nt;
		char nm[500];
		if(fscanf(f, "%d %s %d\n", &nr, nm, &nt)) {
			*t = malloc(sizeof(struct arv));
			(*t)->aluno.numero = nr;
			(*t)->aluno.nome = strdup(nm);
			(*t)->aluno.nota = nt;
			readx(&((*t)->esq), f);
			readx(&((*t)->dir), f);
		}
		else {
			fscanf(f, "%s", nm);
			if(strcmp(nm, "vazia") == 0) {
				*t = NULL;
			}
		}
		return 1;
	}
	else
		return 0;
}


int writex(Turma t, FILE *f) {
	if(f) {
		if(t) {
			fprintf(f, "%d %s %d\n", t->aluno.numero, t->aluno.nome, t->aluno.nota);
			writex(t->esq, f);
			writex(t->dir, f);
		}
		else
			fprintf(f, "vazia\n");
		return 1;
	}
	else
		return 0;
}


int readb(Turma *t, FILE *f) {
	if(f) {
		size_t st = sizeof(size_t);
		int eof;
		char v[] = "vazia", v2[5];
		size_t s = 0, sv = sizeof(char)*strlen(v);
		
		if (!feof(f)) {
			eof = fread(&s, st, 1, f);
			if (s == sv) {
				fread(v2, sv, 1, f);
				*t = NULL;
			}
			else {
				if (eof) {
					*t = malloc(sizeof(struct arv));
					fread(*t, s, 1, f);	
					readb(&((*t)->esq), f);
					readb(&((*t)->dir), f);
				}
			}
		}
		return 1;
	}
	else
		return 0;
}


int writeb(Turma t, FILE *f) {
	if(f) {
		size_t s, st = sizeof(size_t);
		if(t) {
			s = sizeof(t->aluno.numero)+
				sizeof(t->aluno.nota)+
				sizeof(t->aluno.nome)*strlen(t->aluno.nome)+
				sizeof(t->esq)+
				sizeof(t->dir);
			fwrite(&s, st, 1, f);
			fwrite(t, s, 1, f);
			writeb(t->esq, f);
			writeb(t->dir, f);
		}
		else {
			char v[] = "vazia";
			s = sizeof(char)*strlen(v);
			fwrite(&s, st, 1, f);
			fwrite(v, s, 1, f);
		}
		return 1;
	}
	else
		return 0;
}


void printT(Turma t) {
	if(t) {
		printf("%d %s %d\n", t->aluno.numero, t->aluno.nome, t->aluno.nota);
		printT(t->esq);
		printT(t->dir);
	}
}


int main() {
	FILE *f = fopen("turmar.txt","r");
	FILE *f2 = fopen("turmaw.txt","w");

	FILE *fb = fopen("turmar","w");
	
	Turma t = NULL, tb = NULL;
	if (readx(&t, f)) {
		printf("li, vou escrever\n");
		printT(t);
		writex(t, f2);
	}

	if(writeb(t, fb)) {
		fclose(fb);
		printf("escrita binaria done\n");
		fb = fopen("turmar","r");
		if (readb(&tb, fb)) {
			printf("leitura binaria done\n");
			printT(tb);
		}
	}

	fclose(f);
	fclose(f2);
	fclose(fb);
	return 1;
}








