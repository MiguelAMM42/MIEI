#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <assert.h>

#define MAXLINE 1024

char buffer[MAXLINE];

// 1 - Maior da sequência

void one() {
    int largest = INT_MIN;
    int num;
    puts("Maior de uma sequência\nInsere uma lista de números (um por linha) terminada em 0:");
    while(1) {
        int num;
        assert(scanf("%d",&num) == 1);
        if(num == 0) break;
        if(num > largest) largest = num;
    }
    printf("Maior: %d\n", largest);
}

// 2 - Média da sequência

void two() {
    double soma = 0;
    int n = 0;
    while(1) {
        int num;
        assert(scanf("%d",&num) == 1);
        if(num == 0) break;
        soma += num;
        n++;
    }
    double media = soma / n;
    printf("Media: %.5f\n", media);
}

// 3 - Segundo maior da sequência

void three() {
    int biggest = INT_MIN, second_biggest = INT_MIN, num;
    while(1) {
        assert(scanf("%d",&num) == 1);
        if(num == 0) break;
        if(num > biggest) {
            second_biggest = biggest;
            biggest = num;
        } else if (num > second_biggest) second_biggest = num;
    }
    printf("Segundo maior numero: %d\n", second_biggest);
}

// 4 - Nº de bits iguais a 1 na representação binária de n

int bitsUm (unsigned int n){
    int r = 0;
    while(n) {
        r += (n % 2);
        n >>= 1; // Shifts the bits in n one bit to the right, i.e., n = n / 2
    }
    return r;
}

// 5

int trailingZ (unsigned int n) {
    if(n % 2) return 0;
    else return 1 + trailingZ(n >> 1);
}

// 6

int qDig (unsigned int n) {
    if(n / 10 < 1) return 1;
    else return 1 + qDig(n / 10);
}

// 7

char* mystrcat(char s1[], char s2[]) {
    char* cat = s1;
    while(*s1) s1++;
    while((*s1 = *s2)) {s1++; s2++;}
    return cat;
}

// 8

char* mystrcpy(char* dest, char source[]) {
    char* result = dest;
    while((*dest = *source)) { source++; dest++; }
    return result;
}

// 9

int mystrcmp(char s1[], char s2[]) {
    while(*s1 == *s2 && *s1) { s1++; s2++; }
    return *s1 - *s2;
}

// 10

char* mystrstr (char haystack[], char needle[]) {
    int isContained = 1;
    char* ans = haystack;
    char* needleStart = needle;
    while(*needle && *haystack) {
        if(*haystack != *needle) {
            isContained = 0;
            needle = needleStart;
        }
        if(*haystack == *needle) {
            if(!isContained) {
                isContained = 1;
                ans = haystack;
            }
            needle++;
        }
        haystack++;
    }
    if (isContained && !(*needle)) return ans;
    else return NULL;
}

// 11

void mystrrev(char s[]) {
    int len;
    for(len = 0; s[len]; len++);
    char rev[len];
    for(int i = 0; i < len; i++) rev[i] = s[len - i - 1];
    for(int i = 0; i < len; i++) s[i] = rev[i];
}

// 12

void removeIndex(char* s) {
    for(; *s; s++)
        *s = *(s+1);
}

void strnoV (char s[]) {
    while(*s) {
        if(*s == 'A' || *s == 'E' || *s == 'I' || *s == 'O' || *s == 'U' || *s == 'a'
        || *s == 'e' || *s == 'i' || *s == 'o' || *s == 'u') removeIndex(s);
        else s++;
    }
}

// 13

void truncW (char t[], int n) {
    int wordLen = 0, i = 0;
    char c;
    while(c = t[i]) {
        if(c == ' ' || c == '\n' || c == '\t') {i++; wordLen = 0;}
        else {
            if(wordLen++ >= n) removeIndex(t + i);
            else i++;
        }
    } 
}

// 14

