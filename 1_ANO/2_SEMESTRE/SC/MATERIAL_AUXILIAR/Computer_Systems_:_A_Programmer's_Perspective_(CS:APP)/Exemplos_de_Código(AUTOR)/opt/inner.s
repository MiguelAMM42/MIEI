	.file	"inner.c"
	.version	"01.01"
gcc2_compiled.:
.globl abstract_descr
.data
	.align 32
	.type	 abstract_descr,@object
	.size	 abstract_descr,32
abstract_descr:
	.string	"Maximum use of data abstraction"
.text
	.align 4
.globl abstract_inner
	.type	 abstract_inner,@function
abstract_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%edi
	movl 16(%ebp),%esi
	movl $0,(%esi)
	xorl %ebx,%ebx
	jmp .L3
	.p2align 4,,7
.L6:
	addl $-4,%esp
	leal -4(%ebp),%eax
	pushl %eax
	pushl %ebx
	pushl %edi
	call get_vec_element
	addl $-4,%esp
	leal -8(%ebp),%eax
	pushl %eax
	pushl %ebx
	movl 12(%ebp),%eax
	pushl %eax
	call get_vec_element
	movl -4(%ebp),%eax
	imull -8(%ebp),%eax
	addl %eax,(%esi)
	addl $32,%esp
	incl %ebx
.L3:
	addl $-12,%esp
	pushl %edi
	call vec_length
	addl $16,%esp
	cmpl %eax,%ebx
	jl .L6
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 abstract_inner,.Lfe1-abstract_inner
.globl motion_descr
.data
	.type	 motion_descr,@object
	.size	 motion_descr,30
motion_descr:
	.string	"Take vec_length() out of loop"
.text
	.align 4
.globl motion_inner
	.type	 motion_inner,@function
motion_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 16(%ebp),%edi
	movl 8(%ebp),%eax
	addl $-12,%esp
	pushl %eax
	call vec_length
	movl %eax,%esi
	movl $0,(%edi)
	xorl %ebx,%ebx
	addl $16,%esp
	cmpl %esi,%ebx
	jge .L10
	.p2align 4,,7
.L12:
	addl $-4,%esp
	leal -4(%ebp),%eax
	pushl %eax
	pushl %ebx
	movl 8(%ebp),%eax
	pushl %eax
	call get_vec_element
	addl $-4,%esp
	leal -8(%ebp),%eax
	pushl %eax
	pushl %ebx
	movl 12(%ebp),%eax
	pushl %eax
	call get_vec_element
	movl -4(%ebp),%eax
	imull -8(%ebp),%eax
	addl %eax,(%edi)
	addl $32,%esp
	incl %ebx
	cmpl %esi,%ebx
	jl .L12
.L10:
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe2:
	.size	 motion_inner,.Lfe2-motion_inner
.globl array_descr
.data
	.align 32
	.type	 array_descr,@object
	.size	 array_descr,31
array_descr:
	.string	"Array reference to vector data"
.text
	.align 4
.globl array_inner
	.type	 array_inner,@function
