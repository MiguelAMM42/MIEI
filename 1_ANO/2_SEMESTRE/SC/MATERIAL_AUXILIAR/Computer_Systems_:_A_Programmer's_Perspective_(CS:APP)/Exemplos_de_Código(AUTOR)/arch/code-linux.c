#include <stdio.h>
#include <stdlib.h>

int array[] = {0xd, 0xc0, 0xb00, 0xa000};

/* $begin sum-ans */
int Sum(int *Start, int Count)
{
  int sum = 0;
  while (Count) {
    sum += *Start;
    Start++;
    Count--;
  }
  return sum;
}
/* $end sum-ans */

void Prog()
{
  int val = Sum(array, 4);
  printf("0x%x\n", val);
  exit(0);
}

int main()
{
  Prog();
  return 0;
}