char charMaisfreq (char s[]) {
    if(!s[0]) return 0;
    int charFreq[256];
    int freqMax = 0;
    char maisFreq = s[0];
    for(int i = 0; i < 256; i++) charFreq[i] = 0;
    for(int i = 0; s[i]; i++) {
        int c = s[i];
        charFreq[c] += 1;
        if(charFreq[c] > freqMax) {
            freqMax = charFreq[c];
            maisFreq = s[i];
        }
    }
    return maisFreq;
}

int freqC(char ch, char s[]) {
    int freq = 0;
    for(int i = 0; s[i]; i++) {
        if(s[i] == ch) freq++;
    }
    return freq;
}

char charMaisFreq(char s[]) {
    char maisFreq = s[0];
    int freqMax = 0, freq;
    for(int i = 0; s[i]; i++) {
        if((freq = freqC(s[i],s)) > freqMax) {
            freqMax = freq;
            maisFreq = s[i];
        }
    }
    return maisFreq;
}

// 15

int iguaisConsecutivos (char s[]) {
    int consec = 1, max = 0;
    for(int i = 0; s[i]; i++) {
        if(s[i] == s[i + 1]) consec++;
        else {
            if(consec > max) max = consec;
            consec = 1;
        }
    }
    return max;
}

// 16

int not_in_prev(char str[], int k, int n) {
    int i, ans = 1;
    for(i = k; i < n; i++) {
        if(str[i] == str[n]) {
            ans = 0;
            break;
        }
    }
    return ans;
}

int difConsecutivos(char s[]) {
    int i, j, ans = 0;
    for(i = 0; s[i]; i++) {
        int consec = 0;
        for(j = i; s[j]; j++) {
            if(not_in_prev(s,i,j)) consec++;
            else break;
        }
        if (consec > ans) ans = consec;
    }
    return ans;
}

// 17

int maiorPrefixo (char s1 [], char s2 []) {
    int i;
    for(i = 0; s1[i] == s2[i] && s1[i]; i++);
    return i;
}

// 18

int maiorSufixo (char s1 [], char s2 []) {
    int i, j, ans = -1;
    for(i = 0; s1[i]; i++);
    for(j = 0; s2[j]; j++);
    while(s1[i--] == s2[j--]) ans++;
    return ans;
}

// 19

int sufPref (char s1[], char s2[]) {
    int ans = 0, i, j = 0;
    for(i = 0; s1[i]; i++) {
        if(s1[i] == s2[j++]) ans++;
        else ans = j = 0;
    }
    return ans;
}

// 20

int contaPal (char s[]) {
    int inWord = 0, total = 0;
    for(int i = 0; s[i]; i++) {
        if(s[i] == ' ' || s[i] == '\n') {
            if(inWord) total++;
            inWord = 0;
        }
        else inWord = 1;
    }
    if(inWord) total++;
    return total;
}

// 21

int contaVogais (char s[]) {
    int total = 0;
    for(int i = 0; s[i]; i++) {
        switch(s[i]) {
            case 'a': case 'e': case 'i': case 'o': case 'u':
            case 'A': case 'E': case 'I': case 'O': case 'U':
                total++;
        }
    }
    return total;
}

// 22

int contida (char a[], char b[]) {
    int cont = 1;
    for(int i = 0; a[i]; i++) {
        int pertence = 0;
        for(int j = 0; b[j]; j++) {
            if(a[i] == b[j]) pertence = 1;
        }
        if(!pertence) {
            cont = 0;
            break;
        }
    }
    return cont;
}

// 23

int palindrome (char s[]) {
    int len = 0, pal = 1;
    for(int i = 0; s[i]; i++) len++;
    for(int i = 0; s[i]; i++) if(s[i] != s[len - 1 - i]) pal = 0;
    return pal;
}

// 24

int remRep (char x[]) {
    if(!x[0]) return 0;
    int i = 1;
    char prev = x[0];
    while(x[i]) {
        if(x[i] == prev) removeIndex(x + i);
        else prev = x[i++];
    }
    return i;
}

// 25

