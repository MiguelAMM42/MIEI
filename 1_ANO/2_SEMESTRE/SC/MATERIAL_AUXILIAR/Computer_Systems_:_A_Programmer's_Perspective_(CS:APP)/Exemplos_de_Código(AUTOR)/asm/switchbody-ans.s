	.file	"switchbody-ans.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl switch_prob
	.type	 switch_prob,@function
switch_prob:
	pushl %ebp
	movl %esp,%ebp
	movl 8(%ebp),%eax
	leal -50(%eax),%edx
	cmpl $5,%edx
	ja .L9
	jmp *.L10(,%edx,4)
	.p2align 4,,7
.section	.rodata
	.align 4
	.align 4
.L10:
	.long .L5
	.long .L9
	.long .L5
	.long .L6
	.long .L7
	.long .L8
.text
	.p2align 4,,7
.L5:
	sall $2,%eax
	jmp .L3
	.p2align 4,,7
.L6:
	sarl $2,%eax
	jmp .L3
	.p2align 4,,7
.L7:
	leal (%eax,%eax,2),%eax
.L8:
	imull %eax,%eax
.L9:
	addl $10,%eax
.L3:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 switch_prob,.Lfe1-switch_prob
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $8,%esp
	addl $-12,%esp
	pushl $53
	call switch_prob
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 main,.Lfe2-main
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
