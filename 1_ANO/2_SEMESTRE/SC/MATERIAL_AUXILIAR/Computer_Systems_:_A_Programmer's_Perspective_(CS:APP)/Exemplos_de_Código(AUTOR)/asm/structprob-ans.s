	.file	"structprob-ans.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl test
	.type	 test,@function
test:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	movl 8(%ebp),%eax
	movl 12(%ebp),%ecx
	leal (%eax,%eax,4),%eax
	leal 4(%ecx,%eax,4),%eax
	movl (%eax),%edx
	sall $2,%edx
	movl 184(%ecx),%ebx
	addl (%ecx),%ebx
	movl %ebx,4(%edx,%eax)
	popl %ebx
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 test,.Lfe1-test
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
