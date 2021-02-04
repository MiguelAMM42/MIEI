#include <stdio.h>
#include <stdlib.h>


//FILE * fopen (const char * restrict path, const char * restrict mode);
// fclose

// acesso a ficheiros de texto:
// fputc
// fgetc
// fprintf
// fscanf

// acesso a ficheiros "binários"
// fread
// fread(void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
//       | zona de memoria |    tamanho                | ficheiro             |
// fwrite(void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
//       | zona de memoria |    tamanho                | ficheiro             |

// int fseek(FILE *stream, long offset, int whence);
//           ficheiro    | posicao    | referencial
//     referencial : SEEK_SET  (a partir do inicio do ficheiro)
//                   SEEK_CUR  (a partir da posição actual)
//                   SEEK_END  (a partir do fim do ficheiro)

// long ftell (FILE *stream); diz qual a posição onde estamos.
// fseek (f, 0, SEEK_SET) // posicionar na primeira posição do ficheiro

// fseek (f, 10, SEEK_SET) // posicionar na posição 10 do ficheiro
// fseek (f,  3, SEEK_CUR) // posicionar na posição 13 do ficheiro
// fseek (f, -4, SEEK_CUR) // posicionar na posição  9 do ficheiro




int main (int argc // numero de argumentos com que foi chamado
	     ,char *argv[] // argumentos do programa
	     ) {

	// int i, n[10];

	FILE *f;

	if (argc == 2) {
       // f = fopen (argv[1], "r");  // para leitura
       // f = fopen (argv[1], "w");  // para escrita
       // f = fopen (argv[1], "a");  // para escrita no final do ficheiro

	   // f = fopen (argv[1], "r+"); // para leitura e escrita, dá erro se o ficheiro não existir
	   // f = fopen (argv[1], "w+"); // para escrita e leitura, apagando o conteudo
	   // f = fopen (argv[1], "a+"); // para escrita no final e leitura
       
       f = fopen (argv[1], "a+");
       if (f == NULL)
       	  printf ("Ficheiro não existe\n");
       else {
       	  fseek (f, -4, SEEK_END); // posicionar no último byte
       	  fwrite ("XYZW", 4, 1, f);
       	  ftell 
          fclose (f);
      }
	}
    
	return 0;
}At