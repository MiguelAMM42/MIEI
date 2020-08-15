	.file	"bufbomb.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl getxs
	.type	 getxs,@function
getxs:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl $1,%esi
	xorl %edi,%edi
	jmp .L39
	.p2align 4,,7
.L41:
	movl __ctype_b,%eax
	testb $16,1(%eax,%edx,2)
	je .L39
	leal -48(%edx),%eax
	cmpl $9,%eax
	ja .L45
	movl %eax,%ecx
	jmp .L46
	.p2align 4,,7
.L45:
	leal -65(%edx),%eax
	leal -87(%edx),%ecx
	cmpl $5,%eax
	ja .L46
	leal -55(%edx),%ecx
.L46:
	testl %esi,%esi
	je .L49
	movl %ecx,%edi
	xorl %esi,%esi
	jmp .L39
	.p2align 4,,7
.L49:
	movl %edi,%eax
	salb $4,%al
	addb %cl,%al
	movb %al,(%ebx)
	incl %ebx
	movl $1,%esi
.L39:
	movl stdin,%eax
	addl $-12,%esp
	pushl %eax
	call _IO_getc
	movl %eax,%edx
	addl $16,%esp
	cmpl $-1,%edx
	je .L40
	cmpl $10,%edx
	jne .L41
.L40:
	movb $0,(%ebx)
	movl 8(%ebp),%eax
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 getxs,.Lfe1-getxs
	.align 4
.globl getbuf
	.type	 getbuf,@function
getbuf:
	pushl %ebp
	movl %esp,%ebp
	subl $24,%esp
	addl $-12,%esp
	leal -12(%ebp),%eax
	pushl %eax
	call getxs
	movl $1,%eax
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 getbuf,.Lfe2-getbuf
.section	.rodata
.LC0:
	.string	"Allocated %d bytes on stack\n"
.LC1:
	.string	"Type Hex string:"
.LC2:
	.string	"getbuf returned 0x%x\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $72,%esp
	leal -64(%ebp),%edx
	andl $4095,%edx
	leal 15(%edx),%eax
	andl $8176,%eax
	subl %eax,%esp
	addl $-8,%esp
	pushl %edx
	pushl $.LC0
	call printf
	addl $-12,%esp
	pushl $.LC1
	call printf
	addl $32,%esp
	call getbuf
	addl $-8,%esp
	pushl %eax
	pushl $.LC2
	call printf
	xorl %eax,%eax
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe3:
	.size	 main,.Lfe3-main
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
