
structprob-ans.o:     file format elf32-i386

Disassembly of section .text:

00000000 <test>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	8b 45 08             	mov    0x8(%ebp),%eax
   7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
   a:	8d 04 80             	lea    (%eax,%eax,4),%eax
   d:	8d 44 81 04          	lea    0x4(%ecx,%eax,4),%eax
  11:	8b 10                	mov    (%eax),%edx
  13:	c1 e2 02             	shl    $0x2,%edx
  16:	8b 99 b8 00 00 00    	mov    0xb8(%ecx),%ebx
  1c:	03 19                	add    (%ecx),%ebx
  1e:	89 5c 02 04          	mov    %ebx,0x4(%edx,%eax,1)
  22:	5b                   	pop    %ebx
  23:	89 ec                	mov    %ebp,%esp
  25:	5d                   	pop    %ebp
  26:	c3                   	ret    