int limpaEspacos (char t[]) {
    int i = 0;
    int prevSpace = 0;
    while(t[i]) {
        if(t[i++] == ' ') {
            if(prevSpace) for(int j = --i; t[j]; j++) t[j] = t[j + 1];
            else prevSpace = 1;
        }
        else prevSpace = 0;
    }
    return i;
}

// 26

void insere (int v[], int N, int x) {
    for(int i = 0; i < N; i++) {
        if(v[i] > x) {
            for(int j = N; j > i; j--) {
                v[j] = v[j - 1];
            }
            v[i] = x;
            break;
        }
        if(i == N - 1) {
            v[N] = x;
        }
    }
}

// 27

void merge (int r [], int a[], int b[], int na, int nb) {
    int i = 0, j = 0, k = 0;
    while(k < na + nb) {
        if((a[i] < b[j] && i < na) || j >= nb)
            r[k++] = a[i++];
        else
            r[k++] = b[j++];
    }
}

void recursive_merge(int r[], int a[], int b[], int na, int nb) {
    if(na > 0) {
        if(nb > 0) {
            if(*a > *b) {
                *r = *b;
                recursive_merge(r+1, a, b+1, na, nb-1);
            }
            else {
                *r = *a;
                recursive_merge(r+1, a+1, b, na-1, nb);
            }
        }
        *r = *a;
        recursive_merge(r+1, a+1, b, na-1, nb);
    }
    else if(nb > 0) {
        *r = *b;
        recursive_merge(r+1, a, b+1, na, nb-1);
    }
}

// 28

int crescente (int a[], int i, int j) {
    int cresc = 1;
    for(int k = i; k < j; k++) {
        if(a[k + 1] < a[k]) cresc = 0;
    }
    return cresc;
}

// 29

int retiraNeg (int v[], int N) {
    int i = 0;
    while(i < N) {
        if(v[i] < 0) {
            for(int j = i; j < N; j++) v[j] = v[j + 1];
            N--;
        }
        else i++;
    }
    return N;
}

// 30

int menosFreq (int v[], int N) {
    int freq = 1, minFreq = N, ans = v[0], i;
    for(i = 1; i < N; i++) {
        if(v[i] == v[i - 1]) freq++;
        if(v[i] != v[i - 1]) {
            if(freq < minFreq) {
                minFreq = freq;
                ans = v[i - 1];
            }
            freq = 1;
        }
    }
    if(freq < minFreq) {
        minFreq = freq;
        ans = v[i - 1];
    }
    return ans;
}

// 31

int maisFreq (int v[], int N) {
    int freq = 1, maxFreq = 0, ans = v[0];
    for(int i = 1; i < N; i++) {
        if(v[i] == v[i - 1]) freq++;
        if(v[i] != v[i - 1]) {
            if(freq > maxFreq) {
                maxFreq = freq;
                ans = v[i - 1];
            }
            freq = 1;
        }
    }
    return ans;
}

// 32

int maxCresc (int v[], int N) {
    int ans = 1, currAns = 1;
    for(int i = 1; i < N; i++) {
        if(v[i - 1] > v[i]) {
            ans = currAns > ans ? currAns : ans;
            currAns = 1;
        }
        else {
            currAns++;
        }
    }
    ans = currAns > ans ? currAns : ans;
    return ans;
}

// 33

int elimRep (int v[], int n) {
    int i = 1;
    while(i < n) {
        int belongs = 0;
        for(int j = 0; j < i; j++) {
            if(v[i] == v[j]) belongs = 1;
        }
        if(belongs) {
            for(int j = i; j < n; j++) {
                v[j] = v[j + 1];
            }
            n--;
        } else i++;
    }
    return n;
}

// 34

int elimRepOrd (int v[], int n) {return elimRep(v,n);}

// 35

int comunsOrd (int a[], int na, int b[], int nb) {
    int i = 0, j = 0, ans = 0;
    while(i < na && j < nb) {
        if(a[i++] == b[j++]) {
            ans++;
            i++;
            j++;
        }
        else if(a[i] > b[j]) j++;
        else i++;
    }
    return ans;
}

