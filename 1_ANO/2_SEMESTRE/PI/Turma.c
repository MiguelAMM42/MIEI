Turma

typedef struct Aluno {
  char nome[8];
  int num;
} Aluno;

typedef struct Turma {
    Aluno aluno;
    struct Turma *prox;
  } Turma, *Turmita;


int acrescentaAluno (Turmita * t, Aluno a)
{
  Turma * nov = malloc (sizeof (struct Turma));
  if (nov == NULL) return 1;
  nov->aluno = a;
  nov->prox = NULL;
  while ( (*t) != NULL) t = &((*t)->prox);
  *t = nov;
  return 0;
}

int main  ()
{
//  LInt prim = NULL;
  Aluno n1;
  n1.num = 50;
  strcpy( &(n1.nome), "AAA");

  Aluno n2;
  strcpy( &(n2.nome), "BBB");
  n2.num = 60;
  Turmita t1 = NULL;
  int res;
  res = acrescentaAluno (&t1 , n1);
  res = acrescentaAluno (&t1 , n2);
  procura (t1, 50)
  
}