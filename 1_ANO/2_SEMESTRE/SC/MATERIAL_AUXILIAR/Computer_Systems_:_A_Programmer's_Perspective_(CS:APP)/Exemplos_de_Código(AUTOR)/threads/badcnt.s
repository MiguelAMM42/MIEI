	.file	"badcnt.c"
	.version	"01.01"
gcc2_compiled.:
.globl cnt
.data
	.align 4
	.type	 cnt,@object
	.size	 cnt,4
cnt:
	.long 0
.section	.rodata
.LC0:
	.string	"BOOM! cnt=%d\n"
.LC1:
	.string	"OK cnt=%d\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $24,%esp
	pushl $0
	pushl $count
	pushl $0
	leal -4(%ebp),%eax
	pushl %eax
	call Pthread_create
	addl $16,%esp
	pushl $0
	pushl $count
	pushl $0
	leal -8(%ebp),%eax
	pushl %eax
	call Pthread_create
	addl $16,%esp
	addl $-8,%esp
	pushl $0
	movl -4(%ebp),%eax
	pushl %eax
	call Pthread_join
	addl $16,%esp
	addl $-8,%esp
	pushl $0
	movl -8(%ebp),%eax
	pushl %eax
	call Pthread_join
	addl $16,%esp
	movl cnt,%eax
	cmpl $200000000,%eax
	je .L7
	addl $-8,%esp
	movl cnt,%eax
	pushl %eax
	pushl $.LC0
	call printf
	addl $16,%esp
	jmp .L8
	.p2align 4,,7
.L7:
	addl $-8,%esp
	movl cnt,%eax
	pushl %eax
	pushl $.LC1
	call printf
	addl $16,%esp
.L8:
	addl $-12,%esp
	pushl $0
	call exit
	addl $16,%esp
	.p2align 4,,7
.L6:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 main,.Lfe1-main
	.align 4
.globl count
	.type	 count,@function
count:
	pushl %ebp
	movl %esp,%ebp
	subl $24,%esp
	nop
	movl $0,-4(%ebp)
	.p2align 4,,7
.L10:
	movl -4(%ebp),%eax
	cmpl $99999999,%eax
	jle .L13
	jmp .L11
	.p2align 4,,7
.L13:
	movl cnt,%eax
	leal 1(%eax),%edx
	movl %edx,cnt
.L12:
	movl -4(%ebp),%eax
	leal 1(%eax),%edx
	movl %edx,-4(%ebp)
	jmp .L10
	.p2align 4,,7
.L11:
	xorl %eax,%eax
	jmp .L9
	.p2align 4,,7
.L9:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 count,.Lfe2-count
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
