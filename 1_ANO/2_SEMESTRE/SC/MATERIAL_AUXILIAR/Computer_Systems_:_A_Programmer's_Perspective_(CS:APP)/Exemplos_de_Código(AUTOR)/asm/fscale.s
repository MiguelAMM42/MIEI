	.file	"fscale.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl scale_kludge
	.type	 scale_kludge,@function
scale_kludge:
	pushl %ebp
	movl %esp,%ebp
#APP
	fildl 16(%ebp); fldl 8(%ebp); fscale; fstpl val; fstp %st(0)
#NO_APP
	fldl val
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 scale_kludge,.Lfe1-scale_kludge
	.align 4
.globl scale
	.type	 scale,@function
scale:
	pushl %ebp
	movl %esp,%ebp
#APP
	fildl 16(%ebp); fldl 8(%ebp); fscale; movl 20(%ebp),%eax;
        fstpl (%eax); fstp %st(0)
#NO_APP
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 scale,.Lfe2-scale
.section	.rodata
	.align 32
.LC0:
	.string	"scale_kludge: %f * 2**%d = %f\n"
.LC1:
	.string	"scale: %f * 2**%d = %f\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
	pushl %ebp
	movl %esp,%ebp
	subl $36,%esp
	pushl %ebx
	movl 12(%ebp),%ebx
	addl $-4,%esp
	movl 4(%ebx),%eax
	pushl $0
	pushl $0
	pushl %eax
	call __strtod_internal
	fstpl -16(%ebp)
	movl 8(%ebx),%eax
	addl $16,%esp
	pushl $0
	pushl $10
	pushl $0
	pushl %eax
	call __strtol_internal
	movl %eax,%ebx
	addl $16,%esp
	addl $-4,%esp
	pushl %ebx
	pushl -12(%ebp)
	pushl -16(%ebp)
	call scale_kludge
	fstl -8(%ebp)
	addl $-8,%esp
	subl $8,%esp
	fstpl (%esp)
	pushl %ebx
	pushl -12(%ebp)
	pushl -16(%ebp)
	pushl $.LC0
	call printf
	addl $48,%esp
	leal -8(%ebp),%eax
	pushl %eax
	pushl %ebx
	pushl -12(%ebp)
	pushl -16(%ebp)
	call scale
	fldl -8(%ebp)
	addl $-8,%esp
	subl $8,%esp
	fstpl (%esp)
	pushl %ebx
	pushl -12(%ebp)
	pushl -16(%ebp)
	pushl $.LC1
	call printf
	movl -40(%ebp),%ebx
	xorl %eax,%eax
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe3:
	.size	 main,.Lfe3-main
	.local	val
	.comm	val,8,8
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