// 36

int comuns (int a[], int na, int b[], int nb) {
    int ans = 0;
    for(int i = 0; i < na; i++) {
        int belongs = 0;
        for(int j = 0; j < nb; j++) if(a[i] == b[j]) belongs = 1;
        if(belongs) ans++;
    }
    return ans;
}

// 37

int minInd (int v[], int n) {
    int minIndex = 0;
    for(int i = 1; i < n; i++) 
        if(v[i] < v[minIndex]) 
            minIndex = i;
    return minIndex;
}

// 38

void somasAc (int v[], int Ac [], int N) {
    for(int i = 0; i < N; i++) {
        Ac[i] = 0;
        for(int j = 0; j <= i; j++) {
            Ac[i] += v[j];
        }
    }
}

// 39

int triSup (int N, float m [N][N]) {
    int x = 1;
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < i; j++) {
            if(m[i][j]) x = 0;
        }
    }
    return x;
}

// 40

void transposta (int N, float m[N][N]) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < i; j++) {
            float temp = m[i][j];
            m[i][j] = m[j][i];
            m[j][i] = temp;
        }
    }
}

// 41

void addTo (int N, int M, int a[N][M], int b[N][M]) {
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < M; j++) {
            *(*(a + i)+j) += b[i][j];
        }
    }
}

// 42

int unionSet (int N, int v1[N], int v2[N], int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] || v2[i];
        len += r[i];
    }
    return len;
}

// 43

int intersectSet (int N, int v1[N], int v2[N],int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] && v2[i];
        len += r[i];
    }
    return len;
}

// 44

int intersectMSet (int N, int v1[N], int v2[N],int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] < v2[i] ? v1[i] : v2[i];
        len += r[i]; 
    }
    return len;
}

// 45

int unionMSet (int N, int v1[N], int v2[N], int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] + v2[i];
        len += r[i]; 
    }
    return len;
}

// 46

int cardinalMSet (int N, int v[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) len += v[i];
    return len;
}

// 47

typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;
typedef struct posicao {
    int x, y;
} Posicao;

Posicao posFinal (Posicao inicial, Movimento mov[], int N) {
    for(int i = 0; i < N; i++) {
        Movimento x = mov[i];
        if(x == Norte) inicial.y++;
        if(x == Este) inicial.x++;
        if(x == Sul) inicial.y--;
        if(x == Oeste) inicial.x--;
    }
    return inicial;
}

// 48

int caminho (Posicao inicial, Posicao final, Movimento mov[], int N) {
    int* xi = &inicial.x;
    int* yi = &inicial.y;
    int xf = final.x, yf = final.y, i;
    for(i = 0; i < N; i++) {
        if((*xi) < xf) {
            (*xi)++;
            mov[i] = Este;
        }
        else if ((*xi) > xf) {
            (*xi)--;
            mov[i] = Oeste;
        } 
        else if ((*yi) < yf) {
            (*yi)++;
            mov[i] = Norte;
        }
        else if ((*yi) > yf) {
            (*yi)--;
            mov[i] = Sul;
        }
        else break;
    }
    if(inicial.x != final.x || inicial.y != final.y) return -1;
    else return i;
}

// 49

int manDist(int x, int y, int x0, int y0) {return abs(x - x0) + abs(y - y0);}

int maisCentral (Posicao pos[], int N) {
    int minDist = manDist(pos[0].x,pos[0].y,0,0);
    int ans = 0, i;
    for(i = 1; i < N; i++) {
        if(manDist(pos[i].x,pos[i].y,0,0) < minDist) {
            ans = i;
            minDist = manDist(pos[i].x,pos[i].y,0,0);
        }
    }
    return ans;
}

// 50

int vizinhos (Posicao p, Posicao pos[], int N) {
    int ans = 0;
    for(int i = 0; i < N; i++) {
        if(manDist(pos[i].x,pos[i].y,p.x,p.y) == 1) ans++;
    }
    return ans;
}



