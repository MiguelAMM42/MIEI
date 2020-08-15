	.file	"fcomp.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl recip
	.type	 recip,@function
recip:
	pushl %ebp
	movl %esp,%ebp
	subl $24,%esp
	movl 8(%ebp),%eax
	fld1
	movl %eax,-4(%ebp)
	fildl -4(%ebp)
	fdivrp %st,%st(1)
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 recip,.Lfe1-recip
	.align 4
.globl do_nothing
	.type	 do_nothing,@function
do_nothing:
	pushl %ebp
	movl %esp,%ebp
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 do_nothing,.Lfe2-do_nothing
.section	.rodata
.LC0:
	.string	"test1 t1: r1 %f %c= r2 %f\n"
.LC1:
	.string	"test1 t2: r1 %f %c= r2 %f\n"
.text
	.align 4
.globl test1
	.type	 test1,@function
test1:
	pushl %ebp
	movl %esp,%ebp
	subl $32,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call recip
	fstpl -8(%ebp)
	addl $-12,%esp
	pushl %ebx
	call recip
	fstl -16(%ebp)
	fldl -8(%ebp)
	addl $32,%esp
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%ebx
	call do_nothing
	fldl -8(%ebp)
	fldl -16(%ebp)
	addl $-8,%esp
	subl $8,%esp
	fstl (%esp)
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%esi
	movl $33,%eax
	testl %ebx,%ebx
	je .L35
	movl $61,%eax
.L35:
	pushl %eax
	pushl -4(%ebp)
	pushl -8(%ebp)
	pushl $.LC0
	call printf
	addl $32,%esp
	addl $-8,%esp
	pushl -12(%ebp)
	pushl -16(%ebp)
	movl $33,%eax
	testl %esi,%esi
	je .L37
	movl $61,%eax
.L37:
	pushl %eax
	pushl -4(%ebp)
	pushl -8(%ebp)
	pushl $.LC1
	call printf
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe3:
	.size	 test1,.Lfe3-test1
.section	.rodata
.LC2:
	.string	"test2 t1: r1 %f %c= r2 %f\n"
.LC3:
	.string	"test2 t2: r1 %f %c= r2 %f\n"
.text
	.align 4
.globl test2
	.type	 test2,@function
test2:
	pushl %ebp
	movl %esp,%ebp
	subl $32,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call recip
	fstpl -16(%ebp)
	movl %ebx,-4(%ebp)
	fildl -4(%ebp)
	movl $0,-24(%ebp)
	movl $1072693248,-20(%ebp)
	fdivrl -24(%ebp)
	fldl -16(%ebp)
	addl $16,%esp
	fucomp %st(1)
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%ebx
	fstpl -24(%ebp)
	call do_nothing
	fldl -16(%ebp)
	fldl -24(%ebp)
	addl $-8,%esp
	subl $8,%esp
	fstl (%esp)
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%esi
	movl $33,%eax
	testl %ebx,%ebx
	je .L40
	movl $61,%eax
.L40:
	pushl %eax
	pushl -12(%ebp)
	pushl -16(%ebp)
	pushl $.LC2
	call printf
	addl $32,%esp
	addl $-8,%esp
	pushl -20(%ebp)
	pushl -24(%ebp)
	movl $33,%eax
	testl %esi,%esi
	je .L42
	movl $61,%eax
.L42:
	pushl %eax
	pushl -12(%ebp)
	pushl -16(%ebp)
	pushl $.LC3
	call printf
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe4:
	.size	 test2,.Lfe4-test2
	.align 4
.globl recip_l
	.type	 recip_l,@function
recip_l:
	pushl %ebp
	movl %esp,%ebp
	subl $24,%esp
	movl 8(%ebp),%eax
	movl %eax,-4(%ebp)
	fildl -4(%ebp)
	fld1
	fdivp %st,%st(1)
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe5:
	.size	 recip_l,.Lfe5-recip_l
.section	.rodata
.LC4:
	.string	"test3 t1: r1 %f %c= r2 %f\n"
.LC5:
	.string	"test3 t2: r1 %f %c= r2 %f\n"
.text
	.align 4
.globl test3
	.type	 test3,@function
test3:
	pushl %ebp
	movl %esp,%ebp
	subl $80,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call recip_l
	fstpt -32(%ebp)
	addl $-12,%esp
	pushl %ebx
	call recip_l
	fld %st(0)
	fstpt -48(%ebp)
	addl $32,%esp
	fldt -32(%ebp)
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%ebx
	call do_nothing
	fldt -48(%ebp)
	fstl -56(%ebp)
	fldt -32(%ebp)
	fucompp
	fnstsw %ax
	andb $69,%ah
	cmpb $64,%ah
	sete %al
	movzbl %al,%esi
	addl $-8,%esp
	pushl -52(%ebp)
	pushl -56(%ebp)
	movl $33,%eax
	testl %ebx,%ebx
	je .L46
	movl $61,%eax
.L46:
	pushl %eax
	fldt -32(%ebp)
	fstpl -64(%ebp)
	pushl -60(%ebp)
	pushl -64(%ebp)
	pushl $.LC4
	call printf
	addl $32,%esp
	addl $-8,%esp
	pushl -52(%ebp)
	pushl -56(%ebp)
	movl $33,%eax
	testl %esi,%esi
	je .L48
	movl $61,%eax
.L48:
	pushl %eax
	pushl -60(%ebp)
	pushl -64(%ebp)
	pushl $.LC5
	call printf
	leal -88(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe6:
	.size	 test3,.Lfe6-test3
.section	.rodata
	.align 32
.LC6:
	.string	"A long double on this machine requires %d bytes\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $20,%esp
	pushl %ebx
	movl 12(%ebp),%eax
	movl 4(%eax),%eax
	pushl $0
	pushl $10
	pushl $0
	pushl %eax
	call __strtol_internal
	movl %eax,%ebx
	addl $16,%esp
	addl $-12,%esp
	pushl %ebx
	call test1
	addl $-12,%esp
	pushl %ebx
	call test2
	addl $32,%esp
	addl $-12,%esp
	pushl %ebx
	call test3
	addl $-8,%esp
	pushl $12
	pushl $.LC6
	call printf
	movl -24(%ebp),%ebx
	xorl %eax,%eax
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe7:
	.size	 main,.Lfe7-main
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
