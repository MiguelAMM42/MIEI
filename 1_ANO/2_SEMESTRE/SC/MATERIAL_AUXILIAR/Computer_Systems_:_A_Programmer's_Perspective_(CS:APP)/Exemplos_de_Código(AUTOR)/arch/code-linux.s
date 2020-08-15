	.file	"code-linux.c"
	.version	"01.01"
gcc2_compiled.:
.globl array
.data
	.align 4
	.type	 array,@object
array:
	.long 13
	.long 192
	.long 2816
	.long 40960
	.size	 array,16
.text
	.align 4
.globl Sum
	.type	 Sum,@function
Sum:
	pushl %ebp
	movl %esp,%ebp
	movl 8(%ebp),%ecx
	movl 12(%ebp),%edx
	xorl %eax,%eax
	testl %edx,%edx
	je .L34
	.p2align 4,,7
.L35:
	addl (%ecx),%eax
	addl $4,%ecx
	decl %edx
	jnz .L35
.L34:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 Sum,.Lfe1-Sum
.section	.rodata
.LC0:
	.string	"0x%x\n"
.text
	.align 4
.globl Prog
	.type	 Prog,@function
Prog:
	pushl %ebp
	movl %esp,%ebp
	subl $8,%esp
	addl $-8,%esp
	pushl $4
	pushl $array
	call Sum
	addl $-8,%esp
	pushl %eax
	pushl $.LC0
	call printf
	addl $32,%esp
	addl $-12,%esp
	pushl $0
	call exit
.Lfe2:
	.size	 Prog,.Lfe2-Prog
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $8,%esp
	call Prog
	xorl %eax,%eax
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe3:
	.size	 main,.Lfe3-main
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
