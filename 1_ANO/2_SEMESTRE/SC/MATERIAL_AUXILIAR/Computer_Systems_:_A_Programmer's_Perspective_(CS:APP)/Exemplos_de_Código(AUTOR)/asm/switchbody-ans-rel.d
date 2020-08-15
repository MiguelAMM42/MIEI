
switchbody-ans.o:     file format elf32-i386

Disassembly of section .text:

00000000 <switch_prob>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 45 08             	mov    0x8(%ebp),%eax
   6:	8d 50 ce             	lea    0xffffffce(%eax),%edx
   9:	83 fa 05             	cmp    $0x5,%edx
   c:	77 1d                	ja     2b <switch_prob+0x2b>
   e:	ff 24 95 00 00 00 00 	jmp    *0x0(,%edx,4)
  15:	c1 e0 02             	shl    $0x2,%eax
  18:	eb 14                	jmp    2e <switch_prob+0x2e>
  1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  20:	c1 f8 02             	sar    $0x2,%eax
  23:	eb 09                	jmp    2e <switch_prob+0x2e>
  25:	8d 04 40             	lea    (%eax,%eax,2),%eax
  28:	0f af c0             	imul   %eax,%eax
  2b:	83 c0 0a             	add    $0xa,%eax
  2e:	89 ec                	mov    %ebp,%esp
  30:	5d                   	pop    %ebp
  31:	c3                   	ret    
  32:	89 f6                	mov    %esi,%esi

00000034 <main>:
  34:	55                   	push   %ebp
  35:	89 e5                	mov    %esp,%ebp
  37:	83 ec 08             	sub    $0x8,%esp
  3a:	83 c4 f4             	add    $0xfffffff4,%esp
  3d:	6a 35                	push   $0x35
  3f:	e8 fc ff ff ff       	call   40 <main+0xc>
  44:	89 ec                	mov    %ebp,%esp
  46:	5d                   	pop    %ebp
  47:	c3                   	ret    
