
switchbody-ans:     file format elf32-i386

Disassembly of section .init:

08048274 <_init>:
 8048274:	55                   	push   %ebp
 8048275:	89 e5                	mov    %esp,%ebp
 8048277:	53                   	push   %ebx
 8048278:	e8 00 00 00 00       	call   804827d <_init+0x9>
 804827d:	5b                   	pop    %ebx
 804827e:	81 c3 23 12 00 00    	add    $0x1223,%ebx
 8048284:	83 bb 18 00 00 00 00 	cmpl   $0x0,0x18(%ebx)
 804828b:	74 05                	je     8048292 <_init+0x1e>
 804828d:	e8 6e 7d fb f7       	call   0 <_init-0x8048274>
 8048292:	89 f6                	mov    %esi,%esi
 8048294:	e8 e7 00 00 00       	call   8048380 <frame_dummy>
 8048299:	e8 72 01 00 00       	call   8048410 <__do_global_ctors_aux>
 804829e:	8b 5d fc             	mov    0xfffffffc(%ebp),%ebx
 80482a1:	c9                   	leave  
 80482a2:	c3                   	ret    
Disassembly of section .plt:

080482a4 <.plt>:
 80482a4:	ff 35 a4 94 04 08    	pushl  0x80494a4
 80482aa:	ff 25 a8 94 04 08    	jmp    *0x80494a8
 80482b0:	00 00                	add    %al,(%eax)
 80482b2:	00 00                	add    %al,(%eax)
 80482b4:	ff 25 ac 94 04 08    	jmp    *0x80494ac
 80482ba:	68 00 00 00 00       	push   $0x0
 80482bf:	e9 e0 ff ff ff       	jmp    80482a4 <_init+0x30>
 80482c4:	ff 25 b0 94 04 08    	jmp    *0x80494b0
 80482ca:	68 08 00 00 00       	push   $0x8
 80482cf:	e9 d0 ff ff ff       	jmp    80482a4 <_init+0x30>
 80482d4:	ff 25 b4 94 04 08    	jmp    *0x80494b4
 80482da:	68 10 00 00 00       	push   $0x10
 80482df:	e9 c0 ff ff ff       	jmp    80482a4 <_init+0x30>
Disassembly of section .text:

080482f0 <_start>:
 80482f0:	31 ed                	xor    %ebp,%ebp
 80482f2:	5e                   	pop    %esi
 80482f3:	89 e1                	mov    %esp,%ecx
 80482f5:	83 e4 f8             	and    $0xfffffff8,%esp
 80482f8:	50                   	push   %eax
 80482f9:	54                   	push   %esp
 80482fa:	52                   	push   %edx
 80482fb:	68 44 84 04 08       	push   $0x8048444
 8048300:	68 74 82 04 08       	push   $0x8048274
 8048305:	51                   	push   %ecx
 8048306:	56                   	push   %esi
 8048307:	68 f4 83 04 08       	push   $0x80483f4
 804830c:	e8 c3 ff ff ff       	call   80482d4 <_init+0x60>
 8048311:	f4                   	hlt    
 8048312:	90                   	nop    
 8048313:	90                   	nop    

08048314 <gcc2_compiled.>:
 8048314:	90 90 90 90 90 90 90 90 90 90 90 90                 ............

