/* $begin switch-prob2-c */
int switch2(int x) {
  int result = 0;
  switch (x) {
    /* Body of switch statement omitted */
/* $end switch-prob2-c */
  case -2: return -2;
  case 0: return 0;
  case 1: return 1;
  case 2:
  case 3: return 3;
  case 4: return 4;
  default: return 7;
/* $begin switch-prob2-c */
  }
  return result;
}
/* $end switch-prob2-c */


/* $begin switch-prob3-c */
/* $begin switch-prob3-ans-c */
/* Enumerated type creates set of constants numbered 0 and upward */
typedef enum {MODE_A, MODE_B, MODE_C, MODE_D, MODE_E} mode_t;

int switch3(int *p1, int *p2, mode_t action)
{
  int result = 0;
  switch(action) {
/* $end switch-prob3-c */
/* $end switch-prob3-ans-c */
#if 1
/* $begin switch-prob3-ans-c */
  case MODE_A:
    result = *p1;
    *p1 = *p2;
    break;
  case MODE_B:
    *p2 += *p1;
    result = *p2;
    break;
  case MODE_C:
    *p2 = 15;
    result = *p1;
    break;
  case MODE_D:
    *p2 = *p1;
    /* Fall Through */
  case MODE_E:
    result = 17;
    break;
  default:
    result = -1;
/* $end switch-prob3-ans-c */
#else
/* $begin switch-prob3-c */
  case MODE_A:

  case MODE_B:

  case MODE_C:

  case MODE_D:

  case MODE_E:

  default:

/* $end switch-prob3-c */
#endif
/* $begin switch-prob3-c */
/* $begin switch-prob3-ans-c */
  }
  return result;
}
/* $end switch-prob3-c */
/* $end switch-prob3-ans-c */
