	.file	"combinesum.c"
	.version	"01.01"
gcc2_compiled.:
.globl combine1_descr
.data
	.align 32
	.type	 combine1_descr,@object
	.size	 combine1_descr,42
combine1_descr:
	.string	"combine1: Maximum use of data abstraction"
.text
	.align 4
.globl combine1
	.type	 combine1,@function
combine1:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%edi
	movl 12(%ebp),%esi
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
	movl -4(%ebp),%eax
	addl %eax,(%esi)
	addl $16,%esp
	incl %ebx
.L3:
	addl $-12,%esp
	pushl %edi
	call vec_length
	addl $16,%esp
	cmpl %eax,%ebx
	jl .L6
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 combine1,.Lfe1-combine1
.globl combine2_descr
.data
	.align 32
	.type	 combine2_descr,@object
	.size	 combine2_descr,40
combine2_descr:
	.string	"combine2: Take vec_length() out of loop"
.text
	.align 4
.globl combine2
	.type	 combine2,@function
combine2:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 12(%ebp),%edi
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
	leal -4(%ebp),%eax
	movl %eax,-8(%ebp)
	.p2align 4,,7
.L12:
	movl -8(%ebp),%eax
	addl $-4,%esp
	pushl %eax
	pushl %ebx
	movl 8(%ebp),%eax
	pushl %eax
	call get_vec_element
	movl -4(%ebp),%eax
	addl %eax,(%edi)
	addl $16,%esp
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
	.size	 combine2,.Lfe2-combine2
.globl combine3_descr
.data
	.align 32
	.type	 combine3_descr,@object
	.size	 combine3_descr,41
combine3_descr:
	.string	"combine3: Array reference to vector data"
.text
	.align 4
.globl combine3
	.type	 combine3,@function
combine3:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%edi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ecx
	movl $0,(%edi)
	xorl %edx,%edx
	cmpl %esi,%edx
	jge .L16
	.p2align 4,,7
.L18:
	movl (%ecx,%edx,4),%eax
	addl %eax,(%edi)
	incl %edx
	cmpl %esi,%edx
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
	.size	 combine3,.Lfe3-combine3
.globl combine4_descr
.data
	.align 32
	.type	 combine4_descr,@object
	.size	 combine4_descr,51
combine4_descr:
	.string	"combine4: Array reference, accumulate in temporary"
.text
	.align 4
.globl combine4
	.type	 combine4,@function
combine4:
	pushl %ebp
	movl %esp,%ebp
	subl $12,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	movl 12(%ebp),%edi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	movl $0,(%edi)
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L22
	.p2align 4,,7
.L24:
	addl (%eax,%edx,4),%ecx
	incl %edx
	cmpl %esi,%edx
	jl .L24
.L22:
	movl %ecx,(%edi)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe4:
	.size	 combine4,.Lfe4-combine4
.globl combine4p_descr
.data
	.align 32
	.type	 combine4p_descr,@object
	.size	 combine4p_descr,54
combine4p_descr:
	.string	"combine4p: Pointer reference, accumulate in temporary"
.text
	.align 4
.globl combine4p
	.type	 combine4p,@function
combine4p:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal (%eax,%esi,4),%edx
	xorl %ecx,%ecx
	cmpl %edx,%eax
	jae .L28
	.p2align 4,,7
.L30:
	addl (%eax),%ecx
	addl $4,%eax
	cmpl %edx,%eax
	jb .L30
.L28:
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe5:
	.size	 combine4p,.Lfe5-combine4p
.globl unroll2a_descr
.data
	.type	 unroll2a_descr,@object
	.size	 unroll2a_descr,26
unroll2a_descr:
	.string	"Array code, unrolled by 2"
.text
	.align 4
.globl unroll2a_combine
	.type	 unroll2a_combine,@function