08048320 <__do_global_dtors_aux>:
 8048320:	55                   	push   %ebp
 8048321:	89 e5                	mov    %esp,%ebp
 8048323:	83 ec 08             	sub    $0x8,%esp
 8048326:	83 3d 88 94 04 08 00 	cmpl   $0x0,0x8049488
 804832d:	75 3e                	jne    804836d <__do_global_dtors_aux+0x4d>
 804832f:	eb 12                	jmp    8048343 <__do_global_dtors_aux+0x23>
 8048331:	a1 84 94 04 08       	mov    0x8049484,%eax
 8048336:	8d 50 04             	lea    0x4(%eax),%edx
 8048339:	89 15 84 94 04 08    	mov    %edx,0x8049484
 804833f:	8b 00                	mov    (%eax),%eax
 8048341:	ff d0                	call   *%eax
 8048343:	a1 84 94 04 08       	mov    0x8049484,%eax
 8048348:	83 38 00             	cmpl   $0x0,(%eax)
 804834b:	75 e4                	jne    8048331 <__do_global_dtors_aux+0x11>
 804834d:	b8 c4 82 04 08       	mov    $0x80482c4,%eax
 8048352:	85 c0                	test   %eax,%eax
 8048354:	74 0d                	je     8048363 <__do_global_dtors_aux+0x43>
 8048356:	83 c4 f4             	add    $0xfffffff4,%esp
 8048359:	68 8c 94 04 08       	push   $0x804948c
 804835e:	e8 61 ff ff ff       	call   80482c4 <_init+0x50>
 8048363:	c7 05 88 94 04 08 01 	movl   $0x1,0x8049488
 804836a:	00 00 00 
 804836d:	89 ec                	mov    %ebp,%esp
 804836f:	5d                   	pop    %ebp
 8048370:	c3                   	ret    
 8048371:	8d 76 00             	lea    0x0(%esi),%esi

08048374 <fini_dummy>:
 8048374:	55                   	push   %ebp
 8048375:	89 e5                	mov    %esp,%ebp
 8048377:	83 ec 08             	sub    $0x8,%esp
 804837a:	89 ec                	mov    %ebp,%esp
 804837c:	5d                   	pop    %ebp
 804837d:	c3                   	ret    
 804837e:	89 f6                	mov    %esi,%esi

08048380 <frame_dummy>:
 8048380:	55                   	push   %ebp
 8048381:	89 e5                	mov    %esp,%ebp
 8048383:	83 ec 08             	sub    $0x8,%esp
 8048386:	b8 b4 82 04 08       	mov    $0x80482b4,%eax
 804838b:	85 c0                	test   %eax,%eax
 804838d:	74 12                	je     80483a1 <frame_dummy+0x21>
 804838f:	83 c4 f8             	add    $0xfffffff8,%esp
 8048392:	68 5c 95 04 08       	push   $0x804955c
 8048397:	68 8c 94 04 08       	push   $0x804948c
 804839c:	e8 13 ff ff ff       	call   80482b4 <_init+0x40>
 80483a1:	89 ec                	mov    %ebp,%esp
 80483a3:	5d                   	pop    %ebp
 80483a4:	c3                   	ret    
 80483a5:	8d 76 00             	lea    0x0(%esi),%esi

080483a8 <init_dummy>:
 80483a8:	55                   	push   %ebp
 80483a9:	89 e5                	mov    %esp,%ebp
 80483ab:	83 ec 08             	sub    $0x8,%esp
 80483ae:	89 ec                	mov    %ebp,%esp
 80483b0:	5d                   	pop    %ebp
 80483b1:	c3                   	ret    
 80483b2:	90                   	nop    
 80483b3:	90                   	nop    
 80483b4:	90                   	nop    
 80483b5:	90                   	nop    
 80483b6:	90                   	nop    
 80483b7:	90                   	nop    
 80483b8:	90                   	nop    
 80483b9:	90                   	nop    
 80483ba:	90                   	nop    
 80483bb:	90                   	nop    
 80483bc:	90                   	nop    
 80483bd:	90                   	nop    
 80483be:	90                   	nop    
 80483bf:	90                   	nop    