array_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 16(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	movl 12(%ebp),%eax
	addl $32,%esp
	addl $-12,%esp
	pushl %eax
	call get_vec_start
	movl %eax,%ecx
	movl $0,(%esi)
	xorl %edx,%edx
	cmpl %edi,%edx
	jge .L16
	.p2align 4,,7
.L18:
	movl (%ebx,%edx,4),%eax
	imull (%ecx,%edx,4),%eax
	addl %eax,(%esi)
	incl %edx
	cmpl %edi,%edx
	jl .L18
.L16:
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe3:
	.size	 array_inner,.Lfe3-array_inner
.globl inner4_descr
.data
	.align 32
	.type	 inner4_descr,@object
	.size	 inner4_descr,49
inner4_descr:
	.string	"inner4: Array reference, accumulate in temporary"
.text
	.align 4
.globl inner4
	.type	 inner4,@function
inner4:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%esi
	movl 12(%ebp),%eax
	addl $32,%esp
	addl $-12,%esp
	pushl %eax
	call get_vec_start
	movl %eax,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %edi,%ecx
	jge .L22
	.p2align 4,,7
.L24:
	movl (%esi,%edx,4),%eax
	imull (%ebx,%edx,4),%eax
	addl %eax,%ecx
	incl %edx
	cmpl %edi,%edx
	jl .L24
.L22:
	movl 16(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe4:
	.size	 inner4,.Lfe4-inner4
.globl pointer_descr
.data
	.align 32
	.type	 pointer_descr,@object
	.size	 pointer_descr,43
pointer_descr:
	.string	"Pointer reference, accumulate in temporary"
.text
	.align 4
.globl pointer_inner
	.type	 pointer_inner,@function
pointer_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%edx
	leal (%ebx,%edi,4),%ecx
	xorl %esi,%esi
	cmpl %ecx,%ebx
	jae .L28
	.p2align 4,,7
.L30:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%esi
	addl $4,%ebx
	addl $4,%edx
	cmpl %ecx,%ebx
	jb .L30
.L28:
	movl 16(%ebp),%eax
	movl %esi,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe5:
	.size	 pointer_inner,.Lfe5-pointer_inner
.globl unroll2a_descr
.data
	.type	 unroll2a_descr,@object
	.size	 unroll2a_descr,26
unroll2a_descr:
	.string	"Array code, unrolled by 2"
.text
	.align 4
.globl unroll2a_inner
	.type	 unroll2a_inner,@function
unroll2a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%edi
	movl 12(%ebp),%eax
	decl %esi
	addl $32,%esp
	addl $-12,%esp
	pushl %eax
	call get_vec_start
	movl %eax,%ebx
	xorl %edx,%edx
	xorl %ecx,%ecx
	cmpl %esi,%edx
	jge .L44
	.p2align 4,,7
.L36:
	movl (%edi,%ecx,4),%eax
	imull (%ebx,%ecx,4),%eax
	addl %edx,%eax
	movl 4(%edi,%ecx,4),%edx
	imull 4(%ebx,%ecx,4),%edx
	addl %eax,%edx
	addl $2,%ecx
	cmpl %esi,%ecx
	jl .L36
	jmp .L44
	.p2align 4,,7
.L41:
	movl (%edi,%ecx,4),%eax
	imull (%ebx,%ecx,4),%eax
	addl %eax,%edx
	incl %ecx
.L44:
	cmpl -4(%ebp),%ecx
	jl .L41
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe6:
	.size	 unroll2a_inner,.Lfe6-unroll2a_inner
.globl unroll8a_descr
.data
	.type	 unroll8a_descr,@object
	.size	 unroll8a_descr,26
unroll8a_descr:
	.string	"Array code, unrolled by 8"
.text
	.align 4
.globl unroll8a_inner
	.type	 unroll8a_inner,@function
unroll8a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	leal -7(%edi),%eax
	movl %eax,-4(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-8(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-12(%ebp)
	xorl %edx,%edx
	xorl %esi,%esi
	cmpl -4(%ebp),%edx
	jge .L57
	movl -8(%ebp),%ecx
	movl %eax,%ebx
	.p2align 4,,7
.L49:
	movl (%ecx),%eax
	imull (%ebx),%eax
	addl %edx,%eax
	movl 4(%ecx),%edx
	imull 4(%ebx),%edx
	addl %edx,%eax
	movl 8(%ecx),%edx
	imull 8(%ebx),%edx
	addl %edx,%eax
	movl 12(%ecx),%edx
	imull 12(%ebx),%edx
	addl %edx,%eax
	movl 16(%ecx),%edx
	imull 16(%ebx),%edx
	addl %edx,%eax
	movl 20(%ecx),%edx
	imull 20(%ebx),%edx
	addl %edx,%eax
	movl 24(%ecx),%edx
	imull 24(%ebx),%edx
	addl %edx,%eax
	movl 28(%ecx),%edx
	imull 28(%ebx),%edx
	addl %eax,%edx
	addl $32,%ebx
	addl $32,%ecx
	addl $8,%esi
	cmpl -4(%ebp),%esi
	jl .L49
	jmp .L57
	.p2align 4,,7
.L54:
	movl -8(%ebp),%ecx
	movl (%ecx,%esi,4),%eax
	movl -12(%ebp),%ecx
	imull (%ecx,%esi,4),%eax
	addl %eax,%edx
	incl %esi
.L57:
	cmpl %edi,%esi
	jl .L54
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe7:
	.size	 unroll8a_inner,.Lfe7-unroll8a_inner
.globl unroll16a_descr
.data
	.type	 unroll16a_descr,@object
	.size	 unroll16a_descr,27
unroll16a_descr:
	.string	"Array code, unrolled by 16"
.text
	.align 4
.globl unroll16a_inner
	.type	 unroll16a_inner,@function
unroll16a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	leal -15(%edi),%eax
	movl %eax,-4(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-8(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-12(%ebp)
	xorl %edx,%edx
	xorl %esi,%esi
	cmpl -4(%ebp),%edx
	jge .L70
	movl -8(%ebp),%ecx
	movl %eax,%ebx
	.p2align 4,,7
.L62:
	movl (%ecx),%eax
	imull (%ebx),%eax
	addl %edx,%eax
	movl 4(%ecx),%edx
	imull 4(%ebx),%edx
	addl %edx,%eax
	movl 8(%ecx),%edx
	imull 8(%ebx),%edx
	addl %edx,%eax
	movl 12(%ecx),%edx
	imull 12(%ebx),%edx
	addl %edx,%eax
	movl 16(%ecx),%edx
	imull 16(%ebx),%edx
	addl %edx,%eax
	movl 20(%ecx),%edx
	imull 20(%ebx),%edx
	addl %edx,%eax
	movl 24(%ecx),%edx
	imull 24(%ebx),%edx
	addl %edx,%eax
	movl 28(%ecx),%edx
	imull 28(%ebx),%edx
	addl %edx,%eax
	movl 32(%ecx),%edx
	imull 32(%ebx),%edx
	addl %edx,%eax
	movl 36(%ecx),%edx
	imull 36(%ebx),%edx
	addl %edx,%eax
	movl 40(%ecx),%edx
	imull 40(%ebx),%edx
	addl %edx,%eax
	movl 44(%ecx),%edx
	imull 44(%ebx),%edx
	addl %edx,%eax
	movl 48(%ecx),%edx
	imull 48(%ebx),%edx
	addl %edx,%eax
	movl 52(%ecx),%edx
	imull 52(%ebx),%edx
	addl %edx,%eax
	movl 56(%ecx),%edx
	imull 56(%ebx),%edx
	addl %edx,%eax
	movl 60(%ecx),%edx
	imull 60(%ebx),%edx
	addl %eax,%edx
	addl $64,%ebx
	addl $64,%ecx
	addl $16,%esi
	cmpl -4(%ebp),%esi
	jl .L62
	jmp .L70
	.p2align 4,,7
.L67:
	movl -8(%ebp),%ecx
	movl (%ecx,%esi,4),%eax
	movl -12(%ebp),%ecx
	imull (%ecx,%esi,4),%eax
	addl %eax,%edx
	incl %esi
.L70:
	cmpl %edi,%esi
	jl .L67
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe8:
	.size	 unroll16a_inner,.Lfe8-unroll16a_inner
.globl unroll2_descr
.data
	.type	 unroll2_descr,@object
	.size	 unroll2_descr,28
unroll2_descr:
	.string	"Pointer code, unrolled by 2"
.text
	.align 4
.globl unroll2_inner
	.type	 unroll2_inner,@function
unroll2_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%ecx
	leal -4(%ebx,%edi,4),%esi
	xorl %edx,%edx
	cmpl %esi,%ebx
	jae .L73
	.p2align 4,,7
.L75:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %edx,%eax
	movl 4(%ebx),%edx
	imull 4(%ecx),%edx
	addl %eax,%edx
	addl $8,%ebx
	addl $8,%ecx
	cmpl %esi,%ebx
	jb .L75
.L73:
	addl $4,%esi
	cmpl %esi,%ebx
	jae .L78
	.p2align 4,,7
.L80:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	addl $4,%ebx
	addl $4,%ecx
	cmpl %esi,%ebx
	jb .L80
.L78:
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe9:
	.size	 unroll2_inner,.Lfe9-unroll2_inner
.globl unroll4_descr
.data
	.type	 unroll4_descr,@object
	.size	 unroll4_descr,28
unroll4_descr:
	.string	"Pointer code, unrolled by 4"
.text
	.align 4
.globl unroll4_inner
	.type	 unroll4_inner,@function
unroll4_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%ecx
	leal -12(%ebx,%edi,4),%esi
	xorl %edx,%edx
	cmpl %esi,%ebx
	jae .L84
	.p2align 4,,7
.L86:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %edx,%eax
	movl 4(%ebx),%edx
	imull 4(%ecx),%edx
	addl %edx,%eax
	movl 8(%ebx),%edx
	imull 8(%ecx),%edx
	addl %edx,%eax
	movl 12(%ebx),%edx
	imull 12(%ecx),%edx
	addl %eax,%edx
	addl $16,%ebx
	addl $16,%ecx
	cmpl %esi,%ebx
	jb .L86
.L84:
	addl $12,%esi
	cmpl %esi,%ebx
	jae .L89
	.p2align 4,,7
.L91:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	addl $4,%ebx
	addl $4,%ecx
	cmpl %esi,%ebx
	jb .L91
.L89:
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe10:
	.size	 unroll4_inner,.Lfe10-unroll4_inner
.globl unroll8_descr
.data
	.type	 unroll8_descr,@object
	.size	 unroll8_descr,28
unroll8_descr:
	.string	"Pointer code, unrolled by 8"
.text
	.align 4
.globl unroll8_inner
	.type	 unroll8_inner,@function
unroll8_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%ecx
	leal -28(%ebx,%edi,4),%esi
	xorl %edx,%edx
	cmpl %esi,%ebx
	jae .L95
	.p2align 4,,7
.L97:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %edx,%eax
	movl 4(%ebx),%edx
	imull 4(%ecx),%edx
	addl %edx,%eax
	movl 8(%ebx),%edx
	imull 8(%ecx),%edx
	addl %edx,%eax
	movl 12(%ebx),%edx
	imull 12(%ecx),%edx
	addl %edx,%eax
	movl 16(%ebx),%edx
	imull 16(%ecx),%edx
	addl %edx,%eax
	movl 20(%ebx),%edx
	imull 20(%ecx),%edx
	addl %edx,%eax
	movl 24(%ebx),%edx
	imull 24(%ecx),%edx
	addl %edx,%eax
	movl 28(%ebx),%edx
	imull 28(%ecx),%edx
	addl %eax,%edx
	addl $32,%ebx
	addl $32,%ecx
	cmpl %esi,%ebx
	jb .L97
.L95:
	addl $28,%esi
	cmpl %esi,%ebx
	jae .L100
	.p2align 4,,7
.L102:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	addl $4,%ebx
	addl $4,%ecx
	cmpl %esi,%ebx
	jb .L102
.L100:
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe11:
	.size	 unroll8_inner,.Lfe11-unroll8_inner
.globl unroll16_descr
.data
	.type	 unroll16_descr,@object
	.size	 unroll16_descr,29
unroll16_descr:
	.string	"Pointer code, unrolled by 16"
.text
	.align 4
.globl unroll16_inner
	.type	 unroll16_inner,@function
unroll16_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%ecx
	leal -60(%ebx,%edi,4),%esi
	xorl %edx,%edx
	cmpl %esi,%ebx
	jae .L106
	.p2align 4,,7
.L108:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %edx,%eax
	movl 4(%ebx),%edx
	imull 4(%ecx),%edx
	addl %edx,%eax
	movl 8(%ebx),%edx
	imull 8(%ecx),%edx
	addl %edx,%eax
	movl 12(%ebx),%edx
	imull 12(%ecx),%edx
	addl %edx,%eax
	movl 16(%ebx),%edx
	imull 16(%ecx),%edx
	addl %edx,%eax
	movl 20(%ebx),%edx
	imull 20(%ecx),%edx
	addl %edx,%eax
	movl 24(%ebx),%edx
	imull 24(%ecx),%edx
	addl %edx,%eax
	movl 28(%ebx),%edx
	imull 28(%ecx),%edx
	addl %edx,%eax
	movl 32(%ebx),%edx
	imull 32(%ecx),%edx
	addl %edx,%eax
	movl 36(%ebx),%edx
	imull 36(%ecx),%edx
	addl %edx,%eax
	movl 40(%ebx),%edx
	imull 40(%ecx),%edx
	addl %edx,%eax
	movl 44(%ebx),%edx
	imull 44(%ecx),%edx
	addl %edx,%eax
	movl 48(%ebx),%edx
	imull 48(%ecx),%edx
	addl %edx,%eax
	movl 52(%ebx),%edx
	imull 52(%ecx),%edx
	addl %edx,%eax
	movl 56(%ebx),%edx
	imull 56(%ecx),%edx
	addl %edx,%eax
	movl 60(%ebx),%edx
	imull 60(%ecx),%edx
	addl %eax,%edx
	addl $64,%ebx
	addl $64,%ecx
	cmpl %esi,%ebx
	jb .L108
.L106:
	addl $60,%esi
	cmpl %esi,%ebx
	jae .L111
	.p2align 4,,7
.L113:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	addl $4,%ebx
	addl $4,%ecx
	cmpl %esi,%ebx
	jb .L113
.L111:
	movl 16(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe12:
	.size	 unroll16_inner,.Lfe12-unroll16_inner
.globl unroll8x2a_descr
.data
	.align 32
	.type	 unroll8x2a_descr,@object
	.size	 unroll8x2a_descr,42
unroll8x2a_descr:
	.string	"Array code, unrolled by 8, Superscalar x2"
.text
	.align 4
.globl unroll8x2a_inner
	.type	 unroll8x2a_inner,@function
unroll8x2a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	addl $-7,%eax
	movl %eax,-8(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-12(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-16(%ebp)
	xorl %ebx,%ebx
	xorl %edi,%edi
	xorl %esi,%esi
	cmpl -8(%ebp),%ebx
	jge .L127
	movl -12(%ebp),%edx
	movl %eax,%ecx
	.p2align 4,,7
.L119:
	movl (%edx),%eax
	imull (%ecx),%eax
	addl %eax,%ebx
	movl 4(%edx),%eax
	imull 4(%ecx),%eax
	addl %eax,%edi
	movl 8(%edx),%eax
	imull 8(%ecx),%eax
	addl %eax,%ebx
	movl 12(%edx),%eax
	imull 12(%ecx),%eax
	addl %eax,%edi
	movl 16(%edx),%eax
	imull 16(%ecx),%eax
	addl %eax,%ebx
	movl 20(%edx),%eax
	imull 20(%ecx),%eax
	addl %eax,%edi
	movl 24(%edx),%eax
	imull 24(%ecx),%eax
	addl %eax,%ebx
	movl 28(%edx),%eax
	imull 28(%ecx),%eax
	addl %eax,%edi
	addl $32,%ecx
	addl $32,%edx
	addl $8,%esi
	cmpl -8(%ebp),%esi
	jl .L119
	jmp .L127
	.p2align 4,,7
.L124:
	movl -12(%ebp),%edx
	movl (%edx,%esi,4),%eax
	movl -16(%ebp),%edx
	imull (%edx,%esi,4),%eax
	addl %eax,%ebx
	incl %esi
.L127:
	cmpl -4(%ebp),%esi
	jl .L124
	movl 16(%ebp),%eax
	addl %edi,%ebx
	movl %ebx,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe13:
	.size	 unroll8x2a_inner,.Lfe13-unroll8x2a_inner
.globl unroll8x4a_descr
.data
	.align 32
	.type	 unroll8x4a_descr,@object
	.size	 unroll8x4a_descr,42
unroll8x4a_descr:
	.string	"Array code, unrolled by 8, Superscalar x4"
.text
	.align 4
.globl unroll8x4a_inner
	.type	 unroll8x4a_inner,@function
unroll8x4a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	addl $-7,%eax
	movl %eax,-8(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-12(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-16(%ebp)
	xorl %esi,%esi
	movl $0,-20(%ebp)
	movl $0,-24(%ebp)
	xorl %edi,%edi
	xorl %ebx,%ebx
	cmpl -8(%ebp),%edi
	jge .L140
	movl -12(%ebp),%edx
	movl %eax,%ecx
	.p2align 4,,7
.L132:
	movl (%edx),%eax
	imull (%ecx),%eax
	addl %eax,%esi
	movl 4(%edx),%eax
	imull 4(%ecx),%eax
	addl %eax,-20(%ebp)
	movl 8(%edx),%eax
	imull 8(%ecx),%eax
	addl %eax,-24(%ebp)
	movl 12(%edx),%eax
	imull 12(%ecx),%eax
	addl %eax,%edi
	movl 16(%edx),%eax
	imull 16(%ecx),%eax
	addl %eax,%esi
	movl 20(%edx),%eax
	imull 20(%ecx),%eax
	addl %eax,-20(%ebp)
	movl 24(%edx),%eax
	imull 24(%ecx),%eax
	addl %eax,-24(%ebp)
	movl 28(%edx),%eax
	imull 28(%ecx),%eax
	addl %eax,%edi
	addl $32,%ecx
	addl $32,%edx
	addl $8,%ebx
	cmpl -8(%ebp),%ebx
	jl .L132
	jmp .L140
	.p2align 4,,7
.L137:
	movl -12(%ebp),%edx
	movl (%edx,%ebx,4),%eax
	movl -16(%ebp),%edx
	imull (%edx,%ebx,4),%eax
	addl %eax,%esi
	incl %ebx
.L140:
	cmpl -4(%ebp),%ebx
	jl .L137
	movl -20(%ebp),%edx
	leal (%edx,%esi),%eax
	movl 16(%ebp),%edx
	addl -24(%ebp),%eax
	addl %edi,%eax
	movl %eax,(%edx)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe14:
	.size	 unroll8x4a_inner,.Lfe14-unroll8x4a_inner
.globl unroll12x6a_descr
.data
	.align 32
	.type	 unroll12x6a_descr,@object
	.size	 unroll12x6a_descr,43
unroll12x6a_descr:
	.string	"Array code, unrolled by 12, Superscalar x6"
.text
	.align 4
.globl unroll12x6a_inner
	.type	 unroll12x6a_inner,@function
unroll12x6a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	addl $-11,%eax
	movl %eax,-8(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-12(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-16(%ebp)
	xorl %esi,%esi
	movl $0,-20(%ebp)
	movl $0,-24(%ebp)
	movl $0,-28(%ebp)
	movl $0,-32(%ebp)
	xorl %edi,%edi
	xorl %ebx,%ebx
	cmpl -8(%ebp),%edi
	jge .L153
	movl -12(%ebp),%edx
	movl %eax,%ecx
	.p2align 4,,7
.L145:
	movl (%edx),%eax
	imull (%ecx),%eax
	addl %eax,%esi
	movl 4(%edx),%eax
	imull 4(%ecx),%eax
	addl %eax,-20(%ebp)
	movl 8(%edx),%eax
	imull 8(%ecx),%eax
	addl %eax,-24(%ebp)
	movl 12(%edx),%eax
	imull 12(%ecx),%eax
	addl %eax,-28(%ebp)
	movl 16(%edx),%eax
	imull 16(%ecx),%eax
	addl %eax,-32(%ebp)
	movl 20(%edx),%eax
	imull 20(%ecx),%eax
	addl %eax,%edi
	movl 24(%edx),%eax
	imull 24(%ecx),%eax
	addl %eax,%esi
	movl 28(%edx),%eax
	imull 28(%ecx),%eax
	addl %eax,-20(%ebp)
	movl 32(%edx),%eax
	imull 32(%ecx),%eax
	addl %eax,-24(%ebp)
	movl 36(%edx),%eax
	imull 36(%ecx),%eax
	addl %eax,-28(%ebp)
	movl 40(%edx),%eax
	imull 40(%ecx),%eax
	addl %eax,-32(%ebp)
	movl 44(%edx),%eax
	imull 44(%ecx),%eax
	addl %eax,%edi
	addl $48,%ecx
	addl $48,%edx
	addl $12,%ebx
	cmpl -8(%ebp),%ebx
	jl .L145
	jmp .L153
	.p2align 4,,7
.L150:
	movl -12(%ebp),%edx
	movl (%edx,%ebx,4),%eax
	movl -16(%ebp),%edx
	imull (%edx,%ebx,4),%eax
	addl %eax,%esi
	incl %ebx
.L153:
	cmpl -4(%ebp),%ebx
	jl .L150
	movl -20(%ebp),%edx
	leal (%edx,%esi),%eax
	movl 16(%ebp),%edx
	addl -24(%ebp),%eax
	addl -28(%ebp),%eax
	addl -32(%ebp),%eax
	addl %edi,%eax
	movl %eax,(%edx)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe15:
	.size	 unroll12x6a_inner,.Lfe15-unroll12x6a_inner
.globl unroll8x8a_descr
.data
	.align 32
	.type	 unroll8x8a_descr,@object
	.size	 unroll8x8a_descr,42
unroll8x8a_descr:
	.string	"Array code, unrolled by 8, Superscalar x8"
.text
	.align 4
.globl unroll8x8a_inner
	.type	 unroll8x8a_inner,@function
unroll8x8a_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $60,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	leal -7(%edi),%eax
	movl %eax,-4(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-8(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl -4(%ebp),%edx
	movl %eax,-12(%ebp)
	xorl %esi,%esi
	movl $0,-16(%ebp)
	movl $0,-20(%ebp)
	movl $0,-24(%ebp)
	movl $0,-28(%ebp)
	movl $0,-32(%ebp)
	movl $0,-36(%ebp)
	movl $0,-40(%ebp)
	xorl %ebx,%ebx
	cmpl %edx,-40(%ebp)
	jge .L166
	movl -8(%ebp),%edx
	movl %eax,%ecx
	.p2align 4,,7
.L158:
	movl (%edx),%eax
	imull (%ecx),%eax
	addl %eax,%esi
	movl 4(%edx),%eax
	imull 4(%ecx),%eax
	addl %eax,-16(%ebp)
	movl 8(%edx),%eax
	imull 8(%ecx),%eax
	addl %eax,-20(%ebp)
	movl 12(%edx),%eax
	imull 12(%ecx),%eax
	addl %eax,-24(%ebp)
	movl 16(%edx),%eax
	imull 16(%ecx),%eax
	addl %eax,-28(%ebp)
	movl 20(%edx),%eax
	imull 20(%ecx),%eax
	addl %eax,-32(%ebp)
	movl 24(%edx),%eax
	imull 24(%ecx),%eax
	addl %eax,-36(%ebp)
	movl 28(%edx),%eax
	imull 28(%ecx),%eax
	addl %eax,-40(%ebp)
	addl $32,%ecx
	addl $32,%edx
	addl $8,%ebx
	cmpl -4(%ebp),%ebx
	jl .L158
	jmp .L166
	.p2align 4,,7
.L163:
	movl -8(%ebp),%edx
	movl (%edx,%ebx,4),%eax
	movl -12(%ebp),%edx
	imull (%edx,%ebx,4),%eax
	addl %eax,%esi
	incl %ebx
.L166:
	cmpl %edi,%ebx
	jl .L163
	movl -16(%ebp),%edx
	leal (%edx,%esi),%eax
	movl 16(%ebp),%edx
	addl -20(%ebp),%eax
	addl -24(%ebp),%eax
	addl -28(%ebp),%eax
	addl -32(%ebp),%eax
	addl -36(%ebp),%eax
	addl -40(%ebp),%eax
	movl %eax,(%edx)
	leal -72(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe16:
	.size	 unroll8x8a_inner,.Lfe16-unroll8x8a_inner
.globl unrollx2as_descr
.data
	.align 32
	.type	 unrollx2as_descr,@object
	.size	 unrollx2as_descr,54
unrollx2as_descr:
	.string	"Array code, Unroll x2, Superscalar x2, noninterleaved"
.text
	.align 4
.globl unrollx2as_inner
	.type	 unrollx2as_inner,@function
unrollx2as_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	movl -4(%ebp),%edi
	shrl $31,%eax
	addl %eax,%edi
	sarl $1,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-8(%ebp)
	leal 0(,%edi,4),%ebx
	addl %ebx,%eax
	movl %eax,-12(%ebp)
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,-24(%ebp)
	addl %eax,%ebx
	movl %ebx,-16(%ebp)
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %edi,%ebx
	jge .L169
	.p2align 4,,7
.L171:
	movl -8(%ebp),%esi
	movl (%esi,%edx,4),%eax
	movl -24(%ebp),%esi
	imull (%esi,%edx,4),%eax
	movl -12(%ebp),%esi
	addl %eax,%ebx
	movl (%esi,%edx,4),%eax
	movl -16(%ebp),%esi
	imull (%esi,%edx,4),%eax
	addl %eax,%ecx
	incl %edx
	cmpl %edi,%edx
	jl .L171
.L169:
	leal (%edi,%edi),%edx
	cmpl -4(%ebp),%edx
	jge .L174
	.p2align 4,,7
.L176:
	movl -8(%ebp),%esi
	movl (%esi,%edx,4),%eax
	movl -24(%ebp),%esi
	imull (%esi,%edx,4),%eax
	addl %eax,%ecx
	incl %edx
	cmpl -4(%ebp),%edx
	jl .L176
.L174:
	movl 16(%ebp),%eax
	addl %ecx,%ebx
	movl %ebx,(%eax)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe17:
	.size	 unrollx2as_inner,.Lfe17-unrollx2as_inner
.globl unroll8x2_descr
.data
	.align 32
	.type	 unroll8x2_descr,@object
	.size	 unroll8x2_descr,44
unroll8x2_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x2"
.text
	.align 4
.globl unroll8x2_inner
	.type	 unroll8x2_inner,@function
unroll8x2_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%edx
	leal -28(%ebx,%edi,4),%edi
	xorl %ecx,%ecx
	xorl %esi,%esi
	cmpl %edi,%ebx
	jae .L180
	.p2align 4,,7
.L182:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%ecx
	movl 4(%ebx),%eax
	imull 4(%edx),%eax
	addl %eax,%esi
	movl 8(%ebx),%eax
	imull 8(%edx),%eax
	addl %eax,%ecx
	movl 12(%ebx),%eax
	imull 12(%edx),%eax
	addl %eax,%esi
	movl 16(%ebx),%eax
	imull 16(%edx),%eax
	addl %eax,%ecx
	movl 20(%ebx),%eax
	imull 20(%edx),%eax
	addl %eax,%esi
	movl 24(%ebx),%eax
	imull 24(%edx),%eax
	addl %eax,%ecx
	movl 28(%ebx),%eax
	imull 28(%edx),%eax
	addl %eax,%esi
	addl $32,%ebx
	addl $32,%edx
	cmpl %edi,%ebx
	jb .L182
.L180:
	addl $28,%edi
	cmpl %edi,%ebx
	jae .L185
	.p2align 4,,7
.L187:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%ecx
	addl $4,%ebx
	addl $4,%edx
	cmpl %edi,%ebx
	jb .L187
.L185:
	movl 16(%ebp),%eax
	addl %esi,%ecx
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe18:
	.size	 unroll8x2_inner,.Lfe18-unroll8x2_inner
.globl unroll9x3_descr
.data
	.align 32
	.type	 unroll9x3_descr,@object
	.size	 unroll9x3_descr,44
unroll9x3_descr:
	.string	"Pointer code, unrolled by 9, Superscalar x3"
.text
	.align 4
.globl unroll9x3_inner
	.type	 unroll9x3_inner,@function
unroll9x3_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%ecx
	leal -32(%ebx,%edi,4),%esi
	xorl %edx,%edx
	xorl %edi,%edi
	movl $0,-4(%ebp)
	cmpl %esi,%ebx
	jae .L191
	.p2align 4,,7
.L193:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	movl 4(%ebx),%eax
	imull 4(%ecx),%eax
	addl %eax,%edi
	movl 8(%ebx),%eax
	imull 8(%ecx),%eax
	addl %eax,-4(%ebp)
	movl 12(%ebx),%eax
	imull 12(%ecx),%eax
	addl %eax,%edx
	movl 16(%ebx),%eax
	imull 16(%ecx),%eax
	addl %eax,%edi
	movl 20(%ebx),%eax
	imull 20(%ecx),%eax
	addl %eax,-4(%ebp)
	movl 24(%ebx),%eax
	imull 24(%ecx),%eax
	addl %eax,%edx
	movl 28(%ebx),%eax
	imull 28(%ecx),%eax
	addl %eax,%edi
	movl 32(%ebx),%eax
	imull 32(%ecx),%eax
	addl %eax,-4(%ebp)
	addl $36,%ebx
	addl $36,%ecx
	cmpl %esi,%ebx
	jb .L193
.L191:
	addl $32,%esi
	cmpl %esi,%ebx
	jae .L196
	.p2align 4,,7
.L198:
	movl (%ebx),%eax
	imull (%ecx),%eax
	addl %eax,%edx
	addl $4,%ebx
	addl $4,%ecx
	cmpl %esi,%ebx
	jb .L198
.L196:
	movl 16(%ebp),%eax
	addl %edi,%edx
	addl -4(%ebp),%edx
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe19:
	.size	 unroll9x3_inner,.Lfe19-unroll9x3_inner
.globl unroll8x4_descr
.data
	.align 32
	.type	 unroll8x4_descr,@object
	.size	 unroll8x4_descr,44
unroll8x4_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x4"
.text
	.align 4
.globl unroll8x4_inner
	.type	 unroll8x4_inner,@function
unroll8x4_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%edx
	leal -28(%ebx,%edi,4),%ecx
	xorl %esi,%esi
	xorl %edi,%edi
	movl $0,-4(%ebp)
	movl $0,-8(%ebp)
	cmpl %ecx,%ebx
	jae .L202
	.p2align 4,,7
.L204:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%esi
	movl 4(%ebx),%eax
	imull 4(%edx),%eax
	addl %eax,%edi
	movl 8(%ebx),%eax
	imull 8(%edx),%eax
	addl %eax,-4(%ebp)
	movl 12(%ebx),%eax
	imull 12(%edx),%eax
	addl %eax,-8(%ebp)
	movl 16(%ebx),%eax
	imull 16(%edx),%eax
	addl %eax,%esi
	movl 20(%ebx),%eax
	imull 20(%edx),%eax
	addl %eax,%edi
	movl 24(%ebx),%eax
	imull 24(%edx),%eax
	addl %eax,-4(%ebp)
	movl 28(%ebx),%eax
	imull 28(%edx),%eax
	addl %eax,-8(%ebp)
	addl $32,%ebx
	addl $32,%edx
	cmpl %ecx,%ebx
	jb .L204
.L202:
	addl $28,%ecx
	cmpl %ecx,%ebx
	jae .L207
	.p2align 4,,7
.L209:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%esi
	addl $4,%ebx
	addl $4,%edx
	cmpl %ecx,%ebx
	jb .L209
.L207:
	movl 16(%ebp),%edx
	leal (%edi,%esi),%eax
	addl -4(%ebp),%eax
	addl -8(%ebp),%eax
	movl %eax,(%edx)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe20:
	.size	 unroll8x4_inner,.Lfe20-unroll8x4_inner
.globl unroll8x8_descr
.data
	.align 32
	.type	 unroll8x8_descr,@object
	.size	 unroll8x8_descr,44
unroll8x8_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x8"
.text
	.align 4
.globl unroll8x8_inner
	.type	 unroll8x8_inner,@function
unroll8x8_inner:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	addl $32,%esp
	addl $-12,%esp
	pushl %esi
	call get_vec_start
	movl %eax,%edx
	leal -28(%ebx,%edi,4),%ecx
	xorl %esi,%esi
	xorl %edi,%edi
	movl $0,-4(%ebp)
	movl $0,-8(%ebp)
	movl $0,-12(%ebp)
	movl $0,-16(%ebp)
	movl $0,-20(%ebp)
	movl $0,-24(%ebp)
	cmpl %ecx,%ebx
	jae .L213
	.p2align 4,,7
.L215:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%esi
	movl 4(%ebx),%eax
	imull 4(%edx),%eax
	addl %eax,%edi
	movl 8(%ebx),%eax
	imull 8(%edx),%eax
	addl %eax,-4(%ebp)
	movl 12(%ebx),%eax
	imull 12(%edx),%eax
	addl %eax,-8(%ebp)
	movl 16(%ebx),%eax
	imull 16(%edx),%eax
	addl %eax,-12(%ebp)
	movl 20(%ebx),%eax
	imull 20(%edx),%eax
	addl %eax,-16(%ebp)
	movl 24(%ebx),%eax
	imull 24(%edx),%eax
	addl %eax,-20(%ebp)
	movl 28(%ebx),%eax
	imull 28(%edx),%eax
	addl %eax,-24(%ebp)
	addl $32,%ebx
	addl $32,%edx
	cmpl %ecx,%ebx
	jb .L215
.L213:
	addl $28,%ecx
	cmpl %ecx,%ebx
	jae .L218
	.p2align 4,,7
.L220:
	movl (%ebx),%eax
	imull (%edx),%eax
	addl %eax,%esi
	addl $4,%ebx
	addl $4,%edx
	cmpl %ecx,%ebx
	jb .L220
.L218:
	movl 16(%ebp),%edx
	leal (%edi,%esi),%eax
	addl -4(%ebp),%eax
	addl -8(%ebp),%eax
	addl -12(%ebp),%eax
	addl -16(%ebp),%eax
	addl -20(%ebp),%eax
	addl -24(%ebp),%eax
	movl %eax,(%edx)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe21:
	.size	 unroll8x8_inner,.Lfe21-unroll8x8_inner
	.align 4
.globl register_inners
	.type	 register_inners,@function
register_inners:
	pushl %ebp
	movl %esp,%ebp
	subl $8,%esp
	addl $-4,%esp
	pushl $abstract_descr
	pushl $abstract_inner
	pushl $abstract_inner
	call add_inner
	addl $-4,%esp
	pushl $motion_descr
	pushl $abstract_inner
	pushl $motion_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $array_descr
	pushl $abstract_inner
	pushl $array_inner
	call add_inner
	addl $-4,%esp
	pushl $inner4_descr
	pushl $abstract_inner
	pushl $inner4
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $pointer_descr
	pushl $abstract_inner
	pushl $pointer_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll2a_descr
	pushl $abstract_inner
	pushl $unroll2a_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8a_descr
	pushl $abstract_inner
	pushl $unroll8a_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll16a_descr
	pushl $abstract_inner
	pushl $unroll16a_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll2_descr
	pushl $abstract_inner
	pushl $unroll2_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll4_descr
	pushl $abstract_inner
	pushl $unroll4_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8_descr
	pushl $abstract_inner
	pushl $unroll8_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll16_descr
	pushl $abstract_inner
	pushl $unroll16_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x2a_descr
	pushl $abstract_inner
	pushl $unroll8x2a_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll8x4a_descr
	pushl $abstract_inner
	pushl $unroll8x4a_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x8a_descr
	pushl $abstract_inner
	pushl $unroll8x8a_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll12x6a_descr
	pushl $abstract_inner
	pushl $unroll12x6a_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x2_descr
	pushl $abstract_inner
	pushl $unroll8x2_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll8x4_descr
	pushl $abstract_inner
	pushl $unroll8x4_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x8_descr
	pushl $abstract_inner
	pushl $unroll8x8_inner
	call add_inner
	addl $-4,%esp
	pushl $unroll9x3_descr
	pushl $abstract_inner
	pushl $unroll9x3_inner
	call add_inner
	addl $32,%esp
	addl $-4,%esp
	pushl $unrollx2as_descr
	pushl $abstract_inner
	pushl $unrollx2as_inner
	call add_inner
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe22:
	.size	 register_inners,.Lfe22-register_inners
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