unroll2a_combine:
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
	leal -1(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L44
	.p2align 4,,7
.L36:
	addl (%eax,%edx,4),%ecx
	addl 4(%eax,%edx,4),%ecx
	addl $2,%edx
	cmpl %esi,%edx
	jl .L36
	jmp .L44
	.p2align 4,,7
.L41:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L44:
	cmpl %edi,%edx
	jl .L41
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe6:
	.size	 unroll2a_combine,.Lfe6-unroll2a_combine
.globl combine5_descr
.data
	.align 32
	.type	 combine5_descr,@object
	.size	 combine5_descr,36
combine5_descr:
	.string	"combine5: Array code, unrolled by 3"
.text
	.align 4
.globl combine5
	.type	 combine5,@function
combine5:
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
	leal -2(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L57
	.p2align 4,,7
.L49:
	addl (%eax,%edx,4),%ecx
	addl 4(%eax,%edx,4),%ecx
	addl 8(%eax,%edx,4),%ecx
	addl $3,%edx
	cmpl %esi,%edx
	jl .L49
	jmp .L57
	.p2align 4,,7
.L54:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L57:
	cmpl %edi,%edx
	jl .L54
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe7:
	.size	 combine5,.Lfe7-combine5
.globl combine5p_descr
.data
	.align 32
	.type	 combine5p_descr,@object
	.size	 combine5p_descr,49
combine5p_descr:
	.string	"combine5p: Pointer code, unrolled by 3, for loop"
.text
	.align 4
.globl combine5p
	.type	 combine5p,@function
combine5p:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call vec_length
	leal (%esi,%eax,4),%eax
	leal -8(%eax),%ecx
	xorl %edx,%edx
	cmpl %ecx,%esi
	jae .L70
	.p2align 4,,7
.L62:
	addl (%esi),%edx
	addl 4(%esi),%edx
	addl 8(%esi),%edx
	addl $12,%esi
	cmpl %ecx,%esi
	jb .L62
	jmp .L70
	.p2align 4,,7
.L67:
	addl (%esi),%edx
	addl $4,%esi
.L70:
	cmpl %eax,%esi
	jb .L67
	movl 12(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe8:
	.size	 combine5p,.Lfe8-combine5p
.globl unroll3aw_descr
.data
	.align 32
	.type	 unroll3aw_descr,@object
	.size	 unroll3aw_descr,38
unroll3aw_descr:
	.string	"Array code, unrolled by 3, while loop"
.text
	.align 4
.globl unroll3aw_combine
	.type	 unroll3aw_combine,@function
unroll3aw_combine:
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
	leal -1(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L82
	.p2align 4,,7
.L74:
	addl (%eax,%edx,4),%ecx
	addl $3,%edx
	addl -8(%eax,%edx,4),%ecx
	addl -4(%eax,%edx,4),%ecx
	cmpl %esi,%edx
	jl .L74
	jmp .L82
	.p2align 4,,7
.L79:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L82:
	cmpl %edi,%edx
	jl .L79
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe9:
	.size	 unroll3aw_combine,.Lfe9-unroll3aw_combine
.globl unroll4a_descr
.data
	.type	 unroll4a_descr,@object
	.size	 unroll4a_descr,26
unroll4a_descr:
	.string	"Array code, unrolled by 4"
.text
	.align 4
.globl unroll4a_combine
	.type	 unroll4a_combine,@function
unroll4a_combine:
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
	leal -3(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L95
	.p2align 4,,7
.L87:
	addl (%eax,%edx,4),%ecx
	addl 4(%eax,%edx,4),%ecx
	addl 8(%eax,%edx,4),%ecx
	addl 12(%eax,%edx,4),%ecx
	addl $4,%edx
	cmpl %esi,%edx
	jl .L87
	jmp .L95
	.p2align 4,,7
.L92:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L95:
	cmpl %edi,%edx
	jl .L92
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe10:
	.size	 unroll4a_combine,.Lfe10-unroll4a_combine
.globl unroll8a_descr
.data
	.type	 unroll8a_descr,@object
	.size	 unroll8a_descr,26
unroll8a_descr:
	.string	"Array code, unrolled by 8"
.text
	.align 4
.globl unroll8a_combine
	.type	 unroll8a_combine,@function
unroll8a_combine:
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
	leal -7(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	xorl %edx,%edx
	xorl %ecx,%ecx
	cmpl %esi,%edx
	jge .L108
	.p2align 4,,7
.L100:
	addl (%eax),%edx
	addl 4(%eax),%edx
	addl 8(%eax),%edx
	addl 12(%eax),%edx
	addl 16(%eax),%edx
	addl 20(%eax),%edx
	addl 24(%eax),%edx
	addl 28(%eax),%edx
	addl $32,%eax
	addl $8,%ecx
	cmpl %esi,%ecx
	jl .L100
	jmp .L108
	.p2align 4,,7
.L105:
	addl (%ebx,%ecx,4),%edx
	incl %ecx
.L108:
	cmpl %edi,%ecx
	jl .L105
	movl 12(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe11:
	.size	 unroll8a_combine,.Lfe11-unroll8a_combine
.globl unroll16a_descr
.data
	.type	 unroll16a_descr,@object
	.size	 unroll16a_descr,27
unroll16a_descr:
	.string	"Array code, unrolled by 16"
.text
	.align 4
.globl unroll16a_combine
	.type	 unroll16a_combine,@function
unroll16a_combine:
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
	movl %eax,%esi
	leal -15(%esi),%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	xorl %edx,%edx
	xorl %ecx,%ecx
	cmpl %edi,%edx
	jge .L121
	.p2align 4,,7
.L113:
	addl (%eax),%edx
	addl 4(%eax),%edx
	addl 8(%eax),%edx
	addl 12(%eax),%edx
	addl 16(%eax),%edx
	addl 20(%eax),%edx
	addl 24(%eax),%edx
	addl 28(%eax),%edx
	addl 32(%eax),%edx
	addl 36(%eax),%edx
	addl 40(%eax),%edx
	addl 44(%eax),%edx
	addl 48(%eax),%edx
	addl 52(%eax),%edx
	addl 56(%eax),%edx
	addl 60(%eax),%edx
	addl $64,%eax
	addl $16,%ecx
	cmpl %edi,%ecx
	jl .L113
	jmp .L121
	.p2align 4,,7
.L118:
	addl (%ebx,%ecx,4),%edx
	incl %ecx
.L121:
	cmpl %esi,%ecx
	jl .L118
	movl 12(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe12:
	.size	 unroll16a_combine,.Lfe12-unroll16a_combine
.globl unroll2_descr
.data
	.type	 unroll2_descr,@object
	.size	 unroll2_descr,28
unroll2_descr:
	.string	"Pointer code, unrolled by 2"
.text
	.align 4
.globl unroll2_combine
	.type	 unroll2_combine,@function
unroll2_combine:
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
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%edx
	movl %esi,%eax
	shrl $31,%eax
	addl %esi,%eax
	andb $254,%al
	movl %esi,%edi
	subl %eax,%edi
	leal (%edx,%esi,4),%ecx
	leal 0(,%edi,4),%eax
	subl %eax,%ecx
	xorl %ebx,%ebx
	cmpl %ecx,%edx
	jae .L124
	.p2align 4,,7
.L125:
	addl (%edx),%ebx
	addl 4(%edx),%ebx
	addl $8,%edx
	cmpl %ecx,%edx
	jb .L125
.L124:
	leal (%ecx,%edi,4),%ecx
	cmpl %ecx,%edx
	jae .L128
	.p2align 4,,7
.L129:
	addl (%edx),%ebx
	addl $4,%edx
	cmpl %ecx,%edx
	jb .L129
.L128:
	movl 12(%ebp),%eax
	movl %ebx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe13:
	.size	 unroll2_combine,.Lfe13-unroll2_combine
.globl unroll3_descr
.data
	.type	 unroll3_descr,@object
	.size	 unroll3_descr,28
unroll3_descr:
	.string	"Pointer code, unrolled by 3"
.text
	.align 4
.globl unroll3_combine
	.type	 unroll3_combine,@function
unroll3_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -8(%eax,%esi,4),%ecx
	xorl %edx,%edx
	cmpl %ecx,%eax
	jae .L133
	.p2align 4,,7
.L134:
	addl (%eax),%edx
	addl 4(%eax),%edx
	addl 8(%eax),%edx
	addl $12,%eax
	cmpl %ecx,%eax
	jb .L134
.L133:
	addl $8,%ecx
	cmpl %ecx,%eax
	jae .L137
	.p2align 4,,7
.L138:
	addl (%eax),%edx
	addl $4,%eax
	cmpl %ecx,%eax
	jb .L138
.L137:
	movl 12(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe14:
	.size	 unroll3_combine,.Lfe14-unroll3_combine
.globl unroll4_descr
.data
	.type	 unroll4_descr,@object
	.size	 unroll4_descr,28
unroll4_descr:
	.string	"Pointer code, unrolled by 4"
.text
	.align 4
.globl unroll4_combine
	.type	 unroll4_combine,@function
unroll4_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -12(%eax,%esi,4),%ecx
	xorl %edx,%edx
	cmpl %ecx,%eax
	jae .L142
	.p2align 4,,7
.L143:
	addl (%eax),%edx
	addl 4(%eax),%edx
	addl 8(%eax),%edx
	addl 12(%eax),%edx
	addl $16,%eax
	cmpl %ecx,%eax
	jb .L143
.L142:
	addl $12,%ecx
	cmpl %ecx,%eax
	jae .L146
	.p2align 4,,7
.L147:
	addl (%eax),%edx
	addl $4,%eax
	cmpl %ecx,%eax
	jb .L147
.L146:
	movl 12(%ebp),%eax
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe15:
	.size	 unroll4_combine,.Lfe15-unroll4_combine
.globl unroll8_descr
.data
	.type	 unroll8_descr,@object
	.size	 unroll8_descr,28
unroll8_descr:
	.string	"Pointer code, unrolled by 8"
.text
	.align 4
.globl unroll8_combine
	.type	 unroll8_combine,@function
unroll8_combine:
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
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%edx
	movl %esi,%eax
	testl %esi,%esi
	jge .L150
	leal 7(%esi),%eax
.L150:
	andb $248,%al
	movl %esi,%edi
	subl %eax,%edi
	leal (%edx,%esi,4),%ebx
	leal 0(,%edi,4),%eax
	subl %eax,%ebx
	xorl %ecx,%ecx
	cmpl %ebx,%edx
	jae .L152
	.p2align 4,,7
.L153:
	addl (%edx),%ecx
	addl 4(%edx),%ecx
	addl 8(%edx),%ecx
	addl 12(%edx),%ecx
	addl 16(%edx),%ecx
	addl 20(%edx),%ecx
	addl 24(%edx),%ecx
	addl 28(%edx),%ecx
	addl $32,%edx
	cmpl %ebx,%edx
	jb .L153
.L152:
	leal (%ebx,%edi,4),%ebx
	cmpl %ebx,%edx
	jae .L156
	.p2align 4,,7
.L157:
	addl (%edx),%ecx
	addl $4,%edx
	cmpl %ebx,%edx
	jb .L157
.L156:
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe16:
	.size	 unroll8_combine,.Lfe16-unroll8_combine
.globl unroll16_descr
.data
	.type	 unroll16_descr,@object
	.size	 unroll16_descr,29
unroll16_descr:
	.string	"Pointer code, unrolled by 16"
.text
	.align 4
.globl unroll16_combine
	.type	 unroll16_combine,@function
unroll16_combine:
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
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%edx
	movl %esi,%eax
	testl %esi,%esi
	jge .L160
	leal 15(%esi),%eax
.L160:
	andb $240,%al
	movl %esi,%edi
	subl %eax,%edi
	leal (%edx,%esi,4),%ebx
	leal 0(,%edi,4),%eax
	subl %eax,%ebx
	xorl %ecx,%ecx
	cmpl %ebx,%edx
	jae .L162
	.p2align 4,,7
.L163:
	addl (%edx),%ecx
	addl 4(%edx),%ecx
	addl 8(%edx),%ecx
	addl 12(%edx),%ecx
	addl 16(%edx),%ecx
	addl 20(%edx),%ecx
	addl 24(%edx),%ecx
	addl 28(%edx),%ecx
	addl 32(%edx),%ecx
	addl 36(%edx),%ecx
	addl 40(%edx),%ecx
	addl 44(%edx),%ecx
	addl 48(%edx),%ecx
	addl 52(%edx),%ecx
	addl 56(%edx),%ecx
	addl 60(%edx),%ecx
	addl $64,%edx
	cmpl %ebx,%edx
	jb .L163
.L162:
	leal (%ebx,%edi,4),%ebx
	cmpl %ebx,%edx
	jae .L166
	.p2align 4,,7
.L167:
	addl (%edx),%ecx
	addl $4,%edx
	cmpl %ebx,%edx
	jb .L167
.L166:
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe17:
	.size	 unroll16_combine,.Lfe17-unroll16_combine
.globl combine6_descr
.data
	.align 32
	.type	 combine6_descr,@object
	.size	 combine6_descr,52
combine6_descr:
	.string	"combine6: Array code, unrolled by 2, Superscalar x2"
.text
	.align 4
.globl combine6
	.type	 combine6,@function
combine6:
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
	leal -1(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %ebx,%ebx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L181
	.p2align 4,,7
.L173:
	addl (%eax,%edx,4),%ecx
	addl 4(%eax,%edx,4),%ebx
	addl $2,%edx
	cmpl %esi,%edx
	jl .L173
	jmp .L181
	.p2align 4,,7
.L178:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L181:
	cmpl %edi,%edx
	jl .L178
	movl 12(%ebp),%eax
	addl %ebx,%ecx
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe18:
	.size	 combine6,.Lfe18-combine6
.globl unroll4x2a_descr
.data
	.align 32
	.type	 unroll4x2a_descr,@object
	.size	 unroll4x2a_descr,42
unroll4x2a_descr:
	.string	"Array code, unrolled by 4, Superscalar x2"
.text
	.align 4
.globl unroll4x2a_combine
	.type	 unroll4x2a_combine,@function
unroll4x2a_combine:
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
	leal -3(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	xorl %ecx,%ecx
	xorl %ebx,%ebx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L194
	.p2align 4,,7
.L186:
	addl (%eax,%edx,4),%ecx
	addl 4(%eax,%edx,4),%ebx
	addl 8(%eax,%edx,4),%ecx
	addl 12(%eax,%edx,4),%ebx
	addl $4,%edx
	cmpl %esi,%edx
	jl .L186
	jmp .L194
	.p2align 4,,7
.L191:
	addl (%eax,%edx,4),%ecx
	incl %edx
.L194:
	cmpl %edi,%edx
	jl .L191
	movl 12(%ebp),%eax
	addl %ebx,%ecx
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe19:
	.size	 unroll4x2a_combine,.Lfe19-unroll4x2a_combine
.globl unroll8x2a_descr
.data
	.align 32
	.type	 unroll8x2a_descr,@object
	.size	 unroll8x2a_descr,42
unroll8x2a_descr:
	.string	"Array code, unrolled by 8, Superscalar x2"
.text
	.align 4
.globl unroll8x2a_combine
	.type	 unroll8x2a_combine,@function
unroll8x2a_combine:
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
	leal -7(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-4(%ebp)
	xorl %edx,%edx
	xorl %ecx,%ecx
	xorl %ebx,%ebx
	cmpl %esi,%edx
	jge .L207
	.p2align 4,,7
.L199:
	addl (%eax),%edx
	addl 4(%eax),%ecx
	addl 8(%eax),%edx
	addl 12(%eax),%ecx
	addl 16(%eax),%edx
	addl 20(%eax),%ecx
	addl 24(%eax),%edx
	addl 28(%eax),%ecx
	addl $32,%eax
	addl $8,%ebx
	cmpl %esi,%ebx
	jl .L199
	jmp .L207
	.p2align 4,,7
.L204:
	movl -4(%ebp),%eax
	addl (%eax,%ebx,4),%edx
	incl %ebx
.L207:
	cmpl %edi,%ebx
	jl .L204
	movl 12(%ebp),%eax
	addl %ecx,%edx
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe20:
	.size	 unroll8x2a_combine,.Lfe20-unroll8x2a_combine
.globl unroll8x4a_descr
.data
	.align 32
	.type	 unroll8x4a_descr,@object
	.size	 unroll8x4a_descr,42
unroll8x4a_descr:
	.string	"Array code, unrolled by 8, Superscalar x4"
.text
	.align 4
.globl unroll8x4a_combine
	.type	 unroll8x4a_combine,@function
unroll8x4a_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
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
	xorl %ecx,%ecx
	xorl %esi,%esi
	xorl %edi,%edi
	xorl %ebx,%ebx
	xorl %edx,%edx
	cmpl -8(%ebp),%ebx
	jge .L220
	.p2align 4,,7
.L212:
	addl (%eax),%ecx
	addl 4(%eax),%esi
	addl 8(%eax),%edi
	addl 12(%eax),%ebx
	addl 16(%eax),%ecx
	addl 20(%eax),%esi
	addl 24(%eax),%edi
	addl 28(%eax),%ebx
	addl $32,%eax
	addl $8,%edx
	cmpl -8(%ebp),%edx
	jl .L212
	jmp .L220
	.p2align 4,,7
.L217:
	movl -12(%ebp),%eax
	addl (%eax,%edx,4),%ecx
	incl %edx
.L220:
	cmpl -4(%ebp),%edx
	jl .L217
	movl 12(%ebp),%edx
	leal (%esi,%ecx),%eax
	addl %edi,%eax
	addl %ebx,%eax
	movl %eax,(%edx)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe21:
	.size	 unroll8x4a_combine,.Lfe21-unroll8x4a_combine
.globl unroll12x6a_descr
.data
	.align 32
	.type	 unroll12x6a_descr,@object
	.size	 unroll12x6a_descr,43
unroll12x6a_descr:
	.string	"Array code, unrolled by 12, Superscalar x6"
.text
	.align 4
.globl unroll12x6a_combine
	.type	 unroll12x6a_combine,@function
unroll12x6a_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
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
	xorl %ecx,%ecx
	movl $0,-16(%ebp)
	movl $0,-20(%ebp)
	xorl %esi,%esi
	movl $0,-24(%ebp)
	xorl %ebx,%ebx
	xorl %edx,%edx
	cmpl -8(%ebp),%ecx
	jge .L223
	.p2align 4,,7
.L225:
	movl 4(%eax),%edi
	addl (%eax),%ecx
	addl 24(%eax),%ecx
	addl %edi,-16(%ebp)
	movl 28(%eax),%edi
	addl %edi,-16(%ebp)
	movl 8(%eax),%edi
	addl %edi,-20(%ebp)
	movl 32(%eax),%edi
	addl %edi,-20(%ebp)
	movl 16(%eax),%edi
	addl 12(%eax),%esi
	addl 36(%eax),%esi
	addl %edi,-24(%ebp)
	movl 40(%eax),%edi
	addl %edi,-24(%ebp)
	addl 20(%eax),%ebx
	addl 44(%eax),%ebx
	addl $48,%eax
	addl $12,%edx
	cmpl -8(%ebp),%edx
	jl .L225
.L223:
	addl -20(%ebp),%esi
	addl -24(%ebp),%ebx
	cmpl -4(%ebp),%edx
	jge .L232
	.p2align 4,,7
.L230:
	movl -12(%ebp),%eax
	addl (%eax,%edx,4),%ecx
	incl %edx
	cmpl -4(%ebp),%edx
	jl .L230
.L232:
	movl -16(%ebp),%edx
	leal (%edx,%ecx),%eax
	movl 12(%ebp),%edx
	addl %esi,%eax
	addl %ebx,%eax
	movl %eax,(%edx)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe22:
	.size	 unroll12x6a_combine,.Lfe22-unroll12x6a_combine
.globl unroll8x8a_descr
.data
	.align 32
	.type	 unroll8x8a_descr,@object
	.size	 unroll8x8a_descr,42
unroll8x8a_descr:
	.string	"Array code, unrolled by 8, Superscalar x8"
.text
	.align 4
.globl unroll8x8a_combine
	.type	 unroll8x8a_combine,@function
unroll8x8a_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $44,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	leal -7(%esi),%eax
	movl %eax,-32(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl -32(%ebp),%edi
	movl %eax,%ebx
	xorl %ecx,%ecx
	movl $0,-4(%ebp)
	movl $0,-8(%ebp)
	movl $0,-12(%ebp)
	movl $0,-16(%ebp)
	movl $0,-20(%ebp)
	movl $0,-24(%ebp)
	movl $0,-28(%ebp)
	xorl %edx,%edx
	cmpl %edi,-28(%ebp)
	jge .L245
	.p2align 4,,7
.L237:
	movl 4(%eax),%edi
	addl (%eax),%ecx
	addl %edi,-4(%ebp)
	movl 8(%eax),%edi
	addl %edi,-8(%ebp)
	movl 12(%eax),%edi
	addl %edi,-12(%ebp)
	movl 16(%eax),%edi
	addl %edi,-16(%ebp)
	movl 20(%eax),%edi
	addl %edi,-20(%ebp)
	movl 24(%eax),%edi
	addl %edi,-24(%ebp)
	movl 28(%eax),%edi
	addl %edi,-28(%ebp)
	addl $32,%eax
	addl $8,%edx
	cmpl -32(%ebp),%edx
	jl .L237
	jmp .L245
	.p2align 4,,7
.L242:
	addl (%ebx,%edx,4),%ecx
	incl %edx
.L245:
	cmpl %esi,%edx
	jl .L242
	movl -4(%ebp),%edx
	leal (%edx,%ecx),%eax
	movl 12(%ebp),%edx
	addl -8(%ebp),%eax
	addl -12(%ebp),%eax
	addl -16(%ebp),%eax
	addl -20(%ebp),%eax
	addl -24(%ebp),%eax
	addl -28(%ebp),%eax
	movl %eax,(%edx)
	leal -56(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe23:
	.size	 unroll8x8a_combine,.Lfe23-unroll8x8a_combine
.globl unrollx2as_descr
.data
	.align 32
	.type	 unrollx2as_descr,@object
	.size	 unrollx2as_descr,54
unrollx2as_descr:
	.string	"Array code, Unroll x2, Superscalar x2, noninterleaved"
.text
	.align 4
.globl unrollx2as_combine
	.type	 unrollx2as_combine,@function
unrollx2as_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-8(%ebp)
	movl -8(%ebp),%esi
	shrl $31,%eax
	addl %eax,%esi
	sarl $1,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal (%eax,%esi,4),%edx
	movl %edx,-4(%ebp)
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ebx
	jge .L248
	.p2align 4,,7
.L250:
	movl -4(%ebp),%edi
	addl (%eax,%edx,4),%ebx
	addl (%edi,%edx,4),%ecx
	incl %edx
	cmpl %esi,%edx
	jl .L250
.L248:
	leal (%esi,%esi),%edx
	cmpl -8(%ebp),%edx
	jge .L253
	.p2align 4,,7
.L255:
	addl (%eax,%edx,4),%ecx
	incl %edx
	cmpl -8(%ebp),%edx
	jl .L255
.L253:
	movl 12(%ebp),%eax
	addl %ecx,%ebx
	movl %ebx,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe24:
	.size	 unrollx2as_combine,.Lfe24-unrollx2as_combine
.globl unroll4x2as_descr
.data
	.align 32
	.type	 unroll4x2as_descr,@object
	.size	 unroll4x2as_descr,54
unroll4x2as_descr:
	.string	"Array code, Unroll x4, Superscalar x2, noninterleaved"
.text
	.align 4
.globl unroll4x2as_combine
	.type	 unroll4x2as_combine,@function
unroll4x2as_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-8(%ebp)
	movl -8(%ebp),%esi
	shrl $31,%eax
	addl %eax,%esi
	sarl $1,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal (%eax,%esi,4),%edx
	movl %edx,-4(%ebp)
	xorl %ebx,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ebx
	jge .L259
	.p2align 4,,7
.L261:
	movl -4(%ebp),%edi
	addl (%eax,%edx,4),%ebx
	addl (%edi,%edx,4),%ecx
	incl %edx
	cmpl %esi,%edx
	jl .L261
.L259:
	leal (%esi,%esi),%edx
	cmpl -8(%ebp),%edx
	jge .L264
	.p2align 4,,7
.L266:
	addl (%eax,%edx,4),%ecx
	incl %edx
	cmpl -8(%ebp),%edx
	jl .L266
.L264:
	movl 12(%ebp),%eax
	addl %ecx,%ebx
	movl %ebx,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe25:
	.size	 unroll4x2as_combine,.Lfe25-unroll4x2as_combine
.globl unroll8x2_descr
.data
	.align 32
	.type	 unroll8x2_descr,@object
	.size	 unroll8x2_descr,44
unroll8x2_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x2"
.text
	.align 4
.globl unroll8x2_combine
	.type	 unroll8x2_combine,@function
unroll8x2_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -28(%eax,%esi,4),%ebx
	xorl %edx,%edx
	xorl %ecx,%ecx
	cmpl %ebx,%eax
	jae .L270
	.p2align 4,,7
.L271:
	addl (%eax),%edx
	addl 4(%eax),%ecx
	addl 8(%eax),%edx
	addl 12(%eax),%ecx
	addl 16(%eax),%edx
	addl 20(%eax),%ecx
	addl 24(%eax),%edx
	addl 28(%eax),%ecx
	addl $32,%eax
	cmpl %ebx,%eax
	jb .L271
.L270:
	addl $28,%ebx
	cmpl %ebx,%eax
	jae .L274
	.p2align 4,,7
.L275:
	addl (%eax),%edx
	addl $4,%eax
	cmpl %ebx,%eax
	jb .L275
.L274:
	movl 12(%ebp),%eax
	addl %ecx,%edx
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe26:
	.size	 unroll8x2_combine,.Lfe26-unroll8x2_combine
.globl unroll9x3_descr
.data
	.align 32
	.type	 unroll9x3_descr,@object
	.size	 unroll9x3_descr,44
unroll9x3_descr:
	.string	"Pointer code, unrolled by 9, Superscalar x3"
.text
	.align 4
.globl unroll9x3_combine
	.type	 unroll9x3_combine,@function
unroll9x3_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -32(%eax,%esi,4),%ecx
	xorl %edx,%edx
	xorl %ebx,%ebx
	xorl %esi,%esi
	cmpl %ecx,%eax
	jae .L279
	.p2align 4,,7
.L280:
	addl (%eax),%edx
	addl 4(%eax),%ebx
	addl 8(%eax),%esi
	addl 12(%eax),%edx
	addl 16(%eax),%ebx
	addl 20(%eax),%esi
	addl 24(%eax),%edx
	addl 28(%eax),%ebx
	addl 32(%eax),%esi
	addl $36,%eax
	cmpl %ecx,%eax
	jb .L280
.L279:
	addl $32,%ecx
	cmpl %ecx,%eax
	jae .L283
	.p2align 4,,7
.L284:
	addl (%eax),%edx
	addl $4,%eax
	cmpl %ecx,%eax
	jb .L284
.L283:
	movl 12(%ebp),%eax
	addl %ebx,%edx
	addl %esi,%edx
	movl %edx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe27:
	.size	 unroll9x3_combine,.Lfe27-unroll9x3_combine
.globl unroll8x4_descr
.data
	.align 32
	.type	 unroll8x4_descr,@object
	.size	 unroll8x4_descr,44
unroll8x4_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x4"
.text
	.align 4
.globl unroll8x4_combine
	.type	 unroll8x4_combine,@function
unroll8x4_combine:
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
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -28(%eax,%esi,4),%edx
	xorl %ecx,%ecx
	xorl %ebx,%ebx
	xorl %esi,%esi
	xorl %edi,%edi
	cmpl %edx,%eax
	jae .L288
	.p2align 4,,7
.L289:
	addl (%eax),%ecx
	addl 4(%eax),%ebx
	addl 8(%eax),%esi
	addl 12(%eax),%edi
	addl 16(%eax),%ecx
	addl 20(%eax),%ebx
	addl 24(%eax),%esi
	addl 28(%eax),%edi
	addl $32,%eax
	cmpl %edx,%eax
	jb .L289
.L288:
	addl $28,%edx
	cmpl %edx,%eax
	jae .L292
	.p2align 4,,7
.L293:
	addl (%eax),%ecx
	addl $4,%eax
	cmpl %edx,%eax
	jb .L293
.L292:
	movl 12(%ebp),%edx
	leal (%ebx,%ecx),%eax
	addl %esi,%eax
	addl %edi,%eax
	movl %eax,(%edx)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe28:
	.size	 unroll8x4_combine,.Lfe28-unroll8x4_combine
.globl unroll8x8_descr
.data
	.align 32
	.type	 unroll8x8_descr,@object
	.size	 unroll8x8_descr,44
unroll8x8_descr:
	.string	"Pointer code, unrolled by 8, Superscalar x8"
.text
	.align 4
.globl unroll8x8_combine
	.type	 unroll8x8_combine,@function
unroll8x8_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	leal -28(%eax,%esi,4),%edx
	xorl %ecx,%ecx
	xorl %ebx,%ebx
	xorl %esi,%esi
	movl $0,-20(%ebp)
	movl $0,-4(%ebp)
	movl $0,-8(%ebp)
	movl $0,-12(%ebp)
	movl $0,-16(%ebp)
	cmpl %edx,%eax
	jae .L297
	.p2align 4,,7
.L298:
	movl 12(%eax),%edi
	addl (%eax),%ecx
	addl 4(%eax),%ebx
	addl 8(%eax),%esi
	addl %edi,-20(%ebp)
	movl 16(%eax),%edi
	addl %edi,-4(%ebp)
	movl 20(%eax),%edi
	addl %edi,-8(%ebp)
	movl 24(%eax),%edi
	addl %edi,-12(%ebp)
	movl 28(%eax),%edi
	addl %edi,-16(%ebp)
	addl $32,%eax
	cmpl %edx,%eax
	jb .L298
.L297:
	addl $28,%edx
	cmpl %edx,%eax
	jae .L301
	.p2align 4,,7
.L302:
	addl (%eax),%ecx
	addl $4,%eax
	cmpl %edx,%eax
	jb .L302
.L301:
	movl 12(%ebp),%edx
	leal (%ebx,%ecx),%eax
	addl %esi,%eax
	addl -20(%ebp),%eax
	addl -4(%ebp),%eax
	addl -8(%ebp),%eax
	addl -12(%ebp),%eax
	addl -16(%ebp),%eax
	movl %eax,(%edx)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe29:
	.size	 unroll8x8_combine,.Lfe29-unroll8x8_combine
.globl unroll2aa_descr
.data
	.align 32
	.type	 unroll2aa_descr,@object
	.size	 unroll2aa_descr,51
unroll2aa_descr:
	.string	"Array code, unrolled by 2, different associativity"
.text
	.align 4
.globl unroll2aa_combine
	.type	 unroll2aa_combine,@function
unroll2aa_combine:
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
	leal -1(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	xorl %ecx,%ecx
	xorl %edx,%edx
	cmpl %esi,%ecx
	jge .L316
	.p2align 4,,7
.L308:
	movl 4(%ebx,%edx,4),%eax
	addl (%ebx,%edx,4),%eax
	addl %eax,%ecx
	addl $2,%edx
	cmpl %esi,%edx
	jl .L308
	jmp .L316
	.p2align 4,,7
.L313:
	addl (%ebx,%edx,4),%ecx
	incl %edx
.L316:
	cmpl %edi,%edx
	jl .L313
	movl 12(%ebp),%eax
	movl %ecx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe30:
	.size	 unroll2aa_combine,.Lfe30-unroll2aa_combine
.globl unroll3aa_descr
.data
	.align 32
	.type	 unroll3aa_descr,@object
	.size	 unroll3aa_descr,51
unroll3aa_descr:
	.string	"Array code, unrolled by 3, Different Associativity"
.text
	.align 4
.globl unroll3aa_combine
	.type	 unroll3aa_combine,@function
unroll3aa_combine:
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
	leal -2(%edi),%esi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ecx
	xorl %ebx,%ebx
	xorl %edx,%edx
	cmpl %esi,%ebx
	jge .L329
	.p2align 4,,7
.L321:
	movl 4(%ecx,%edx,4),%eax
	addl (%ecx,%edx,4),%eax
	addl 8(%ecx,%edx,4),%eax
	addl %eax,%ebx
	addl $3,%edx
	cmpl %esi,%edx
	jl .L321
	jmp .L329
	.p2align 4,,7
.L326:
	addl (%ecx,%edx,4),%ebx
	incl %edx
.L329:
	cmpl %edi,%edx
	jl .L326
	movl 12(%ebp),%eax
	movl %ebx,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe31:
	.size	 unroll3aa_combine,.Lfe31-unroll3aa_combine
.globl unroll4aa_descr
.data
	.align 32
	.type	 unroll4aa_descr,@object
	.size	 unroll4aa_descr,51
unroll4aa_descr:
	.string	"Array code, unrolled by 4, Different Associativity"
.text
	.align 4
.globl unroll4aa_combine
	.type	 unroll4aa_combine,@function
unroll4aa_combine:
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
	movl %eax,%edi
	addl $-3,%edi
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,%ebx
	xorl %esi,%esi
	xorl %ecx,%ecx
	cmpl %edi,%esi
	jge .L342
	.p2align 4,,7
.L334:
	movl 4(%ebx,%ecx,4),%edx
	movl 12(%ebx,%ecx,4),%eax
	addl (%ebx,%ecx,4),%edx
	addl 8(%ebx,%ecx,4),%eax
	addl %eax,%edx
	addl %edx,%esi
	addl $4,%ecx
	cmpl %edi,%ecx
	jl .L334
	jmp .L342
	.p2align 4,,7
.L339:
	addl (%ebx,%ecx,4),%esi
	incl %ecx
.L342:
	cmpl -4(%ebp),%ecx
	jl .L339
	movl 12(%ebp),%eax
	movl %esi,(%eax)
	leal -24(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe32:
	.size	 unroll4aa_combine,.Lfe32-unroll4aa_combine
.globl unroll6aa_descr
.data
	.align 32
	.type	 unroll6aa_descr,@object
	.size	 unroll6aa_descr,51
unroll6aa_descr:
	.string	"Array code, unrolled by 6, Different Associativity"
.text
	.align 4
.globl unroll6aa_combine
	.type	 unroll6aa_combine,@function
unroll6aa_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
	addl $-12,%esp
	pushl %ebx
	call vec_length
	movl %eax,-4(%ebp)
	addl $-5,%eax
	movl %eax,-8(%ebp)
	addl $-12,%esp
	pushl %ebx
	call get_vec_start
	movl %eax,-12(%ebp)
	xorl %edi,%edi
	xorl %esi,%esi
	cmpl -8(%ebp),%edi
	jge .L355
	movl %eax,%ebx
	.p2align 4,,7
.L347:
	movl 4(%ebx),%eax
	movl 12(%ebx),%ecx
	movl 20(%ebx),%edx
	addl (%ebx),%eax
	addl 8(%ebx),%ecx
	addl 16(%ebx),%edx
	addl %ecx,%eax
	addl %edx,%eax
	addl %eax,%edi
	addl $24,%ebx
	addl $6,%esi
	cmpl -8(%ebp),%esi
	jl .L347
	jmp .L355
	.p2align 4,,7
.L352:
	movl -12(%ebp),%eax
	addl (%eax,%esi,4),%edi
	incl %esi
.L355:
	cmpl -4(%ebp),%esi
	jl .L352
	movl 12(%ebp),%eax
	movl %edi,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe33:
	.size	 unroll6aa_combine,.Lfe33-unroll6aa_combine
.globl unroll8aa_descr
.data
	.align 32
	.type	 unroll8aa_descr,@object
	.size	 unroll8aa_descr,51
unroll8aa_descr:
	.string	"Array code, unrolled by 8, Different Associativity"
.text
	.align 4
.globl unroll8aa_combine
	.type	 unroll8aa_combine,@function
unroll8aa_combine:
	pushl %ebp
	movl %esp,%ebp
	subl $28,%esp
	pushl %edi
	pushl %esi
	pushl %ebx
	movl 8(%ebp),%ebx
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
	xorl %edi,%edi
	xorl %esi,%esi
	cmpl -8(%ebp),%edi
	jge .L368
	movl %eax,%ebx
	.p2align 4,,7
.L360:
	movl 4(%ebx),%ecx
	movl 12(%ebx),%eax
	movl 20(%ebx),%edx
	addl (%ebx),%ecx
	addl 8(%ebx),%eax
	addl %eax,%ecx
	movl 28(%ebx),%eax
	addl 16(%ebx),%edx
	addl 24(%ebx),%eax
	addl %eax,%edx
	addl %edx,%ecx
	addl %ecx,%edi
	addl $32,%ebx
	addl $8,%esi
	cmpl -8(%ebp),%esi
	jl .L360
	jmp .L368
	.p2align 4,,7
.L365:
	movl -12(%ebp),%eax
	addl (%eax,%esi,4),%edi
	incl %esi
.L368:
	cmpl -4(%ebp),%esi
	jl .L365
	movl 12(%ebp),%eax
	movl %edi,(%eax)
	leal -40(%ebp),%esp
	popl %ebx
	popl %esi
	popl %edi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe34:
	.size	 unroll8aa_combine,.Lfe34-unroll8aa_combine
	.align 4
.globl register_combiners
	.type	 register_combiners,@function
register_combiners:
	pushl %ebp
	movl %esp,%ebp
	subl $8,%esp
	addl $-4,%esp
	pushl $combine1_descr
	pushl $combine1
	pushl $combine1
	call add_combiner
	addl $-4,%esp
	pushl $combine2_descr
	pushl $combine1
	pushl $combine2
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $combine3_descr
	pushl $combine1
	pushl $combine3
	call add_combiner
	addl $-4,%esp
	pushl $combine4_descr
	pushl $combine1
	pushl $combine4
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $combine4p_descr
	pushl $combine1
	pushl $combine4p
	call add_combiner
	addl $-4,%esp
	pushl $unroll2a_descr
	pushl $combine1
	pushl $unroll2a_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $combine5p_descr
	pushl $combine1
	pushl $combine5p
	call add_combiner
	addl $-4,%esp
	pushl $unroll3aw_descr
	pushl $combine1
	pushl $unroll3aw_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll4a_descr
	pushl $combine1
	pushl $unroll4a_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll8a_descr
	pushl $combine1
	pushl $unroll8a_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll16a_descr
	pushl $combine1
	pushl $unroll16a_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll2_descr
	pushl $combine1
	pushl $unroll2_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll3_descr
	pushl $combine1
	pushl $unroll3_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll4_descr
	pushl $combine1
	pushl $unroll4_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8_descr
	pushl $combine1
	pushl $unroll8_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll16_descr
	pushl $combine1
	pushl $unroll16_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $combine6_descr
	pushl $combine1
	pushl $combine6
	call add_combiner
	addl $-4,%esp
	pushl $unroll4x2a_descr
	pushl $combine1
	pushl $unroll4x2a_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x2a_descr
	pushl $combine1
	pushl $unroll8x2a_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll8x4a_descr
	pushl $combine1
	pushl $unroll8x4a_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x8a_descr
	pushl $combine1
	pushl $unroll8x8a_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll12x6a_descr
	pushl $combine1
	pushl $unroll12x6a_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x2_descr
	pushl $combine1
	pushl $unroll8x2_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll8x4_descr
	pushl $combine1
	pushl $unroll8x4_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll8x8_descr
	pushl $combine1
	pushl $unroll8x8_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll9x3_descr
	pushl $combine1
	pushl $unroll9x3_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unrollx2as_descr
	pushl $combine1
	pushl $unrollx2as_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll2aa_descr
	pushl $combine1
	pushl $unroll2aa_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll3aa_descr
	pushl $combine1
	pushl $unroll3aa_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll4aa_descr
	pushl $combine1
	pushl $unroll4aa_combine
	call add_combiner
	addl $32,%esp
	addl $-4,%esp
	pushl $unroll6aa_descr
	pushl $combine1
	pushl $unroll6aa_combine
	call add_combiner
	addl $-4,%esp
	pushl $unroll8aa_descr
	pushl $combine1
	pushl $unroll8aa_combine
	call add_combiner
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe35:
	.size	 register_combiners,.Lfe35-register_combiners
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
