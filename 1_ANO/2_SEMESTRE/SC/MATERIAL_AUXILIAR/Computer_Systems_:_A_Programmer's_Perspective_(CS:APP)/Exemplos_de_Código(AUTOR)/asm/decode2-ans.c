/* $begin decode2-ans-proto */
int decode2(int x, int y, int z); 
/* $end decode2-ans-proto */

/* $begin decode2-ans-c */
int decode2(int x, int y, int z) 
{ 
    int t1 = y - z; 
    int t2 = x * t1; 
    int t3 = (t1 << 31) >> 31; 
    int t4 = t3 ^ t2; 

    return t4; 
} 
/* $end decode2-ans-c */
 