080483c0 <switch_prob>:
 80483c0:	55                   	push   %ebp
 80483c1:	89 e5                	mov    %esp,%ebp
 80483c3:	8b 45 08             	mov    0x8(%ebp),%eax
 80483c6:	8d 50 ce             	lea    0xffffffce(%eax),%edx
 80483c9:	83 fa 05             	cmp    $0x5,%edx
 80483cc:	77 1d                	ja     80483eb <switch_prob+0x2b>
 80483ce:	ff 24 95 68 84 04 08 	jmp    *0x8048468(,%edx,4)
 80483d5:	c1 e0 02             	shl    $0x2,%eax
 80483d8:	eb 14                	jmp    80483ee <switch_prob+0x2e>
 80483da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 80483e0:	c1 f8 02             	sar    $0x2,%eax
 80483e3:	eb 09                	jmp    80483ee <switch_prob+0x2e>
 80483e5:	8d 04 40             	lea    (%eax,%eax,2),%eax
 80483e8:	0f af c0             	imul   %eax,%eax
 80483eb:	83 c0 0a             	add    $0xa,%eax
 80483ee:	89 ec                	mov    %ebp,%esp
 80483f0:	5d                   	pop    %ebp
 80483f1:	c3                   	ret    
 80483f2:	89 f6                	mov    %esi,%esi

080483f4 <main>:
 80483f4:	55                   	push   %ebp
 80483f5:	89 e5                	mov    %esp,%ebp
 80483f7:	83 ec 08             	sub    $0x8,%esp
 80483fa:	83 c4 f4             	add    $0xfffffff4,%esp
 80483fd:	6a 35                	push   $0x35
 80483ff:	e8 bc ff ff ff       	call   80483c0 <switch_prob>
 8048404:	89 ec                	mov    %ebp,%esp
 8048406:	5d                   	pop    %ebp
 8048407:	c3                   	ret    
 8048408:	90                   	nop    
 8048409:	90                   	nop    
 804840a:	90                   	nop    
 804840b:	90                   	nop    
 804840c:	90                   	nop    
 804840d:	90                   	nop    
 804840e:	90                   	nop    
 804840f:	90                   	nop    

08048410 <__do_global_ctors_aux>:
 8048410:	55                   	push   %ebp
 8048411:	89 e5                	mov    %esp,%ebp
 8048413:	83 ec 14             	sub    $0x14,%esp
 8048416:	53                   	push   %ebx
 8048417:	bb 90 94 04 08       	mov    $0x8049490,%ebx
 804841c:	83 3d 90 94 04 08 ff 	cmpl   $0xffffffff,0x8049490
 8048423:	74 0c                	je     8048431 <__do_global_ctors_aux+0x21>
 8048425:	8b 03                	mov    (%ebx),%eax
 8048427:	ff d0                	call   *%eax
 8048429:	83 c3 fc             	add    $0xfffffffc,%ebx
 804842c:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 804842f:	75 f4                	jne    8048425 <__do_global_ctors_aux+0x15>
 8048431:	5b                   	pop    %ebx
 8048432:	89 ec                	mov    %ebp,%esp
 8048434:	5d                   	pop    %ebp
 8048435:	c3                   	ret    
 8048436:	89 f6                	mov    %esi,%esi

08048438 <init_dummy>:
 8048438:	55                   	push   %ebp
 8048439:	89 e5                	mov    %esp,%ebp
 804843b:	83 ec 08             	sub    $0x8,%esp
 804843e:	89 ec                	mov    %ebp,%esp
 8048440:	5d                   	pop    %ebp
 8048441:	c3                   	ret    
 8048442:	90                   	nop    
 8048443:	90                   	nop    
Disassembly of section .fini:

08048444 <_fini>:
 8048444:	55                   	push   %ebp
 8048445:	89 e5                	mov    %esp,%ebp
 8048447:	53                   	push   %ebx
 8048448:	e8 00 00 00 00       	call   804844d <_etext+0x9>
 804844d:	5b                   	pop    %ebx
 804844e:	81 c3 53 10 00 00    	add    $0x1053,%ebx
 8048454:	e8 c7 fe ff ff       	call   8048320 <__do_global_dtors_aux>
 8048459:	8b 5d fc             	mov    0xfffffffc(%ebp),%ebx
 804845c:	c9                   	leave  
 804845d:	c3                   	ret    
