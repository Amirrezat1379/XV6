
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 c5 10 80       	mov    $0x8010c5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 30 10 80       	mov    $0x80103060,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb 14 c6 10 80       	mov    $0x8010c614,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 e0 78 10 80       	push   $0x801078e0
80100055:	68 e0 c5 10 80       	push   $0x8010c5e0
8010005a:	e8 01 4a 00 00       	call   80104a60 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 dc 0c 11 80       	mov    $0x80110cdc,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 2c 0d 11 80 dc 	movl   $0x80110cdc,0x80110d2c
8010006e:	0c 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 30 0d 11 80 dc 	movl   $0x80110cdc,0x80110d30
80100078:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 78 10 80       	push   $0x801078e7
80100097:	50                   	push   %eax
80100098:	e8 83 48 00 00       	call   80104920 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 0d 11 80       	mov    0x80110d30,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 80 0a 11 80    	cmp    $0x80110a80,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 e0 c5 10 80       	push   $0x8010c5e0
801000e8:	e8 f3 4a 00 00       	call   80104be0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 30 0d 11 80    	mov    0x80110d30,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c 0d 11 80    	mov    0x80110d2c,%ebx
80100126:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 c5 10 80       	push   $0x8010c5e0
80100162:	e8 39 4b 00 00       	call   80104ca0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 47 00 00       	call   80104960 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 0f 21 00 00       	call   801022a0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ee 78 10 80       	push   $0x801078ee
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 39 48 00 00       	call   80104a00 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 c3 20 00 00       	jmp    801022a0 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 ff 78 10 80       	push   $0x801078ff
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 f8 47 00 00       	call   80104a00 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 a8 47 00 00       	call   801049c0 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
8010021f:	e8 bc 49 00 00       	call   80104be0 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 30 0d 11 80       	mov    0x80110d30,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 30 0d 11 80       	mov    0x80110d30,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 2b 4a 00 00       	jmp    80104ca0 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 06 79 10 80       	push   $0x80107906
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
8010029d:	ff 75 08             	pushl  0x8(%ebp)
{
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
801002a3:	89 de                	mov    %ebx,%esi
  iunlock(ip);
801002a5:	e8 b6 15 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002b1:	e8 2a 49 00 00       	call   80104be0 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002bc:	01 df                	add    %ebx,%edi
  while(n > 0){
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
    while(input.r == input.w){
801002c6:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
801002cb:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 20 b5 10 80       	push   $0x8010b520
801002e0:	68 c0 0f 11 80       	push   $0x80110fc0
801002e5:	e8 96 40 00 00       	call   80104380 <sleep>
    while(input.r == input.w){
801002ea:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 21 37 00 00       	call   80103a20 <myproc>
801002ff:	8b 48 2c             	mov    0x2c(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 b5 10 80       	push   $0x8010b520
8010030e:	e8 8d 49 00 00       	call   80104ca0 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 64 14 00 00       	call   80101780 <ilock>
        return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 c0 0f 11 80    	mov    %edx,0x80110fc0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 40 0f 11 80 	movsbl -0x7feef0c0(%edx),%ecx
    if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
    *dst++ = c;
8010034a:	89 d8                	mov    %ebx,%eax
    --n;
8010034c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
  release(&cons.lock);
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 20 b5 10 80       	push   $0x8010b520
80100365:	e8 36 49 00 00       	call   80104ca0 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 0d 14 00 00       	call   80101780 <ilock>
  return target - n;
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
}
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037b:	29 d8                	sub    %ebx,%eax
}
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
      if(n < target){
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
        input.r--;
80100386:	a3 c0 0f 11 80       	mov    %eax,0x80110fc0
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
  cons.locking = 0;
8010039d:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 0e 25 00 00       	call   801028c0 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 0d 79 10 80       	push   $0x8010790d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 77 82 10 80 	movl   $0x80108277,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 9f 46 00 00       	call   80104a80 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 21 79 10 80       	push   $0x80107921
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100404:	00 00 00 
  for(;;)
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 b1 60 00 00       	call   801064e0 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004eb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 c6 5f 00 00       	call   801064e0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 ba 5f 00 00       	call   801064e0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 ae 5f 00 00       	call   801064e0 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 2a 48 00 00       	call   80104d90 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 75 47 00 00       	call   80104cf0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 25 79 10 80       	push   $0x80107925
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 6d                	js     80100621 <printint+0x81>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005bb:	31 db                	xor    %ebx,%ebx
801005bd:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	89 ce                	mov    %ecx,%esi
801005c6:	f7 75 d4             	divl   -0x2c(%ebp)
801005c9:	0f b6 92 50 79 10 80 	movzbl -0x7fef86b0(%edx),%edx
801005d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005d3:	89 d8                	mov    %ebx,%eax
801005d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005d8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005db:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005de:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
801005e1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005e4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005e7:	73 d7                	jae    801005c0 <printint+0x20>
801005e9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
801005ec:	85 f6                	test   %esi,%esi
801005ee:	74 0c                	je     801005fc <printint+0x5c>
    buf[i++] = '-';
801005f0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005f5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005f7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801005fc:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100600:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100603:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 03                	je     80100610 <printint+0x70>
  asm volatile("cli");
8010060d:	fa                   	cli    
    for(;;)
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
80100610:	e8 fb fd ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
80100615:	39 fb                	cmp    %edi,%ebx
80100617:	74 10                	je     80100629 <printint+0x89>
80100619:	0f be 03             	movsbl (%ebx),%eax
8010061c:	83 eb 01             	sub    $0x1,%ebx
8010061f:	eb e2                	jmp    80100603 <printint+0x63>
    x = -xx;
80100621:	f7 d8                	neg    %eax
80100623:	89 ce                	mov    %ecx,%esi
80100625:	89 c1                	mov    %eax,%ecx
80100627:	eb 8f                	jmp    801005b8 <printint+0x18>
}
80100629:	83 c4 2c             	add    $0x2c,%esp
8010062c:	5b                   	pop    %ebx
8010062d:	5e                   	pop    %esi
8010062e:	5f                   	pop    %edi
8010062f:	5d                   	pop    %ebp
80100630:	c3                   	ret    
80100631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010063f:	90                   	nop

80100640 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100640:	f3 0f 1e fb          	endbr32 
80100644:	55                   	push   %ebp
80100645:	89 e5                	mov    %esp,%ebp
80100647:	57                   	push   %edi
80100648:	56                   	push   %esi
80100649:	53                   	push   %ebx
8010064a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010064d:	ff 75 08             	pushl  0x8(%ebp)
{
80100650:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100653:	e8 08 12 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
80100658:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010065f:	e8 7c 45 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++)
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100671:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100677:	85 d2                	test   %edx,%edx
80100679:	74 05                	je     80100680 <consolewrite+0x40>
8010067b:	fa                   	cli    
    for(;;)
8010067c:	eb fe                	jmp    8010067c <consolewrite+0x3c>
8010067e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100680:	0f b6 07             	movzbl (%edi),%eax
80100683:	83 c7 01             	add    $0x1,%edi
80100686:	e8 85 fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
8010068b:	39 fe                	cmp    %edi,%esi
8010068d:	75 e2                	jne    80100671 <consolewrite+0x31>
  release(&cons.lock);
8010068f:	83 ec 0c             	sub    $0xc,%esp
80100692:	68 20 b5 10 80       	push   $0x8010b520
80100697:	e8 04 46 00 00       	call   80104ca0 <release>
  ilock(ip);
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 db 10 00 00       	call   80101780 <ilock>

  return n;
}
801006a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a8:	89 d8                	mov    %ebx,%eax
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop

801006b0 <cprintf>:
{
801006b0:	f3 0f 1e fb          	endbr32 
801006b4:	55                   	push   %ebp
801006b5:	89 e5                	mov    %esp,%ebp
801006b7:	57                   	push   %edi
801006b8:	56                   	push   %esi
801006b9:	53                   	push   %ebx
801006ba:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006bd:	a1 54 b5 10 80       	mov    0x8010b554,%eax
801006c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c5:	85 c0                	test   %eax,%eax
801006c7:	0f 85 e8 00 00 00    	jne    801007b5 <cprintf+0x105>
  if (fmt == 0)
801006cd:	8b 45 08             	mov    0x8(%ebp),%eax
801006d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d3:	85 c0                	test   %eax,%eax
801006d5:	0f 84 5a 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006db:	0f b6 00             	movzbl (%eax),%eax
801006de:	85 c0                	test   %eax,%eax
801006e0:	74 36                	je     80100718 <cprintf+0x68>
  argp = (uint*)(void*)(&fmt + 1);
801006e2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e5:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e7:	83 f8 25             	cmp    $0x25,%eax
801006ea:	74 44                	je     80100730 <cprintf+0x80>
  if(panicked){
801006ec:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
801006f2:	85 c9                	test   %ecx,%ecx
801006f4:	74 0f                	je     80100705 <cprintf+0x55>
801006f6:	fa                   	cli    
    for(;;)
801006f7:	eb fe                	jmp    801006f7 <cprintf+0x47>
801006f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100700:	b8 25 00 00 00       	mov    $0x25,%eax
80100705:	e8 06 fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010070a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010070d:	83 c6 01             	add    $0x1,%esi
80100710:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100714:	85 c0                	test   %eax,%eax
80100716:	75 cf                	jne    801006e7 <cprintf+0x37>
  if(locking)
80100718:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071b:	85 c0                	test   %eax,%eax
8010071d:	0f 85 fd 00 00 00    	jne    80100820 <cprintf+0x170>
}
80100723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100726:	5b                   	pop    %ebx
80100727:	5e                   	pop    %esi
80100728:	5f                   	pop    %edi
80100729:	5d                   	pop    %ebp
8010072a:	c3                   	ret    
8010072b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010072f:	90                   	nop
    c = fmt[++i] & 0xff;
80100730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100733:	83 c6 01             	add    $0x1,%esi
80100736:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
8010073a:	85 ff                	test   %edi,%edi
8010073c:	74 da                	je     80100718 <cprintf+0x68>
    switch(c){
8010073e:	83 ff 70             	cmp    $0x70,%edi
80100741:	74 5a                	je     8010079d <cprintf+0xed>
80100743:	7f 2a                	jg     8010076f <cprintf+0xbf>
80100745:	83 ff 25             	cmp    $0x25,%edi
80100748:	0f 84 92 00 00 00    	je     801007e0 <cprintf+0x130>
8010074e:	83 ff 64             	cmp    $0x64,%edi
80100751:	0f 85 a1 00 00 00    	jne    801007f8 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100757:	8b 03                	mov    (%ebx),%eax
80100759:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100761:	ba 0a 00 00 00       	mov    $0xa,%edx
80100766:	89 fb                	mov    %edi,%ebx
80100768:	e8 33 fe ff ff       	call   801005a0 <printint>
      break;
8010076d:	eb 9b                	jmp    8010070a <cprintf+0x5a>
    switch(c){
8010076f:	83 ff 73             	cmp    $0x73,%edi
80100772:	75 24                	jne    80100798 <cprintf+0xe8>
      if((s = (char*)*argp++) == 0)
80100774:	8d 7b 04             	lea    0x4(%ebx),%edi
80100777:	8b 1b                	mov    (%ebx),%ebx
80100779:	85 db                	test   %ebx,%ebx
8010077b:	75 55                	jne    801007d2 <cprintf+0x122>
        s = "(null)";
8010077d:	bb 38 79 10 80       	mov    $0x80107938,%ebx
      for(; *s; s++)
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100787:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
8010078d:	85 d2                	test   %edx,%edx
8010078f:	74 39                	je     801007ca <cprintf+0x11a>
80100791:	fa                   	cli    
    for(;;)
80100792:	eb fe                	jmp    80100792 <cprintf+0xe2>
80100794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100798:	83 ff 78             	cmp    $0x78,%edi
8010079b:	75 5b                	jne    801007f8 <cprintf+0x148>
      printint(*argp++, 16, 0);
8010079d:	8b 03                	mov    (%ebx),%eax
8010079f:	8d 7b 04             	lea    0x4(%ebx),%edi
801007a2:	31 c9                	xor    %ecx,%ecx
801007a4:	ba 10 00 00 00       	mov    $0x10,%edx
801007a9:	89 fb                	mov    %edi,%ebx
801007ab:	e8 f0 fd ff ff       	call   801005a0 <printint>
      break;
801007b0:	e9 55 ff ff ff       	jmp    8010070a <cprintf+0x5a>
    acquire(&cons.lock);
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 20 b5 10 80       	push   $0x8010b520
801007bd:	e8 1e 44 00 00       	call   80104be0 <acquire>
801007c2:	83 c4 10             	add    $0x10,%esp
801007c5:	e9 03 ff ff ff       	jmp    801006cd <cprintf+0x1d>
801007ca:	e8 41 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007cf:	83 c3 01             	add    $0x1,%ebx
801007d2:	0f be 03             	movsbl (%ebx),%eax
801007d5:	84 c0                	test   %al,%al
801007d7:	75 ae                	jne    80100787 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
801007d9:	89 fb                	mov    %edi,%ebx
801007db:	e9 2a ff ff ff       	jmp    8010070a <cprintf+0x5a>
  if(panicked){
801007e0:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
    for(;;)
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007f8:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
    for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100812:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
    for(;;)
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 20 b5 10 80       	push   $0x8010b520
80100828:	e8 73 44 00 00       	call   80104ca0 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 3f 79 10 80       	push   $0x8010793f
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 b6 fe ff ff       	jmp    8010070a <cprintf+0x5a>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <consoleintr>:
{
80100860:	f3 0f 1e fb          	endbr32 
80100864:	55                   	push   %ebp
80100865:	89 e5                	mov    %esp,%ebp
80100867:	57                   	push   %edi
80100868:	56                   	push   %esi
  int c, doprocdump = 0;
80100869:	31 f6                	xor    %esi,%esi
{
8010086b:	53                   	push   %ebx
8010086c:	83 ec 18             	sub    $0x18,%esp
8010086f:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100872:	68 20 b5 10 80       	push   $0x8010b520
80100877:	e8 64 43 00 00       	call   80104be0 <acquire>
  while((c = getc()) >= 0){
8010087c:	83 c4 10             	add    $0x10,%esp
8010087f:	eb 17                	jmp    80100898 <consoleintr+0x38>
    switch(c){
80100881:	83 fb 08             	cmp    $0x8,%ebx
80100884:	0f 84 f6 00 00 00    	je     80100980 <consoleintr+0x120>
8010088a:	83 fb 10             	cmp    $0x10,%ebx
8010088d:	0f 85 15 01 00 00    	jne    801009a8 <consoleintr+0x148>
80100893:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100898:	ff d7                	call   *%edi
8010089a:	89 c3                	mov    %eax,%ebx
8010089c:	85 c0                	test   %eax,%eax
8010089e:	0f 88 23 01 00 00    	js     801009c7 <consoleintr+0x167>
    switch(c){
801008a4:	83 fb 15             	cmp    $0x15,%ebx
801008a7:	74 77                	je     80100920 <consoleintr+0xc0>
801008a9:	7e d6                	jle    80100881 <consoleintr+0x21>
801008ab:	83 fb 7f             	cmp    $0x7f,%ebx
801008ae:	0f 84 cc 00 00 00    	je     80100980 <consoleintr+0x120>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008b4:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
801008b9:	89 c2                	mov    %eax,%edx
801008bb:	2b 15 c0 0f 11 80    	sub    0x80110fc0,%edx
801008c1:	83 fa 7f             	cmp    $0x7f,%edx
801008c4:	77 d2                	ja     80100898 <consoleintr+0x38>
        c = (c == '\r') ? '\n' : c;
801008c6:	8d 48 01             	lea    0x1(%eax),%ecx
801008c9:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801008cf:	83 e0 7f             	and    $0x7f,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801008d2:	89 0d c8 0f 11 80    	mov    %ecx,0x80110fc8
        c = (c == '\r') ? '\n' : c;
801008d8:	83 fb 0d             	cmp    $0xd,%ebx
801008db:	0f 84 02 01 00 00    	je     801009e3 <consoleintr+0x183>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e1:	88 98 40 0f 11 80    	mov    %bl,-0x7feef0c0(%eax)
  if(panicked){
801008e7:	85 d2                	test   %edx,%edx
801008e9:	0f 85 ff 00 00 00    	jne    801009ee <consoleintr+0x18e>
801008ef:	89 d8                	mov    %ebx,%eax
801008f1:	e8 1a fb ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008f6:	83 fb 0a             	cmp    $0xa,%ebx
801008f9:	0f 84 0f 01 00 00    	je     80100a0e <consoleintr+0x1ae>
801008ff:	83 fb 04             	cmp    $0x4,%ebx
80100902:	0f 84 06 01 00 00    	je     80100a0e <consoleintr+0x1ae>
80100908:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
8010090d:	83 e8 80             	sub    $0xffffff80,%eax
80100910:	39 05 c8 0f 11 80    	cmp    %eax,0x80110fc8
80100916:	75 80                	jne    80100898 <consoleintr+0x38>
80100918:	e9 f6 00 00 00       	jmp    80100a13 <consoleintr+0x1b3>
8010091d:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100920:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100925:	39 05 c4 0f 11 80    	cmp    %eax,0x80110fc4
8010092b:	0f 84 67 ff ff ff    	je     80100898 <consoleintr+0x38>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100931:	83 e8 01             	sub    $0x1,%eax
80100934:	89 c2                	mov    %eax,%edx
80100936:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100939:	80 ba 40 0f 11 80 0a 	cmpb   $0xa,-0x7feef0c0(%edx)
80100940:	0f 84 52 ff ff ff    	je     80100898 <consoleintr+0x38>
  if(panicked){
80100946:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
        input.e--;
8010094c:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
  if(panicked){
80100951:	85 d2                	test   %edx,%edx
80100953:	74 0b                	je     80100960 <consoleintr+0x100>
80100955:	fa                   	cli    
    for(;;)
80100956:	eb fe                	jmp    80100956 <consoleintr+0xf6>
80100958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010095f:	90                   	nop
80100960:	b8 00 01 00 00       	mov    $0x100,%eax
80100965:	e8 a6 fa ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
8010096a:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
8010096f:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
80100975:	75 ba                	jne    80100931 <consoleintr+0xd1>
80100977:	e9 1c ff ff ff       	jmp    80100898 <consoleintr+0x38>
8010097c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100980:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100985:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
8010098b:	0f 84 07 ff ff ff    	je     80100898 <consoleintr+0x38>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
  if(panicked){
80100999:	a1 58 b5 10 80       	mov    0x8010b558,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 16                	je     801009b8 <consoleintr+0x158>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x143>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009a8:	85 db                	test   %ebx,%ebx
801009aa:	0f 84 e8 fe ff ff    	je     80100898 <consoleintr+0x38>
801009b0:	e9 ff fe ff ff       	jmp    801008b4 <consoleintr+0x54>
801009b5:	8d 76 00             	lea    0x0(%esi),%esi
801009b8:	b8 00 01 00 00       	mov    $0x100,%eax
801009bd:	e8 4e fa ff ff       	call   80100410 <consputc.part.0>
801009c2:	e9 d1 fe ff ff       	jmp    80100898 <consoleintr+0x38>
  release(&cons.lock);
801009c7:	83 ec 0c             	sub    $0xc,%esp
801009ca:	68 20 b5 10 80       	push   $0x8010b520
801009cf:	e8 cc 42 00 00       	call   80104ca0 <release>
  if(doprocdump) {
801009d4:	83 c4 10             	add    $0x10,%esp
801009d7:	85 f6                	test   %esi,%esi
801009d9:	75 1d                	jne    801009f8 <consoleintr+0x198>
}
801009db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009de:	5b                   	pop    %ebx
801009df:	5e                   	pop    %esi
801009e0:	5f                   	pop    %edi
801009e1:	5d                   	pop    %ebp
801009e2:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009e3:	c6 80 40 0f 11 80 0a 	movb   $0xa,-0x7feef0c0(%eax)
  if(panicked){
801009ea:	85 d2                	test   %edx,%edx
801009ec:	74 16                	je     80100a04 <consoleintr+0x1a4>
801009ee:	fa                   	cli    
    for(;;)
801009ef:	eb fe                	jmp    801009ef <consoleintr+0x18f>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801009f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009fb:	5b                   	pop    %ebx
801009fc:	5e                   	pop    %esi
801009fd:	5f                   	pop    %edi
801009fe:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801009ff:	e9 dc 3d 00 00       	jmp    801047e0 <procdump>
80100a04:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a09:	e8 02 fa ff ff       	call   80100410 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a0e:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
          wakeup(&input.r);
80100a13:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a16:	a3 c4 0f 11 80       	mov    %eax,0x80110fc4
          wakeup(&input.r);
80100a1b:	68 c0 0f 11 80       	push   $0x80110fc0
80100a20:	e8 bb 3c 00 00       	call   801046e0 <wakeup>
80100a25:	83 c4 10             	add    $0x10,%esp
80100a28:	e9 6b fe ff ff       	jmp    80100898 <consoleintr+0x38>
80100a2d:	8d 76 00             	lea    0x0(%esi),%esi

80100a30 <consoleinit>:

void
consoleinit(void)
{
80100a30:	f3 0f 1e fb          	endbr32 
80100a34:	55                   	push   %ebp
80100a35:	89 e5                	mov    %esp,%ebp
80100a37:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a3a:	68 48 79 10 80       	push   $0x80107948
80100a3f:	68 20 b5 10 80       	push   $0x8010b520
80100a44:	e8 17 40 00 00       	call   80104a60 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a49:	58                   	pop    %eax
80100a4a:	5a                   	pop    %edx
80100a4b:	6a 00                	push   $0x0
80100a4d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a4f:	c7 05 8c 19 11 80 40 	movl   $0x80100640,0x8011198c
80100a56:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100a59:	c7 05 88 19 11 80 90 	movl   $0x80100290,0x80111988
80100a60:	02 10 80 
  cons.locking = 1;
80100a63:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
80100a6a:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a6d:	e8 de 19 00 00       	call   80102450 <ioapicenable>
}
80100a72:	83 c4 10             	add    $0x10,%esp
80100a75:	c9                   	leave  
80100a76:	c3                   	ret    
80100a77:	66 90                	xchg   %ax,%ax
80100a79:	66 90                	xchg   %ax,%ax
80100a7b:	66 90                	xchg   %ax,%ax
80100a7d:	66 90                	xchg   %ax,%ax
80100a7f:	90                   	nop

80100a80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a80:	f3 0f 1e fb          	endbr32 
80100a84:	55                   	push   %ebp
80100a85:	89 e5                	mov    %esp,%ebp
80100a87:	57                   	push   %edi
80100a88:	56                   	push   %esi
80100a89:	53                   	push   %ebx
80100a8a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a90:	e8 8b 2f 00 00       	call   80103a20 <myproc>
80100a95:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a9b:	e8 b0 22 00 00       	call   80102d50 <begin_op>

  if((ip = namei(path)) == 0){
80100aa0:	83 ec 0c             	sub    $0xc,%esp
80100aa3:	ff 75 08             	pushl  0x8(%ebp)
80100aa6:	e8 a5 15 00 00       	call   80102050 <namei>
80100aab:	83 c4 10             	add    $0x10,%esp
80100aae:	85 c0                	test   %eax,%eax
80100ab0:	0f 84 12 03 00 00    	je     80100dc8 <exec+0x348>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ab6:	83 ec 0c             	sub    $0xc,%esp
80100ab9:	89 c3                	mov    %eax,%ebx
80100abb:	50                   	push   %eax
80100abc:	e8 bf 0c 00 00       	call   80101780 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100ac1:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ac7:	6a 34                	push   $0x34
80100ac9:	6a 00                	push   $0x0
80100acb:	50                   	push   %eax
80100acc:	53                   	push   %ebx
80100acd:	e8 ae 0f 00 00       	call   80101a80 <readi>
80100ad2:	83 c4 20             	add    $0x20,%esp
80100ad5:	83 f8 34             	cmp    $0x34,%eax
80100ad8:	74 26                	je     80100b00 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ada:	83 ec 0c             	sub    $0xc,%esp
80100add:	53                   	push   %ebx
80100ade:	e8 3d 0f 00 00       	call   80101a20 <iunlockput>
    end_op();
80100ae3:	e8 d8 22 00 00       	call   80102dc0 <end_op>
80100ae8:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100aeb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100af0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100af3:	5b                   	pop    %ebx
80100af4:	5e                   	pop    %esi
80100af5:	5f                   	pop    %edi
80100af6:	5d                   	pop    %ebp
80100af7:	c3                   	ret    
80100af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100aff:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100b00:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b07:	45 4c 46 
80100b0a:	75 ce                	jne    80100ada <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
80100b0c:	e8 3f 6b 00 00       	call   80107650 <setupkvm>
80100b11:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b17:	85 c0                	test   %eax,%eax
80100b19:	74 bf                	je     80100ada <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b1b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b22:	00 
80100b23:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b29:	0f 84 b8 02 00 00    	je     80100de7 <exec+0x367>
  sz = 0;
80100b2f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b36:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b39:	31 ff                	xor    %edi,%edi
80100b3b:	e9 86 00 00 00       	jmp    80100bc6 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80100b40:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b47:	75 6c                	jne    80100bb5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b49:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b4f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b55:	0f 82 87 00 00 00    	jb     80100be2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b5b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b61:	72 7f                	jb     80100be2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b63:	83 ec 04             	sub    $0x4,%esp
80100b66:	50                   	push   %eax
80100b67:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b6d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b73:	e8 f8 68 00 00       	call   80107470 <allocuvm>
80100b78:	83 c4 10             	add    $0x10,%esp
80100b7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b81:	85 c0                	test   %eax,%eax
80100b83:	74 5d                	je     80100be2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100b85:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b8b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b90:	75 50                	jne    80100be2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b9b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ba1:	53                   	push   %ebx
80100ba2:	50                   	push   %eax
80100ba3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba9:	e8 f2 67 00 00       	call   801073a0 <loaduvm>
80100bae:	83 c4 20             	add    $0x20,%esp
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	78 2d                	js     80100be2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbc:	83 c7 01             	add    $0x1,%edi
80100bbf:	83 c6 20             	add    $0x20,%esi
80100bc2:	39 f8                	cmp    %edi,%eax
80100bc4:	7e 3a                	jle    80100c00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bcc:	6a 20                	push   $0x20
80100bce:	56                   	push   %esi
80100bcf:	50                   	push   %eax
80100bd0:	53                   	push   %ebx
80100bd1:	e8 aa 0e 00 00       	call   80101a80 <readi>
80100bd6:	83 c4 10             	add    $0x10,%esp
80100bd9:	83 f8 20             	cmp    $0x20,%eax
80100bdc:	0f 84 5e ff ff ff    	je     80100b40 <exec+0xc0>
    freevm(pgdir);
80100be2:	83 ec 0c             	sub    $0xc,%esp
80100be5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100beb:	e8 e0 69 00 00       	call   801075d0 <freevm>
  if(ip){
80100bf0:	83 c4 10             	add    $0x10,%esp
80100bf3:	e9 e2 fe ff ff       	jmp    80100ada <exec+0x5a>
80100bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bff:	90                   	nop
80100c00:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c06:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c0c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c12:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c18:	83 ec 0c             	sub    $0xc,%esp
80100c1b:	53                   	push   %ebx
80100c1c:	e8 ff 0d 00 00       	call   80101a20 <iunlockput>
  end_op();
80100c21:	e8 9a 21 00 00       	call   80102dc0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c26:	83 c4 0c             	add    $0xc,%esp
80100c29:	56                   	push   %esi
80100c2a:	57                   	push   %edi
80100c2b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c31:	57                   	push   %edi
80100c32:	e8 39 68 00 00       	call   80107470 <allocuvm>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	89 c6                	mov    %eax,%esi
80100c3c:	85 c0                	test   %eax,%eax
80100c3e:	0f 84 94 00 00 00    	je     80100cd8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c44:	83 ec 08             	sub    $0x8,%esp
80100c47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c4d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c4f:	50                   	push   %eax
80100c50:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c51:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c53:	e8 98 6a 00 00       	call   801076f0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c5b:	83 c4 10             	add    $0x10,%esp
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c64:	8b 00                	mov    (%eax),%eax
80100c66:	85 c0                	test   %eax,%eax
80100c68:	0f 84 8b 00 00 00    	je     80100cf9 <exec+0x279>
80100c6e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c74:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c7a:	eb 23                	jmp    80100c9f <exec+0x21f>
80100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c80:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c83:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c8a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c93:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	74 59                	je     80100cf3 <exec+0x273>
    if(argc >= MAXARG)
80100c9a:	83 ff 20             	cmp    $0x20,%edi
80100c9d:	74 39                	je     80100cd8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c9f:	83 ec 0c             	sub    $0xc,%esp
80100ca2:	50                   	push   %eax
80100ca3:	e8 48 42 00 00       	call   80104ef0 <strlen>
80100ca8:	f7 d0                	not    %eax
80100caa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cac:	58                   	pop    %eax
80100cad:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cb6:	e8 35 42 00 00       	call   80104ef0 <strlen>
80100cbb:	83 c0 01             	add    $0x1,%eax
80100cbe:	50                   	push   %eax
80100cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc2:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cc5:	53                   	push   %ebx
80100cc6:	56                   	push   %esi
80100cc7:	e8 84 6b 00 00       	call   80107850 <copyout>
80100ccc:	83 c4 20             	add    $0x20,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	79 ad                	jns    80100c80 <exec+0x200>
80100cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cd7:	90                   	nop
    freevm(pgdir);
80100cd8:	83 ec 0c             	sub    $0xc,%esp
80100cdb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ce1:	e8 ea 68 00 00       	call   801075d0 <freevm>
80100ce6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cee:	e9 fd fd ff ff       	jmp    80100af0 <exec+0x70>
80100cf3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cf9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d00:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d02:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d09:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d0d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d0f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d12:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d18:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d1a:	50                   	push   %eax
80100d1b:	52                   	push   %edx
80100d1c:	53                   	push   %ebx
80100d1d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d23:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d2a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d2d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d33:	e8 18 6b 00 00       	call   80107850 <copyout>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	85 c0                	test   %eax,%eax
80100d3d:	78 99                	js     80100cd8 <exec+0x258>
  for(last=s=path; *s; s++)
80100d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d42:	8b 55 08             	mov    0x8(%ebp),%edx
80100d45:	0f b6 00             	movzbl (%eax),%eax
80100d48:	84 c0                	test   %al,%al
80100d4a:	74 13                	je     80100d5f <exec+0x2df>
80100d4c:	89 d1                	mov    %edx,%ecx
80100d4e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80100d50:	83 c1 01             	add    $0x1,%ecx
80100d53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d55:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d5b:	84 c0                	test   %al,%al
80100d5d:	75 f1                	jne    80100d50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d5f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d65:	83 ec 04             	sub    $0x4,%esp
80100d68:	6a 10                	push   $0x10
80100d6a:	89 f8                	mov    %edi,%eax
80100d6c:	52                   	push   %edx
80100d6d:	83 c0 74             	add    $0x74,%eax
80100d70:	50                   	push   %eax
80100d71:	e8 3a 41 00 00       	call   80104eb0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d76:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d7c:	89 f8                	mov    %edi,%eax
80100d7e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100d81:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100d83:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d86:	89 c1                	mov    %eax,%ecx
80100d88:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d8e:	8b 40 20             	mov    0x20(%eax),%eax
80100d91:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d94:	8b 41 20             	mov    0x20(%ecx),%eax
80100d97:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->threads = 1;
80100d9a:	c7 41 14 01 00 00 00 	movl   $0x1,0x14(%ecx)
  curproc->stackTop = sp;
80100da1:	89 59 18             	mov    %ebx,0x18(%ecx)
  curproc->priority = 3;
80100da4:	c7 81 94 00 00 00 03 	movl   $0x3,0x94(%ecx)
80100dab:	00 00 00 
  switchuvm(curproc);
80100dae:	89 0c 24             	mov    %ecx,(%esp)
80100db1:	e8 5a 64 00 00       	call   80107210 <switchuvm>
  freevm(oldpgdir);
80100db6:	89 3c 24             	mov    %edi,(%esp)
80100db9:	e8 12 68 00 00       	call   801075d0 <freevm>
  return 0;
80100dbe:	83 c4 10             	add    $0x10,%esp
80100dc1:	31 c0                	xor    %eax,%eax
80100dc3:	e9 28 fd ff ff       	jmp    80100af0 <exec+0x70>
    end_op();
80100dc8:	e8 f3 1f 00 00       	call   80102dc0 <end_op>
    cprintf("exec: fail\n");
80100dcd:	83 ec 0c             	sub    $0xc,%esp
80100dd0:	68 61 79 10 80       	push   $0x80107961
80100dd5:	e8 d6 f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100de2:	e9 09 fd ff ff       	jmp    80100af0 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100de7:	31 ff                	xor    %edi,%edi
80100de9:	be 00 20 00 00       	mov    $0x2000,%esi
80100dee:	e9 25 fe ff ff       	jmp    80100c18 <exec+0x198>
80100df3:	66 90                	xchg   %ax,%ax
80100df5:	66 90                	xchg   %ax,%ax
80100df7:	66 90                	xchg   %ax,%ax
80100df9:	66 90                	xchg   %ax,%ax
80100dfb:	66 90                	xchg   %ax,%ax
80100dfd:	66 90                	xchg   %ax,%ax
80100dff:	90                   	nop

80100e00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e00:	f3 0f 1e fb          	endbr32 
80100e04:	55                   	push   %ebp
80100e05:	89 e5                	mov    %esp,%ebp
80100e07:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e0a:	68 6d 79 10 80       	push   $0x8010796d
80100e0f:	68 e0 0f 11 80       	push   $0x80110fe0
80100e14:	e8 47 3c 00 00       	call   80104a60 <initlock>
}
80100e19:	83 c4 10             	add    $0x10,%esp
80100e1c:	c9                   	leave  
80100e1d:	c3                   	ret    
80100e1e:	66 90                	xchg   %ax,%ax

80100e20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e20:	f3 0f 1e fb          	endbr32 
80100e24:	55                   	push   %ebp
80100e25:	89 e5                	mov    %esp,%ebp
80100e27:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e28:	bb 14 10 11 80       	mov    $0x80111014,%ebx
{
80100e2d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e30:	68 e0 0f 11 80       	push   $0x80110fe0
80100e35:	e8 a6 3d 00 00       	call   80104be0 <acquire>
80100e3a:	83 c4 10             	add    $0x10,%esp
80100e3d:	eb 0c                	jmp    80100e4b <filealloc+0x2b>
80100e3f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e40:	83 c3 18             	add    $0x18,%ebx
80100e43:	81 fb 74 19 11 80    	cmp    $0x80111974,%ebx
80100e49:	74 25                	je     80100e70 <filealloc+0x50>
    if(f->ref == 0){
80100e4b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e4e:	85 c0                	test   %eax,%eax
80100e50:	75 ee                	jne    80100e40 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e52:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e55:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e5c:	68 e0 0f 11 80       	push   $0x80110fe0
80100e61:	e8 3a 3e 00 00       	call   80104ca0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e66:	89 d8                	mov    %ebx,%eax
      return f;
80100e68:	83 c4 10             	add    $0x10,%esp
}
80100e6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e6e:	c9                   	leave  
80100e6f:	c3                   	ret    
  release(&ftable.lock);
80100e70:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e73:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e75:	68 e0 0f 11 80       	push   $0x80110fe0
80100e7a:	e8 21 3e 00 00       	call   80104ca0 <release>
}
80100e7f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e81:	83 c4 10             	add    $0x10,%esp
}
80100e84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e87:	c9                   	leave  
80100e88:	c3                   	ret    
80100e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e90 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e90:	f3 0f 1e fb          	endbr32 
80100e94:	55                   	push   %ebp
80100e95:	89 e5                	mov    %esp,%ebp
80100e97:	53                   	push   %ebx
80100e98:	83 ec 10             	sub    $0x10,%esp
80100e9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e9e:	68 e0 0f 11 80       	push   $0x80110fe0
80100ea3:	e8 38 3d 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100ea8:	8b 43 04             	mov    0x4(%ebx),%eax
80100eab:	83 c4 10             	add    $0x10,%esp
80100eae:	85 c0                	test   %eax,%eax
80100eb0:	7e 1a                	jle    80100ecc <filedup+0x3c>
    panic("filedup");
  f->ref++;
80100eb2:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100eb5:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100eb8:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ebb:	68 e0 0f 11 80       	push   $0x80110fe0
80100ec0:	e8 db 3d 00 00       	call   80104ca0 <release>
  return f;
}
80100ec5:	89 d8                	mov    %ebx,%eax
80100ec7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eca:	c9                   	leave  
80100ecb:	c3                   	ret    
    panic("filedup");
80100ecc:	83 ec 0c             	sub    $0xc,%esp
80100ecf:	68 74 79 10 80       	push   $0x80107974
80100ed4:	e8 b7 f4 ff ff       	call   80100390 <panic>
80100ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ee0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ee0:	f3 0f 1e fb          	endbr32 
80100ee4:	55                   	push   %ebp
80100ee5:	89 e5                	mov    %esp,%ebp
80100ee7:	57                   	push   %edi
80100ee8:	56                   	push   %esi
80100ee9:	53                   	push   %ebx
80100eea:	83 ec 28             	sub    $0x28,%esp
80100eed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ef0:	68 e0 0f 11 80       	push   $0x80110fe0
80100ef5:	e8 e6 3c 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100efa:	8b 53 04             	mov    0x4(%ebx),%edx
80100efd:	83 c4 10             	add    $0x10,%esp
80100f00:	85 d2                	test   %edx,%edx
80100f02:	0f 8e a1 00 00 00    	jle    80100fa9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f08:	83 ea 01             	sub    $0x1,%edx
80100f0b:	89 53 04             	mov    %edx,0x4(%ebx)
80100f0e:	75 40                	jne    80100f50 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f10:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f14:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f17:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f19:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f1f:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f22:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f25:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f28:	68 e0 0f 11 80       	push   $0x80110fe0
  ff = *f;
80100f2d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f30:	e8 6b 3d 00 00       	call   80104ca0 <release>

  if(ff.type == FD_PIPE)
80100f35:	83 c4 10             	add    $0x10,%esp
80100f38:	83 ff 01             	cmp    $0x1,%edi
80100f3b:	74 53                	je     80100f90 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f3d:	83 ff 02             	cmp    $0x2,%edi
80100f40:	74 26                	je     80100f68 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f45:	5b                   	pop    %ebx
80100f46:	5e                   	pop    %esi
80100f47:	5f                   	pop    %edi
80100f48:	5d                   	pop    %ebp
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f50:	c7 45 08 e0 0f 11 80 	movl   $0x80110fe0,0x8(%ebp)
}
80100f57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f5a:	5b                   	pop    %ebx
80100f5b:	5e                   	pop    %esi
80100f5c:	5f                   	pop    %edi
80100f5d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f5e:	e9 3d 3d 00 00       	jmp    80104ca0 <release>
80100f63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f67:	90                   	nop
    begin_op();
80100f68:	e8 e3 1d 00 00       	call   80102d50 <begin_op>
    iput(ff.ip);
80100f6d:	83 ec 0c             	sub    $0xc,%esp
80100f70:	ff 75 e0             	pushl  -0x20(%ebp)
80100f73:	e8 38 09 00 00       	call   801018b0 <iput>
    end_op();
80100f78:	83 c4 10             	add    $0x10,%esp
}
80100f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7e:	5b                   	pop    %ebx
80100f7f:	5e                   	pop    %esi
80100f80:	5f                   	pop    %edi
80100f81:	5d                   	pop    %ebp
    end_op();
80100f82:	e9 39 1e 00 00       	jmp    80102dc0 <end_op>
80100f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f8e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100f90:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f94:	83 ec 08             	sub    $0x8,%esp
80100f97:	53                   	push   %ebx
80100f98:	56                   	push   %esi
80100f99:	e8 82 25 00 00       	call   80103520 <pipeclose>
80100f9e:	83 c4 10             	add    $0x10,%esp
}
80100fa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa4:	5b                   	pop    %ebx
80100fa5:	5e                   	pop    %esi
80100fa6:	5f                   	pop    %edi
80100fa7:	5d                   	pop    %ebp
80100fa8:	c3                   	ret    
    panic("fileclose");
80100fa9:	83 ec 0c             	sub    $0xc,%esp
80100fac:	68 7c 79 10 80       	push   $0x8010797c
80100fb1:	e8 da f3 ff ff       	call   80100390 <panic>
80100fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fbd:	8d 76 00             	lea    0x0(%esi),%esi

80100fc0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fc0:	f3 0f 1e fb          	endbr32 
80100fc4:	55                   	push   %ebp
80100fc5:	89 e5                	mov    %esp,%ebp
80100fc7:	53                   	push   %ebx
80100fc8:	83 ec 04             	sub    $0x4,%esp
80100fcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fce:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fd1:	75 2d                	jne    80101000 <filestat+0x40>
    ilock(f->ip);
80100fd3:	83 ec 0c             	sub    $0xc,%esp
80100fd6:	ff 73 10             	pushl  0x10(%ebx)
80100fd9:	e8 a2 07 00 00       	call   80101780 <ilock>
    stati(f->ip, st);
80100fde:	58                   	pop    %eax
80100fdf:	5a                   	pop    %edx
80100fe0:	ff 75 0c             	pushl  0xc(%ebp)
80100fe3:	ff 73 10             	pushl  0x10(%ebx)
80100fe6:	e8 65 0a 00 00       	call   80101a50 <stati>
    iunlock(f->ip);
80100feb:	59                   	pop    %ecx
80100fec:	ff 73 10             	pushl  0x10(%ebx)
80100fef:	e8 6c 08 00 00       	call   80101860 <iunlock>
    return 0;
  }
  return -1;
}
80100ff4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80100ff7:	83 c4 10             	add    $0x10,%esp
80100ffa:	31 c0                	xor    %eax,%eax
}
80100ffc:	c9                   	leave  
80100ffd:	c3                   	ret    
80100ffe:	66 90                	xchg   %ax,%ax
80101000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101003:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101010 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101010:	f3 0f 1e fb          	endbr32 
80101014:	55                   	push   %ebp
80101015:	89 e5                	mov    %esp,%ebp
80101017:	57                   	push   %edi
80101018:	56                   	push   %esi
80101019:	53                   	push   %ebx
8010101a:	83 ec 0c             	sub    $0xc,%esp
8010101d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101020:	8b 75 0c             	mov    0xc(%ebp),%esi
80101023:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101026:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010102a:	74 64                	je     80101090 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
8010102c:	8b 03                	mov    (%ebx),%eax
8010102e:	83 f8 01             	cmp    $0x1,%eax
80101031:	74 45                	je     80101078 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101033:	83 f8 02             	cmp    $0x2,%eax
80101036:	75 5f                	jne    80101097 <fileread+0x87>
    ilock(f->ip);
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	ff 73 10             	pushl  0x10(%ebx)
8010103e:	e8 3d 07 00 00       	call   80101780 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101043:	57                   	push   %edi
80101044:	ff 73 14             	pushl  0x14(%ebx)
80101047:	56                   	push   %esi
80101048:	ff 73 10             	pushl  0x10(%ebx)
8010104b:	e8 30 0a 00 00       	call   80101a80 <readi>
80101050:	83 c4 20             	add    $0x20,%esp
80101053:	89 c6                	mov    %eax,%esi
80101055:	85 c0                	test   %eax,%eax
80101057:	7e 03                	jle    8010105c <fileread+0x4c>
      f->off += r;
80101059:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010105c:	83 ec 0c             	sub    $0xc,%esp
8010105f:	ff 73 10             	pushl  0x10(%ebx)
80101062:	e8 f9 07 00 00       	call   80101860 <iunlock>
    return r;
80101067:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010106a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010106d:	89 f0                	mov    %esi,%eax
8010106f:	5b                   	pop    %ebx
80101070:	5e                   	pop    %esi
80101071:	5f                   	pop    %edi
80101072:	5d                   	pop    %ebp
80101073:	c3                   	ret    
80101074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101078:	8b 43 0c             	mov    0xc(%ebx),%eax
8010107b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010107e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101081:	5b                   	pop    %ebx
80101082:	5e                   	pop    %esi
80101083:	5f                   	pop    %edi
80101084:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101085:	e9 36 26 00 00       	jmp    801036c0 <piperead>
8010108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101090:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101095:	eb d3                	jmp    8010106a <fileread+0x5a>
  panic("fileread");
80101097:	83 ec 0c             	sub    $0xc,%esp
8010109a:	68 86 79 10 80       	push   $0x80107986
8010109f:	e8 ec f2 ff ff       	call   80100390 <panic>
801010a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010af:	90                   	nop

801010b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b0:	f3 0f 1e fb          	endbr32 
801010b4:	55                   	push   %ebp
801010b5:	89 e5                	mov    %esp,%ebp
801010b7:	57                   	push   %edi
801010b8:	56                   	push   %esi
801010b9:	53                   	push   %ebx
801010ba:	83 ec 1c             	sub    $0x1c,%esp
801010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801010c0:	8b 75 08             	mov    0x8(%ebp),%esi
801010c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c6:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010c9:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801010cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010d0:	0f 84 c1 00 00 00    	je     80101197 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
801010d6:	8b 06                	mov    (%esi),%eax
801010d8:	83 f8 01             	cmp    $0x1,%eax
801010db:	0f 84 c3 00 00 00    	je     801011a4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010e1:	83 f8 02             	cmp    $0x2,%eax
801010e4:	0f 85 cc 00 00 00    	jne    801011b6 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010ed:	31 ff                	xor    %edi,%edi
    while(i < n){
801010ef:	85 c0                	test   %eax,%eax
801010f1:	7f 34                	jg     80101127 <filewrite+0x77>
801010f3:	e9 98 00 00 00       	jmp    80101190 <filewrite+0xe0>
801010f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ff:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101100:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101103:	83 ec 0c             	sub    $0xc,%esp
80101106:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101109:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010110c:	e8 4f 07 00 00       	call   80101860 <iunlock>
      end_op();
80101111:	e8 aa 1c 00 00       	call   80102dc0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101116:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101119:	83 c4 10             	add    $0x10,%esp
8010111c:	39 c3                	cmp    %eax,%ebx
8010111e:	75 60                	jne    80101180 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
80101120:	01 df                	add    %ebx,%edi
    while(i < n){
80101122:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101125:	7e 69                	jle    80101190 <filewrite+0xe0>
      int n1 = n - i;
80101127:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010112a:	b8 00 06 00 00       	mov    $0x600,%eax
8010112f:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101131:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101137:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010113a:	e8 11 1c 00 00       	call   80102d50 <begin_op>
      ilock(f->ip);
8010113f:	83 ec 0c             	sub    $0xc,%esp
80101142:	ff 76 10             	pushl  0x10(%esi)
80101145:	e8 36 06 00 00       	call   80101780 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010114a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010114d:	53                   	push   %ebx
8010114e:	ff 76 14             	pushl  0x14(%esi)
80101151:	01 f8                	add    %edi,%eax
80101153:	50                   	push   %eax
80101154:	ff 76 10             	pushl  0x10(%esi)
80101157:	e8 24 0a 00 00       	call   80101b80 <writei>
8010115c:	83 c4 20             	add    $0x20,%esp
8010115f:	85 c0                	test   %eax,%eax
80101161:	7f 9d                	jg     80101100 <filewrite+0x50>
      iunlock(f->ip);
80101163:	83 ec 0c             	sub    $0xc,%esp
80101166:	ff 76 10             	pushl  0x10(%esi)
80101169:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010116c:	e8 ef 06 00 00       	call   80101860 <iunlock>
      end_op();
80101171:	e8 4a 1c 00 00       	call   80102dc0 <end_op>
      if(r < 0)
80101176:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101179:	83 c4 10             	add    $0x10,%esp
8010117c:	85 c0                	test   %eax,%eax
8010117e:	75 17                	jne    80101197 <filewrite+0xe7>
        panic("short filewrite");
80101180:	83 ec 0c             	sub    $0xc,%esp
80101183:	68 8f 79 10 80       	push   $0x8010798f
80101188:	e8 03 f2 ff ff       	call   80100390 <panic>
8010118d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101190:	89 f8                	mov    %edi,%eax
80101192:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101195:	74 05                	je     8010119c <filewrite+0xec>
80101197:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010119c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010119f:	5b                   	pop    %ebx
801011a0:	5e                   	pop    %esi
801011a1:	5f                   	pop    %edi
801011a2:	5d                   	pop    %ebp
801011a3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801011a4:	8b 46 0c             	mov    0xc(%esi),%eax
801011a7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ad:	5b                   	pop    %ebx
801011ae:	5e                   	pop    %esi
801011af:	5f                   	pop    %edi
801011b0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011b1:	e9 0a 24 00 00       	jmp    801035c0 <pipewrite>
  panic("filewrite");
801011b6:	83 ec 0c             	sub    $0xc,%esp
801011b9:	68 95 79 10 80       	push   $0x80107995
801011be:	e8 cd f1 ff ff       	call   80100390 <panic>
801011c3:	66 90                	xchg   %ax,%ax
801011c5:	66 90                	xchg   %ax,%ax
801011c7:	66 90                	xchg   %ax,%ax
801011c9:	66 90                	xchg   %ax,%ax
801011cb:	66 90                	xchg   %ax,%ax
801011cd:	66 90                	xchg   %ax,%ax
801011cf:	90                   	nop

801011d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011d0:	55                   	push   %ebp
801011d1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011d3:	89 d0                	mov    %edx,%eax
801011d5:	c1 e8 0c             	shr    $0xc,%eax
801011d8:	03 05 f8 19 11 80    	add    0x801119f8,%eax
{
801011de:	89 e5                	mov    %esp,%ebp
801011e0:	56                   	push   %esi
801011e1:	53                   	push   %ebx
801011e2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011e4:	83 ec 08             	sub    $0x8,%esp
801011e7:	50                   	push   %eax
801011e8:	51                   	push   %ecx
801011e9:	e8 e2 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011ee:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011f0:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801011f3:	ba 01 00 00 00       	mov    $0x1,%edx
801011f8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801011fb:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101201:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101204:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101206:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
8010120b:	85 d1                	test   %edx,%ecx
8010120d:	74 25                	je     80101234 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010120f:	f7 d2                	not    %edx
  log_write(bp);
80101211:	83 ec 0c             	sub    $0xc,%esp
80101214:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
80101216:	21 ca                	and    %ecx,%edx
80101218:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
8010121c:	50                   	push   %eax
8010121d:	e8 0e 1d 00 00       	call   80102f30 <log_write>
  brelse(bp);
80101222:	89 34 24             	mov    %esi,(%esp)
80101225:	e8 c6 ef ff ff       	call   801001f0 <brelse>
}
8010122a:	83 c4 10             	add    $0x10,%esp
8010122d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101230:	5b                   	pop    %ebx
80101231:	5e                   	pop    %esi
80101232:	5d                   	pop    %ebp
80101233:	c3                   	ret    
    panic("freeing free block");
80101234:	83 ec 0c             	sub    $0xc,%esp
80101237:	68 9f 79 10 80       	push   $0x8010799f
8010123c:	e8 4f f1 ff ff       	call   80100390 <panic>
80101241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010124f:	90                   	nop

80101250 <balloc>:
{
80101250:	55                   	push   %ebp
80101251:	89 e5                	mov    %esp,%ebp
80101253:	57                   	push   %edi
80101254:	56                   	push   %esi
80101255:	53                   	push   %ebx
80101256:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101259:	8b 0d e0 19 11 80    	mov    0x801119e0,%ecx
{
8010125f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101262:	85 c9                	test   %ecx,%ecx
80101264:	0f 84 87 00 00 00    	je     801012f1 <balloc+0xa1>
8010126a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101271:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101274:	83 ec 08             	sub    $0x8,%esp
80101277:	89 f0                	mov    %esi,%eax
80101279:	c1 f8 0c             	sar    $0xc,%eax
8010127c:	03 05 f8 19 11 80    	add    0x801119f8,%eax
80101282:	50                   	push   %eax
80101283:	ff 75 d8             	pushl  -0x28(%ebp)
80101286:	e8 45 ee ff ff       	call   801000d0 <bread>
8010128b:	83 c4 10             	add    $0x10,%esp
8010128e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101291:	a1 e0 19 11 80       	mov    0x801119e0,%eax
80101296:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101299:	31 c0                	xor    %eax,%eax
8010129b:	eb 2f                	jmp    801012cc <balloc+0x7c>
8010129d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012a0:	89 c1                	mov    %eax,%ecx
801012a2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801012aa:	83 e1 07             	and    $0x7,%ecx
801012ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012af:	89 c1                	mov    %eax,%ecx
801012b1:	c1 f9 03             	sar    $0x3,%ecx
801012b4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012b9:	89 fa                	mov    %edi,%edx
801012bb:	85 df                	test   %ebx,%edi
801012bd:	74 41                	je     80101300 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012bf:	83 c0 01             	add    $0x1,%eax
801012c2:	83 c6 01             	add    $0x1,%esi
801012c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ca:	74 05                	je     801012d1 <balloc+0x81>
801012cc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012cf:	77 cf                	ja     801012a0 <balloc+0x50>
    brelse(bp);
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801012d7:	e8 14 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012dc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012e3:	83 c4 10             	add    $0x10,%esp
801012e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012e9:	39 05 e0 19 11 80    	cmp    %eax,0x801119e0
801012ef:	77 80                	ja     80101271 <balloc+0x21>
  panic("balloc: out of blocks");
801012f1:	83 ec 0c             	sub    $0xc,%esp
801012f4:	68 b2 79 10 80       	push   $0x801079b2
801012f9:	e8 92 f0 ff ff       	call   80100390 <panic>
801012fe:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101300:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101303:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101306:	09 da                	or     %ebx,%edx
80101308:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010130c:	57                   	push   %edi
8010130d:	e8 1e 1c 00 00       	call   80102f30 <log_write>
        brelse(bp);
80101312:	89 3c 24             	mov    %edi,(%esp)
80101315:	e8 d6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010131a:	58                   	pop    %eax
8010131b:	5a                   	pop    %edx
8010131c:	56                   	push   %esi
8010131d:	ff 75 d8             	pushl  -0x28(%ebp)
80101320:	e8 ab ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101325:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101328:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010132a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010132d:	68 00 02 00 00       	push   $0x200
80101332:	6a 00                	push   $0x0
80101334:	50                   	push   %eax
80101335:	e8 b6 39 00 00       	call   80104cf0 <memset>
  log_write(bp);
8010133a:	89 1c 24             	mov    %ebx,(%esp)
8010133d:	e8 ee 1b 00 00       	call   80102f30 <log_write>
  brelse(bp);
80101342:	89 1c 24             	mov    %ebx,(%esp)
80101345:	e8 a6 ee ff ff       	call   801001f0 <brelse>
}
8010134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134d:	89 f0                	mov    %esi,%eax
8010134f:	5b                   	pop    %ebx
80101350:	5e                   	pop    %esi
80101351:	5f                   	pop    %edi
80101352:	5d                   	pop    %ebp
80101353:	c3                   	ret    
80101354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010135b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010135f:	90                   	nop

80101360 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	89 c7                	mov    %eax,%edi
80101366:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101367:	31 f6                	xor    %esi,%esi
{
80101369:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136a:	bb 34 1a 11 80       	mov    $0x80111a34,%ebx
{
8010136f:	83 ec 28             	sub    $0x28,%esp
80101372:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101375:	68 00 1a 11 80       	push   $0x80111a00
8010137a:	e8 61 38 00 00       	call   80104be0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010137f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101382:	83 c4 10             	add    $0x10,%esp
80101385:	eb 1b                	jmp    801013a2 <iget+0x42>
80101387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010138e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101390:	39 3b                	cmp    %edi,(%ebx)
80101392:	74 6c                	je     80101400 <iget+0xa0>
80101394:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010139a:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
801013a0:	73 26                	jae    801013c8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013a2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801013a5:	85 c9                	test   %ecx,%ecx
801013a7:	7f e7                	jg     80101390 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013a9:	85 f6                	test   %esi,%esi
801013ab:	75 e7                	jne    80101394 <iget+0x34>
801013ad:	89 d8                	mov    %ebx,%eax
801013af:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013b5:	85 c9                	test   %ecx,%ecx
801013b7:	75 6e                	jne    80101427 <iget+0xc7>
801013b9:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013bb:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
801013c1:	72 df                	jb     801013a2 <iget+0x42>
801013c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013c7:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013c8:	85 f6                	test   %esi,%esi
801013ca:	74 73                	je     8010143f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013cc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013cf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013d1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013d4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013db:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013e2:	68 00 1a 11 80       	push   $0x80111a00
801013e7:	e8 b4 38 00 00       	call   80104ca0 <release>

  return ip;
801013ec:	83 c4 10             	add    $0x10,%esp
}
801013ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f2:	89 f0                	mov    %esi,%eax
801013f4:	5b                   	pop    %ebx
801013f5:	5e                   	pop    %esi
801013f6:	5f                   	pop    %edi
801013f7:	5d                   	pop    %ebp
801013f8:	c3                   	ret    
801013f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101400:	39 53 04             	cmp    %edx,0x4(%ebx)
80101403:	75 8f                	jne    80101394 <iget+0x34>
      release(&icache.lock);
80101405:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101408:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010140b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010140d:	68 00 1a 11 80       	push   $0x80111a00
      ip->ref++;
80101412:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101415:	e8 86 38 00 00       	call   80104ca0 <release>
      return ip;
8010141a:	83 c4 10             	add    $0x10,%esp
}
8010141d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101420:	89 f0                	mov    %esi,%eax
80101422:	5b                   	pop    %ebx
80101423:	5e                   	pop    %esi
80101424:	5f                   	pop    %edi
80101425:	5d                   	pop    %ebp
80101426:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101427:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
8010142d:	73 10                	jae    8010143f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010142f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101432:	85 c9                	test   %ecx,%ecx
80101434:	0f 8f 56 ff ff ff    	jg     80101390 <iget+0x30>
8010143a:	e9 6e ff ff ff       	jmp    801013ad <iget+0x4d>
    panic("iget: no inodes");
8010143f:	83 ec 0c             	sub    $0xc,%esp
80101442:	68 c8 79 10 80       	push   $0x801079c8
80101447:	e8 44 ef ff ff       	call   80100390 <panic>
8010144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	89 c6                	mov    %eax,%esi
80101457:	53                   	push   %ebx
80101458:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	0f 86 84 00 00 00    	jbe    801014e8 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101464:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101467:	83 fb 7f             	cmp    $0x7f,%ebx
8010146a:	0f 87 98 00 00 00    	ja     80101508 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	8b 16                	mov    (%esi),%edx
80101478:	85 c0                	test   %eax,%eax
8010147a:	74 54                	je     801014d0 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010147c:	83 ec 08             	sub    $0x8,%esp
8010147f:	50                   	push   %eax
80101480:	52                   	push   %edx
80101481:	e8 4a ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101486:	83 c4 10             	add    $0x10,%esp
80101489:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010148d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010148f:	8b 1a                	mov    (%edx),%ebx
80101491:	85 db                	test   %ebx,%ebx
80101493:	74 1b                	je     801014b0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101495:	83 ec 0c             	sub    $0xc,%esp
80101498:	57                   	push   %edi
80101499:	e8 52 ed ff ff       	call   801001f0 <brelse>
    return addr;
8010149e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
801014a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a4:	89 d8                	mov    %ebx,%eax
801014a6:	5b                   	pop    %ebx
801014a7:	5e                   	pop    %esi
801014a8:	5f                   	pop    %edi
801014a9:	5d                   	pop    %ebp
801014aa:	c3                   	ret    
801014ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801014af:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
801014b0:	8b 06                	mov    (%esi),%eax
801014b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014b5:	e8 96 fd ff ff       	call   80101250 <balloc>
801014ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801014bd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014c0:	89 c3                	mov    %eax,%ebx
801014c2:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801014c4:	57                   	push   %edi
801014c5:	e8 66 1a 00 00       	call   80102f30 <log_write>
801014ca:	83 c4 10             	add    $0x10,%esp
801014cd:	eb c6                	jmp    80101495 <bmap+0x45>
801014cf:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014d0:	89 d0                	mov    %edx,%eax
801014d2:	e8 79 fd ff ff       	call   80101250 <balloc>
801014d7:	8b 16                	mov    (%esi),%edx
801014d9:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014df:	eb 9b                	jmp    8010147c <bmap+0x2c>
801014e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
801014e8:	8d 3c 90             	lea    (%eax,%edx,4),%edi
801014eb:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801014ee:	85 db                	test   %ebx,%ebx
801014f0:	75 af                	jne    801014a1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014f2:	8b 00                	mov    (%eax),%eax
801014f4:	e8 57 fd ff ff       	call   80101250 <balloc>
801014f9:	89 47 5c             	mov    %eax,0x5c(%edi)
801014fc:	89 c3                	mov    %eax,%ebx
}
801014fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101501:	89 d8                	mov    %ebx,%eax
80101503:	5b                   	pop    %ebx
80101504:	5e                   	pop    %esi
80101505:	5f                   	pop    %edi
80101506:	5d                   	pop    %ebp
80101507:	c3                   	ret    
  panic("bmap: out of range");
80101508:	83 ec 0c             	sub    $0xc,%esp
8010150b:	68 d8 79 10 80       	push   $0x801079d8
80101510:	e8 7b ee ff ff       	call   80100390 <panic>
80101515:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <readsb>:
{
80101520:	f3 0f 1e fb          	endbr32 
80101524:	55                   	push   %ebp
80101525:	89 e5                	mov    %esp,%ebp
80101527:	56                   	push   %esi
80101528:	53                   	push   %ebx
80101529:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
8010152c:	83 ec 08             	sub    $0x8,%esp
8010152f:	6a 01                	push   $0x1
80101531:	ff 75 08             	pushl  0x8(%ebp)
80101534:	e8 97 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101539:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010153c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010153e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101541:	6a 1c                	push   $0x1c
80101543:	50                   	push   %eax
80101544:	56                   	push   %esi
80101545:	e8 46 38 00 00       	call   80104d90 <memmove>
  brelse(bp);
8010154a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010154d:	83 c4 10             	add    $0x10,%esp
}
80101550:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101553:	5b                   	pop    %ebx
80101554:	5e                   	pop    %esi
80101555:	5d                   	pop    %ebp
  brelse(bp);
80101556:	e9 95 ec ff ff       	jmp    801001f0 <brelse>
8010155b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010155f:	90                   	nop

80101560 <iinit>:
{
80101560:	f3 0f 1e fb          	endbr32 
80101564:	55                   	push   %ebp
80101565:	89 e5                	mov    %esp,%ebp
80101567:	53                   	push   %ebx
80101568:	bb 40 1a 11 80       	mov    $0x80111a40,%ebx
8010156d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101570:	68 eb 79 10 80       	push   $0x801079eb
80101575:	68 00 1a 11 80       	push   $0x80111a00
8010157a:	e8 e1 34 00 00       	call   80104a60 <initlock>
  for(i = 0; i < NINODE; i++) {
8010157f:	83 c4 10             	add    $0x10,%esp
80101582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101588:	83 ec 08             	sub    $0x8,%esp
8010158b:	68 f2 79 10 80       	push   $0x801079f2
80101590:	53                   	push   %ebx
80101591:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101597:	e8 84 33 00 00       	call   80104920 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
8010159c:	83 c4 10             	add    $0x10,%esp
8010159f:	81 fb 60 36 11 80    	cmp    $0x80113660,%ebx
801015a5:	75 e1                	jne    80101588 <iinit+0x28>
  readsb(dev, &sb);
801015a7:	83 ec 08             	sub    $0x8,%esp
801015aa:	68 e0 19 11 80       	push   $0x801119e0
801015af:	ff 75 08             	pushl  0x8(%ebp)
801015b2:	e8 69 ff ff ff       	call   80101520 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015b7:	ff 35 f8 19 11 80    	pushl  0x801119f8
801015bd:	ff 35 f4 19 11 80    	pushl  0x801119f4
801015c3:	ff 35 f0 19 11 80    	pushl  0x801119f0
801015c9:	ff 35 ec 19 11 80    	pushl  0x801119ec
801015cf:	ff 35 e8 19 11 80    	pushl  0x801119e8
801015d5:	ff 35 e4 19 11 80    	pushl  0x801119e4
801015db:	ff 35 e0 19 11 80    	pushl  0x801119e0
801015e1:	68 58 7a 10 80       	push   $0x80107a58
801015e6:	e8 c5 f0 ff ff       	call   801006b0 <cprintf>
}
801015eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015ee:	83 c4 30             	add    $0x30,%esp
801015f1:	c9                   	leave  
801015f2:	c3                   	ret    
801015f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101600 <ialloc>:
{
80101600:	f3 0f 1e fb          	endbr32 
80101604:	55                   	push   %ebp
80101605:	89 e5                	mov    %esp,%ebp
80101607:	57                   	push   %edi
80101608:	56                   	push   %esi
80101609:	53                   	push   %ebx
8010160a:	83 ec 1c             	sub    $0x1c,%esp
8010160d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101610:	83 3d e8 19 11 80 01 	cmpl   $0x1,0x801119e8
{
80101617:	8b 75 08             	mov    0x8(%ebp),%esi
8010161a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010161d:	0f 86 8d 00 00 00    	jbe    801016b0 <ialloc+0xb0>
80101623:	bf 01 00 00 00       	mov    $0x1,%edi
80101628:	eb 1d                	jmp    80101647 <ialloc+0x47>
8010162a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101630:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101633:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101636:	53                   	push   %ebx
80101637:	e8 b4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010163c:	83 c4 10             	add    $0x10,%esp
8010163f:	3b 3d e8 19 11 80    	cmp    0x801119e8,%edi
80101645:	73 69                	jae    801016b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101647:	89 f8                	mov    %edi,%eax
80101649:	83 ec 08             	sub    $0x8,%esp
8010164c:	c1 e8 03             	shr    $0x3,%eax
8010164f:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101655:	50                   	push   %eax
80101656:	56                   	push   %esi
80101657:	e8 74 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010165c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010165f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101661:	89 f8                	mov    %edi,%eax
80101663:	83 e0 07             	and    $0x7,%eax
80101666:	c1 e0 06             	shl    $0x6,%eax
80101669:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010166d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101671:	75 bd                	jne    80101630 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101673:	83 ec 04             	sub    $0x4,%esp
80101676:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101679:	6a 40                	push   $0x40
8010167b:	6a 00                	push   $0x0
8010167d:	51                   	push   %ecx
8010167e:	e8 6d 36 00 00       	call   80104cf0 <memset>
      dip->type = type;
80101683:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101687:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010168a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010168d:	89 1c 24             	mov    %ebx,(%esp)
80101690:	e8 9b 18 00 00       	call   80102f30 <log_write>
      brelse(bp);
80101695:	89 1c 24             	mov    %ebx,(%esp)
80101698:	e8 53 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010169d:	83 c4 10             	add    $0x10,%esp
}
801016a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016a3:	89 fa                	mov    %edi,%edx
}
801016a5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016a6:	89 f0                	mov    %esi,%eax
}
801016a8:	5e                   	pop    %esi
801016a9:	5f                   	pop    %edi
801016aa:	5d                   	pop    %ebp
      return iget(dev, inum);
801016ab:	e9 b0 fc ff ff       	jmp    80101360 <iget>
  panic("ialloc: no inodes");
801016b0:	83 ec 0c             	sub    $0xc,%esp
801016b3:	68 f8 79 10 80       	push   $0x801079f8
801016b8:	e8 d3 ec ff ff       	call   80100390 <panic>
801016bd:	8d 76 00             	lea    0x0(%esi),%esi

801016c0 <iupdate>:
{
801016c0:	f3 0f 1e fb          	endbr32 
801016c4:	55                   	push   %ebp
801016c5:	89 e5                	mov    %esp,%ebp
801016c7:	56                   	push   %esi
801016c8:	53                   	push   %ebx
801016c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016cc:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016cf:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d2:	83 ec 08             	sub    $0x8,%esp
801016d5:	c1 e8 03             	shr    $0x3,%eax
801016d8:	03 05 f4 19 11 80    	add    0x801119f4,%eax
801016de:	50                   	push   %eax
801016df:	ff 73 a4             	pushl  -0x5c(%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016e7:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016eb:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016ee:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016f0:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016f3:	83 e0 07             	and    $0x7,%eax
801016f6:	c1 e0 06             	shl    $0x6,%eax
801016f9:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016fd:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101700:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101704:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101707:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
8010170b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010170f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101713:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101717:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
8010171b:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010171e:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	53                   	push   %ebx
80101724:	50                   	push   %eax
80101725:	e8 66 36 00 00       	call   80104d90 <memmove>
  log_write(bp);
8010172a:	89 34 24             	mov    %esi,(%esp)
8010172d:	e8 fe 17 00 00       	call   80102f30 <log_write>
  brelse(bp);
80101732:	89 75 08             	mov    %esi,0x8(%ebp)
80101735:	83 c4 10             	add    $0x10,%esp
}
80101738:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010173b:	5b                   	pop    %ebx
8010173c:	5e                   	pop    %esi
8010173d:	5d                   	pop    %ebp
  brelse(bp);
8010173e:	e9 ad ea ff ff       	jmp    801001f0 <brelse>
80101743:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010174a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101750 <idup>:
{
80101750:	f3 0f 1e fb          	endbr32 
80101754:	55                   	push   %ebp
80101755:	89 e5                	mov    %esp,%ebp
80101757:	53                   	push   %ebx
80101758:	83 ec 10             	sub    $0x10,%esp
8010175b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010175e:	68 00 1a 11 80       	push   $0x80111a00
80101763:	e8 78 34 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101768:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010176c:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101773:	e8 28 35 00 00       	call   80104ca0 <release>
}
80101778:	89 d8                	mov    %ebx,%eax
8010177a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010177d:	c9                   	leave  
8010177e:	c3                   	ret    
8010177f:	90                   	nop

80101780 <ilock>:
{
80101780:	f3 0f 1e fb          	endbr32 
80101784:	55                   	push   %ebp
80101785:	89 e5                	mov    %esp,%ebp
80101787:	56                   	push   %esi
80101788:	53                   	push   %ebx
80101789:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010178c:	85 db                	test   %ebx,%ebx
8010178e:	0f 84 b3 00 00 00    	je     80101847 <ilock+0xc7>
80101794:	8b 53 08             	mov    0x8(%ebx),%edx
80101797:	85 d2                	test   %edx,%edx
80101799:	0f 8e a8 00 00 00    	jle    80101847 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010179f:	83 ec 0c             	sub    $0xc,%esp
801017a2:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a5:	50                   	push   %eax
801017a6:	e8 b5 31 00 00       	call   80104960 <acquiresleep>
  if(ip->valid == 0){
801017ab:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ae:	83 c4 10             	add    $0x10,%esp
801017b1:	85 c0                	test   %eax,%eax
801017b3:	74 0b                	je     801017c0 <ilock+0x40>
}
801017b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b8:	5b                   	pop    %ebx
801017b9:	5e                   	pop    %esi
801017ba:	5d                   	pop    %ebp
801017bb:	c3                   	ret    
801017bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c0:	8b 43 04             	mov    0x4(%ebx),%eax
801017c3:	83 ec 08             	sub    $0x8,%esp
801017c6:	c1 e8 03             	shr    $0x3,%eax
801017c9:	03 05 f4 19 11 80    	add    0x801119f4,%eax
801017cf:	50                   	push   %eax
801017d0:	ff 33                	pushl  (%ebx)
801017d2:	e8 f9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017d7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017da:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017dc:	8b 43 04             	mov    0x4(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101803:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101807:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010180b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010180e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101811:	6a 34                	push   $0x34
80101813:	50                   	push   %eax
80101814:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101817:	50                   	push   %eax
80101818:	e8 73 35 00 00       	call   80104d90 <memmove>
    brelse(bp);
8010181d:	89 34 24             	mov    %esi,(%esp)
80101820:	e8 cb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101834:	0f 85 7b ff ff ff    	jne    801017b5 <ilock+0x35>
      panic("ilock: no type");
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 10 7a 10 80       	push   $0x80107a10
80101842:	e8 49 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 0a 7a 10 80       	push   $0x80107a0a
8010184f:	e8 3c eb ff ff       	call   80100390 <panic>
80101854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iunlock>:
{
80101860:	f3 0f 1e fb          	endbr32 
80101864:	55                   	push   %ebp
80101865:	89 e5                	mov    %esp,%ebp
80101867:	56                   	push   %esi
80101868:	53                   	push   %ebx
80101869:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010186c:	85 db                	test   %ebx,%ebx
8010186e:	74 28                	je     80101898 <iunlock+0x38>
80101870:	83 ec 0c             	sub    $0xc,%esp
80101873:	8d 73 0c             	lea    0xc(%ebx),%esi
80101876:	56                   	push   %esi
80101877:	e8 84 31 00 00       	call   80104a00 <holdingsleep>
8010187c:	83 c4 10             	add    $0x10,%esp
8010187f:	85 c0                	test   %eax,%eax
80101881:	74 15                	je     80101898 <iunlock+0x38>
80101883:	8b 43 08             	mov    0x8(%ebx),%eax
80101886:	85 c0                	test   %eax,%eax
80101888:	7e 0e                	jle    80101898 <iunlock+0x38>
  releasesleep(&ip->lock);
8010188a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010188d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101890:	5b                   	pop    %ebx
80101891:	5e                   	pop    %esi
80101892:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101893:	e9 28 31 00 00       	jmp    801049c0 <releasesleep>
    panic("iunlock");
80101898:	83 ec 0c             	sub    $0xc,%esp
8010189b:	68 1f 7a 10 80       	push   $0x80107a1f
801018a0:	e8 eb ea ff ff       	call   80100390 <panic>
801018a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018b0 <iput>:
{
801018b0:	f3 0f 1e fb          	endbr32 
801018b4:	55                   	push   %ebp
801018b5:	89 e5                	mov    %esp,%ebp
801018b7:	57                   	push   %edi
801018b8:	56                   	push   %esi
801018b9:	53                   	push   %ebx
801018ba:	83 ec 28             	sub    $0x28,%esp
801018bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018c0:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018c3:	57                   	push   %edi
801018c4:	e8 97 30 00 00       	call   80104960 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018c9:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018cc:	83 c4 10             	add    $0x10,%esp
801018cf:	85 d2                	test   %edx,%edx
801018d1:	74 07                	je     801018da <iput+0x2a>
801018d3:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018d8:	74 36                	je     80101910 <iput+0x60>
  releasesleep(&ip->lock);
801018da:	83 ec 0c             	sub    $0xc,%esp
801018dd:	57                   	push   %edi
801018de:	e8 dd 30 00 00       	call   801049c0 <releasesleep>
  acquire(&icache.lock);
801018e3:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
801018ea:	e8 f1 32 00 00       	call   80104be0 <acquire>
  ip->ref--;
801018ef:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018f3:	83 c4 10             	add    $0x10,%esp
801018f6:	c7 45 08 00 1a 11 80 	movl   $0x80111a00,0x8(%ebp)
}
801018fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101900:	5b                   	pop    %ebx
80101901:	5e                   	pop    %esi
80101902:	5f                   	pop    %edi
80101903:	5d                   	pop    %ebp
  release(&icache.lock);
80101904:	e9 97 33 00 00       	jmp    80104ca0 <release>
80101909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101910:	83 ec 0c             	sub    $0xc,%esp
80101913:	68 00 1a 11 80       	push   $0x80111a00
80101918:	e8 c3 32 00 00       	call   80104be0 <acquire>
    int r = ip->ref;
8010191d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101920:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101927:	e8 74 33 00 00       	call   80104ca0 <release>
    if(r == 1){
8010192c:	83 c4 10             	add    $0x10,%esp
8010192f:	83 fe 01             	cmp    $0x1,%esi
80101932:	75 a6                	jne    801018da <iput+0x2a>
80101934:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
8010193a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010193d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101940:	89 cf                	mov    %ecx,%edi
80101942:	eb 0b                	jmp    8010194f <iput+0x9f>
80101944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101948:	83 c6 04             	add    $0x4,%esi
8010194b:	39 fe                	cmp    %edi,%esi
8010194d:	74 19                	je     80101968 <iput+0xb8>
    if(ip->addrs[i]){
8010194f:	8b 16                	mov    (%esi),%edx
80101951:	85 d2                	test   %edx,%edx
80101953:	74 f3                	je     80101948 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101955:	8b 03                	mov    (%ebx),%eax
80101957:	e8 74 f8 ff ff       	call   801011d0 <bfree>
      ip->addrs[i] = 0;
8010195c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101962:	eb e4                	jmp    80101948 <iput+0x98>
80101964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101968:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010196e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101971:	85 c0                	test   %eax,%eax
80101973:	75 33                	jne    801019a8 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101975:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101978:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
8010197f:	53                   	push   %ebx
80101980:	e8 3b fd ff ff       	call   801016c0 <iupdate>
      ip->type = 0;
80101985:	31 c0                	xor    %eax,%eax
80101987:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
8010198b:	89 1c 24             	mov    %ebx,(%esp)
8010198e:	e8 2d fd ff ff       	call   801016c0 <iupdate>
      ip->valid = 0;
80101993:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
8010199a:	83 c4 10             	add    $0x10,%esp
8010199d:	e9 38 ff ff ff       	jmp    801018da <iput+0x2a>
801019a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019a8:	83 ec 08             	sub    $0x8,%esp
801019ab:	50                   	push   %eax
801019ac:	ff 33                	pushl  (%ebx)
801019ae:	e8 1d e7 ff ff       	call   801000d0 <bread>
801019b3:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019b6:	83 c4 10             	add    $0x10,%esp
801019b9:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801019c2:	8d 70 5c             	lea    0x5c(%eax),%esi
801019c5:	89 cf                	mov    %ecx,%edi
801019c7:	eb 0e                	jmp    801019d7 <iput+0x127>
801019c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019d0:	83 c6 04             	add    $0x4,%esi
801019d3:	39 f7                	cmp    %esi,%edi
801019d5:	74 19                	je     801019f0 <iput+0x140>
      if(a[j])
801019d7:	8b 16                	mov    (%esi),%edx
801019d9:	85 d2                	test   %edx,%edx
801019db:	74 f3                	je     801019d0 <iput+0x120>
        bfree(ip->dev, a[j]);
801019dd:	8b 03                	mov    (%ebx),%eax
801019df:	e8 ec f7 ff ff       	call   801011d0 <bfree>
801019e4:	eb ea                	jmp    801019d0 <iput+0x120>
801019e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ed:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801019f0:	83 ec 0c             	sub    $0xc,%esp
801019f3:	ff 75 e4             	pushl  -0x1c(%ebp)
801019f6:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019f9:	e8 f2 e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019fe:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a04:	8b 03                	mov    (%ebx),%eax
80101a06:	e8 c5 f7 ff ff       	call   801011d0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a0b:	83 c4 10             	add    $0x10,%esp
80101a0e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a15:	00 00 00 
80101a18:	e9 58 ff ff ff       	jmp    80101975 <iput+0xc5>
80101a1d:	8d 76 00             	lea    0x0(%esi),%esi

80101a20 <iunlockput>:
{
80101a20:	f3 0f 1e fb          	endbr32 
80101a24:	55                   	push   %ebp
80101a25:	89 e5                	mov    %esp,%ebp
80101a27:	53                   	push   %ebx
80101a28:	83 ec 10             	sub    $0x10,%esp
80101a2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a2e:	53                   	push   %ebx
80101a2f:	e8 2c fe ff ff       	call   80101860 <iunlock>
  iput(ip);
80101a34:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a37:	83 c4 10             	add    $0x10,%esp
}
80101a3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a3d:	c9                   	leave  
  iput(ip);
80101a3e:	e9 6d fe ff ff       	jmp    801018b0 <iput>
80101a43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a50 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a50:	f3 0f 1e fb          	endbr32 
80101a54:	55                   	push   %ebp
80101a55:	89 e5                	mov    %esp,%ebp
80101a57:	8b 55 08             	mov    0x8(%ebp),%edx
80101a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a5d:	8b 0a                	mov    (%edx),%ecx
80101a5f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a62:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a65:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a68:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a6c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a6f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a73:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a77:	8b 52 58             	mov    0x58(%edx),%edx
80101a7a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a7d:	5d                   	pop    %ebp
80101a7e:	c3                   	ret    
80101a7f:	90                   	nop

80101a80 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a80:	f3 0f 1e fb          	endbr32 
80101a84:	55                   	push   %ebp
80101a85:	89 e5                	mov    %esp,%ebp
80101a87:	57                   	push   %edi
80101a88:	56                   	push   %esi
80101a89:	53                   	push   %ebx
80101a8a:	83 ec 1c             	sub    $0x1c,%esp
80101a8d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a90:	8b 45 08             	mov    0x8(%ebp),%eax
80101a93:	8b 75 10             	mov    0x10(%ebp),%esi
80101a96:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a99:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a9c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aa1:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aa4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101aa7:	0f 84 a3 00 00 00    	je     80101b50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101aad:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101ab0:	8b 40 58             	mov    0x58(%eax),%eax
80101ab3:	39 c6                	cmp    %eax,%esi
80101ab5:	0f 87 b6 00 00 00    	ja     80101b71 <readi+0xf1>
80101abb:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101abe:	31 c9                	xor    %ecx,%ecx
80101ac0:	89 da                	mov    %ebx,%edx
80101ac2:	01 f2                	add    %esi,%edx
80101ac4:	0f 92 c1             	setb   %cl
80101ac7:	89 cf                	mov    %ecx,%edi
80101ac9:	0f 82 a2 00 00 00    	jb     80101b71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101acf:	89 c1                	mov    %eax,%ecx
80101ad1:	29 f1                	sub    %esi,%ecx
80101ad3:	39 d0                	cmp    %edx,%eax
80101ad5:	0f 43 cb             	cmovae %ebx,%ecx
80101ad8:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101adb:	85 c9                	test   %ecx,%ecx
80101add:	74 63                	je     80101b42 <readi+0xc2>
80101adf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ae3:	89 f2                	mov    %esi,%edx
80101ae5:	c1 ea 09             	shr    $0x9,%edx
80101ae8:	89 d8                	mov    %ebx,%eax
80101aea:	e8 61 f9 ff ff       	call   80101450 <bmap>
80101aef:	83 ec 08             	sub    $0x8,%esp
80101af2:	50                   	push   %eax
80101af3:	ff 33                	pushl  (%ebx)
80101af5:	e8 d6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101afa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101afd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b02:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b05:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	89 f0                	mov    %esi,%eax
80101b09:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b0e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b10:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b13:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b15:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b19:	39 d9                	cmp    %ebx,%ecx
80101b1b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b1e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b1f:	01 df                	add    %ebx,%edi
80101b21:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b23:	50                   	push   %eax
80101b24:	ff 75 e0             	pushl  -0x20(%ebp)
80101b27:	e8 64 32 00 00       	call   80104d90 <memmove>
    brelse(bp);
80101b2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b2f:	89 14 24             	mov    %edx,(%esp)
80101b32:	e8 b9 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b3a:	83 c4 10             	add    $0x10,%esp
80101b3d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b40:	77 9e                	ja     80101ae0 <readi+0x60>
  }
  return n;
80101b42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b48:	5b                   	pop    %ebx
80101b49:	5e                   	pop    %esi
80101b4a:	5f                   	pop    %edi
80101b4b:	5d                   	pop    %ebp
80101b4c:	c3                   	ret    
80101b4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 17                	ja     80101b71 <readi+0xf1>
80101b5a:	8b 04 c5 80 19 11 80 	mov    -0x7feee680(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 0c                	je     80101b71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b6f:	ff e0                	jmp    *%eax
      return -1;
80101b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b76:	eb cd                	jmp    80101b45 <readi+0xc5>
80101b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b7f:	90                   	nop

80101b80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b80:	f3 0f 1e fb          	endbr32 
80101b84:	55                   	push   %ebp
80101b85:	89 e5                	mov    %esp,%ebp
80101b87:	57                   	push   %edi
80101b88:	56                   	push   %esi
80101b89:	53                   	push   %ebx
80101b8a:	83 ec 1c             	sub    $0x1c,%esp
80101b8d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b90:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b93:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b96:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b9b:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b9e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ba1:	8b 75 10             	mov    0x10(%ebp),%esi
80101ba4:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ba7:	0f 84 b3 00 00 00    	je     80101c60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bad:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bb0:	39 70 58             	cmp    %esi,0x58(%eax)
80101bb3:	0f 82 e3 00 00 00    	jb     80101c9c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bb9:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bbc:	89 f8                	mov    %edi,%eax
80101bbe:	01 f0                	add    %esi,%eax
80101bc0:	0f 82 d6 00 00 00    	jb     80101c9c <writei+0x11c>
80101bc6:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bcb:	0f 87 cb 00 00 00    	ja     80101c9c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bd1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101bd8:	85 ff                	test   %edi,%edi
80101bda:	74 75                	je     80101c51 <writei+0xd1>
80101bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101be0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101be3:	89 f2                	mov    %esi,%edx
80101be5:	c1 ea 09             	shr    $0x9,%edx
80101be8:	89 f8                	mov    %edi,%eax
80101bea:	e8 61 f8 ff ff       	call   80101450 <bmap>
80101bef:	83 ec 08             	sub    $0x8,%esp
80101bf2:	50                   	push   %eax
80101bf3:	ff 37                	pushl  (%edi)
80101bf5:	e8 d6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bfa:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bff:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c02:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c05:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c07:	89 f0                	mov    %esi,%eax
80101c09:	83 c4 0c             	add    $0xc,%esp
80101c0c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c11:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c13:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	39 d9                	cmp    %ebx,%ecx
80101c19:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c1c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c1d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c1f:	ff 75 dc             	pushl  -0x24(%ebp)
80101c22:	50                   	push   %eax
80101c23:	e8 68 31 00 00       	call   80104d90 <memmove>
    log_write(bp);
80101c28:	89 3c 24             	mov    %edi,(%esp)
80101c2b:	e8 00 13 00 00       	call   80102f30 <log_write>
    brelse(bp);
80101c30:	89 3c 24             	mov    %edi,(%esp)
80101c33:	e8 b8 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c38:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c3b:	83 c4 10             	add    $0x10,%esp
80101c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c41:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c44:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c47:	77 97                	ja     80101be0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c4c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c4f:	77 37                	ja     80101c88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c51:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c57:	5b                   	pop    %ebx
80101c58:	5e                   	pop    %esi
80101c59:	5f                   	pop    %edi
80101c5a:	5d                   	pop    %ebp
80101c5b:	c3                   	ret    
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c64:	66 83 f8 09          	cmp    $0x9,%ax
80101c68:	77 32                	ja     80101c9c <writei+0x11c>
80101c6a:	8b 04 c5 84 19 11 80 	mov    -0x7feee67c(,%eax,8),%eax
80101c71:	85 c0                	test   %eax,%eax
80101c73:	74 27                	je     80101c9c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7b:	5b                   	pop    %ebx
80101c7c:	5e                   	pop    %esi
80101c7d:	5f                   	pop    %edi
80101c7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c7f:	ff e0                	jmp    *%eax
80101c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c88:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c8b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c8e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c91:	50                   	push   %eax
80101c92:	e8 29 fa ff ff       	call   801016c0 <iupdate>
80101c97:	83 c4 10             	add    $0x10,%esp
80101c9a:	eb b5                	jmp    80101c51 <writei+0xd1>
      return -1;
80101c9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ca1:	eb b1                	jmp    80101c54 <writei+0xd4>
80101ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cb0:	f3 0f 1e fb          	endbr32 
80101cb4:	55                   	push   %ebp
80101cb5:	89 e5                	mov    %esp,%ebp
80101cb7:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cba:	6a 0e                	push   $0xe
80101cbc:	ff 75 0c             	pushl  0xc(%ebp)
80101cbf:	ff 75 08             	pushl  0x8(%ebp)
80101cc2:	e8 39 31 00 00       	call   80104e00 <strncmp>
}
80101cc7:	c9                   	leave  
80101cc8:	c3                   	ret    
80101cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101cd0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cd0:	f3 0f 1e fb          	endbr32 
80101cd4:	55                   	push   %ebp
80101cd5:	89 e5                	mov    %esp,%ebp
80101cd7:	57                   	push   %edi
80101cd8:	56                   	push   %esi
80101cd9:	53                   	push   %ebx
80101cda:	83 ec 1c             	sub    $0x1c,%esp
80101cdd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101ce0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ce5:	0f 85 89 00 00 00    	jne    80101d74 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ceb:	8b 53 58             	mov    0x58(%ebx),%edx
80101cee:	31 ff                	xor    %edi,%edi
80101cf0:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cf3:	85 d2                	test   %edx,%edx
80101cf5:	74 42                	je     80101d39 <dirlookup+0x69>
80101cf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cfe:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d00:	6a 10                	push   $0x10
80101d02:	57                   	push   %edi
80101d03:	56                   	push   %esi
80101d04:	53                   	push   %ebx
80101d05:	e8 76 fd ff ff       	call   80101a80 <readi>
80101d0a:	83 c4 10             	add    $0x10,%esp
80101d0d:	83 f8 10             	cmp    $0x10,%eax
80101d10:	75 55                	jne    80101d67 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80101d12:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d17:	74 18                	je     80101d31 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101d19:	83 ec 04             	sub    $0x4,%esp
80101d1c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d1f:	6a 0e                	push   $0xe
80101d21:	50                   	push   %eax
80101d22:	ff 75 0c             	pushl  0xc(%ebp)
80101d25:	e8 d6 30 00 00       	call   80104e00 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d2a:	83 c4 10             	add    $0x10,%esp
80101d2d:	85 c0                	test   %eax,%eax
80101d2f:	74 17                	je     80101d48 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d31:	83 c7 10             	add    $0x10,%edi
80101d34:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d37:	72 c7                	jb     80101d00 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d39:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d3c:	31 c0                	xor    %eax,%eax
}
80101d3e:	5b                   	pop    %ebx
80101d3f:	5e                   	pop    %esi
80101d40:	5f                   	pop    %edi
80101d41:	5d                   	pop    %ebp
80101d42:	c3                   	ret    
80101d43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d47:	90                   	nop
      if(poff)
80101d48:	8b 45 10             	mov    0x10(%ebp),%eax
80101d4b:	85 c0                	test   %eax,%eax
80101d4d:	74 05                	je     80101d54 <dirlookup+0x84>
        *poff = off;
80101d4f:	8b 45 10             	mov    0x10(%ebp),%eax
80101d52:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d54:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d58:	8b 03                	mov    (%ebx),%eax
80101d5a:	e8 01 f6 ff ff       	call   80101360 <iget>
}
80101d5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d62:	5b                   	pop    %ebx
80101d63:	5e                   	pop    %esi
80101d64:	5f                   	pop    %edi
80101d65:	5d                   	pop    %ebp
80101d66:	c3                   	ret    
      panic("dirlookup read");
80101d67:	83 ec 0c             	sub    $0xc,%esp
80101d6a:	68 39 7a 10 80       	push   $0x80107a39
80101d6f:	e8 1c e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d74:	83 ec 0c             	sub    $0xc,%esp
80101d77:	68 27 7a 10 80       	push   $0x80107a27
80101d7c:	e8 0f e6 ff ff       	call   80100390 <panic>
80101d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d8f:	90                   	nop

80101d90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d9e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101da4:	0f 84 86 01 00 00    	je     80101f30 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101daa:	e8 71 1c 00 00       	call   80103a20 <myproc>
  acquire(&icache.lock);
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80101db4:	8b 70 70             	mov    0x70(%eax),%esi
  acquire(&icache.lock);
80101db7:	68 00 1a 11 80       	push   $0x80111a00
80101dbc:	e8 1f 2e 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101dc1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc5:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101dcc:	e8 cf 2e 00 00       	call   80104ca0 <release>
80101dd1:	83 c4 10             	add    $0x10,%esp
80101dd4:	eb 0d                	jmp    80101de3 <namex+0x53>
80101dd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ddd:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101de0:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101de3:	0f b6 07             	movzbl (%edi),%eax
80101de6:	3c 2f                	cmp    $0x2f,%al
80101de8:	74 f6                	je     80101de0 <namex+0x50>
  if(*path == 0)
80101dea:	84 c0                	test   %al,%al
80101dec:	0f 84 ee 00 00 00    	je     80101ee0 <namex+0x150>
  while(*path != '/' && *path != 0)
80101df2:	0f b6 07             	movzbl (%edi),%eax
80101df5:	84 c0                	test   %al,%al
80101df7:	0f 84 fb 00 00 00    	je     80101ef8 <namex+0x168>
80101dfd:	89 fb                	mov    %edi,%ebx
80101dff:	3c 2f                	cmp    $0x2f,%al
80101e01:	0f 84 f1 00 00 00    	je     80101ef8 <namex+0x168>
80101e07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e0e:	66 90                	xchg   %ax,%ax
80101e10:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80101e14:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80101e17:	3c 2f                	cmp    $0x2f,%al
80101e19:	74 04                	je     80101e1f <namex+0x8f>
80101e1b:	84 c0                	test   %al,%al
80101e1d:	75 f1                	jne    80101e10 <namex+0x80>
  len = path - s;
80101e1f:	89 d8                	mov    %ebx,%eax
80101e21:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101e23:	83 f8 0d             	cmp    $0xd,%eax
80101e26:	0f 8e 84 00 00 00    	jle    80101eb0 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101e2c:	83 ec 04             	sub    $0x4,%esp
80101e2f:	6a 0e                	push   $0xe
80101e31:	57                   	push   %edi
    path++;
80101e32:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101e34:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e37:	e8 54 2f 00 00       	call   80104d90 <memmove>
80101e3c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e3f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e42:	75 0c                	jne    80101e50 <namex+0xc0>
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e48:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80101e4b:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e4e:	74 f8                	je     80101e48 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e50:	83 ec 0c             	sub    $0xc,%esp
80101e53:	56                   	push   %esi
80101e54:	e8 27 f9 ff ff       	call   80101780 <ilock>
    if(ip->type != T_DIR){
80101e59:	83 c4 10             	add    $0x10,%esp
80101e5c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e61:	0f 85 a1 00 00 00    	jne    80101f08 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e67:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e6a:	85 d2                	test   %edx,%edx
80101e6c:	74 09                	je     80101e77 <namex+0xe7>
80101e6e:	80 3f 00             	cmpb   $0x0,(%edi)
80101e71:	0f 84 d9 00 00 00    	je     80101f50 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e77:	83 ec 04             	sub    $0x4,%esp
80101e7a:	6a 00                	push   $0x0
80101e7c:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e7f:	56                   	push   %esi
80101e80:	e8 4b fe ff ff       	call   80101cd0 <dirlookup>
80101e85:	83 c4 10             	add    $0x10,%esp
80101e88:	89 c3                	mov    %eax,%ebx
80101e8a:	85 c0                	test   %eax,%eax
80101e8c:	74 7a                	je     80101f08 <namex+0x178>
  iunlock(ip);
80101e8e:	83 ec 0c             	sub    $0xc,%esp
80101e91:	56                   	push   %esi
80101e92:	e8 c9 f9 ff ff       	call   80101860 <iunlock>
  iput(ip);
80101e97:	89 34 24             	mov    %esi,(%esp)
80101e9a:	89 de                	mov    %ebx,%esi
80101e9c:	e8 0f fa ff ff       	call   801018b0 <iput>
80101ea1:	83 c4 10             	add    $0x10,%esp
80101ea4:	e9 3a ff ff ff       	jmp    80101de3 <namex+0x53>
80101ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101eb3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101eb6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101eb9:	83 ec 04             	sub    $0x4,%esp
80101ebc:	50                   	push   %eax
80101ebd:	57                   	push   %edi
    name[len] = 0;
80101ebe:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101ec0:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ec3:	e8 c8 2e 00 00       	call   80104d90 <memmove>
    name[len] = 0;
80101ec8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ecb:	83 c4 10             	add    $0x10,%esp
80101ece:	c6 00 00             	movb   $0x0,(%eax)
80101ed1:	e9 69 ff ff ff       	jmp    80101e3f <namex+0xaf>
80101ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101edd:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ee0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ee3:	85 c0                	test   %eax,%eax
80101ee5:	0f 85 85 00 00 00    	jne    80101f70 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
80101eeb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eee:	89 f0                	mov    %esi,%eax
80101ef0:	5b                   	pop    %ebx
80101ef1:	5e                   	pop    %esi
80101ef2:	5f                   	pop    %edi
80101ef3:	5d                   	pop    %ebp
80101ef4:	c3                   	ret    
80101ef5:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80101ef8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101efb:	89 fb                	mov    %edi,%ebx
80101efd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101f00:	31 c0                	xor    %eax,%eax
80101f02:	eb b5                	jmp    80101eb9 <namex+0x129>
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f08:	83 ec 0c             	sub    $0xc,%esp
80101f0b:	56                   	push   %esi
80101f0c:	e8 4f f9 ff ff       	call   80101860 <iunlock>
  iput(ip);
80101f11:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f14:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f16:	e8 95 f9 ff ff       	call   801018b0 <iput>
      return 0;
80101f1b:	83 c4 10             	add    $0x10,%esp
}
80101f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f21:	89 f0                	mov    %esi,%eax
80101f23:	5b                   	pop    %ebx
80101f24:	5e                   	pop    %esi
80101f25:	5f                   	pop    %edi
80101f26:	5d                   	pop    %ebp
80101f27:	c3                   	ret    
80101f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f2f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80101f30:	ba 01 00 00 00       	mov    $0x1,%edx
80101f35:	b8 01 00 00 00       	mov    $0x1,%eax
80101f3a:	89 df                	mov    %ebx,%edi
80101f3c:	e8 1f f4 ff ff       	call   80101360 <iget>
80101f41:	89 c6                	mov    %eax,%esi
80101f43:	e9 9b fe ff ff       	jmp    80101de3 <namex+0x53>
80101f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f4f:	90                   	nop
      iunlock(ip);
80101f50:	83 ec 0c             	sub    $0xc,%esp
80101f53:	56                   	push   %esi
80101f54:	e8 07 f9 ff ff       	call   80101860 <iunlock>
      return ip;
80101f59:	83 c4 10             	add    $0x10,%esp
}
80101f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5f:	89 f0                	mov    %esi,%eax
80101f61:	5b                   	pop    %ebx
80101f62:	5e                   	pop    %esi
80101f63:	5f                   	pop    %edi
80101f64:	5d                   	pop    %ebp
80101f65:	c3                   	ret    
80101f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f6d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80101f70:	83 ec 0c             	sub    $0xc,%esp
80101f73:	56                   	push   %esi
    return 0;
80101f74:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f76:	e8 35 f9 ff ff       	call   801018b0 <iput>
    return 0;
80101f7b:	83 c4 10             	add    $0x10,%esp
80101f7e:	e9 68 ff ff ff       	jmp    80101eeb <namex+0x15b>
80101f83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f90 <dirlink>:
{
80101f90:	f3 0f 1e fb          	endbr32 
80101f94:	55                   	push   %ebp
80101f95:	89 e5                	mov    %esp,%ebp
80101f97:	57                   	push   %edi
80101f98:	56                   	push   %esi
80101f99:	53                   	push   %ebx
80101f9a:	83 ec 20             	sub    $0x20,%esp
80101f9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fa0:	6a 00                	push   $0x0
80101fa2:	ff 75 0c             	pushl  0xc(%ebp)
80101fa5:	53                   	push   %ebx
80101fa6:	e8 25 fd ff ff       	call   80101cd0 <dirlookup>
80101fab:	83 c4 10             	add    $0x10,%esp
80101fae:	85 c0                	test   %eax,%eax
80101fb0:	75 6b                	jne    8010201d <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fb2:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fb5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fb8:	85 ff                	test   %edi,%edi
80101fba:	74 2d                	je     80101fe9 <dirlink+0x59>
80101fbc:	31 ff                	xor    %edi,%edi
80101fbe:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fc1:	eb 0d                	jmp    80101fd0 <dirlink+0x40>
80101fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc7:	90                   	nop
80101fc8:	83 c7 10             	add    $0x10,%edi
80101fcb:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fce:	73 19                	jae    80101fe9 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fd0:	6a 10                	push   $0x10
80101fd2:	57                   	push   %edi
80101fd3:	56                   	push   %esi
80101fd4:	53                   	push   %ebx
80101fd5:	e8 a6 fa ff ff       	call   80101a80 <readi>
80101fda:	83 c4 10             	add    $0x10,%esp
80101fdd:	83 f8 10             	cmp    $0x10,%eax
80101fe0:	75 4e                	jne    80102030 <dirlink+0xa0>
    if(de.inum == 0)
80101fe2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fe7:	75 df                	jne    80101fc8 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80101fe9:	83 ec 04             	sub    $0x4,%esp
80101fec:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fef:	6a 0e                	push   $0xe
80101ff1:	ff 75 0c             	pushl  0xc(%ebp)
80101ff4:	50                   	push   %eax
80101ff5:	e8 56 2e 00 00       	call   80104e50 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ffa:	6a 10                	push   $0x10
  de.inum = inum;
80101ffc:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fff:	57                   	push   %edi
80102000:	56                   	push   %esi
80102001:	53                   	push   %ebx
  de.inum = inum;
80102002:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102006:	e8 75 fb ff ff       	call   80101b80 <writei>
8010200b:	83 c4 20             	add    $0x20,%esp
8010200e:	83 f8 10             	cmp    $0x10,%eax
80102011:	75 2a                	jne    8010203d <dirlink+0xad>
  return 0;
80102013:	31 c0                	xor    %eax,%eax
}
80102015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102018:	5b                   	pop    %ebx
80102019:	5e                   	pop    %esi
8010201a:	5f                   	pop    %edi
8010201b:	5d                   	pop    %ebp
8010201c:	c3                   	ret    
    iput(ip);
8010201d:	83 ec 0c             	sub    $0xc,%esp
80102020:	50                   	push   %eax
80102021:	e8 8a f8 ff ff       	call   801018b0 <iput>
    return -1;
80102026:	83 c4 10             	add    $0x10,%esp
80102029:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010202e:	eb e5                	jmp    80102015 <dirlink+0x85>
      panic("dirlink read");
80102030:	83 ec 0c             	sub    $0xc,%esp
80102033:	68 48 7a 10 80       	push   $0x80107a48
80102038:	e8 53 e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
8010203d:	83 ec 0c             	sub    $0xc,%esp
80102040:	68 5e 80 10 80       	push   $0x8010805e
80102045:	e8 46 e3 ff ff       	call   80100390 <panic>
8010204a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102050 <namei>:

struct inode*
namei(char *path)
{
80102050:	f3 0f 1e fb          	endbr32 
80102054:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102055:	31 d2                	xor    %edx,%edx
{
80102057:	89 e5                	mov    %esp,%ebp
80102059:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010205c:	8b 45 08             	mov    0x8(%ebp),%eax
8010205f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102062:	e8 29 fd ff ff       	call   80101d90 <namex>
}
80102067:	c9                   	leave  
80102068:	c3                   	ret    
80102069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102070 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102070:	f3 0f 1e fb          	endbr32 
80102074:	55                   	push   %ebp
  return namex(path, 1, name);
80102075:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010207a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010207c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010207f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102082:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102083:	e9 08 fd ff ff       	jmp    80101d90 <namex>
80102088:	66 90                	xchg   %ax,%ax
8010208a:	66 90                	xchg   %ax,%ax
8010208c:	66 90                	xchg   %ax,%ax
8010208e:	66 90                	xchg   %ax,%ax

80102090 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102099:	85 c0                	test   %eax,%eax
8010209b:	0f 84 b4 00 00 00    	je     80102155 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020a1:	8b 70 08             	mov    0x8(%eax),%esi
801020a4:	89 c3                	mov    %eax,%ebx
801020a6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020ac:	0f 87 96 00 00 00    	ja     80102148 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020be:	66 90                	xchg   %ax,%ax
801020c0:	89 ca                	mov    %ecx,%edx
801020c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c3:	83 e0 c0             	and    $0xffffffc0,%eax
801020c6:	3c 40                	cmp    $0x40,%al
801020c8:	75 f6                	jne    801020c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ca:	31 ff                	xor    %edi,%edi
801020cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020d1:	89 f8                	mov    %edi,%eax
801020d3:	ee                   	out    %al,(%dx)
801020d4:	b8 01 00 00 00       	mov    $0x1,%eax
801020d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020de:	ee                   	out    %al,(%dx)
801020df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801020e4:	89 f0                	mov    %esi,%eax
801020e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020e7:	89 f0                	mov    %esi,%eax
801020e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801020ee:	c1 f8 08             	sar    $0x8,%eax
801020f1:	ee                   	out    %al,(%dx)
801020f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801020f7:	89 f8                	mov    %edi,%eax
801020f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020fa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801020fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102103:	c1 e0 04             	shl    $0x4,%eax
80102106:	83 e0 10             	and    $0x10,%eax
80102109:	83 c8 e0             	or     $0xffffffe0,%eax
8010210c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010210d:	f6 03 04             	testb  $0x4,(%ebx)
80102110:	75 16                	jne    80102128 <idestart+0x98>
80102112:	b8 20 00 00 00       	mov    $0x20,%eax
80102117:	89 ca                	mov    %ecx,%edx
80102119:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010211a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010211d:	5b                   	pop    %ebx
8010211e:	5e                   	pop    %esi
8010211f:	5f                   	pop    %edi
80102120:	5d                   	pop    %ebp
80102121:	c3                   	ret    
80102122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102128:	b8 30 00 00 00       	mov    $0x30,%eax
8010212d:	89 ca                	mov    %ecx,%edx
8010212f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102130:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102135:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102138:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010213d:	fc                   	cld    
8010213e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102140:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102143:	5b                   	pop    %ebx
80102144:	5e                   	pop    %esi
80102145:	5f                   	pop    %edi
80102146:	5d                   	pop    %ebp
80102147:	c3                   	ret    
    panic("incorrect blockno");
80102148:	83 ec 0c             	sub    $0xc,%esp
8010214b:	68 b4 7a 10 80       	push   $0x80107ab4
80102150:	e8 3b e2 ff ff       	call   80100390 <panic>
    panic("idestart");
80102155:	83 ec 0c             	sub    $0xc,%esp
80102158:	68 ab 7a 10 80       	push   $0x80107aab
8010215d:	e8 2e e2 ff ff       	call   80100390 <panic>
80102162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <ideinit>:
{
80102170:	f3 0f 1e fb          	endbr32 
80102174:	55                   	push   %ebp
80102175:	89 e5                	mov    %esp,%ebp
80102177:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010217a:	68 c6 7a 10 80       	push   $0x80107ac6
8010217f:	68 80 b5 10 80       	push   $0x8010b580
80102184:	e8 d7 28 00 00       	call   80104a60 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102189:	58                   	pop    %eax
8010218a:	a1 20 3d 11 80       	mov    0x80113d20,%eax
8010218f:	5a                   	pop    %edx
80102190:	83 e8 01             	sub    $0x1,%eax
80102193:	50                   	push   %eax
80102194:	6a 0e                	push   $0xe
80102196:	e8 b5 02 00 00       	call   80102450 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010219b:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010219e:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a7:	90                   	nop
801021a8:	ec                   	in     (%dx),%al
801021a9:	83 e0 c0             	and    $0xffffffc0,%eax
801021ac:	3c 40                	cmp    $0x40,%al
801021ae:	75 f8                	jne    801021a8 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021b0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021b5:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021ba:	ee                   	out    %al,(%dx)
801021bb:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021c0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021c5:	eb 0e                	jmp    801021d5 <ideinit+0x65>
801021c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ce:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801021d0:	83 e9 01             	sub    $0x1,%ecx
801021d3:	74 0f                	je     801021e4 <ideinit+0x74>
801021d5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021d6:	84 c0                	test   %al,%al
801021d8:	74 f6                	je     801021d0 <ideinit+0x60>
      havedisk1 = 1;
801021da:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801021e1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021e4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021e9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021ee:	ee                   	out    %al,(%dx)
}
801021ef:	c9                   	leave  
801021f0:	c3                   	ret    
801021f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ff:	90                   	nop

80102200 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102200:	f3 0f 1e fb          	endbr32 
80102204:	55                   	push   %ebp
80102205:	89 e5                	mov    %esp,%ebp
80102207:	57                   	push   %edi
80102208:	56                   	push   %esi
80102209:	53                   	push   %ebx
8010220a:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010220d:	68 80 b5 10 80       	push   $0x8010b580
80102212:	e8 c9 29 00 00       	call   80104be0 <acquire>

  if((b = idequeue) == 0){
80102217:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
8010221d:	83 c4 10             	add    $0x10,%esp
80102220:	85 db                	test   %ebx,%ebx
80102222:	74 5f                	je     80102283 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102224:	8b 43 58             	mov    0x58(%ebx),%eax
80102227:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010222c:	8b 33                	mov    (%ebx),%esi
8010222e:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102234:	75 2b                	jne    80102261 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102236:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010223b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop
80102240:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102241:	89 c1                	mov    %eax,%ecx
80102243:	83 e1 c0             	and    $0xffffffc0,%ecx
80102246:	80 f9 40             	cmp    $0x40,%cl
80102249:	75 f5                	jne    80102240 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010224b:	a8 21                	test   $0x21,%al
8010224d:	75 12                	jne    80102261 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010224f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102252:	b9 80 00 00 00       	mov    $0x80,%ecx
80102257:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010225c:	fc                   	cld    
8010225d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010225f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102261:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102264:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102267:	83 ce 02             	or     $0x2,%esi
8010226a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010226c:	53                   	push   %ebx
8010226d:	e8 6e 24 00 00       	call   801046e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102272:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102277:	83 c4 10             	add    $0x10,%esp
8010227a:	85 c0                	test   %eax,%eax
8010227c:	74 05                	je     80102283 <ideintr+0x83>
    idestart(idequeue);
8010227e:	e8 0d fe ff ff       	call   80102090 <idestart>
    release(&idelock);
80102283:	83 ec 0c             	sub    $0xc,%esp
80102286:	68 80 b5 10 80       	push   $0x8010b580
8010228b:	e8 10 2a 00 00       	call   80104ca0 <release>

  release(&idelock);
}
80102290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102293:	5b                   	pop    %ebx
80102294:	5e                   	pop    %esi
80102295:	5f                   	pop    %edi
80102296:	5d                   	pop    %ebp
80102297:	c3                   	ret    
80102298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229f:	90                   	nop

801022a0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022a0:	f3 0f 1e fb          	endbr32 
801022a4:	55                   	push   %ebp
801022a5:	89 e5                	mov    %esp,%ebp
801022a7:	53                   	push   %ebx
801022a8:	83 ec 10             	sub    $0x10,%esp
801022ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ae:	8d 43 0c             	lea    0xc(%ebx),%eax
801022b1:	50                   	push   %eax
801022b2:	e8 49 27 00 00       	call   80104a00 <holdingsleep>
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	0f 84 cf 00 00 00    	je     80102391 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022c2:	8b 03                	mov    (%ebx),%eax
801022c4:	83 e0 06             	and    $0x6,%eax
801022c7:	83 f8 02             	cmp    $0x2,%eax
801022ca:	0f 84 b4 00 00 00    	je     80102384 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022d0:	8b 53 04             	mov    0x4(%ebx),%edx
801022d3:	85 d2                	test   %edx,%edx
801022d5:	74 0d                	je     801022e4 <iderw+0x44>
801022d7:	a1 60 b5 10 80       	mov    0x8010b560,%eax
801022dc:	85 c0                	test   %eax,%eax
801022de:	0f 84 93 00 00 00    	je     80102377 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022e4:	83 ec 0c             	sub    $0xc,%esp
801022e7:	68 80 b5 10 80       	push   $0x8010b580
801022ec:	e8 ef 28 00 00       	call   80104be0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022f1:	a1 64 b5 10 80       	mov    0x8010b564,%eax
  b->qnext = 0;
801022f6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022fd:	83 c4 10             	add    $0x10,%esp
80102300:	85 c0                	test   %eax,%eax
80102302:	74 6c                	je     80102370 <iderw+0xd0>
80102304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102308:	89 c2                	mov    %eax,%edx
8010230a:	8b 40 58             	mov    0x58(%eax),%eax
8010230d:	85 c0                	test   %eax,%eax
8010230f:	75 f7                	jne    80102308 <iderw+0x68>
80102311:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102314:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102316:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010231c:	74 42                	je     80102360 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010231e:	8b 03                	mov    (%ebx),%eax
80102320:	83 e0 06             	and    $0x6,%eax
80102323:	83 f8 02             	cmp    $0x2,%eax
80102326:	74 23                	je     8010234b <iderw+0xab>
80102328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010232f:	90                   	nop
    sleep(b, &idelock);
80102330:	83 ec 08             	sub    $0x8,%esp
80102333:	68 80 b5 10 80       	push   $0x8010b580
80102338:	53                   	push   %ebx
80102339:	e8 42 20 00 00       	call   80104380 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010233e:	8b 03                	mov    (%ebx),%eax
80102340:	83 c4 10             	add    $0x10,%esp
80102343:	83 e0 06             	and    $0x6,%eax
80102346:	83 f8 02             	cmp    $0x2,%eax
80102349:	75 e5                	jne    80102330 <iderw+0x90>
  }


  release(&idelock);
8010234b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102352:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102355:	c9                   	leave  
  release(&idelock);
80102356:	e9 45 29 00 00       	jmp    80104ca0 <release>
8010235b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010235f:	90                   	nop
    idestart(b);
80102360:	89 d8                	mov    %ebx,%eax
80102362:	e8 29 fd ff ff       	call   80102090 <idestart>
80102367:	eb b5                	jmp    8010231e <iderw+0x7e>
80102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102370:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102375:	eb 9d                	jmp    80102314 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102377:	83 ec 0c             	sub    $0xc,%esp
8010237a:	68 f5 7a 10 80       	push   $0x80107af5
8010237f:	e8 0c e0 ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102384:	83 ec 0c             	sub    $0xc,%esp
80102387:	68 e0 7a 10 80       	push   $0x80107ae0
8010238c:	e8 ff df ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102391:	83 ec 0c             	sub    $0xc,%esp
80102394:	68 ca 7a 10 80       	push   $0x80107aca
80102399:	e8 f2 df ff ff       	call   80100390 <panic>
8010239e:	66 90                	xchg   %ax,%ax

801023a0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023a0:	f3 0f 1e fb          	endbr32 
801023a4:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023a5:	c7 05 54 36 11 80 00 	movl   $0xfec00000,0x80113654
801023ac:	00 c0 fe 
{
801023af:	89 e5                	mov    %esp,%ebp
801023b1:	56                   	push   %esi
801023b2:	53                   	push   %ebx
  ioapic->reg = reg;
801023b3:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023ba:	00 00 00 
  return ioapic->data;
801023bd:	8b 15 54 36 11 80    	mov    0x80113654,%edx
801023c3:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023c6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023cc:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023d2:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023d9:	c1 ee 10             	shr    $0x10,%esi
801023dc:	89 f0                	mov    %esi,%eax
801023de:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801023e1:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801023e4:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023e7:	39 c2                	cmp    %eax,%edx
801023e9:	74 16                	je     80102401 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023eb:	83 ec 0c             	sub    $0xc,%esp
801023ee:	68 14 7b 10 80       	push   $0x80107b14
801023f3:	e8 b8 e2 ff ff       	call   801006b0 <cprintf>
801023f8:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
801023fe:	83 c4 10             	add    $0x10,%esp
80102401:	83 c6 21             	add    $0x21,%esi
{
80102404:	ba 10 00 00 00       	mov    $0x10,%edx
80102409:	b8 20 00 00 00       	mov    $0x20,%eax
8010240e:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102410:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102412:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102414:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
8010241a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010241d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102423:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102426:	8d 5a 01             	lea    0x1(%edx),%ebx
80102429:	83 c2 02             	add    $0x2,%edx
8010242c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010242e:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
80102434:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010243b:	39 f0                	cmp    %esi,%eax
8010243d:	75 d1                	jne    80102410 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010243f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102442:	5b                   	pop    %ebx
80102443:	5e                   	pop    %esi
80102444:	5d                   	pop    %ebp
80102445:	c3                   	ret    
80102446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010244d:	8d 76 00             	lea    0x0(%esi),%esi

80102450 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102450:	f3 0f 1e fb          	endbr32 
80102454:	55                   	push   %ebp
  ioapic->reg = reg;
80102455:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
{
8010245b:	89 e5                	mov    %esp,%ebp
8010245d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102460:	8d 50 20             	lea    0x20(%eax),%edx
80102463:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102467:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102469:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010246f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102472:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102475:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102478:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010247a:	a1 54 36 11 80       	mov    0x80113654,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010247f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102482:	89 50 10             	mov    %edx,0x10(%eax)
}
80102485:	5d                   	pop    %ebp
80102486:	c3                   	ret    
80102487:	66 90                	xchg   %ax,%ax
80102489:	66 90                	xchg   %ax,%ax
8010248b:	66 90                	xchg   %ax,%ax
8010248d:	66 90                	xchg   %ax,%ax
8010248f:	90                   	nop

80102490 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102490:	f3 0f 1e fb          	endbr32 
80102494:	55                   	push   %ebp
80102495:	89 e5                	mov    %esp,%ebp
80102497:	53                   	push   %ebx
80102498:	83 ec 04             	sub    $0x4,%esp
8010249b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010249e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024a4:	75 7a                	jne    80102520 <kfree+0x90>
801024a6:	81 fb 08 6c 11 80    	cmp    $0x80116c08,%ebx
801024ac:	72 72                	jb     80102520 <kfree+0x90>
801024ae:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024b4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024b9:	77 65                	ja     80102520 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024bb:	83 ec 04             	sub    $0x4,%esp
801024be:	68 00 10 00 00       	push   $0x1000
801024c3:	6a 01                	push   $0x1
801024c5:	53                   	push   %ebx
801024c6:	e8 25 28 00 00       	call   80104cf0 <memset>

  if(kmem.use_lock)
801024cb:	8b 15 94 36 11 80    	mov    0x80113694,%edx
801024d1:	83 c4 10             	add    $0x10,%esp
801024d4:	85 d2                	test   %edx,%edx
801024d6:	75 20                	jne    801024f8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024d8:	a1 98 36 11 80       	mov    0x80113698,%eax
801024dd:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024df:	a1 94 36 11 80       	mov    0x80113694,%eax
  kmem.freelist = r;
801024e4:	89 1d 98 36 11 80    	mov    %ebx,0x80113698
  if(kmem.use_lock)
801024ea:	85 c0                	test   %eax,%eax
801024ec:	75 22                	jne    80102510 <kfree+0x80>
    release(&kmem.lock);
}
801024ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024f1:	c9                   	leave  
801024f2:	c3                   	ret    
801024f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024f7:	90                   	nop
    acquire(&kmem.lock);
801024f8:	83 ec 0c             	sub    $0xc,%esp
801024fb:	68 60 36 11 80       	push   $0x80113660
80102500:	e8 db 26 00 00       	call   80104be0 <acquire>
80102505:	83 c4 10             	add    $0x10,%esp
80102508:	eb ce                	jmp    801024d8 <kfree+0x48>
8010250a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102510:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
}
80102517:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251a:	c9                   	leave  
    release(&kmem.lock);
8010251b:	e9 80 27 00 00       	jmp    80104ca0 <release>
    panic("kfree");
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 46 7b 10 80       	push   $0x80107b46
80102528:	e8 63 de ff ff       	call   80100390 <panic>
8010252d:	8d 76 00             	lea    0x0(%esi),%esi

80102530 <freerange>:
{
80102530:	f3 0f 1e fb          	endbr32 
80102534:	55                   	push   %ebp
80102535:	89 e5                	mov    %esp,%ebp
80102537:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102538:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010253b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010253e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010253f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102545:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010254b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102551:	39 de                	cmp    %ebx,%esi
80102553:	72 1f                	jb     80102574 <freerange+0x44>
80102555:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102558:	83 ec 0c             	sub    $0xc,%esp
8010255b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102561:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102567:	50                   	push   %eax
80102568:	e8 23 ff ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010256d:	83 c4 10             	add    $0x10,%esp
80102570:	39 f3                	cmp    %esi,%ebx
80102572:	76 e4                	jbe    80102558 <freerange+0x28>
}
80102574:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102577:	5b                   	pop    %ebx
80102578:	5e                   	pop    %esi
80102579:	5d                   	pop    %ebp
8010257a:	c3                   	ret    
8010257b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010257f:	90                   	nop

80102580 <kinit1>:
{
80102580:	f3 0f 1e fb          	endbr32 
80102584:	55                   	push   %ebp
80102585:	89 e5                	mov    %esp,%ebp
80102587:	56                   	push   %esi
80102588:	53                   	push   %ebx
80102589:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010258c:	83 ec 08             	sub    $0x8,%esp
8010258f:	68 4c 7b 10 80       	push   $0x80107b4c
80102594:	68 60 36 11 80       	push   $0x80113660
80102599:	e8 c2 24 00 00       	call   80104a60 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010259e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801025a4:	c7 05 94 36 11 80 00 	movl   $0x0,0x80113694
801025ab:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801025ae:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025b4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ba:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025c0:	39 de                	cmp    %ebx,%esi
801025c2:	72 20                	jb     801025e4 <kinit1+0x64>
801025c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025d7:	50                   	push   %eax
801025d8:	e8 b3 fe ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	39 de                	cmp    %ebx,%esi
801025e2:	73 e4                	jae    801025c8 <kinit1+0x48>
}
801025e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025e7:	5b                   	pop    %ebx
801025e8:	5e                   	pop    %esi
801025e9:	5d                   	pop    %ebp
801025ea:	c3                   	ret    
801025eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025ef:	90                   	nop

801025f0 <kinit2>:
{
801025f0:	f3 0f 1e fb          	endbr32 
801025f4:	55                   	push   %ebp
801025f5:	89 e5                	mov    %esp,%ebp
801025f7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025f8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801025fe:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025ff:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102605:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010260b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102611:	39 de                	cmp    %ebx,%esi
80102613:	72 1f                	jb     80102634 <kinit2+0x44>
80102615:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102618:	83 ec 0c             	sub    $0xc,%esp
8010261b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102621:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102627:	50                   	push   %eax
80102628:	e8 63 fe ff ff       	call   80102490 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	39 de                	cmp    %ebx,%esi
80102632:	73 e4                	jae    80102618 <kinit2+0x28>
  kmem.use_lock = 1;
80102634:	c7 05 94 36 11 80 01 	movl   $0x1,0x80113694
8010263b:	00 00 00 
}
8010263e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102641:	5b                   	pop    %ebx
80102642:	5e                   	pop    %esi
80102643:	5d                   	pop    %ebp
80102644:	c3                   	ret    
80102645:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010264c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102650 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102650:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102654:	a1 94 36 11 80       	mov    0x80113694,%eax
80102659:	85 c0                	test   %eax,%eax
8010265b:	75 1b                	jne    80102678 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010265d:	a1 98 36 11 80       	mov    0x80113698,%eax
  if(r)
80102662:	85 c0                	test   %eax,%eax
80102664:	74 0a                	je     80102670 <kalloc+0x20>
    kmem.freelist = r->next;
80102666:	8b 10                	mov    (%eax),%edx
80102668:	89 15 98 36 11 80    	mov    %edx,0x80113698
  if(kmem.use_lock)
8010266e:	c3                   	ret    
8010266f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102670:	c3                   	ret    
80102671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102678:	55                   	push   %ebp
80102679:	89 e5                	mov    %esp,%ebp
8010267b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010267e:	68 60 36 11 80       	push   $0x80113660
80102683:	e8 58 25 00 00       	call   80104be0 <acquire>
  r = kmem.freelist;
80102688:	a1 98 36 11 80       	mov    0x80113698,%eax
  if(r)
8010268d:	8b 15 94 36 11 80    	mov    0x80113694,%edx
80102693:	83 c4 10             	add    $0x10,%esp
80102696:	85 c0                	test   %eax,%eax
80102698:	74 08                	je     801026a2 <kalloc+0x52>
    kmem.freelist = r->next;
8010269a:	8b 08                	mov    (%eax),%ecx
8010269c:	89 0d 98 36 11 80    	mov    %ecx,0x80113698
  if(kmem.use_lock)
801026a2:	85 d2                	test   %edx,%edx
801026a4:	74 16                	je     801026bc <kalloc+0x6c>
    release(&kmem.lock);
801026a6:	83 ec 0c             	sub    $0xc,%esp
801026a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026ac:	68 60 36 11 80       	push   $0x80113660
801026b1:	e8 ea 25 00 00       	call   80104ca0 <release>
  return (char*)r;
801026b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026b9:	83 c4 10             	add    $0x10,%esp
}
801026bc:	c9                   	leave  
801026bd:	c3                   	ret    
801026be:	66 90                	xchg   %ax,%ax

801026c0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801026c0:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026c4:	ba 64 00 00 00       	mov    $0x64,%edx
801026c9:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026ca:	a8 01                	test   $0x1,%al
801026cc:	0f 84 be 00 00 00    	je     80102790 <kbdgetc+0xd0>
{
801026d2:	55                   	push   %ebp
801026d3:	ba 60 00 00 00       	mov    $0x60,%edx
801026d8:	89 e5                	mov    %esp,%ebp
801026da:	53                   	push   %ebx
801026db:	ec                   	in     (%dx),%al
  return data;
801026dc:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx
    return -1;
  data = inb(KBDATAP);
801026e2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801026e5:	3c e0                	cmp    $0xe0,%al
801026e7:	74 57                	je     80102740 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026e9:	89 d9                	mov    %ebx,%ecx
801026eb:	83 e1 40             	and    $0x40,%ecx
801026ee:	84 c0                	test   %al,%al
801026f0:	78 5e                	js     80102750 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026f2:	85 c9                	test   %ecx,%ecx
801026f4:	74 09                	je     801026ff <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026f6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026f9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801026fc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801026ff:	0f b6 8a 80 7c 10 80 	movzbl -0x7fef8380(%edx),%ecx
  shift ^= togglecode[data];
80102706:	0f b6 82 80 7b 10 80 	movzbl -0x7fef8480(%edx),%eax
  shift |= shiftcode[data];
8010270d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010270f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102711:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102713:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102719:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010271c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010271f:	8b 04 85 60 7b 10 80 	mov    -0x7fef84a0(,%eax,4),%eax
80102726:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010272a:	74 0b                	je     80102737 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010272c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010272f:	83 fa 19             	cmp    $0x19,%edx
80102732:	77 44                	ja     80102778 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102734:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102737:	5b                   	pop    %ebx
80102738:	5d                   	pop    %ebp
80102739:	c3                   	ret    
8010273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102740:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102743:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102745:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
}
8010274b:	5b                   	pop    %ebx
8010274c:	5d                   	pop    %ebp
8010274d:	c3                   	ret    
8010274e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102750:	83 e0 7f             	and    $0x7f,%eax
80102753:	85 c9                	test   %ecx,%ecx
80102755:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102758:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010275a:	0f b6 8a 80 7c 10 80 	movzbl -0x7fef8380(%edx),%ecx
80102761:	83 c9 40             	or     $0x40,%ecx
80102764:	0f b6 c9             	movzbl %cl,%ecx
80102767:	f7 d1                	not    %ecx
80102769:	21 d9                	and    %ebx,%ecx
}
8010276b:	5b                   	pop    %ebx
8010276c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
8010276d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102773:	c3                   	ret    
80102774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102778:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010277b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010277e:	5b                   	pop    %ebx
8010277f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102780:	83 f9 1a             	cmp    $0x1a,%ecx
80102783:	0f 42 c2             	cmovb  %edx,%eax
}
80102786:	c3                   	ret    
80102787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278e:	66 90                	xchg   %ax,%ax
    return -1;
80102790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102795:	c3                   	ret    
80102796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010279d:	8d 76 00             	lea    0x0(%esi),%esi

801027a0 <kbdintr>:

void
kbdintr(void)
{
801027a0:	f3 0f 1e fb          	endbr32 
801027a4:	55                   	push   %ebp
801027a5:	89 e5                	mov    %esp,%ebp
801027a7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027aa:	68 c0 26 10 80       	push   $0x801026c0
801027af:	e8 ac e0 ff ff       	call   80100860 <consoleintr>
}
801027b4:	83 c4 10             	add    $0x10,%esp
801027b7:	c9                   	leave  
801027b8:	c3                   	ret    
801027b9:	66 90                	xchg   %ax,%ax
801027bb:	66 90                	xchg   %ax,%ax
801027bd:	66 90                	xchg   %ax,%ax
801027bf:	90                   	nop

801027c0 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801027c0:	f3 0f 1e fb          	endbr32 
  if(!lapic)
801027c4:	a1 9c 36 11 80       	mov    0x8011369c,%eax
801027c9:	85 c0                	test   %eax,%eax
801027cb:	0f 84 c7 00 00 00    	je     80102898 <lapicinit+0xd8>
  lapic[index] = value;
801027d1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027d8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027db:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027de:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027e5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027eb:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027f2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027f5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027ff:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102802:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102805:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010280c:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010280f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102812:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102819:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010281c:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010281f:	8b 50 30             	mov    0x30(%eax),%edx
80102822:	c1 ea 10             	shr    $0x10,%edx
80102825:	81 e2 fc 00 00 00    	and    $0xfc,%edx
8010282b:	75 73                	jne    801028a0 <lapicinit+0xe0>
  lapic[index] = value;
8010282d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102834:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102837:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102841:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102844:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102847:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010284e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102851:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102854:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
8010285b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010285e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102861:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102868:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010286e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102875:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102878:	8b 50 20             	mov    0x20(%eax),%edx
8010287b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010287f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102880:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102886:	80 e6 10             	and    $0x10,%dh
80102889:	75 f5                	jne    80102880 <lapicinit+0xc0>
  lapic[index] = value;
8010288b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102892:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102895:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102898:	c3                   	ret    
80102899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028a0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028a7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028aa:	8b 50 20             	mov    0x20(%eax),%edx
}
801028ad:	e9 7b ff ff ff       	jmp    8010282d <lapicinit+0x6d>
801028b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028c0 <lapicid>:

int
lapicid(void)
{
801028c0:	f3 0f 1e fb          	endbr32 
  if (!lapic)
801028c4:	a1 9c 36 11 80       	mov    0x8011369c,%eax
801028c9:	85 c0                	test   %eax,%eax
801028cb:	74 0b                	je     801028d8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801028cd:	8b 40 20             	mov    0x20(%eax),%eax
801028d0:	c1 e8 18             	shr    $0x18,%eax
801028d3:	c3                   	ret    
801028d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801028d8:	31 c0                	xor    %eax,%eax
}
801028da:	c3                   	ret    
801028db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028df:	90                   	nop

801028e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801028e0:	f3 0f 1e fb          	endbr32 
  if(lapic)
801028e4:	a1 9c 36 11 80       	mov    0x8011369c,%eax
801028e9:	85 c0                	test   %eax,%eax
801028eb:	74 0d                	je     801028fa <lapiceoi+0x1a>
  lapic[index] = value;
801028ed:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028f7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028fa:	c3                   	ret    
801028fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028ff:	90                   	nop

80102900 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102900:	f3 0f 1e fb          	endbr32 
}
80102904:	c3                   	ret    
80102905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102910:	f3 0f 1e fb          	endbr32 
80102914:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102915:	b8 0f 00 00 00       	mov    $0xf,%eax
8010291a:	ba 70 00 00 00       	mov    $0x70,%edx
8010291f:	89 e5                	mov    %esp,%ebp
80102921:	53                   	push   %ebx
80102922:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102925:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102928:	ee                   	out    %al,(%dx)
80102929:	b8 0a 00 00 00       	mov    $0xa,%eax
8010292e:	ba 71 00 00 00       	mov    $0x71,%edx
80102933:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102934:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102936:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102939:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010293f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102941:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102944:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102946:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102949:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
8010294c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102952:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102957:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010295d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102960:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102967:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010296a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010296d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102974:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102977:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010297a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102980:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102983:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102989:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010298c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102992:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102995:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
8010299b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
8010299c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010299f:	5d                   	pop    %ebp
801029a0:	c3                   	ret    
801029a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029af:	90                   	nop

801029b0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029b0:	f3 0f 1e fb          	endbr32 
801029b4:	55                   	push   %ebp
801029b5:	b8 0b 00 00 00       	mov    $0xb,%eax
801029ba:	ba 70 00 00 00       	mov    $0x70,%edx
801029bf:	89 e5                	mov    %esp,%ebp
801029c1:	57                   	push   %edi
801029c2:	56                   	push   %esi
801029c3:	53                   	push   %ebx
801029c4:	83 ec 4c             	sub    $0x4c,%esp
801029c7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c8:	ba 71 00 00 00       	mov    $0x71,%edx
801029cd:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ce:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d1:	bb 70 00 00 00       	mov    $0x70,%ebx
801029d6:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029e0:	31 c0                	xor    %eax,%eax
801029e2:	89 da                	mov    %ebx,%edx
801029e4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e5:	b9 71 00 00 00       	mov    $0x71,%ecx
801029ea:	89 ca                	mov    %ecx,%edx
801029ec:	ec                   	in     (%dx),%al
801029ed:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f0:	89 da                	mov    %ebx,%edx
801029f2:	b8 02 00 00 00       	mov    $0x2,%eax
801029f7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f8:	89 ca                	mov    %ecx,%edx
801029fa:	ec                   	in     (%dx),%al
801029fb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fe:	89 da                	mov    %ebx,%edx
80102a00:	b8 04 00 00 00       	mov    $0x4,%eax
80102a05:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a06:	89 ca                	mov    %ecx,%edx
80102a08:	ec                   	in     (%dx),%al
80102a09:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a0c:	89 da                	mov    %ebx,%edx
80102a0e:	b8 07 00 00 00       	mov    $0x7,%eax
80102a13:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a14:	89 ca                	mov    %ecx,%edx
80102a16:	ec                   	in     (%dx),%al
80102a17:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a1a:	89 da                	mov    %ebx,%edx
80102a1c:	b8 08 00 00 00       	mov    $0x8,%eax
80102a21:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a22:	89 ca                	mov    %ecx,%edx
80102a24:	ec                   	in     (%dx),%al
80102a25:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a27:	89 da                	mov    %ebx,%edx
80102a29:	b8 09 00 00 00       	mov    $0x9,%eax
80102a2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2f:	89 ca                	mov    %ecx,%edx
80102a31:	ec                   	in     (%dx),%al
80102a32:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a34:	89 da                	mov    %ebx,%edx
80102a36:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a3f:	84 c0                	test   %al,%al
80102a41:	78 9d                	js     801029e0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102a43:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a47:	89 fa                	mov    %edi,%edx
80102a49:	0f b6 fa             	movzbl %dl,%edi
80102a4c:	89 f2                	mov    %esi,%edx
80102a4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a51:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a55:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a58:	89 da                	mov    %ebx,%edx
80102a5a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a5d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a60:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a64:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a67:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a6a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a6e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a71:	31 c0                	xor    %eax,%eax
80102a73:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a74:	89 ca                	mov    %ecx,%edx
80102a76:	ec                   	in     (%dx),%al
80102a77:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a7a:	89 da                	mov    %ebx,%edx
80102a7c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a7f:	b8 02 00 00 00       	mov    $0x2,%eax
80102a84:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a85:	89 ca                	mov    %ecx,%edx
80102a87:	ec                   	in     (%dx),%al
80102a88:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8b:	89 da                	mov    %ebx,%edx
80102a8d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a90:	b8 04 00 00 00       	mov    $0x4,%eax
80102a95:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a96:	89 ca                	mov    %ecx,%edx
80102a98:	ec                   	in     (%dx),%al
80102a99:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a9c:	89 da                	mov    %ebx,%edx
80102a9e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102aa1:	b8 07 00 00 00       	mov    $0x7,%eax
80102aa6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aa7:	89 ca                	mov    %ecx,%edx
80102aa9:	ec                   	in     (%dx),%al
80102aaa:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aad:	89 da                	mov    %ebx,%edx
80102aaf:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102ab2:	b8 08 00 00 00       	mov    $0x8,%eax
80102ab7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab8:	89 ca                	mov    %ecx,%edx
80102aba:	ec                   	in     (%dx),%al
80102abb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102abe:	89 da                	mov    %ebx,%edx
80102ac0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102ac3:	b8 09 00 00 00       	mov    $0x9,%eax
80102ac8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac9:	89 ca                	mov    %ecx,%edx
80102acb:	ec                   	in     (%dx),%al
80102acc:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102acf:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ad2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ad5:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ad8:	6a 18                	push   $0x18
80102ada:	50                   	push   %eax
80102adb:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ade:	50                   	push   %eax
80102adf:	e8 5c 22 00 00       	call   80104d40 <memcmp>
80102ae4:	83 c4 10             	add    $0x10,%esp
80102ae7:	85 c0                	test   %eax,%eax
80102ae9:	0f 85 f1 fe ff ff    	jne    801029e0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102aef:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102af3:	75 78                	jne    80102b6d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102af5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102af8:	89 c2                	mov    %eax,%edx
80102afa:	83 e0 0f             	and    $0xf,%eax
80102afd:	c1 ea 04             	shr    $0x4,%edx
80102b00:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b03:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b06:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b09:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b0c:	89 c2                	mov    %eax,%edx
80102b0e:	83 e0 0f             	and    $0xf,%eax
80102b11:	c1 ea 04             	shr    $0x4,%edx
80102b14:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b17:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1a:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b1d:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b20:	89 c2                	mov    %eax,%edx
80102b22:	83 e0 0f             	and    $0xf,%eax
80102b25:	c1 ea 04             	shr    $0x4,%edx
80102b28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b31:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b34:	89 c2                	mov    %eax,%edx
80102b36:	83 e0 0f             	and    $0xf,%eax
80102b39:	c1 ea 04             	shr    $0x4,%edx
80102b3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b42:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b45:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b48:	89 c2                	mov    %eax,%edx
80102b4a:	83 e0 0f             	and    $0xf,%eax
80102b4d:	c1 ea 04             	shr    $0x4,%edx
80102b50:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b53:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b56:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b59:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b5c:	89 c2                	mov    %eax,%edx
80102b5e:	83 e0 0f             	and    $0xf,%eax
80102b61:	c1 ea 04             	shr    $0x4,%edx
80102b64:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b67:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b6d:	8b 75 08             	mov    0x8(%ebp),%esi
80102b70:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b73:	89 06                	mov    %eax,(%esi)
80102b75:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b78:	89 46 04             	mov    %eax,0x4(%esi)
80102b7b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b7e:	89 46 08             	mov    %eax,0x8(%esi)
80102b81:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b84:	89 46 0c             	mov    %eax,0xc(%esi)
80102b87:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b8a:	89 46 10             	mov    %eax,0x10(%esi)
80102b8d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b90:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b93:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b9d:	5b                   	pop    %ebx
80102b9e:	5e                   	pop    %esi
80102b9f:	5f                   	pop    %edi
80102ba0:	5d                   	pop    %ebp
80102ba1:	c3                   	ret    
80102ba2:	66 90                	xchg   %ax,%ax
80102ba4:	66 90                	xchg   %ax,%ax
80102ba6:	66 90                	xchg   %ax,%ax
80102ba8:	66 90                	xchg   %ax,%ax
80102baa:	66 90                	xchg   %ax,%ax
80102bac:	66 90                	xchg   %ax,%ax
80102bae:	66 90                	xchg   %ax,%ax

80102bb0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bb0:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102bb6:	85 c9                	test   %ecx,%ecx
80102bb8:	0f 8e 8a 00 00 00    	jle    80102c48 <install_trans+0x98>
{
80102bbe:	55                   	push   %ebp
80102bbf:	89 e5                	mov    %esp,%ebp
80102bc1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bc2:	31 ff                	xor    %edi,%edi
{
80102bc4:	56                   	push   %esi
80102bc5:	53                   	push   %ebx
80102bc6:	83 ec 0c             	sub    $0xc,%esp
80102bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bd0:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102bd5:	83 ec 08             	sub    $0x8,%esp
80102bd8:	01 f8                	add    %edi,%eax
80102bda:	83 c0 01             	add    $0x1,%eax
80102bdd:	50                   	push   %eax
80102bde:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102be4:	e8 e7 d4 ff ff       	call   801000d0 <bread>
80102be9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102beb:	58                   	pop    %eax
80102bec:	5a                   	pop    %edx
80102bed:	ff 34 bd ec 36 11 80 	pushl  -0x7feec914(,%edi,4)
80102bf4:	ff 35 e4 36 11 80    	pushl  0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bfa:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfd:	e8 ce d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c02:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c05:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c07:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c0a:	68 00 02 00 00       	push   $0x200
80102c0f:	50                   	push   %eax
80102c10:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c13:	50                   	push   %eax
80102c14:	e8 77 21 00 00       	call   80104d90 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c19:	89 1c 24             	mov    %ebx,(%esp)
80102c1c:	e8 8f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c21:	89 34 24             	mov    %esi,(%esp)
80102c24:	e8 c7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 bf d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	39 3d e8 36 11 80    	cmp    %edi,0x801136e8
80102c3a:	7f 94                	jg     80102bd0 <install_trans+0x20>
  }
}
80102c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c3f:	5b                   	pop    %ebx
80102c40:	5e                   	pop    %esi
80102c41:	5f                   	pop    %edi
80102c42:	5d                   	pop    %ebp
80102c43:	c3                   	ret    
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c48:	c3                   	ret    
80102c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c50 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c57:	ff 35 d4 36 11 80    	pushl  0x801136d4
80102c5d:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102c63:	e8 68 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c68:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c6b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c6d:	a1 e8 36 11 80       	mov    0x801136e8,%eax
80102c72:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c75:	85 c0                	test   %eax,%eax
80102c77:	7e 19                	jle    80102c92 <write_head+0x42>
80102c79:	31 d2                	xor    %edx,%edx
80102c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c7f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c80:	8b 0c 95 ec 36 11 80 	mov    -0x7feec914(,%edx,4),%ecx
80102c87:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c8b:	83 c2 01             	add    $0x1,%edx
80102c8e:	39 d0                	cmp    %edx,%eax
80102c90:	75 ee                	jne    80102c80 <write_head+0x30>
  }
  bwrite(buf);
80102c92:	83 ec 0c             	sub    $0xc,%esp
80102c95:	53                   	push   %ebx
80102c96:	e8 15 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c9b:	89 1c 24             	mov    %ebx,(%esp)
80102c9e:	e8 4d d5 ff ff       	call   801001f0 <brelse>
}
80102ca3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ca6:	83 c4 10             	add    $0x10,%esp
80102ca9:	c9                   	leave  
80102caa:	c3                   	ret    
80102cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102caf:	90                   	nop

80102cb0 <initlog>:
{
80102cb0:	f3 0f 1e fb          	endbr32 
80102cb4:	55                   	push   %ebp
80102cb5:	89 e5                	mov    %esp,%ebp
80102cb7:	53                   	push   %ebx
80102cb8:	83 ec 2c             	sub    $0x2c,%esp
80102cbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cbe:	68 80 7d 10 80       	push   $0x80107d80
80102cc3:	68 a0 36 11 80       	push   $0x801136a0
80102cc8:	e8 93 1d 00 00       	call   80104a60 <initlock>
  readsb(dev, &sb);
80102ccd:	58                   	pop    %eax
80102cce:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cd1:	5a                   	pop    %edx
80102cd2:	50                   	push   %eax
80102cd3:	53                   	push   %ebx
80102cd4:	e8 47 e8 ff ff       	call   80101520 <readsb>
  log.start = sb.logstart;
80102cd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cdc:	59                   	pop    %ecx
  log.dev = dev;
80102cdd:	89 1d e4 36 11 80    	mov    %ebx,0x801136e4
  log.size = sb.nlog;
80102ce3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ce6:	a3 d4 36 11 80       	mov    %eax,0x801136d4
  log.size = sb.nlog;
80102ceb:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
  struct buf *buf = bread(log.dev, log.start);
80102cf1:	5a                   	pop    %edx
80102cf2:	50                   	push   %eax
80102cf3:	53                   	push   %ebx
80102cf4:	e8 d7 d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102cf9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102cfc:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102cff:	89 0d e8 36 11 80    	mov    %ecx,0x801136e8
  for (i = 0; i < log.lh.n; i++) {
80102d05:	85 c9                	test   %ecx,%ecx
80102d07:	7e 19                	jle    80102d22 <initlog+0x72>
80102d09:	31 d2                	xor    %edx,%edx
80102d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d0f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102d10:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102d14:	89 1c 95 ec 36 11 80 	mov    %ebx,-0x7feec914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d1b:	83 c2 01             	add    $0x1,%edx
80102d1e:	39 d1                	cmp    %edx,%ecx
80102d20:	75 ee                	jne    80102d10 <initlog+0x60>
  brelse(buf);
80102d22:	83 ec 0c             	sub    $0xc,%esp
80102d25:	50                   	push   %eax
80102d26:	e8 c5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d2b:	e8 80 fe ff ff       	call   80102bb0 <install_trans>
  log.lh.n = 0;
80102d30:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102d37:	00 00 00 
  write_head(); // clear the log
80102d3a:	e8 11 ff ff ff       	call   80102c50 <write_head>
}
80102d3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d42:	83 c4 10             	add    $0x10,%esp
80102d45:	c9                   	leave  
80102d46:	c3                   	ret    
80102d47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d4e:	66 90                	xchg   %ax,%ax

80102d50 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d50:	f3 0f 1e fb          	endbr32 
80102d54:	55                   	push   %ebp
80102d55:	89 e5                	mov    %esp,%ebp
80102d57:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d5a:	68 a0 36 11 80       	push   $0x801136a0
80102d5f:	e8 7c 1e 00 00       	call   80104be0 <acquire>
80102d64:	83 c4 10             	add    $0x10,%esp
80102d67:	eb 1c                	jmp    80102d85 <begin_op+0x35>
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d70:	83 ec 08             	sub    $0x8,%esp
80102d73:	68 a0 36 11 80       	push   $0x801136a0
80102d78:	68 a0 36 11 80       	push   $0x801136a0
80102d7d:	e8 fe 15 00 00       	call   80104380 <sleep>
80102d82:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d85:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102d8a:	85 c0                	test   %eax,%eax
80102d8c:	75 e2                	jne    80102d70 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d8e:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102d93:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80102d99:	83 c0 01             	add    $0x1,%eax
80102d9c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d9f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102da2:	83 fa 1e             	cmp    $0x1e,%edx
80102da5:	7f c9                	jg     80102d70 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102da7:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102daa:	a3 dc 36 11 80       	mov    %eax,0x801136dc
      release(&log.lock);
80102daf:	68 a0 36 11 80       	push   $0x801136a0
80102db4:	e8 e7 1e 00 00       	call   80104ca0 <release>
      break;
    }
  }
}
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	c9                   	leave  
80102dbd:	c3                   	ret    
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dc0:	f3 0f 1e fb          	endbr32 
80102dc4:	55                   	push   %ebp
80102dc5:	89 e5                	mov    %esp,%ebp
80102dc7:	57                   	push   %edi
80102dc8:	56                   	push   %esi
80102dc9:	53                   	push   %ebx
80102dca:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dcd:	68 a0 36 11 80       	push   $0x801136a0
80102dd2:	e8 09 1e 00 00       	call   80104be0 <acquire>
  log.outstanding -= 1;
80102dd7:	a1 dc 36 11 80       	mov    0x801136dc,%eax
  if(log.committing)
80102ddc:	8b 35 e0 36 11 80    	mov    0x801136e0,%esi
80102de2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102de5:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102de8:	89 1d dc 36 11 80    	mov    %ebx,0x801136dc
  if(log.committing)
80102dee:	85 f6                	test   %esi,%esi
80102df0:	0f 85 1e 01 00 00    	jne    80102f14 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102df6:	85 db                	test   %ebx,%ebx
80102df8:	0f 85 f2 00 00 00    	jne    80102ef0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dfe:	c7 05 e0 36 11 80 01 	movl   $0x1,0x801136e0
80102e05:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e08:	83 ec 0c             	sub    $0xc,%esp
80102e0b:	68 a0 36 11 80       	push   $0x801136a0
80102e10:	e8 8b 1e 00 00       	call   80104ca0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e15:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80102e1b:	83 c4 10             	add    $0x10,%esp
80102e1e:	85 c9                	test   %ecx,%ecx
80102e20:	7f 3e                	jg     80102e60 <end_op+0xa0>
    acquire(&log.lock);
80102e22:	83 ec 0c             	sub    $0xc,%esp
80102e25:	68 a0 36 11 80       	push   $0x801136a0
80102e2a:	e8 b1 1d 00 00       	call   80104be0 <acquire>
    wakeup(&log);
80102e2f:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
    log.committing = 0;
80102e36:	c7 05 e0 36 11 80 00 	movl   $0x0,0x801136e0
80102e3d:	00 00 00 
    wakeup(&log);
80102e40:	e8 9b 18 00 00       	call   801046e0 <wakeup>
    release(&log.lock);
80102e45:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102e4c:	e8 4f 1e 00 00       	call   80104ca0 <release>
80102e51:	83 c4 10             	add    $0x10,%esp
}
80102e54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e57:	5b                   	pop    %ebx
80102e58:	5e                   	pop    %esi
80102e59:	5f                   	pop    %edi
80102e5a:	5d                   	pop    %ebp
80102e5b:	c3                   	ret    
80102e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e60:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102e65:	83 ec 08             	sub    $0x8,%esp
80102e68:	01 d8                	add    %ebx,%eax
80102e6a:	83 c0 01             	add    $0x1,%eax
80102e6d:	50                   	push   %eax
80102e6e:	ff 35 e4 36 11 80    	pushl  0x801136e4
80102e74:	e8 57 d2 ff ff       	call   801000d0 <bread>
80102e79:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e7b:	58                   	pop    %eax
80102e7c:	5a                   	pop    %edx
80102e7d:	ff 34 9d ec 36 11 80 	pushl  -0x7feec914(,%ebx,4)
80102e84:	ff 35 e4 36 11 80    	pushl  0x801136e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e8a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8d:	e8 3e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e92:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e95:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e97:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e9a:	68 00 02 00 00       	push   $0x200
80102e9f:	50                   	push   %eax
80102ea0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ea3:	50                   	push   %eax
80102ea4:	e8 e7 1e 00 00       	call   80104d90 <memmove>
    bwrite(to);  // write the log
80102ea9:	89 34 24             	mov    %esi,(%esp)
80102eac:	e8 ff d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102eb1:	89 3c 24             	mov    %edi,(%esp)
80102eb4:	e8 37 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 2f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ec1:	83 c4 10             	add    $0x10,%esp
80102ec4:	3b 1d e8 36 11 80    	cmp    0x801136e8,%ebx
80102eca:	7c 94                	jl     80102e60 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ecc:	e8 7f fd ff ff       	call   80102c50 <write_head>
    install_trans(); // Now install writes to home locations
80102ed1:	e8 da fc ff ff       	call   80102bb0 <install_trans>
    log.lh.n = 0;
80102ed6:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
80102edd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ee0:	e8 6b fd ff ff       	call   80102c50 <write_head>
80102ee5:	e9 38 ff ff ff       	jmp    80102e22 <end_op+0x62>
80102eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ef0:	83 ec 0c             	sub    $0xc,%esp
80102ef3:	68 a0 36 11 80       	push   $0x801136a0
80102ef8:	e8 e3 17 00 00       	call   801046e0 <wakeup>
  release(&log.lock);
80102efd:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
80102f04:	e8 97 1d 00 00       	call   80104ca0 <release>
80102f09:	83 c4 10             	add    $0x10,%esp
}
80102f0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f0f:	5b                   	pop    %ebx
80102f10:	5e                   	pop    %esi
80102f11:	5f                   	pop    %edi
80102f12:	5d                   	pop    %ebp
80102f13:	c3                   	ret    
    panic("log.committing");
80102f14:	83 ec 0c             	sub    $0xc,%esp
80102f17:	68 84 7d 10 80       	push   $0x80107d84
80102f1c:	e8 6f d4 ff ff       	call   80100390 <panic>
80102f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f2f:	90                   	nop

80102f30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f30:	f3 0f 1e fb          	endbr32 
80102f34:	55                   	push   %ebp
80102f35:	89 e5                	mov    %esp,%ebp
80102f37:	53                   	push   %ebx
80102f38:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f3b:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
{
80102f41:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f44:	83 fa 1d             	cmp    $0x1d,%edx
80102f47:	0f 8f 91 00 00 00    	jg     80102fde <log_write+0xae>
80102f4d:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102f52:	83 e8 01             	sub    $0x1,%eax
80102f55:	39 c2                	cmp    %eax,%edx
80102f57:	0f 8d 81 00 00 00    	jge    80102fde <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f5d:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102f62:	85 c0                	test   %eax,%eax
80102f64:	0f 8e 81 00 00 00    	jle    80102feb <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f6a:	83 ec 0c             	sub    $0xc,%esp
80102f6d:	68 a0 36 11 80       	push   $0x801136a0
80102f72:	e8 69 1c 00 00       	call   80104be0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f77:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80102f7d:	83 c4 10             	add    $0x10,%esp
80102f80:	85 d2                	test   %edx,%edx
80102f82:	7e 4e                	jle    80102fd2 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f84:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f87:	31 c0                	xor    %eax,%eax
80102f89:	eb 0c                	jmp    80102f97 <log_write+0x67>
80102f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f8f:	90                   	nop
80102f90:	83 c0 01             	add    $0x1,%eax
80102f93:	39 c2                	cmp    %eax,%edx
80102f95:	74 29                	je     80102fc0 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f97:	39 0c 85 ec 36 11 80 	cmp    %ecx,-0x7feec914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 85 ec 36 11 80 	mov    %ecx,-0x7feec914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fad:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
}
80102fb4:	c9                   	leave  
  release(&log.lock);
80102fb5:	e9 e6 1c 00 00       	jmp    80104ca0 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fc0:	89 0c 95 ec 36 11 80 	mov    %ecx,-0x7feec914(,%edx,4)
    log.lh.n++;
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 36 11 80    	mov    %edx,0x801136e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 36 11 80       	mov    %eax,0x801136ec
  if (i == log.lh.n)
80102fda:	75 cb                	jne    80102fa7 <log_write+0x77>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x97>
    panic("too big a transaction");
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 93 7d 10 80       	push   $0x80107d93
80102fe6:	e8 a5 d3 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 a9 7d 10 80       	push   $0x80107da9
80102ff3:	e8 98 d3 ff ff       	call   80100390 <panic>
80102ff8:	66 90                	xchg   %ax,%ax
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103007:	e8 f4 09 00 00       	call   80103a00 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 ed 09 00 00       	call   80103a00 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 c4 7d 10 80       	push   $0x80107dc4
8010301d:	e8 8e d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103022:	e8 b9 30 00 00       	call   801060e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103027:	e8 64 09 00 00       	call   80103990 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010303a:	e8 01 0f 00 00       	call   80103f40 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
{
80103040:	f3 0f 1e fb          	endbr32 
80103044:	55                   	push   %ebp
80103045:	89 e5                	mov    %esp,%ebp
80103047:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010304a:	e8 a1 41 00 00       	call   801071f0 <switchkvm>
  seginit();
8010304f:	e8 0c 41 00 00       	call   80107160 <seginit>
  lapicinit();
80103054:	e8 67 f7 ff ff       	call   801027c0 <lapicinit>
  mpmain();
80103059:	e8 a2 ff ff ff       	call   80103000 <mpmain>
8010305e:	66 90                	xchg   %ax,%ax

80103060 <main>:
{
80103060:	f3 0f 1e fb          	endbr32 
80103064:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103068:	83 e4 f0             	and    $0xfffffff0,%esp
8010306b:	ff 71 fc             	pushl  -0x4(%ecx)
8010306e:	55                   	push   %ebp
8010306f:	89 e5                	mov    %esp,%ebp
80103071:	53                   	push   %ebx
80103072:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 40 80       	push   $0x80400000
8010307b:	68 08 6c 11 80       	push   $0x80116c08
80103080:	e8 fb f4 ff ff       	call   80102580 <kinit1>
  kvmalloc();      // kernel page table
80103085:	e8 46 46 00 00       	call   801076d0 <kvmalloc>
  mpinit();        // detect other processors
8010308a:	e8 81 01 00 00       	call   80103210 <mpinit>
  lapicinit();     // interrupt controller
8010308f:	e8 2c f7 ff ff       	call   801027c0 <lapicinit>
  seginit();       // segment descriptors
80103094:	e8 c7 40 00 00       	call   80107160 <seginit>
  picinit();       // disable pic
80103099:	e8 52 03 00 00       	call   801033f0 <picinit>
  ioapicinit();    // another interrupt controller
8010309e:	e8 fd f2 ff ff       	call   801023a0 <ioapicinit>
  consoleinit();   // console hardware
801030a3:	e8 88 d9 ff ff       	call   80100a30 <consoleinit>
  uartinit();      // serial port
801030a8:	e8 73 33 00 00       	call   80106420 <uartinit>
  pinit();         // process table
801030ad:	e8 ae 08 00 00       	call   80103960 <pinit>
  tvinit();        // trap vectors
801030b2:	e8 a9 2f 00 00       	call   80106060 <tvinit>
  binit();         // buffer cache
801030b7:	e8 84 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030bc:	e8 3f dd ff ff       	call   80100e00 <fileinit>
  ideinit();       // disk 
801030c1:	e8 aa f0 ff ff       	call   80102170 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030c6:	83 c4 0c             	add    $0xc,%esp
801030c9:	68 8a 00 00 00       	push   $0x8a
801030ce:	68 8c b4 10 80       	push   $0x8010b48c
801030d3:	68 00 70 00 80       	push   $0x80007000
801030d8:	e8 b3 1c 00 00       	call   80104d90 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030dd:	83 c4 10             	add    $0x10,%esp
801030e0:	69 05 20 3d 11 80 b0 	imul   $0xb0,0x80113d20,%eax
801030e7:	00 00 00 
801030ea:	05 a0 37 11 80       	add    $0x801137a0,%eax
801030ef:	3d a0 37 11 80       	cmp    $0x801137a0,%eax
801030f4:	76 7a                	jbe    80103170 <main+0x110>
801030f6:	bb a0 37 11 80       	mov    $0x801137a0,%ebx
801030fb:	eb 1c                	jmp    80103119 <main+0xb9>
801030fd:	8d 76 00             	lea    0x0(%esi),%esi
80103100:	69 05 20 3d 11 80 b0 	imul   $0xb0,0x80113d20,%eax
80103107:	00 00 00 
8010310a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103110:	05 a0 37 11 80       	add    $0x801137a0,%eax
80103115:	39 c3                	cmp    %eax,%ebx
80103117:	73 57                	jae    80103170 <main+0x110>
    if(c == mycpu())  // We've started already.
80103119:	e8 72 08 00 00       	call   80103990 <mycpu>
8010311e:	39 c3                	cmp    %eax,%ebx
80103120:	74 de                	je     80103100 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103122:	e8 29 f5 ff ff       	call   80102650 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103127:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010312a:	c7 05 f8 6f 00 80 40 	movl   $0x80103040,0x80006ff8
80103131:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103134:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010313b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010313e:	05 00 10 00 00       	add    $0x1000,%eax
80103143:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103148:	0f b6 03             	movzbl (%ebx),%eax
8010314b:	68 00 70 00 00       	push   $0x7000
80103150:	50                   	push   %eax
80103151:	e8 ba f7 ff ff       	call   80102910 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103156:	83 c4 10             	add    $0x10,%esp
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103166:	85 c0                	test   %eax,%eax
80103168:	74 f6                	je     80103160 <main+0x100>
8010316a:	eb 94                	jmp    80103100 <main+0xa0>
8010316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103170:	83 ec 08             	sub    $0x8,%esp
80103173:	68 00 00 00 8e       	push   $0x8e000000
80103178:	68 00 00 40 80       	push   $0x80400000
8010317d:	e8 6e f4 ff ff       	call   801025f0 <kinit2>
  userinit();      // first user process
80103182:	e8 c9 08 00 00       	call   80103a50 <userinit>
  mpmain();        // finish this processor's setup
80103187:	e8 74 fe ff ff       	call   80103000 <mpmain>
8010318c:	66 90                	xchg   %ax,%ax
8010318e:	66 90                	xchg   %ax,%ax

80103190 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103195:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010319b:	53                   	push   %ebx
  e = addr+len;
8010319c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010319f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031a2:	39 de                	cmp    %ebx,%esi
801031a4:	72 10                	jb     801031b6 <mpsearch1+0x26>
801031a6:	eb 50                	jmp    801031f8 <mpsearch1+0x68>
801031a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031af:	90                   	nop
801031b0:	89 fe                	mov    %edi,%esi
801031b2:	39 fb                	cmp    %edi,%ebx
801031b4:	76 42                	jbe    801031f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031b6:	83 ec 04             	sub    $0x4,%esp
801031b9:	8d 7e 10             	lea    0x10(%esi),%edi
801031bc:	6a 04                	push   $0x4
801031be:	68 d8 7d 10 80       	push   $0x80107dd8
801031c3:	56                   	push   %esi
801031c4:	e8 77 1b 00 00       	call   80104d40 <memcmp>
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	85 c0                	test   %eax,%eax
801031ce:	75 e0                	jne    801031b0 <mpsearch1+0x20>
801031d0:	89 f2                	mov    %esi,%edx
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031d8:	0f b6 0a             	movzbl (%edx),%ecx
801031db:	83 c2 01             	add    $0x1,%edx
801031de:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031e0:	39 fa                	cmp    %edi,%edx
801031e2:	75 f4                	jne    801031d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031e4:	84 c0                	test   %al,%al
801031e6:	75 c8                	jne    801031b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031eb:	89 f0                	mov    %esi,%eax
801031ed:	5b                   	pop    %ebx
801031ee:	5e                   	pop    %esi
801031ef:	5f                   	pop    %edi
801031f0:	5d                   	pop    %ebp
801031f1:	c3                   	ret    
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031fb:	31 f6                	xor    %esi,%esi
}
801031fd:	5b                   	pop    %ebx
801031fe:	89 f0                	mov    %esi,%eax
80103200:	5e                   	pop    %esi
80103201:	5f                   	pop    %edi
80103202:	5d                   	pop    %ebp
80103203:	c3                   	ret    
80103204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010320f:	90                   	nop

80103210 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103210:	f3 0f 1e fb          	endbr32 
80103214:	55                   	push   %ebp
80103215:	89 e5                	mov    %esp,%ebp
80103217:	57                   	push   %edi
80103218:	56                   	push   %esi
80103219:	53                   	push   %ebx
8010321a:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010321d:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103224:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
8010322b:	c1 e0 08             	shl    $0x8,%eax
8010322e:	09 d0                	or     %edx,%eax
80103230:	c1 e0 04             	shl    $0x4,%eax
80103233:	75 1b                	jne    80103250 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103235:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010323c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103243:	c1 e0 08             	shl    $0x8,%eax
80103246:	09 d0                	or     %edx,%eax
80103248:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010324b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103250:	ba 00 04 00 00       	mov    $0x400,%edx
80103255:	e8 36 ff ff ff       	call   80103190 <mpsearch1>
8010325a:	89 c6                	mov    %eax,%esi
8010325c:	85 c0                	test   %eax,%eax
8010325e:	0f 84 4c 01 00 00    	je     801033b0 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103264:	8b 5e 04             	mov    0x4(%esi),%ebx
80103267:	85 db                	test   %ebx,%ebx
80103269:	0f 84 61 01 00 00    	je     801033d0 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010326f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103272:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103278:	6a 04                	push   $0x4
8010327a:	68 dd 7d 10 80       	push   $0x80107ddd
8010327f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103280:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103283:	e8 b8 1a 00 00       	call   80104d40 <memcmp>
80103288:	83 c4 10             	add    $0x10,%esp
8010328b:	85 c0                	test   %eax,%eax
8010328d:	0f 85 3d 01 00 00    	jne    801033d0 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103293:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010329a:	3c 01                	cmp    $0x1,%al
8010329c:	74 08                	je     801032a6 <mpinit+0x96>
8010329e:	3c 04                	cmp    $0x4,%al
801032a0:	0f 85 2a 01 00 00    	jne    801033d0 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
801032a6:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
801032ad:	66 85 d2             	test   %dx,%dx
801032b0:	74 26                	je     801032d8 <mpinit+0xc8>
801032b2:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
801032b5:	89 d8                	mov    %ebx,%eax
  sum = 0;
801032b7:	31 d2                	xor    %edx,%edx
801032b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801032c0:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
801032c7:	83 c0 01             	add    $0x1,%eax
801032ca:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032cc:	39 f8                	cmp    %edi,%eax
801032ce:	75 f0                	jne    801032c0 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801032d0:	84 d2                	test   %dl,%dl
801032d2:	0f 85 f8 00 00 00    	jne    801033d0 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032d8:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801032de:	a3 9c 36 11 80       	mov    %eax,0x8011369c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801032e9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
801032f0:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032f5:	03 55 e4             	add    -0x1c(%ebp),%edx
801032f8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801032fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032ff:	90                   	nop
80103300:	39 c2                	cmp    %eax,%edx
80103302:	76 15                	jbe    80103319 <mpinit+0x109>
    switch(*p){
80103304:	0f b6 08             	movzbl (%eax),%ecx
80103307:	80 f9 02             	cmp    $0x2,%cl
8010330a:	74 5c                	je     80103368 <mpinit+0x158>
8010330c:	77 42                	ja     80103350 <mpinit+0x140>
8010330e:	84 c9                	test   %cl,%cl
80103310:	74 6e                	je     80103380 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103312:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103315:	39 c2                	cmp    %eax,%edx
80103317:	77 eb                	ja     80103304 <mpinit+0xf4>
80103319:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010331c:	85 db                	test   %ebx,%ebx
8010331e:	0f 84 b9 00 00 00    	je     801033dd <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103324:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103328:	74 15                	je     8010333f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010332a:	b8 70 00 00 00       	mov    $0x70,%eax
8010332f:	ba 22 00 00 00       	mov    $0x22,%edx
80103334:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103335:	ba 23 00 00 00       	mov    $0x23,%edx
8010333a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010333b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010333e:	ee                   	out    %al,(%dx)
  }
}
8010333f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103342:	5b                   	pop    %ebx
80103343:	5e                   	pop    %esi
80103344:	5f                   	pop    %edi
80103345:	5d                   	pop    %ebp
80103346:	c3                   	ret    
80103347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010334e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103350:	83 e9 03             	sub    $0x3,%ecx
80103353:	80 f9 01             	cmp    $0x1,%cl
80103356:	76 ba                	jbe    80103312 <mpinit+0x102>
80103358:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010335f:	eb 9f                	jmp    80103300 <mpinit+0xf0>
80103361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103368:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010336c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010336f:	88 0d 80 37 11 80    	mov    %cl,0x80113780
      continue;
80103375:	eb 89                	jmp    80103300 <mpinit+0xf0>
80103377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010337e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103380:	8b 0d 20 3d 11 80    	mov    0x80113d20,%ecx
80103386:	83 f9 07             	cmp    $0x7,%ecx
80103389:	7f 19                	jg     801033a4 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010338b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103391:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103395:	83 c1 01             	add    $0x1,%ecx
80103398:	89 0d 20 3d 11 80    	mov    %ecx,0x80113d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010339e:	88 9f a0 37 11 80    	mov    %bl,-0x7feec860(%edi)
      p += sizeof(struct mpproc);
801033a4:	83 c0 14             	add    $0x14,%eax
      continue;
801033a7:	e9 54 ff ff ff       	jmp    80103300 <mpinit+0xf0>
801033ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
801033b0:	ba 00 00 01 00       	mov    $0x10000,%edx
801033b5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801033ba:	e8 d1 fd ff ff       	call   80103190 <mpsearch1>
801033bf:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801033c1:	85 c0                	test   %eax,%eax
801033c3:	0f 85 9b fe ff ff    	jne    80103264 <mpinit+0x54>
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	68 e2 7d 10 80       	push   $0x80107de2
801033d8:	e8 b3 cf ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801033dd:	83 ec 0c             	sub    $0xc,%esp
801033e0:	68 fc 7d 10 80       	push   $0x80107dfc
801033e5:	e8 a6 cf ff ff       	call   80100390 <panic>
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801033f0:	f3 0f 1e fb          	endbr32 
801033f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033f9:	ba 21 00 00 00       	mov    $0x21,%edx
801033fe:	ee                   	out    %al,(%dx)
801033ff:	ba a1 00 00 00       	mov    $0xa1,%edx
80103404:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103405:	c3                   	ret    
80103406:	66 90                	xchg   %ax,%ax
80103408:	66 90                	xchg   %ax,%ax
8010340a:	66 90                	xchg   %ax,%ax
8010340c:	66 90                	xchg   %ax,%ax
8010340e:	66 90                	xchg   %ax,%ax

80103410 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103410:	f3 0f 1e fb          	endbr32 
80103414:	55                   	push   %ebp
80103415:	89 e5                	mov    %esp,%ebp
80103417:	57                   	push   %edi
80103418:	56                   	push   %esi
80103419:	53                   	push   %ebx
8010341a:	83 ec 0c             	sub    $0xc,%esp
8010341d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103420:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103423:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103429:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010342f:	e8 ec d9 ff ff       	call   80100e20 <filealloc>
80103434:	89 03                	mov    %eax,(%ebx)
80103436:	85 c0                	test   %eax,%eax
80103438:	0f 84 ac 00 00 00    	je     801034ea <pipealloc+0xda>
8010343e:	e8 dd d9 ff ff       	call   80100e20 <filealloc>
80103443:	89 06                	mov    %eax,(%esi)
80103445:	85 c0                	test   %eax,%eax
80103447:	0f 84 8b 00 00 00    	je     801034d8 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010344d:	e8 fe f1 ff ff       	call   80102650 <kalloc>
80103452:	89 c7                	mov    %eax,%edi
80103454:	85 c0                	test   %eax,%eax
80103456:	0f 84 b4 00 00 00    	je     80103510 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010345c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103463:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103466:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103469:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103470:	00 00 00 
  p->nwrite = 0;
80103473:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010347a:	00 00 00 
  p->nread = 0;
8010347d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103484:	00 00 00 
  initlock(&p->lock, "pipe");
80103487:	68 1b 7e 10 80       	push   $0x80107e1b
8010348c:	50                   	push   %eax
8010348d:	e8 ce 15 00 00       	call   80104a60 <initlock>
  (*f0)->type = FD_PIPE;
80103492:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103494:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103497:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010349d:	8b 03                	mov    (%ebx),%eax
8010349f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034a3:	8b 03                	mov    (%ebx),%eax
801034a5:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034a9:	8b 03                	mov    (%ebx),%eax
801034ab:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034ae:	8b 06                	mov    (%esi),%eax
801034b0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034b6:	8b 06                	mov    (%esi),%eax
801034b8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034bc:	8b 06                	mov    (%esi),%eax
801034be:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034c2:	8b 06                	mov    (%esi),%eax
801034c4:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034ca:	31 c0                	xor    %eax,%eax
}
801034cc:	5b                   	pop    %ebx
801034cd:	5e                   	pop    %esi
801034ce:	5f                   	pop    %edi
801034cf:	5d                   	pop    %ebp
801034d0:	c3                   	ret    
801034d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801034d8:	8b 03                	mov    (%ebx),%eax
801034da:	85 c0                	test   %eax,%eax
801034dc:	74 1e                	je     801034fc <pipealloc+0xec>
    fileclose(*f0);
801034de:	83 ec 0c             	sub    $0xc,%esp
801034e1:	50                   	push   %eax
801034e2:	e8 f9 d9 ff ff       	call   80100ee0 <fileclose>
801034e7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034ea:	8b 06                	mov    (%esi),%eax
801034ec:	85 c0                	test   %eax,%eax
801034ee:	74 0c                	je     801034fc <pipealloc+0xec>
    fileclose(*f1);
801034f0:	83 ec 0c             	sub    $0xc,%esp
801034f3:	50                   	push   %eax
801034f4:	e8 e7 d9 ff ff       	call   80100ee0 <fileclose>
801034f9:	83 c4 10             	add    $0x10,%esp
}
801034fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801034ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103504:	5b                   	pop    %ebx
80103505:	5e                   	pop    %esi
80103506:	5f                   	pop    %edi
80103507:	5d                   	pop    %ebp
80103508:	c3                   	ret    
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103510:	8b 03                	mov    (%ebx),%eax
80103512:	85 c0                	test   %eax,%eax
80103514:	75 c8                	jne    801034de <pipealloc+0xce>
80103516:	eb d2                	jmp    801034ea <pipealloc+0xda>
80103518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010351f:	90                   	nop

80103520 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103520:	f3 0f 1e fb          	endbr32 
80103524:	55                   	push   %ebp
80103525:	89 e5                	mov    %esp,%ebp
80103527:	56                   	push   %esi
80103528:	53                   	push   %ebx
80103529:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010352c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010352f:	83 ec 0c             	sub    $0xc,%esp
80103532:	53                   	push   %ebx
80103533:	e8 a8 16 00 00       	call   80104be0 <acquire>
  if(writable){
80103538:	83 c4 10             	add    $0x10,%esp
8010353b:	85 f6                	test   %esi,%esi
8010353d:	74 41                	je     80103580 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010353f:	83 ec 0c             	sub    $0xc,%esp
80103542:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103548:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010354f:	00 00 00 
    wakeup(&p->nread);
80103552:	50                   	push   %eax
80103553:	e8 88 11 00 00       	call   801046e0 <wakeup>
80103558:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010355b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103561:	85 d2                	test   %edx,%edx
80103563:	75 0a                	jne    8010356f <pipeclose+0x4f>
80103565:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010356b:	85 c0                	test   %eax,%eax
8010356d:	74 31                	je     801035a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010356f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103572:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103575:	5b                   	pop    %ebx
80103576:	5e                   	pop    %esi
80103577:	5d                   	pop    %ebp
    release(&p->lock);
80103578:	e9 23 17 00 00       	jmp    80104ca0 <release>
8010357d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103580:	83 ec 0c             	sub    $0xc,%esp
80103583:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103589:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103590:	00 00 00 
    wakeup(&p->nwrite);
80103593:	50                   	push   %eax
80103594:	e8 47 11 00 00       	call   801046e0 <wakeup>
80103599:	83 c4 10             	add    $0x10,%esp
8010359c:	eb bd                	jmp    8010355b <pipeclose+0x3b>
8010359e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	53                   	push   %ebx
801035a4:	e8 f7 16 00 00       	call   80104ca0 <release>
    kfree((char*)p);
801035a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801035ac:	83 c4 10             	add    $0x10,%esp
}
801035af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035b2:	5b                   	pop    %ebx
801035b3:	5e                   	pop    %esi
801035b4:	5d                   	pop    %ebp
    kfree((char*)p);
801035b5:	e9 d6 ee ff ff       	jmp    80102490 <kfree>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035c0:	f3 0f 1e fb          	endbr32 
801035c4:	55                   	push   %ebp
801035c5:	89 e5                	mov    %esp,%ebp
801035c7:	57                   	push   %edi
801035c8:	56                   	push   %esi
801035c9:	53                   	push   %ebx
801035ca:	83 ec 28             	sub    $0x28,%esp
801035cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035d0:	53                   	push   %ebx
801035d1:	e8 0a 16 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++){
801035d6:	8b 45 10             	mov    0x10(%ebp),%eax
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	85 c0                	test   %eax,%eax
801035de:	0f 8e bc 00 00 00    	jle    801036a0 <pipewrite+0xe0>
801035e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801035e7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035ed:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035f6:	03 45 10             	add    0x10(%ebp),%eax
801035f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035fc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103602:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103608:	89 ca                	mov    %ecx,%edx
8010360a:	05 00 02 00 00       	add    $0x200,%eax
8010360f:	39 c1                	cmp    %eax,%ecx
80103611:	74 3b                	je     8010364e <pipewrite+0x8e>
80103613:	eb 63                	jmp    80103678 <pipewrite+0xb8>
80103615:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103618:	e8 03 04 00 00       	call   80103a20 <myproc>
8010361d:	8b 48 2c             	mov    0x2c(%eax),%ecx
80103620:	85 c9                	test   %ecx,%ecx
80103622:	75 34                	jne    80103658 <pipewrite+0x98>
      wakeup(&p->nread);
80103624:	83 ec 0c             	sub    $0xc,%esp
80103627:	57                   	push   %edi
80103628:	e8 b3 10 00 00       	call   801046e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010362d:	58                   	pop    %eax
8010362e:	5a                   	pop    %edx
8010362f:	53                   	push   %ebx
80103630:	56                   	push   %esi
80103631:	e8 4a 0d 00 00       	call   80104380 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103636:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010363c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103642:	83 c4 10             	add    $0x10,%esp
80103645:	05 00 02 00 00       	add    $0x200,%eax
8010364a:	39 c2                	cmp    %eax,%edx
8010364c:	75 2a                	jne    80103678 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010364e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103654:	85 c0                	test   %eax,%eax
80103656:	75 c0                	jne    80103618 <pipewrite+0x58>
        release(&p->lock);
80103658:	83 ec 0c             	sub    $0xc,%esp
8010365b:	53                   	push   %ebx
8010365c:	e8 3f 16 00 00       	call   80104ca0 <release>
        return -1;
80103661:	83 c4 10             	add    $0x10,%esp
80103664:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103669:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010366c:	5b                   	pop    %ebx
8010366d:	5e                   	pop    %esi
8010366e:	5f                   	pop    %edi
8010366f:	5d                   	pop    %ebp
80103670:	c3                   	ret    
80103671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103678:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010367b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010367e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103684:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010368a:	0f b6 06             	movzbl (%esi),%eax
8010368d:	83 c6 01             	add    $0x1,%esi
80103690:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103693:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103697:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010369a:	0f 85 5c ff ff ff    	jne    801035fc <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036a9:	50                   	push   %eax
801036aa:	e8 31 10 00 00       	call   801046e0 <wakeup>
  release(&p->lock);
801036af:	89 1c 24             	mov    %ebx,(%esp)
801036b2:	e8 e9 15 00 00       	call   80104ca0 <release>
  return n;
801036b7:	8b 45 10             	mov    0x10(%ebp),%eax
801036ba:	83 c4 10             	add    $0x10,%esp
801036bd:	eb aa                	jmp    80103669 <pipewrite+0xa9>
801036bf:	90                   	nop

801036c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036c0:	f3 0f 1e fb          	endbr32 
801036c4:	55                   	push   %ebp
801036c5:	89 e5                	mov    %esp,%ebp
801036c7:	57                   	push   %edi
801036c8:	56                   	push   %esi
801036c9:	53                   	push   %ebx
801036ca:	83 ec 18             	sub    $0x18,%esp
801036cd:	8b 75 08             	mov    0x8(%ebp),%esi
801036d0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036d3:	56                   	push   %esi
801036d4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036da:	e8 01 15 00 00       	call   80104be0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036df:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036ee:	74 33                	je     80103723 <piperead+0x63>
801036f0:	eb 3b                	jmp    8010372d <piperead+0x6d>
801036f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
801036f8:	e8 23 03 00 00       	call   80103a20 <myproc>
801036fd:	8b 48 2c             	mov    0x2c(%eax),%ecx
80103700:	85 c9                	test   %ecx,%ecx
80103702:	0f 85 88 00 00 00    	jne    80103790 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103708:	83 ec 08             	sub    $0x8,%esp
8010370b:	56                   	push   %esi
8010370c:	53                   	push   %ebx
8010370d:	e8 6e 0c 00 00       	call   80104380 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103712:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103718:	83 c4 10             	add    $0x10,%esp
8010371b:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103721:	75 0a                	jne    8010372d <piperead+0x6d>
80103723:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103729:	85 c0                	test   %eax,%eax
8010372b:	75 cb                	jne    801036f8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010372d:	8b 55 10             	mov    0x10(%ebp),%edx
80103730:	31 db                	xor    %ebx,%ebx
80103732:	85 d2                	test   %edx,%edx
80103734:	7f 28                	jg     8010375e <piperead+0x9e>
80103736:	eb 34                	jmp    8010376c <piperead+0xac>
80103738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010373f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103740:	8d 48 01             	lea    0x1(%eax),%ecx
80103743:	25 ff 01 00 00       	and    $0x1ff,%eax
80103748:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010374e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103753:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103756:	83 c3 01             	add    $0x1,%ebx
80103759:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010375c:	74 0e                	je     8010376c <piperead+0xac>
    if(p->nread == p->nwrite)
8010375e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103764:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010376a:	75 d4                	jne    80103740 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010376c:	83 ec 0c             	sub    $0xc,%esp
8010376f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103775:	50                   	push   %eax
80103776:	e8 65 0f 00 00       	call   801046e0 <wakeup>
  release(&p->lock);
8010377b:	89 34 24             	mov    %esi,(%esp)
8010377e:	e8 1d 15 00 00       	call   80104ca0 <release>
  return i;
80103783:	83 c4 10             	add    $0x10,%esp
}
80103786:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103789:	89 d8                	mov    %ebx,%eax
8010378b:	5b                   	pop    %ebx
8010378c:	5e                   	pop    %esi
8010378d:	5f                   	pop    %edi
8010378e:	5d                   	pop    %ebp
8010378f:	c3                   	ret    
      release(&p->lock);
80103790:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103793:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103798:	56                   	push   %esi
80103799:	e8 02 15 00 00       	call   80104ca0 <release>
      return -1;
8010379e:	83 c4 10             	add    $0x10,%esp
}
801037a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037a4:	89 d8                	mov    %ebx,%eax
801037a6:	5b                   	pop    %ebx
801037a7:	5e                   	pop    %esi
801037a8:	5f                   	pop    %edi
801037a9:	5d                   	pop    %ebp
801037aa:	c3                   	ret    
801037ab:	66 90                	xchg   %ax,%ax
801037ad:	66 90                	xchg   %ax,%ax
801037af:	90                   	nop

801037b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b4:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037bc:	68 80 3d 11 80       	push   $0x80113d80
801037c1:	e8 1a 14 00 00       	call   80104be0 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 17                	jmp    801037e2 <allocproc+0x32>
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801037d6:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
801037dc:	0f 84 be 00 00 00    	je     801038a0 <allocproc+0xf0>
    if(p->state == UNUSED)
801037e2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037e5:	85 c0                	test   %eax,%eax
801037e7:	75 e7                	jne    801037d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037e9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->priority = 3;
  p->runningTime = 0;
  p->sleepingTime = 0;
  p->turnTime = 0;

  release(&ptable.lock);
801037ee:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037f1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->stackTop = -1;
801037f8:	c7 43 18 ff ff ff ff 	movl   $0xffffffff,0x18(%ebx)
  p->pid = nextpid++;
801037ff:	89 43 10             	mov    %eax,0x10(%ebx)
80103802:	8d 50 01             	lea    0x1(%eax),%edx
  p->threads = -1;
80103805:	c7 43 14 ff ff ff ff 	movl   $0xffffffff,0x14(%ebx)
  p->readyTime = 0;
8010380c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103813:	00 00 00 
  p->priority = 3;
80103816:	c7 83 94 00 00 00 03 	movl   $0x3,0x94(%ebx)
8010381d:	00 00 00 
  p->runningTime = 0;
80103820:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103827:	00 00 00 
  p->sleepingTime = 0;
8010382a:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103831:	00 00 00 
  p->turnTime = 0;
80103834:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
8010383b:	00 00 00 
  release(&ptable.lock);
8010383e:	68 80 3d 11 80       	push   $0x80113d80
  p->pid = nextpid++;
80103843:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103849:	e8 52 14 00 00       	call   80104ca0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010384e:	e8 fd ed ff ff       	call   80102650 <kalloc>
80103853:	83 c4 10             	add    $0x10,%esp
80103856:	89 43 08             	mov    %eax,0x8(%ebx)
80103859:	85 c0                	test   %eax,%eax
8010385b:	74 5c                	je     801038b9 <allocproc+0x109>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010385d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103863:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103866:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010386b:	89 53 20             	mov    %edx,0x20(%ebx)
  *(uint*)sp = (uint)trapret;
8010386e:	c7 40 14 4f 60 10 80 	movl   $0x8010604f,0x14(%eax)
  p->context = (struct context*)sp;
80103875:	89 43 24             	mov    %eax,0x24(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103878:	6a 14                	push   $0x14
8010387a:	6a 00                	push   $0x0
8010387c:	50                   	push   %eax
8010387d:	e8 6e 14 00 00       	call   80104cf0 <memset>
  p->context->eip = (uint)forkret;
80103882:	8b 43 24             	mov    0x24(%ebx),%eax

  return p;
80103885:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103888:	c7 40 10 d0 38 10 80 	movl   $0x801038d0,0x10(%eax)
}
8010388f:	89 d8                	mov    %ebx,%eax
80103891:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103894:	c9                   	leave  
80103895:	c3                   	ret    
80103896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010389d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
801038a0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038a3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038a5:	68 80 3d 11 80       	push   $0x80113d80
801038aa:	e8 f1 13 00 00       	call   80104ca0 <release>
}
801038af:	89 d8                	mov    %ebx,%eax
  return 0;
801038b1:	83 c4 10             	add    $0x10,%esp
}
801038b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038b7:	c9                   	leave  
801038b8:	c3                   	ret    
    p->state = UNUSED;
801038b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038c0:	31 db                	xor    %ebx,%ebx
}
801038c2:	89 d8                	mov    %ebx,%eax
801038c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038c7:	c9                   	leave  
801038c8:	c3                   	ret    
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038d0:	f3 0f 1e fb          	endbr32 
801038d4:	55                   	push   %ebp
801038d5:	89 e5                	mov    %esp,%ebp
801038d7:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038da:	68 80 3d 11 80       	push   $0x80113d80
801038df:	e8 bc 13 00 00       	call   80104ca0 <release>

  if (first) {
801038e4:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038e9:	83 c4 10             	add    $0x10,%esp
801038ec:	85 c0                	test   %eax,%eax
801038ee:	75 08                	jne    801038f8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038f0:	c9                   	leave  
801038f1:	c3                   	ret    
801038f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
801038f8:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038ff:	00 00 00 
    iinit(ROOTDEV);
80103902:	83 ec 0c             	sub    $0xc,%esp
80103905:	6a 01                	push   $0x1
80103907:	e8 54 dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
8010390c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103913:	e8 98 f3 ff ff       	call   80102cb0 <initlog>
}
80103918:	83 c4 10             	add    $0x10,%esp
8010391b:	c9                   	leave  
8010391c:	c3                   	ret    
8010391d:	8d 76 00             	lea    0x0(%esi),%esi

80103920 <check_pgdir_share>:
int check_pgdir_share(struct proc *process) {
80103920:	f3 0f 1e fb          	endbr32 
80103924:	55                   	push   %ebp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103925:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
int check_pgdir_share(struct proc *process) {
8010392a:	89 e5                	mov    %esp,%ebp
8010392c:	8b 55 08             	mov    0x8(%ebp),%edx
8010392f:	eb 13                	jmp    80103944 <check_pgdir_share+0x24>
80103931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103938:	05 98 00 00 00       	add    $0x98,%eax
8010393d:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80103942:	74 14                	je     80103958 <check_pgdir_share+0x38>
    if (p != process && p->pgdir != process->pgdir)
80103944:	39 c2                	cmp    %eax,%edx
80103946:	74 f0                	je     80103938 <check_pgdir_share+0x18>
80103948:	8b 4a 04             	mov    0x4(%edx),%ecx
8010394b:	39 48 04             	cmp    %ecx,0x4(%eax)
8010394e:	74 e8                	je     80103938 <check_pgdir_share+0x18>
      return 0;
80103950:	31 c0                	xor    %eax,%eax
}
80103952:	5d                   	pop    %ebp
80103953:	c3                   	ret    
80103954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 1;
80103958:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010395d:	5d                   	pop    %ebp
8010395e:	c3                   	ret    
8010395f:	90                   	nop

80103960 <pinit>:
{
80103960:	f3 0f 1e fb          	endbr32 
80103964:	55                   	push   %ebp
80103965:	89 e5                	mov    %esp,%ebp
80103967:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
8010396a:	68 20 7e 10 80       	push   $0x80107e20
8010396f:	68 80 3d 11 80       	push   $0x80113d80
80103974:	e8 e7 10 00 00       	call   80104a60 <initlock>
  initlock(&thread, "thread");
80103979:	58                   	pop    %eax
8010397a:	5a                   	pop    %edx
8010397b:	68 27 7e 10 80       	push   $0x80107e27
80103980:	68 40 3d 11 80       	push   $0x80113d40
80103985:	e8 d6 10 00 00       	call   80104a60 <initlock>
}
8010398a:	83 c4 10             	add    $0x10,%esp
8010398d:	c9                   	leave  
8010398e:	c3                   	ret    
8010398f:	90                   	nop

80103990 <mycpu>:
{
80103990:	f3 0f 1e fb          	endbr32 
80103994:	55                   	push   %ebp
80103995:	89 e5                	mov    %esp,%ebp
80103997:	56                   	push   %esi
80103998:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103999:	9c                   	pushf  
8010399a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010399b:	f6 c4 02             	test   $0x2,%ah
8010399e:	75 4a                	jne    801039ea <mycpu+0x5a>
  apicid = lapicid();
801039a0:	e8 1b ef ff ff       	call   801028c0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801039a5:	8b 35 20 3d 11 80    	mov    0x80113d20,%esi
  apicid = lapicid();
801039ab:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
801039ad:	85 f6                	test   %esi,%esi
801039af:	7e 2c                	jle    801039dd <mycpu+0x4d>
801039b1:	31 d2                	xor    %edx,%edx
801039b3:	eb 0a                	jmp    801039bf <mycpu+0x2f>
801039b5:	8d 76 00             	lea    0x0(%esi),%esi
801039b8:	83 c2 01             	add    $0x1,%edx
801039bb:	39 f2                	cmp    %esi,%edx
801039bd:	74 1e                	je     801039dd <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
801039bf:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801039c5:	0f b6 81 a0 37 11 80 	movzbl -0x7feec860(%ecx),%eax
801039cc:	39 d8                	cmp    %ebx,%eax
801039ce:	75 e8                	jne    801039b8 <mycpu+0x28>
}
801039d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801039d3:	8d 81 a0 37 11 80    	lea    -0x7feec860(%ecx),%eax
}
801039d9:	5b                   	pop    %ebx
801039da:	5e                   	pop    %esi
801039db:	5d                   	pop    %ebp
801039dc:	c3                   	ret    
  panic("unknown apicid\n");
801039dd:	83 ec 0c             	sub    $0xc,%esp
801039e0:	68 2e 7e 10 80       	push   $0x80107e2e
801039e5:	e8 a6 c9 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801039ea:	83 ec 0c             	sub    $0xc,%esp
801039ed:	68 1c 7f 10 80       	push   $0x80107f1c
801039f2:	e8 99 c9 ff ff       	call   80100390 <panic>
801039f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039fe:	66 90                	xchg   %ax,%ax

80103a00 <cpuid>:
cpuid() {
80103a00:	f3 0f 1e fb          	endbr32 
80103a04:	55                   	push   %ebp
80103a05:	89 e5                	mov    %esp,%ebp
80103a07:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a0a:	e8 81 ff ff ff       	call   80103990 <mycpu>
}
80103a0f:	c9                   	leave  
  return mycpu()-cpus;
80103a10:	2d a0 37 11 80       	sub    $0x801137a0,%eax
80103a15:	c1 f8 04             	sar    $0x4,%eax
80103a18:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a1e:	c3                   	ret    
80103a1f:	90                   	nop

80103a20 <myproc>:
myproc(void) {
80103a20:	f3 0f 1e fb          	endbr32 
80103a24:	55                   	push   %ebp
80103a25:	89 e5                	mov    %esp,%ebp
80103a27:	53                   	push   %ebx
80103a28:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a2b:	e8 b0 10 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
80103a30:	e8 5b ff ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103a35:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a3b:	e8 f0 10 00 00       	call   80104b30 <popcli>
}
80103a40:	83 c4 04             	add    $0x4,%esp
80103a43:	89 d8                	mov    %ebx,%eax
80103a45:	5b                   	pop    %ebx
80103a46:	5d                   	pop    %ebp
80103a47:	c3                   	ret    
80103a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a4f:	90                   	nop

80103a50 <userinit>:
{
80103a50:	f3 0f 1e fb          	endbr32 
80103a54:	55                   	push   %ebp
80103a55:	89 e5                	mov    %esp,%ebp
80103a57:	53                   	push   %ebx
80103a58:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103a5b:	e8 50 fd ff ff       	call   801037b0 <allocproc>
80103a60:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a62:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103a67:	e8 e4 3b 00 00       	call   80107650 <setupkvm>
80103a6c:	89 43 04             	mov    %eax,0x4(%ebx)
80103a6f:	85 c0                	test   %eax,%eax
80103a71:	0f 84 c4 00 00 00    	je     80103b3b <userinit+0xeb>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a77:	83 ec 04             	sub    $0x4,%esp
80103a7a:	68 2c 00 00 00       	push   $0x2c
80103a7f:	68 60 b4 10 80       	push   $0x8010b460
80103a84:	50                   	push   %eax
80103a85:	e8 96 38 00 00       	call   80107320 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a8a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a8d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  p->threads = 1;
80103a93:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a9a:	6a 4c                	push   $0x4c
80103a9c:	6a 00                	push   $0x0
80103a9e:	ff 73 20             	pushl  0x20(%ebx)
80103aa1:	e8 4a 12 00 00       	call   80104cf0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103aa6:	8b 43 20             	mov    0x20(%ebx),%eax
80103aa9:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103aae:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ab1:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ab6:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103aba:	8b 43 20             	mov    0x20(%ebx),%eax
80103abd:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103ac1:	8b 43 20             	mov    0x20(%ebx),%eax
80103ac4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ac8:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103acc:	8b 43 20             	mov    0x20(%ebx),%eax
80103acf:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ad3:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ad7:	8b 43 20             	mov    0x20(%ebx),%eax
80103ada:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ae1:	8b 43 20             	mov    0x20(%ebx),%eax
80103ae4:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103aeb:	8b 43 20             	mov    0x20(%ebx),%eax
80103aee:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103af5:	8d 43 74             	lea    0x74(%ebx),%eax
80103af8:	6a 10                	push   $0x10
80103afa:	68 57 7e 10 80       	push   $0x80107e57
80103aff:	50                   	push   %eax
80103b00:	e8 ab 13 00 00       	call   80104eb0 <safestrcpy>
  p->cwd = namei("/");
80103b05:	c7 04 24 60 7e 10 80 	movl   $0x80107e60,(%esp)
80103b0c:	e8 3f e5 ff ff       	call   80102050 <namei>
80103b11:	89 43 70             	mov    %eax,0x70(%ebx)
  acquire(&ptable.lock);
80103b14:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103b1b:	e8 c0 10 00 00       	call   80104be0 <acquire>
  p->state = RUNNABLE;
80103b20:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b27:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103b2e:	e8 6d 11 00 00       	call   80104ca0 <release>
}
80103b33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b36:	83 c4 10             	add    $0x10,%esp
80103b39:	c9                   	leave  
80103b3a:	c3                   	ret    
    panic("userinit: out of memory?");
80103b3b:	83 ec 0c             	sub    $0xc,%esp
80103b3e:	68 3e 7e 10 80       	push   $0x80107e3e
80103b43:	e8 48 c8 ff ff       	call   80100390 <panic>
80103b48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b4f:	90                   	nop

80103b50 <growproc>:
{
80103b50:	f3 0f 1e fb          	endbr32 
80103b54:	55                   	push   %ebp
80103b55:	89 e5                	mov    %esp,%ebp
80103b57:	56                   	push   %esi
80103b58:	53                   	push   %ebx
80103b59:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103b5c:	e8 7f 0f 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
80103b61:	e8 2a fe ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103b66:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b6c:	e8 bf 0f 00 00       	call   80104b30 <popcli>
  acquire(&thread);
80103b71:	83 ec 0c             	sub    $0xc,%esp
80103b74:	68 40 3d 11 80       	push   $0x80113d40
80103b79:	e8 62 10 00 00       	call   80104be0 <acquire>
  sz = curproc->sz;
80103b7e:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b80:	83 c4 10             	add    $0x10,%esp
80103b83:	85 f6                	test   %esi,%esi
80103b85:	7f 79                	jg     80103c00 <growproc+0xb0>
  } else if(n < 0){
80103b87:	0f 85 eb 00 00 00    	jne    80103c78 <growproc+0x128>
  acquire(&ptable.lock);
80103b8d:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b90:	89 03                	mov    %eax,(%ebx)
  acquire(&ptable.lock);
80103b92:	68 80 3d 11 80       	push   $0x80113d80
80103b97:	e8 44 10 00 00       	call   80104be0 <acquire>
  if (curproc->threads == -1) {
80103b9c:	8b 53 14             	mov    0x14(%ebx),%edx
80103b9f:	83 c4 10             	add    $0x10,%esp
80103ba2:	83 fa ff             	cmp    $0xffffffff,%edx
80103ba5:	0f 84 8d 00 00 00    	je     80103c38 <growproc+0xe8>
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103bab:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
    if (numberOfChildren <= 0) {
80103bb0:	83 fa 01             	cmp    $0x1,%edx
80103bb3:	7e 1d                	jle    80103bd2 <growproc+0x82>
80103bb5:	8d 76 00             	lea    0x0(%esi),%esi
        if (p != curproc && p->threads == -1) {
80103bb8:	39 c3                	cmp    %eax,%ebx
80103bba:	74 0a                	je     80103bc6 <growproc+0x76>
80103bbc:	83 78 14 ff          	cmpl   $0xffffffff,0x14(%eax)
80103bc0:	75 04                	jne    80103bc6 <growproc+0x76>
          p->sz = curproc->sz;
80103bc2:	8b 13                	mov    (%ebx),%edx
80103bc4:	89 10                	mov    %edx,(%eax)
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103bc6:	05 98 00 00 00       	add    $0x98,%eax
80103bcb:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80103bd0:	75 e6                	jne    80103bb8 <growproc+0x68>
  release(&ptable.lock);
80103bd2:	83 ec 0c             	sub    $0xc,%esp
80103bd5:	68 80 3d 11 80       	push   $0x80113d80
80103bda:	e8 c1 10 00 00       	call   80104ca0 <release>
  release(&thread);
80103bdf:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103be6:	e8 b5 10 00 00       	call   80104ca0 <release>
  switchuvm(curproc);
80103beb:	89 1c 24             	mov    %ebx,(%esp)
80103bee:	e8 1d 36 00 00       	call   80107210 <switchuvm>
  return 0;
80103bf3:	83 c4 10             	add    $0x10,%esp
80103bf6:	31 c0                	xor    %eax,%eax
}
80103bf8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bfb:	5b                   	pop    %ebx
80103bfc:	5e                   	pop    %esi
80103bfd:	5d                   	pop    %ebp
80103bfe:	c3                   	ret    
80103bff:	90                   	nop
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0) {
80103c00:	83 ec 04             	sub    $0x4,%esp
80103c03:	01 c6                	add    %eax,%esi
80103c05:	56                   	push   %esi
80103c06:	50                   	push   %eax
80103c07:	ff 73 04             	pushl  0x4(%ebx)
80103c0a:	e8 61 38 00 00       	call   80107470 <allocuvm>
80103c0f:	83 c4 10             	add    $0x10,%esp
80103c12:	85 c0                	test   %eax,%eax
80103c14:	0f 85 73 ff ff ff    	jne    80103b8d <growproc+0x3d>
      release(&thread);
80103c1a:	83 ec 0c             	sub    $0xc,%esp
80103c1d:	68 40 3d 11 80       	push   $0x80113d40
80103c22:	e8 79 10 00 00       	call   80104ca0 <release>
      return -1;
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c2f:	eb c7                	jmp    80103bf8 <growproc+0xa8>
80103c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    curproc->parent->sz = curproc->sz;
80103c38:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103c3b:	8b 13                	mov    (%ebx),%edx
80103c3d:	89 10                	mov    %edx,(%eax)
    numberOfChildren = curproc->parent->threads - 2;
80103c3f:	8b 53 1c             	mov    0x1c(%ebx),%edx
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103c42:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
    if (numberOfChildren <= 0) {
80103c47:	83 7a 14 02          	cmpl   $0x2,0x14(%edx)
80103c4b:	7f 13                	jg     80103c60 <growproc+0x110>
80103c4d:	eb 83                	jmp    80103bd2 <growproc+0x82>
80103c4f:	90                   	nop
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103c50:	05 98 00 00 00       	add    $0x98,%eax
80103c55:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80103c5a:	0f 84 72 ff ff ff    	je     80103bd2 <growproc+0x82>
        if (p != curproc && p->parent == curproc->parent && p->threads == -1) {
80103c60:	39 c3                	cmp    %eax,%ebx
80103c62:	74 ec                	je     80103c50 <growproc+0x100>
80103c64:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
80103c67:	39 48 1c             	cmp    %ecx,0x1c(%eax)
80103c6a:	75 e4                	jne    80103c50 <growproc+0x100>
80103c6c:	83 78 14 ff          	cmpl   $0xffffffff,0x14(%eax)
80103c70:	75 de                	jne    80103c50 <growproc+0x100>
          p->sz = curproc->sz;
80103c72:	8b 13                	mov    (%ebx),%edx
80103c74:	89 10                	mov    %edx,(%eax)
          numberOfChildren--;
80103c76:	eb d8                	jmp    80103c50 <growproc+0x100>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0) {
80103c78:	83 ec 04             	sub    $0x4,%esp
80103c7b:	01 c6                	add    %eax,%esi
80103c7d:	56                   	push   %esi
80103c7e:	50                   	push   %eax
80103c7f:	ff 73 04             	pushl  0x4(%ebx)
80103c82:	e8 19 39 00 00       	call   801075a0 <deallocuvm>
80103c87:	83 c4 10             	add    $0x10,%esp
80103c8a:	85 c0                	test   %eax,%eax
80103c8c:	0f 85 fb fe ff ff    	jne    80103b8d <growproc+0x3d>
80103c92:	eb 86                	jmp    80103c1a <growproc+0xca>
80103c94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop

80103ca0 <thread_create>:
int thread_create(void *stack) {
80103ca0:	f3 0f 1e fb          	endbr32 
80103ca4:	55                   	push   %ebp
80103ca5:	89 e5                	mov    %esp,%ebp
80103ca7:	57                   	push   %edi
80103ca8:	56                   	push   %esi
80103ca9:	53                   	push   %ebx
80103caa:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103cad:	e8 2e 0e 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
80103cb2:	e8 d9 fc ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103cb7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cbd:	e8 6e 0e 00 00       	call   80104b30 <popcli>
  if((np = allocproc()) == 0){
80103cc2:	e8 e9 fa ff ff       	call   801037b0 <allocproc>
80103cc7:	85 c0                	test   %eax,%eax
80103cc9:	0f 84 2c 01 00 00    	je     80103dfb <thread_create+0x15b>
80103ccf:	89 c2                	mov    %eax,%edx
  np->stackTop = (int)((char*)stack + PAGESIZE);
80103cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&ptable.lock);
80103cd4:	83 ec 0c             	sub    $0xc,%esp
  curproc->threads++;
80103cd7:	83 43 14 01          	addl   $0x1,0x14(%ebx)
  np->stackTop = (int)((char*)stack + PAGESIZE);
80103cdb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103cde:	05 00 10 00 00       	add    $0x1000,%eax
80103ce3:	89 42 18             	mov    %eax,0x18(%edx)
  acquire(&ptable.lock);
80103ce6:	68 80 3d 11 80       	push   $0x80113d80
80103ceb:	e8 f0 0e 00 00       	call   80104be0 <acquire>
  np->pgdir = curproc->pgdir;
80103cf0:	8b 43 04             	mov    0x4(%ebx),%eax
80103cf3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103cf6:	89 42 04             	mov    %eax,0x4(%edx)
  np->sz = curproc->sz;
80103cf9:	8b 03                	mov    (%ebx),%eax
80103cfb:	89 02                	mov    %eax,(%edx)
  release(&ptable.lock);
80103cfd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103d04:	e8 97 0f 00 00       	call   80104ca0 <release>
  int bytesOnStack = curproc->stackTop - curproc->tf->esp;
80103d09:	8b 43 20             	mov    0x20(%ebx),%eax
80103d0c:	8b 4b 18             	mov    0x18(%ebx),%ecx
  memmove((void*)np->tf->esp, (void*)curproc->tf->esp, bytesOnStack);
80103d0f:	83 c4 0c             	add    $0xc,%esp
  np->tf->esp = np->stackTop - bytesOnStack;
80103d12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  int bytesOnStack = curproc->stackTop - curproc->tf->esp;
80103d15:	89 cf                	mov    %ecx,%edi
80103d17:	2b 78 44             	sub    0x44(%eax),%edi
  np->tf->esp = np->stackTop - bytesOnStack;
80103d1a:	8b 42 18             	mov    0x18(%edx),%eax
80103d1d:	8b 4a 20             	mov    0x20(%edx),%ecx
  memmove((void*)np->tf->esp, (void*)curproc->tf->esp, bytesOnStack);
80103d20:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80103d23:	89 55 e0             	mov    %edx,-0x20(%ebp)
  np->tf->esp = np->stackTop - bytesOnStack;
80103d26:	29 f8                	sub    %edi,%eax
80103d28:	89 41 44             	mov    %eax,0x44(%ecx)
  memmove((void*)np->tf->esp, (void*)curproc->tf->esp, bytesOnStack);
80103d2b:	57                   	push   %edi
80103d2c:	8b 43 20             	mov    0x20(%ebx),%eax
80103d2f:	ff 70 44             	pushl  0x44(%eax)
80103d32:	8b 42 20             	mov    0x20(%edx),%eax
80103d35:	ff 70 44             	pushl  0x44(%eax)
80103d38:	e8 53 10 00 00       	call   80104d90 <memmove>
  np->parent = curproc;
80103d3d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  *np->tf = *curproc->tf;
80103d40:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->tf->ebp = np->stackTop - (curproc->stackTop - curproc->tf->ebp);
80103d45:	83 c4 10             	add    $0x10,%esp
  np->parent = curproc;
80103d48:	89 5a 1c             	mov    %ebx,0x1c(%edx)
  *np->tf = *curproc->tf;
80103d4b:	8b 7a 20             	mov    0x20(%edx),%edi
80103d4e:	8b 73 20             	mov    0x20(%ebx),%esi
80103d51:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d53:	89 d7                	mov    %edx,%edi
  np->tf->eax = 0;
80103d55:	8b 42 20             	mov    0x20(%edx),%eax
80103d58:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  np->tf->esp = np->stackTop - bytesOnStack;
80103d5f:	8b 4a 20             	mov    0x20(%edx),%ecx
80103d62:	8b 42 18             	mov    0x18(%edx),%eax
80103d65:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80103d68:	89 41 44             	mov    %eax,0x44(%ecx)
  np->tf->ebp = np->stackTop - (curproc->stackTop - curproc->tf->ebp);
80103d6b:	8b 73 20             	mov    0x20(%ebx),%esi
80103d6e:	8b 4a 20             	mov    0x20(%edx),%ecx
80103d71:	8b 42 18             	mov    0x18(%edx),%eax
80103d74:	03 46 08             	add    0x8(%esi),%eax
80103d77:	2b 43 18             	sub    0x18(%ebx),%eax
  for(i = 0; i < NOFILE; i++)
80103d7a:	31 f6                	xor    %esi,%esi
  np->tf->ebp = np->stackTop - (curproc->stackTop - curproc->tf->ebp);
80103d7c:	89 41 08             	mov    %eax,0x8(%ecx)
  for(i = 0; i < NOFILE; i++)
80103d7f:	90                   	nop
    if(curproc->ofile[i])
80103d80:	8b 44 b3 30          	mov    0x30(%ebx,%esi,4),%eax
80103d84:	85 c0                	test   %eax,%eax
80103d86:	74 10                	je     80103d98 <thread_create+0xf8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d88:	83 ec 0c             	sub    $0xc,%esp
80103d8b:	50                   	push   %eax
80103d8c:	e8 ff d0 ff ff       	call   80100e90 <filedup>
80103d91:	83 c4 10             	add    $0x10,%esp
80103d94:	89 44 b7 30          	mov    %eax,0x30(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103d98:	83 c6 01             	add    $0x1,%esi
80103d9b:	83 fe 10             	cmp    $0x10,%esi
80103d9e:	75 e0                	jne    80103d80 <thread_create+0xe0>
  np->cwd = idup(curproc->cwd);
80103da0:	83 ec 0c             	sub    $0xc,%esp
80103da3:	ff 73 70             	pushl  0x70(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103da6:	83 c3 74             	add    $0x74,%ebx
80103da9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  np->cwd = idup(curproc->cwd);
80103dac:	e8 9f d9 ff ff       	call   80101750 <idup>
80103db1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103db4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103db7:	89 42 70             	mov    %eax,0x70(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dba:	8d 42 74             	lea    0x74(%edx),%eax
80103dbd:	6a 10                	push   $0x10
80103dbf:	53                   	push   %ebx
80103dc0:	50                   	push   %eax
80103dc1:	e8 ea 10 00 00       	call   80104eb0 <safestrcpy>
  pid = np->pid;
80103dc6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103dc9:	8b 5a 10             	mov    0x10(%edx),%ebx
  acquire(&ptable.lock);
80103dcc:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103dd3:	e8 08 0e 00 00       	call   80104be0 <acquire>
  np->state = RUNNABLE;
80103dd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ddb:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80103de2:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103de9:	e8 b2 0e 00 00       	call   80104ca0 <release>
  return pid;
80103dee:	83 c4 10             	add    $0x10,%esp
}
80103df1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103df4:	89 d8                	mov    %ebx,%eax
80103df6:	5b                   	pop    %ebx
80103df7:	5e                   	pop    %esi
80103df8:	5f                   	pop    %edi
80103df9:	5d                   	pop    %ebp
80103dfa:	c3                   	ret    
    return -1;
80103dfb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e00:	eb ef                	jmp    80103df1 <thread_create+0x151>
80103e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e10 <fork>:
{
80103e10:	f3 0f 1e fb          	endbr32 
80103e14:	55                   	push   %ebp
80103e15:	89 e5                	mov    %esp,%ebp
80103e17:	57                   	push   %edi
80103e18:	56                   	push   %esi
80103e19:	53                   	push   %ebx
80103e1a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e1d:	e8 be 0c 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
80103e22:	e8 69 fb ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103e27:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e2d:	e8 fe 0c 00 00       	call   80104b30 <popcli>
  if((np = allocproc()) == 0){
80103e32:	e8 79 f9 ff ff       	call   801037b0 <allocproc>
80103e37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e3a:	85 c0                	test   %eax,%eax
80103e3c:	0f 84 cb 00 00 00    	je     80103f0d <fork+0xfd>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e42:	83 ec 08             	sub    $0x8,%esp
80103e45:	ff 33                	pushl  (%ebx)
80103e47:	89 c7                	mov    %eax,%edi
80103e49:	ff 73 04             	pushl  0x4(%ebx)
80103e4c:	e8 cf 38 00 00       	call   80107720 <copyuvm>
80103e51:	83 c4 10             	add    $0x10,%esp
80103e54:	89 47 04             	mov    %eax,0x4(%edi)
80103e57:	85 c0                	test   %eax,%eax
80103e59:	0f 84 b5 00 00 00    	je     80103f14 <fork+0x104>
  np->sz = curproc->sz;
80103e5f:	8b 03                	mov    (%ebx),%eax
80103e61:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103e64:	89 01                	mov    %eax,(%ecx)
  np->stackTop = curproc->stackTop;
80103e66:	8b 43 18             	mov    0x18(%ebx),%eax
  *np->tf = *curproc->tf;
80103e69:	8b 79 20             	mov    0x20(%ecx),%edi
  np->threads = 1;
80103e6c:	c7 41 14 01 00 00 00 	movl   $0x1,0x14(%ecx)
  np->stackTop = curproc->stackTop;
80103e73:	89 41 18             	mov    %eax,0x18(%ecx)
  np->threads = 1;
80103e76:	89 c8                	mov    %ecx,%eax
  np->parent = curproc;
80103e78:	89 59 1c             	mov    %ebx,0x1c(%ecx)
  *np->tf = *curproc->tf;
80103e7b:	b9 13 00 00 00       	mov    $0x13,%ecx
80103e80:	8b 73 20             	mov    0x20(%ebx),%esi
80103e83:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103e85:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103e87:	8b 40 20             	mov    0x20(%eax),%eax
80103e8a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103e98:	8b 44 b3 30          	mov    0x30(%ebx,%esi,4),%eax
80103e9c:	85 c0                	test   %eax,%eax
80103e9e:	74 13                	je     80103eb3 <fork+0xa3>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ea0:	83 ec 0c             	sub    $0xc,%esp
80103ea3:	50                   	push   %eax
80103ea4:	e8 e7 cf ff ff       	call   80100e90 <filedup>
80103ea9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103eac:	83 c4 10             	add    $0x10,%esp
80103eaf:	89 44 b2 30          	mov    %eax,0x30(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103eb3:	83 c6 01             	add    $0x1,%esi
80103eb6:	83 fe 10             	cmp    $0x10,%esi
80103eb9:	75 dd                	jne    80103e98 <fork+0x88>
  np->cwd = idup(curproc->cwd);
80103ebb:	83 ec 0c             	sub    $0xc,%esp
80103ebe:	ff 73 70             	pushl  0x70(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ec1:	83 c3 74             	add    $0x74,%ebx
  np->cwd = idup(curproc->cwd);
80103ec4:	e8 87 d8 ff ff       	call   80101750 <idup>
80103ec9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ecc:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ecf:	89 47 70             	mov    %eax,0x70(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ed2:	8d 47 74             	lea    0x74(%edi),%eax
80103ed5:	6a 10                	push   $0x10
80103ed7:	53                   	push   %ebx
80103ed8:	50                   	push   %eax
80103ed9:	e8 d2 0f 00 00       	call   80104eb0 <safestrcpy>
  pid = np->pid;
80103ede:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ee1:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ee8:	e8 f3 0c 00 00       	call   80104be0 <acquire>
  np->state = RUNNABLE;
80103eed:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103ef4:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103efb:	e8 a0 0d 00 00       	call   80104ca0 <release>
  return pid;
80103f00:	83 c4 10             	add    $0x10,%esp
}
80103f03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f06:	89 d8                	mov    %ebx,%eax
80103f08:	5b                   	pop    %ebx
80103f09:	5e                   	pop    %esi
80103f0a:	5f                   	pop    %edi
80103f0b:	5d                   	pop    %ebp
80103f0c:	c3                   	ret    
    return -1;
80103f0d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f12:	eb ef                	jmp    80103f03 <fork+0xf3>
    kfree(np->kstack);
80103f14:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103f17:	83 ec 0c             	sub    $0xc,%esp
80103f1a:	ff 73 08             	pushl  0x8(%ebx)
80103f1d:	e8 6e e5 ff ff       	call   80102490 <kfree>
    np->kstack = 0;
80103f22:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103f29:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103f2c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103f33:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f38:	eb c9                	jmp    80103f03 <fork+0xf3>
80103f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f40 <scheduler>:
{
80103f40:	f3 0f 1e fb          	endbr32 
80103f44:	55                   	push   %ebp
80103f45:	89 e5                	mov    %esp,%ebp
80103f47:	57                   	push   %edi
80103f48:	56                   	push   %esi
80103f49:	53                   	push   %ebx
80103f4a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103f4d:	e8 3e fa ff ff       	call   80103990 <mycpu>
  c->proc = 0;
80103f52:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f59:	00 00 00 
  struct cpu *c = mycpu();
80103f5c:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103f5e:	8d 78 04             	lea    0x4(%eax),%edi
80103f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103f68:	fb                   	sti    
    acquire(&ptable.lock);
80103f69:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6c:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
    acquire(&ptable.lock);
80103f71:	68 80 3d 11 80       	push   $0x80113d80
80103f76:	e8 65 0c 00 00       	call   80104be0 <acquire>
80103f7b:	83 c4 10             	add    $0x10,%esp
80103f7e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103f80:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103f84:	75 33                	jne    80103fb9 <scheduler+0x79>
      switchuvm(p);
80103f86:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103f89:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103f8f:	53                   	push   %ebx
80103f90:	e8 7b 32 00 00       	call   80107210 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103f95:	58                   	pop    %eax
80103f96:	5a                   	pop    %edx
80103f97:	ff 73 24             	pushl  0x24(%ebx)
80103f9a:	57                   	push   %edi
      p->state = RUNNING;
80103f9b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103fa2:	e8 6c 0f 00 00       	call   80104f13 <swtch>
      switchkvm();
80103fa7:	e8 44 32 00 00       	call   801071f0 <switchkvm>
      c->proc = 0;
80103fac:	83 c4 10             	add    $0x10,%esp
80103faf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103fb6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb9:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103fbf:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
80103fc5:	75 b9                	jne    80103f80 <scheduler+0x40>
    release(&ptable.lock);
80103fc7:	83 ec 0c             	sub    $0xc,%esp
80103fca:	68 80 3d 11 80       	push   $0x80113d80
80103fcf:	e8 cc 0c 00 00       	call   80104ca0 <release>
    sti();
80103fd4:	83 c4 10             	add    $0x10,%esp
80103fd7:	eb 8f                	jmp    80103f68 <scheduler+0x28>
80103fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103fe0 <updateTimes>:
void updateTimes(void) {
80103fe0:	f3 0f 1e fb          	endbr32 
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  
80103fe4:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80103fe9:	eb 1d                	jmp    80104008 <updateTimes+0x28>
80103feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fef:	90                   	nop
    if (p->state == RUNNABLE)
80103ff0:	83 fa 03             	cmp    $0x3,%edx
80103ff3:	75 07                	jne    80103ffc <updateTimes+0x1c>
      p->readyTime = p->readyTime + 1;
80103ff5:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  
80103ffc:	05 98 00 00 00       	add    $0x98,%eax
80104001:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104006:	74 20                	je     80104028 <updateTimes+0x48>
    if (p->state == RUNNING)
80104008:	8b 50 0c             	mov    0xc(%eax),%edx
8010400b:	83 fa 04             	cmp    $0x4,%edx
8010400e:	74 20                	je     80104030 <updateTimes+0x50>
    if (p->state == SLEEPING)
80104010:	83 fa 02             	cmp    $0x2,%edx
80104013:	75 db                	jne    80103ff0 <updateTimes+0x10>
      p->sleepingTime = p->sleepingTime + 1;
80104015:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {  
8010401c:	05 98 00 00 00       	add    $0x98,%eax
80104021:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104026:	75 e0                	jne    80104008 <updateTimes+0x28>
}
80104028:	c3                   	ret    
80104029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      p->runningTime = p->runningTime + 1;
80104030:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
    if (p->state == RUNNABLE)
80104037:	eb c3                	jmp    80103ffc <updateTimes+0x1c>
80104039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104040 <getTurnaroundTime>:
int getTurnaroundTime(int pid) {
80104040:	f3 0f 1e fb          	endbr32 
80104044:	55                   	push   %ebp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104045:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
int getTurnaroundTime(int pid) {
8010404a:	89 e5                	mov    %esp,%ebp
8010404c:	8b 55 08             	mov    0x8(%ebp),%edx
8010404f:	eb 13                	jmp    80104064 <getTurnaroundTime+0x24>
80104051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104058:	05 98 00 00 00       	add    $0x98,%eax
8010405d:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104062:	74 24                	je     80104088 <getTurnaroundTime+0x48>
    if (p->pid == pid) {
80104064:	39 50 10             	cmp    %edx,0x10(%eax)
80104067:	75 ef                	jne    80104058 <getTurnaroundTime+0x18>
      p->turnTime = p->sleepingTime + p->readyTime + p->runningTime;
80104069:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010406f:	03 90 88 00 00 00    	add    0x88(%eax),%edx
80104075:	03 90 84 00 00 00    	add    0x84(%eax),%edx
8010407b:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
}
80104081:	89 d0                	mov    %edx,%eax
80104083:	5d                   	pop    %ebp
80104084:	c3                   	ret    
80104085:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
80104088:	31 d2                	xor    %edx,%edx
}
8010408a:	5d                   	pop    %ebp
8010408b:	89 d0                	mov    %edx,%eax
8010408d:	c3                   	ret    
8010408e:	66 90                	xchg   %ax,%ax

80104090 <getWaitingTime>:
int getWaitingTime(int pid) {
80104090:	f3 0f 1e fb          	endbr32 
80104094:	55                   	push   %ebp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104095:	ba b4 3d 11 80       	mov    $0x80113db4,%edx
int getWaitingTime(int pid) {
8010409a:	89 e5                	mov    %esp,%ebp
8010409c:	8b 45 08             	mov    0x8(%ebp),%eax
8010409f:	eb 15                	jmp    801040b6 <getWaitingTime+0x26>
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040a8:	81 c2 98 00 00 00    	add    $0x98,%edx
801040ae:	81 fa b4 63 11 80    	cmp    $0x801163b4,%edx
801040b4:	74 1a                	je     801040d0 <getWaitingTime+0x40>
    if (p->pid == pid) {
801040b6:	39 42 10             	cmp    %eax,0x10(%edx)
801040b9:	75 ed                	jne    801040a8 <getWaitingTime+0x18>
      return p->turnTime - p->runningTime;
801040bb:	8b 82 90 00 00 00    	mov    0x90(%edx),%eax
}
801040c1:	5d                   	pop    %ebp
      return p->turnTime - p->runningTime;
801040c2:	2b 82 84 00 00 00    	sub    0x84(%edx),%eax
}
801040c8:	c3                   	ret    
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
801040d0:	31 c0                	xor    %eax,%eax
}
801040d2:	5d                   	pop    %ebp
801040d3:	c3                   	ret    
801040d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040df:	90                   	nop

801040e0 <getCpuBurstTime>:
int getCpuBurstTime(int pid) {
801040e0:	f3 0f 1e fb          	endbr32 
801040e4:	55                   	push   %ebp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040e5:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
int getCpuBurstTime(int pid) {
801040ea:	89 e5                	mov    %esp,%ebp
801040ec:	8b 55 08             	mov    0x8(%ebp),%edx
801040ef:	eb 13                	jmp    80104104 <getCpuBurstTime+0x24>
801040f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801040f8:	05 98 00 00 00       	add    $0x98,%eax
801040fd:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104102:	74 14                	je     80104118 <getCpuBurstTime+0x38>
    if (p->pid == pid) {
80104104:	39 50 10             	cmp    %edx,0x10(%eax)
80104107:	75 ef                	jne    801040f8 <getCpuBurstTime+0x18>
      return p->runningTime;
80104109:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
8010410f:	5d                   	pop    %ebp
80104110:	c3                   	ret    
80104111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80104118:	31 c0                	xor    %eax,%eax
}
8010411a:	5d                   	pop    %ebp
8010411b:	c3                   	ret    
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104120 <sched>:
{
80104120:	f3 0f 1e fb          	endbr32 
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	56                   	push   %esi
80104128:	53                   	push   %ebx
  pushcli();
80104129:	e8 b2 09 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
8010412e:	e8 5d f8 ff ff       	call   80103990 <mycpu>
  p = c->proc;
80104133:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104139:	e8 f2 09 00 00       	call   80104b30 <popcli>
  if(!holding(&ptable.lock))
8010413e:	83 ec 0c             	sub    $0xc,%esp
80104141:	68 80 3d 11 80       	push   $0x80113d80
80104146:	e8 45 0a 00 00       	call   80104b90 <holding>
8010414b:	83 c4 10             	add    $0x10,%esp
8010414e:	85 c0                	test   %eax,%eax
80104150:	74 4f                	je     801041a1 <sched+0x81>
  if(mycpu()->ncli != 1)
80104152:	e8 39 f8 ff ff       	call   80103990 <mycpu>
80104157:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010415e:	75 68                	jne    801041c8 <sched+0xa8>
  if(p->state == RUNNING)
80104160:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104164:	74 55                	je     801041bb <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104166:	9c                   	pushf  
80104167:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104168:	f6 c4 02             	test   $0x2,%ah
8010416b:	75 41                	jne    801041ae <sched+0x8e>
  intena = mycpu()->intena;
8010416d:	e8 1e f8 ff ff       	call   80103990 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104172:	83 c3 24             	add    $0x24,%ebx
  intena = mycpu()->intena;
80104175:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010417b:	e8 10 f8 ff ff       	call   80103990 <mycpu>
80104180:	83 ec 08             	sub    $0x8,%esp
80104183:	ff 70 04             	pushl  0x4(%eax)
80104186:	53                   	push   %ebx
80104187:	e8 87 0d 00 00       	call   80104f13 <swtch>
  mycpu()->intena = intena;
8010418c:	e8 ff f7 ff ff       	call   80103990 <mycpu>
}
80104191:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104194:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010419a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010419d:	5b                   	pop    %ebx
8010419e:	5e                   	pop    %esi
8010419f:	5d                   	pop    %ebp
801041a0:	c3                   	ret    
    panic("sched ptable.lock");
801041a1:	83 ec 0c             	sub    $0xc,%esp
801041a4:	68 62 7e 10 80       	push   $0x80107e62
801041a9:	e8 e2 c1 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801041ae:	83 ec 0c             	sub    $0xc,%esp
801041b1:	68 8e 7e 10 80       	push   $0x80107e8e
801041b6:	e8 d5 c1 ff ff       	call   80100390 <panic>
    panic("sched running");
801041bb:	83 ec 0c             	sub    $0xc,%esp
801041be:	68 80 7e 10 80       	push   $0x80107e80
801041c3:	e8 c8 c1 ff ff       	call   80100390 <panic>
    panic("sched locks");
801041c8:	83 ec 0c             	sub    $0xc,%esp
801041cb:	68 74 7e 10 80       	push   $0x80107e74
801041d0:	e8 bb c1 ff ff       	call   80100390 <panic>
801041d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041e0 <exit>:
{
801041e0:	f3 0f 1e fb          	endbr32 
801041e4:	55                   	push   %ebp
801041e5:	89 e5                	mov    %esp,%ebp
801041e7:	57                   	push   %edi
801041e8:	56                   	push   %esi
801041e9:	53                   	push   %ebx
801041ea:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801041ed:	e8 ee 08 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
801041f2:	e8 99 f7 ff ff       	call   80103990 <mycpu>
  p = c->proc;
801041f7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041fd:	e8 2e 09 00 00       	call   80104b30 <popcli>
  if(curproc == initproc)
80104202:	8d 73 30             	lea    0x30(%ebx),%esi
80104205:	8d 7b 70             	lea    0x70(%ebx),%edi
80104208:	39 1d b8 b5 10 80    	cmp    %ebx,0x8010b5b8
8010420e:	0f 84 0d 01 00 00    	je     80104321 <exit+0x141>
80104214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104218:	8b 06                	mov    (%esi),%eax
8010421a:	85 c0                	test   %eax,%eax
8010421c:	74 12                	je     80104230 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010421e:	83 ec 0c             	sub    $0xc,%esp
80104221:	50                   	push   %eax
80104222:	e8 b9 cc ff ff       	call   80100ee0 <fileclose>
      curproc->ofile[fd] = 0;
80104227:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010422d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104230:	83 c6 04             	add    $0x4,%esi
80104233:	39 f7                	cmp    %esi,%edi
80104235:	75 e1                	jne    80104218 <exit+0x38>
  begin_op();
80104237:	e8 14 eb ff ff       	call   80102d50 <begin_op>
  iput(curproc->cwd);
8010423c:	83 ec 0c             	sub    $0xc,%esp
8010423f:	ff 73 70             	pushl  0x70(%ebx)
80104242:	e8 69 d6 ff ff       	call   801018b0 <iput>
  end_op();
80104247:	e8 74 eb ff ff       	call   80102dc0 <end_op>
  curproc->cwd = 0;
8010424c:	c7 43 70 00 00 00 00 	movl   $0x0,0x70(%ebx)
  acquire(&ptable.lock);
80104253:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010425a:	e8 81 09 00 00       	call   80104be0 <acquire>
  if(curproc->threads == -1){
8010425f:	83 c4 10             	add    $0x10,%esp
80104262:	83 7b 14 ff          	cmpl   $0xffffffff,0x14(%ebx)
80104266:	75 07                	jne    8010426f <exit+0x8f>
    curproc->parent->threads--;
80104268:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010426b:	83 68 14 01          	subl   $0x1,0x14(%eax)
  wakeup1(curproc->parent);
8010426f:	8b 53 1c             	mov    0x1c(%ebx),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104272:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104277:	eb 13                	jmp    8010428c <exit+0xac>
80104279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104280:	05 98 00 00 00       	add    $0x98,%eax
80104285:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
8010428a:	74 1e                	je     801042aa <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010428c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104290:	75 ee                	jne    80104280 <exit+0xa0>
80104292:	3b 50 28             	cmp    0x28(%eax),%edx
80104295:	75 e9                	jne    80104280 <exit+0xa0>
      p->state = RUNNABLE;
80104297:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010429e:	05 98 00 00 00       	add    $0x98,%eax
801042a3:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
801042a8:	75 e2                	jne    8010428c <exit+0xac>
      p->parent = initproc;
801042aa:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b0:	ba b4 3d 11 80       	mov    $0x80113db4,%edx
801042b5:	eb 17                	jmp    801042ce <exit+0xee>
801042b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042be:	66 90                	xchg   %ax,%ax
801042c0:	81 c2 98 00 00 00    	add    $0x98,%edx
801042c6:	81 fa b4 63 11 80    	cmp    $0x801163b4,%edx
801042cc:	74 3a                	je     80104308 <exit+0x128>
    if(p->parent == curproc){
801042ce:	39 5a 1c             	cmp    %ebx,0x1c(%edx)
801042d1:	75 ed                	jne    801042c0 <exit+0xe0>
      if(p->state == ZOMBIE)
801042d3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801042d7:	89 4a 1c             	mov    %ecx,0x1c(%edx)
      if(p->state == ZOMBIE)
801042da:	75 e4                	jne    801042c0 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042dc:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
801042e1:	eb 11                	jmp    801042f4 <exit+0x114>
801042e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042e7:	90                   	nop
801042e8:	05 98 00 00 00       	add    $0x98,%eax
801042ed:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
801042f2:	74 cc                	je     801042c0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
801042f4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801042f8:	75 ee                	jne    801042e8 <exit+0x108>
801042fa:	3b 48 28             	cmp    0x28(%eax),%ecx
801042fd:	75 e9                	jne    801042e8 <exit+0x108>
      p->state = RUNNABLE;
801042ff:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104306:	eb e0                	jmp    801042e8 <exit+0x108>
  curproc->state = ZOMBIE;
80104308:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010430f:	e8 0c fe ff ff       	call   80104120 <sched>
  panic("zombie exit");
80104314:	83 ec 0c             	sub    $0xc,%esp
80104317:	68 af 7e 10 80       	push   $0x80107eaf
8010431c:	e8 6f c0 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104321:	83 ec 0c             	sub    $0xc,%esp
80104324:	68 a2 7e 10 80       	push   $0x80107ea2
80104329:	e8 62 c0 ff ff       	call   80100390 <panic>
8010432e:	66 90                	xchg   %ax,%ax

80104330 <yield>:
{
80104330:	f3 0f 1e fb          	endbr32 
80104334:	55                   	push   %ebp
80104335:	89 e5                	mov    %esp,%ebp
80104337:	53                   	push   %ebx
80104338:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010433b:	68 80 3d 11 80       	push   $0x80113d80
80104340:	e8 9b 08 00 00       	call   80104be0 <acquire>
  pushcli();
80104345:	e8 96 07 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
8010434a:	e8 41 f6 ff ff       	call   80103990 <mycpu>
  p = c->proc;
8010434f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104355:	e8 d6 07 00 00       	call   80104b30 <popcli>
  myproc()->state = RUNNABLE;
8010435a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104361:	e8 ba fd ff ff       	call   80104120 <sched>
  release(&ptable.lock);
80104366:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010436d:	e8 2e 09 00 00       	call   80104ca0 <release>
}
80104372:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104375:	83 c4 10             	add    $0x10,%esp
80104378:	c9                   	leave  
80104379:	c3                   	ret    
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104380 <sleep>:
{
80104380:	f3 0f 1e fb          	endbr32 
80104384:	55                   	push   %ebp
80104385:	89 e5                	mov    %esp,%ebp
80104387:	57                   	push   %edi
80104388:	56                   	push   %esi
80104389:	53                   	push   %ebx
8010438a:	83 ec 0c             	sub    $0xc,%esp
8010438d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104390:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104393:	e8 48 07 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
80104398:	e8 f3 f5 ff ff       	call   80103990 <mycpu>
  p = c->proc;
8010439d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043a3:	e8 88 07 00 00       	call   80104b30 <popcli>
  if(p == 0)
801043a8:	85 db                	test   %ebx,%ebx
801043aa:	0f 84 83 00 00 00    	je     80104433 <sleep+0xb3>
  if(lk == 0)
801043b0:	85 f6                	test   %esi,%esi
801043b2:	74 72                	je     80104426 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801043b4:	81 fe 80 3d 11 80    	cmp    $0x80113d80,%esi
801043ba:	74 4c                	je     80104408 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801043bc:	83 ec 0c             	sub    $0xc,%esp
801043bf:	68 80 3d 11 80       	push   $0x80113d80
801043c4:	e8 17 08 00 00       	call   80104be0 <acquire>
    release(lk);
801043c9:	89 34 24             	mov    %esi,(%esp)
801043cc:	e8 cf 08 00 00       	call   80104ca0 <release>
  p->chan = chan;
801043d1:	89 7b 28             	mov    %edi,0x28(%ebx)
  p->state = SLEEPING;
801043d4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043db:	e8 40 fd ff ff       	call   80104120 <sched>
  p->chan = 0;
801043e0:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
    release(&ptable.lock);
801043e7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801043ee:	e8 ad 08 00 00       	call   80104ca0 <release>
    acquire(lk);
801043f3:	89 75 08             	mov    %esi,0x8(%ebp)
801043f6:	83 c4 10             	add    $0x10,%esp
}
801043f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043fc:	5b                   	pop    %ebx
801043fd:	5e                   	pop    %esi
801043fe:	5f                   	pop    %edi
801043ff:	5d                   	pop    %ebp
    acquire(lk);
80104400:	e9 db 07 00 00       	jmp    80104be0 <acquire>
80104405:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104408:	89 7b 28             	mov    %edi,0x28(%ebx)
  p->state = SLEEPING;
8010440b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104412:	e8 09 fd ff ff       	call   80104120 <sched>
  p->chan = 0;
80104417:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
}
8010441e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104421:	5b                   	pop    %ebx
80104422:	5e                   	pop    %esi
80104423:	5f                   	pop    %edi
80104424:	5d                   	pop    %ebp
80104425:	c3                   	ret    
    panic("sleep without lk");
80104426:	83 ec 0c             	sub    $0xc,%esp
80104429:	68 c1 7e 10 80       	push   $0x80107ec1
8010442e:	e8 5d bf ff ff       	call   80100390 <panic>
    panic("sleep");
80104433:	83 ec 0c             	sub    $0xc,%esp
80104436:	68 bb 7e 10 80       	push   $0x80107ebb
8010443b:	e8 50 bf ff ff       	call   80100390 <panic>

80104440 <join>:
int join(void) {
80104440:	f3 0f 1e fb          	endbr32 
80104444:	55                   	push   %ebp
80104445:	89 e5                	mov    %esp,%ebp
80104447:	56                   	push   %esi
80104448:	53                   	push   %ebx
  pushcli();
80104449:	e8 92 06 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
8010444e:	e8 3d f5 ff ff       	call   80103990 <mycpu>
  p = c->proc;
80104453:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104459:	e8 d2 06 00 00       	call   80104b30 <popcli>
  acquire(&ptable.lock);
8010445e:	83 ec 0c             	sub    $0xc,%esp
80104461:	68 80 3d 11 80       	push   $0x80113d80
80104466:	e8 75 07 00 00       	call   80104be0 <acquire>
8010446b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010446e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104470:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104475:	eb 17                	jmp    8010448e <join+0x4e>
80104477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447e:	66 90                	xchg   %ax,%ax
80104480:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104486:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
8010448c:	74 24                	je     801044b2 <join+0x72>
      if(p->parent != curproc)
8010448e:	39 73 1c             	cmp    %esi,0x1c(%ebx)
80104491:	75 ed                	jne    80104480 <join+0x40>
      if(p->threads != -1)
80104493:	83 7b 14 ff          	cmpl   $0xffffffff,0x14(%ebx)
80104497:	75 e7                	jne    80104480 <join+0x40>
      if(p->state == ZOMBIE){
80104499:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010449d:	74 41                	je     801044e0 <join+0xa0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010449f:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
801044a5:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044aa:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
801044b0:	75 dc                	jne    8010448e <join+0x4e>
    if(!havekids || curproc->killed){
801044b2:	85 c0                	test   %eax,%eax
801044b4:	0f 84 bf 00 00 00    	je     80104579 <join+0x139>
801044ba:	8b 46 2c             	mov    0x2c(%esi),%eax
801044bd:	85 c0                	test   %eax,%eax
801044bf:	0f 85 b4 00 00 00    	jne    80104579 <join+0x139>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801044c5:	83 ec 08             	sub    $0x8,%esp
801044c8:	68 80 3d 11 80       	push   $0x80113d80
801044cd:	56                   	push   %esi
801044ce:	e8 ad fe ff ff       	call   80104380 <sleep>
    havekids = 0;
801044d3:	83 c4 10             	add    $0x10,%esp
801044d6:	eb 96                	jmp    8010446e <join+0x2e>
801044d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044df:	90                   	nop
        kfree(p->kstack);
801044e0:	83 ec 0c             	sub    $0xc,%esp
801044e3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801044e6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801044e9:	e8 a2 df ff ff       	call   80102490 <kfree>
        p->kstack = 0;
801044ee:	8b 53 04             	mov    0x4(%ebx),%edx
801044f1:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801044f4:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
        p->kstack = 0;
801044f9:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104500:	eb 12                	jmp    80104514 <join+0xd4>
80104502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104508:	05 98 00 00 00       	add    $0x98,%eax
8010450d:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104512:	74 57                	je     8010456b <join+0x12b>
    if (p != process && p->pgdir != process->pgdir)
80104514:	39 c3                	cmp    %eax,%ebx
80104516:	74 f0                	je     80104508 <join+0xc8>
80104518:	39 50 04             	cmp    %edx,0x4(%eax)
8010451b:	74 eb                	je     80104508 <join+0xc8>
        release(&ptable.lock);
8010451d:	83 ec 0c             	sub    $0xc,%esp
        p->pid = 0;
80104520:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        release(&ptable.lock);
80104527:	68 80 3d 11 80       	push   $0x80113d80
        p->parent = 0;
8010452c:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
        p->name[0] = 0;
80104533:	c6 43 74 00          	movb   $0x0,0x74(%ebx)
        p->killed = 0;
80104537:	c7 43 2c 00 00 00 00 	movl   $0x0,0x2c(%ebx)
        p->state = UNUSED;
8010453e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->pgdir = 0;
80104545:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        p->stackTop = 0;
8010454c:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
        p->threads = -1;
80104553:	c7 43 14 ff ff ff ff 	movl   $0xffffffff,0x14(%ebx)
        release(&ptable.lock);
8010455a:	e8 41 07 00 00       	call   80104ca0 <release>
        return pid;
8010455f:	83 c4 10             	add    $0x10,%esp
}
80104562:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104565:	89 f0                	mov    %esi,%eax
80104567:	5b                   	pop    %ebx
80104568:	5e                   	pop    %esi
80104569:	5d                   	pop    %ebp
8010456a:	c3                   	ret    
          freevm(p->pgdir);
8010456b:	83 ec 0c             	sub    $0xc,%esp
8010456e:	52                   	push   %edx
8010456f:	e8 5c 30 00 00       	call   801075d0 <freevm>
80104574:	83 c4 10             	add    $0x10,%esp
80104577:	eb a4                	jmp    8010451d <join+0xdd>
      release(&ptable.lock);
80104579:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010457c:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104581:	68 80 3d 11 80       	push   $0x80113d80
80104586:	e8 15 07 00 00       	call   80104ca0 <release>
      return -1;
8010458b:	83 c4 10             	add    $0x10,%esp
8010458e:	eb d2                	jmp    80104562 <join+0x122>

80104590 <wait>:
{
80104590:	f3 0f 1e fb          	endbr32 
80104594:	55                   	push   %ebp
80104595:	89 e5                	mov    %esp,%ebp
80104597:	56                   	push   %esi
80104598:	53                   	push   %ebx
  pushcli();
80104599:	e8 42 05 00 00       	call   80104ae0 <pushcli>
  c = mycpu();
8010459e:	e8 ed f3 ff ff       	call   80103990 <mycpu>
  p = c->proc;
801045a3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801045a9:	e8 82 05 00 00       	call   80104b30 <popcli>
  acquire(&ptable.lock);
801045ae:	83 ec 0c             	sub    $0xc,%esp
801045b1:	68 80 3d 11 80       	push   $0x80113d80
801045b6:	e8 25 06 00 00       	call   80104be0 <acquire>
801045bb:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801045be:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c0:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
801045c5:	eb 17                	jmp    801045de <wait+0x4e>
801045c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ce:	66 90                	xchg   %ax,%ax
801045d0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801045d6:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
801045dc:	74 1e                	je     801045fc <wait+0x6c>
      if(p->parent != curproc)
801045de:	39 73 1c             	cmp    %esi,0x1c(%ebx)
801045e1:	75 ed                	jne    801045d0 <wait+0x40>
      if(p->state == ZOMBIE){
801045e3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801045e7:	74 3f                	je     80104628 <wait+0x98>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e9:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
801045ef:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045f4:	81 fb b4 63 11 80    	cmp    $0x801163b4,%ebx
801045fa:	75 e2                	jne    801045de <wait+0x4e>
    if(!havekids || curproc->killed){
801045fc:	85 c0                	test   %eax,%eax
801045fe:	0f 84 bd 00 00 00    	je     801046c1 <wait+0x131>
80104604:	8b 46 2c             	mov    0x2c(%esi),%eax
80104607:	85 c0                	test   %eax,%eax
80104609:	0f 85 b2 00 00 00    	jne    801046c1 <wait+0x131>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010460f:	83 ec 08             	sub    $0x8,%esp
80104612:	68 80 3d 11 80       	push   $0x80113d80
80104617:	56                   	push   %esi
80104618:	e8 63 fd ff ff       	call   80104380 <sleep>
    havekids = 0;
8010461d:	83 c4 10             	add    $0x10,%esp
80104620:	eb 9c                	jmp    801045be <wait+0x2e>
80104622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104628:	83 ec 0c             	sub    $0xc,%esp
8010462b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010462e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104631:	e8 5a de ff ff       	call   80102490 <kfree>
        p->kstack = 0;
80104636:	8b 53 04             	mov    0x4(%ebx),%edx
80104639:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010463c:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
        p->kstack = 0;
80104641:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104648:	eb 12                	jmp    8010465c <wait+0xcc>
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104650:	05 98 00 00 00       	add    $0x98,%eax
80104655:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
8010465a:	74 57                	je     801046b3 <wait+0x123>
    if (p != process && p->pgdir != process->pgdir)
8010465c:	39 c3                	cmp    %eax,%ebx
8010465e:	74 f0                	je     80104650 <wait+0xc0>
80104660:	39 50 04             	cmp    %edx,0x4(%eax)
80104663:	74 eb                	je     80104650 <wait+0xc0>
        release(&ptable.lock);
80104665:	83 ec 0c             	sub    $0xc,%esp
        p->pid = 0;
80104668:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        release(&ptable.lock);
8010466f:	68 80 3d 11 80       	push   $0x80113d80
        p->parent = 0;
80104674:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
        p->name[0] = 0;
8010467b:	c6 43 74 00          	movb   $0x0,0x74(%ebx)
        p->killed = 0;
8010467f:	c7 43 2c 00 00 00 00 	movl   $0x0,0x2c(%ebx)
        p->state = UNUSED;
80104686:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->stackTop = -1;
8010468d:	c7 43 18 ff ff ff ff 	movl   $0xffffffff,0x18(%ebx)
        p->pgdir = 0;
80104694:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        p->threads = -1;
8010469b:	c7 43 14 ff ff ff ff 	movl   $0xffffffff,0x14(%ebx)
        release(&ptable.lock);
801046a2:	e8 f9 05 00 00       	call   80104ca0 <release>
        return pid;
801046a7:	83 c4 10             	add    $0x10,%esp
}
801046aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046ad:	89 f0                	mov    %esi,%eax
801046af:	5b                   	pop    %ebx
801046b0:	5e                   	pop    %esi
801046b1:	5d                   	pop    %ebp
801046b2:	c3                   	ret    
          freevm(p->pgdir);
801046b3:	83 ec 0c             	sub    $0xc,%esp
801046b6:	52                   	push   %edx
801046b7:	e8 14 2f 00 00       	call   801075d0 <freevm>
801046bc:	83 c4 10             	add    $0x10,%esp
801046bf:	eb a4                	jmp    80104665 <wait+0xd5>
      release(&ptable.lock);
801046c1:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801046c4:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801046c9:	68 80 3d 11 80       	push   $0x80113d80
801046ce:	e8 cd 05 00 00       	call   80104ca0 <release>
      return -1;
801046d3:	83 c4 10             	add    $0x10,%esp
801046d6:	eb d2                	jmp    801046aa <wait+0x11a>
801046d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046df:	90                   	nop

801046e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801046e0:	f3 0f 1e fb          	endbr32 
801046e4:	55                   	push   %ebp
801046e5:	89 e5                	mov    %esp,%ebp
801046e7:	53                   	push   %ebx
801046e8:	83 ec 10             	sub    $0x10,%esp
801046eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801046ee:	68 80 3d 11 80       	push   $0x80113d80
801046f3:	e8 e8 04 00 00       	call   80104be0 <acquire>
801046f8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046fb:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104700:	eb 12                	jmp    80104714 <wakeup+0x34>
80104702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104708:	05 98 00 00 00       	add    $0x98,%eax
8010470d:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104712:	74 1e                	je     80104732 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104714:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104718:	75 ee                	jne    80104708 <wakeup+0x28>
8010471a:	3b 58 28             	cmp    0x28(%eax),%ebx
8010471d:	75 e9                	jne    80104708 <wakeup+0x28>
      p->state = RUNNABLE;
8010471f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104726:	05 98 00 00 00       	add    $0x98,%eax
8010472b:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104730:	75 e2                	jne    80104714 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104732:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80104739:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010473c:	c9                   	leave  
  release(&ptable.lock);
8010473d:	e9 5e 05 00 00       	jmp    80104ca0 <release>
80104742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104750 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104750:	f3 0f 1e fb          	endbr32 
80104754:	55                   	push   %ebp
80104755:	89 e5                	mov    %esp,%ebp
80104757:	53                   	push   %ebx
80104758:	83 ec 10             	sub    $0x10,%esp
8010475b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010475e:	68 80 3d 11 80       	push   $0x80113d80
80104763:	e8 78 04 00 00       	call   80104be0 <acquire>
80104768:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010476b:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104770:	eb 12                	jmp    80104784 <kill+0x34>
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	05 98 00 00 00       	add    $0x98,%eax
8010477d:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104782:	74 34                	je     801047b8 <kill+0x68>
    if(p->pid == pid){
80104784:	39 58 10             	cmp    %ebx,0x10(%eax)
80104787:	75 ef                	jne    80104778 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104789:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010478d:	c7 40 2c 01 00 00 00 	movl   $0x1,0x2c(%eax)
      if(p->state == SLEEPING)
80104794:	75 07                	jne    8010479d <kill+0x4d>
        p->state = RUNNABLE;
80104796:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010479d:	83 ec 0c             	sub    $0xc,%esp
801047a0:	68 80 3d 11 80       	push   $0x80113d80
801047a5:	e8 f6 04 00 00       	call   80104ca0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801047aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801047ad:	83 c4 10             	add    $0x10,%esp
801047b0:	31 c0                	xor    %eax,%eax
}
801047b2:	c9                   	leave  
801047b3:	c3                   	ret    
801047b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801047b8:	83 ec 0c             	sub    $0xc,%esp
801047bb:	68 80 3d 11 80       	push   $0x80113d80
801047c0:	e8 db 04 00 00       	call   80104ca0 <release>
}
801047c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801047c8:	83 c4 10             	add    $0x10,%esp
801047cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047d0:	c9                   	leave  
801047d1:	c3                   	ret    
801047d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801047e0:	f3 0f 1e fb          	endbr32 
801047e4:	55                   	push   %ebp
801047e5:	89 e5                	mov    %esp,%ebp
801047e7:	57                   	push   %edi
801047e8:	56                   	push   %esi
801047e9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801047ec:	53                   	push   %ebx
801047ed:	bb 28 3e 11 80       	mov    $0x80113e28,%ebx
801047f2:	83 ec 3c             	sub    $0x3c,%esp
801047f5:	eb 2b                	jmp    80104822 <procdump+0x42>
801047f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047fe:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	68 77 82 10 80       	push   $0x80108277
80104808:	e8 a3 be ff ff       	call   801006b0 <cprintf>
8010480d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104810:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104816:	81 fb 28 64 11 80    	cmp    $0x80116428,%ebx
8010481c:	0f 84 8e 00 00 00    	je     801048b0 <procdump+0xd0>
    if(p->state == UNUSED)
80104822:	8b 43 98             	mov    -0x68(%ebx),%eax
80104825:	85 c0                	test   %eax,%eax
80104827:	74 e7                	je     80104810 <procdump+0x30>
      state = "???";
80104829:	ba d2 7e 10 80       	mov    $0x80107ed2,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010482e:	83 f8 05             	cmp    $0x5,%eax
80104831:	77 11                	ja     80104844 <procdump+0x64>
80104833:	8b 14 85 44 7f 10 80 	mov    -0x7fef80bc(,%eax,4),%edx
      state = "???";
8010483a:	b8 d2 7e 10 80       	mov    $0x80107ed2,%eax
8010483f:	85 d2                	test   %edx,%edx
80104841:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104844:	53                   	push   %ebx
80104845:	52                   	push   %edx
80104846:	ff 73 9c             	pushl  -0x64(%ebx)
80104849:	68 d6 7e 10 80       	push   $0x80107ed6
8010484e:	e8 5d be ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104853:	83 c4 10             	add    $0x10,%esp
80104856:	83 7b 98 02          	cmpl   $0x2,-0x68(%ebx)
8010485a:	75 a4                	jne    80104800 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010485c:	83 ec 08             	sub    $0x8,%esp
8010485f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104862:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104865:	50                   	push   %eax
80104866:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104869:	8b 40 0c             	mov    0xc(%eax),%eax
8010486c:	83 c0 08             	add    $0x8,%eax
8010486f:	50                   	push   %eax
80104870:	e8 0b 02 00 00       	call   80104a80 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104875:	83 c4 10             	add    $0x10,%esp
80104878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010487f:	90                   	nop
80104880:	8b 17                	mov    (%edi),%edx
80104882:	85 d2                	test   %edx,%edx
80104884:	0f 84 76 ff ff ff    	je     80104800 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010488a:	83 ec 08             	sub    $0x8,%esp
8010488d:	83 c7 04             	add    $0x4,%edi
80104890:	52                   	push   %edx
80104891:	68 21 79 10 80       	push   $0x80107921
80104896:	e8 15 be ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010489b:	83 c4 10             	add    $0x10,%esp
8010489e:	39 fe                	cmp    %edi,%esi
801048a0:	75 de                	jne    80104880 <procdump+0xa0>
801048a2:	e9 59 ff ff ff       	jmp    80104800 <procdump+0x20>
801048a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ae:	66 90                	xchg   %ax,%ax
  }
}
801048b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048b3:	5b                   	pop    %ebx
801048b4:	5e                   	pop    %esi
801048b5:	5f                   	pop    %edi
801048b6:	5d                   	pop    %ebp
801048b7:	c3                   	ret    
801048b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048bf:	90                   	nop

801048c0 <getHelloWorld>:

int getHelloWorld(void) {
801048c0:	f3 0f 1e fb          	endbr32 
801048c4:	55                   	push   %ebp
801048c5:	89 e5                	mov    %esp,%ebp
801048c7:	83 ec 14             	sub    $0x14,%esp
  cprintf("Hello, World!");
801048ca:	68 df 7e 10 80       	push   $0x80107edf
801048cf:	e8 dc bd ff ff       	call   801006b0 <cprintf>
  return 0;
}
801048d4:	31 c0                	xor    %eax,%eax
801048d6:	c9                   	leave  
801048d7:	c3                   	ret    
801048d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048df:	90                   	nop

801048e0 <getProcCount>:

int getProcCount(void) {
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
  int counter;
  counter = 0;
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048e5:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
int getProcCount(void) {
801048ea:	89 e5                	mov    %esp,%ebp
801048ec:	53                   	push   %ebx
  counter = 0;
801048ed:	31 db                	xor    %ebx,%ebx
int getProcCount(void) {
801048ef:	83 ec 04             	sub    $0x4,%esp
801048f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state != UNUSED)
      counter++;
801048f8:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
801048fc:	83 db ff             	sbb    $0xffffffff,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048ff:	05 98 00 00 00       	add    $0x98,%eax
80104904:	3d b4 63 11 80       	cmp    $0x801163b4,%eax
80104909:	75 ed                	jne    801048f8 <getProcCount+0x18>
  }
  cprintf("%d", counter);
8010490b:	83 ec 08             	sub    $0x8,%esp
8010490e:	53                   	push   %ebx
8010490f:	68 ed 7e 10 80       	push   $0x80107eed
80104914:	e8 97 bd ff ff       	call   801006b0 <cprintf>
  return counter;
}
80104919:	89 d8                	mov    %ebx,%eax
8010491b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010491e:	c9                   	leave  
8010491f:	c3                   	ret    

80104920 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104920:	f3 0f 1e fb          	endbr32 
80104924:	55                   	push   %ebp
80104925:	89 e5                	mov    %esp,%ebp
80104927:	53                   	push   %ebx
80104928:	83 ec 0c             	sub    $0xc,%esp
8010492b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010492e:	68 5c 7f 10 80       	push   $0x80107f5c
80104933:	8d 43 04             	lea    0x4(%ebx),%eax
80104936:	50                   	push   %eax
80104937:	e8 24 01 00 00       	call   80104a60 <initlock>
  lk->name = name;
8010493c:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010493f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104945:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104948:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010494f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104952:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104955:	c9                   	leave  
80104956:	c3                   	ret    
80104957:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010495e:	66 90                	xchg   %ax,%ax

80104960 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104960:	f3 0f 1e fb          	endbr32 
80104964:	55                   	push   %ebp
80104965:	89 e5                	mov    %esp,%ebp
80104967:	56                   	push   %esi
80104968:	53                   	push   %ebx
80104969:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010496c:	8d 73 04             	lea    0x4(%ebx),%esi
8010496f:	83 ec 0c             	sub    $0xc,%esp
80104972:	56                   	push   %esi
80104973:	e8 68 02 00 00       	call   80104be0 <acquire>
  while (lk->locked) {
80104978:	8b 13                	mov    (%ebx),%edx
8010497a:	83 c4 10             	add    $0x10,%esp
8010497d:	85 d2                	test   %edx,%edx
8010497f:	74 1a                	je     8010499b <acquiresleep+0x3b>
80104981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104988:	83 ec 08             	sub    $0x8,%esp
8010498b:	56                   	push   %esi
8010498c:	53                   	push   %ebx
8010498d:	e8 ee f9 ff ff       	call   80104380 <sleep>
  while (lk->locked) {
80104992:	8b 03                	mov    (%ebx),%eax
80104994:	83 c4 10             	add    $0x10,%esp
80104997:	85 c0                	test   %eax,%eax
80104999:	75 ed                	jne    80104988 <acquiresleep+0x28>
  }
  lk->locked = 1;
8010499b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801049a1:	e8 7a f0 ff ff       	call   80103a20 <myproc>
801049a6:	8b 40 10             	mov    0x10(%eax),%eax
801049a9:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801049ac:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049b2:	5b                   	pop    %ebx
801049b3:	5e                   	pop    %esi
801049b4:	5d                   	pop    %ebp
  release(&lk->lk);
801049b5:	e9 e6 02 00 00       	jmp    80104ca0 <release>
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801049c0:	f3 0f 1e fb          	endbr32 
801049c4:	55                   	push   %ebp
801049c5:	89 e5                	mov    %esp,%ebp
801049c7:	56                   	push   %esi
801049c8:	53                   	push   %ebx
801049c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801049cc:	8d 73 04             	lea    0x4(%ebx),%esi
801049cf:	83 ec 0c             	sub    $0xc,%esp
801049d2:	56                   	push   %esi
801049d3:	e8 08 02 00 00       	call   80104be0 <acquire>
  lk->locked = 0;
801049d8:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801049de:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801049e5:	89 1c 24             	mov    %ebx,(%esp)
801049e8:	e8 f3 fc ff ff       	call   801046e0 <wakeup>
  release(&lk->lk);
801049ed:	89 75 08             	mov    %esi,0x8(%ebp)
801049f0:	83 c4 10             	add    $0x10,%esp
}
801049f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049f6:	5b                   	pop    %ebx
801049f7:	5e                   	pop    %esi
801049f8:	5d                   	pop    %ebp
  release(&lk->lk);
801049f9:	e9 a2 02 00 00       	jmp    80104ca0 <release>
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	89 e5                	mov    %esp,%ebp
80104a07:	57                   	push   %edi
80104a08:	31 ff                	xor    %edi,%edi
80104a0a:	56                   	push   %esi
80104a0b:	53                   	push   %ebx
80104a0c:	83 ec 18             	sub    $0x18,%esp
80104a0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104a12:	8d 73 04             	lea    0x4(%ebx),%esi
80104a15:	56                   	push   %esi
80104a16:	e8 c5 01 00 00       	call   80104be0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104a1b:	8b 03                	mov    (%ebx),%eax
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	85 c0                	test   %eax,%eax
80104a22:	75 1c                	jne    80104a40 <holdingsleep+0x40>
  release(&lk->lk);
80104a24:	83 ec 0c             	sub    $0xc,%esp
80104a27:	56                   	push   %esi
80104a28:	e8 73 02 00 00       	call   80104ca0 <release>
  return r;
}
80104a2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a30:	89 f8                	mov    %edi,%eax
80104a32:	5b                   	pop    %ebx
80104a33:	5e                   	pop    %esi
80104a34:	5f                   	pop    %edi
80104a35:	5d                   	pop    %ebp
80104a36:	c3                   	ret    
80104a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a3e:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104a40:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a43:	e8 d8 ef ff ff       	call   80103a20 <myproc>
80104a48:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a4b:	0f 94 c0             	sete   %al
80104a4e:	0f b6 c0             	movzbl %al,%eax
80104a51:	89 c7                	mov    %eax,%edi
80104a53:	eb cf                	jmp    80104a24 <holdingsleep+0x24>
80104a55:	66 90                	xchg   %ax,%ax
80104a57:	66 90                	xchg   %ax,%ax
80104a59:	66 90                	xchg   %ax,%ax
80104a5b:	66 90                	xchg   %ax,%ax
80104a5d:	66 90                	xchg   %ax,%ax
80104a5f:	90                   	nop

80104a60 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a60:	f3 0f 1e fb          	endbr32 
80104a64:	55                   	push   %ebp
80104a65:	89 e5                	mov    %esp,%ebp
80104a67:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a6d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104a73:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104a76:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104a7d:	5d                   	pop    %ebp
80104a7e:	c3                   	ret    
80104a7f:	90                   	nop

80104a80 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104a80:	f3 0f 1e fb          	endbr32 
80104a84:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a85:	31 d2                	xor    %edx,%edx
{
80104a87:	89 e5                	mov    %esp,%ebp
80104a89:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104a8a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104a8d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104a90:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104a93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a97:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a98:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104a9e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104aa4:	77 1a                	ja     80104ac0 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104aa6:	8b 58 04             	mov    0x4(%eax),%ebx
80104aa9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104aac:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104aaf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ab1:	83 fa 0a             	cmp    $0xa,%edx
80104ab4:	75 e2                	jne    80104a98 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104ab6:	5b                   	pop    %ebx
80104ab7:	5d                   	pop    %ebp
80104ab8:	c3                   	ret    
80104ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104ac0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104ac3:	8d 51 28             	lea    0x28(%ecx),%edx
80104ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104acd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104ad0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ad6:	83 c0 04             	add    $0x4,%eax
80104ad9:	39 d0                	cmp    %edx,%eax
80104adb:	75 f3                	jne    80104ad0 <getcallerpcs+0x50>
}
80104add:	5b                   	pop    %ebx
80104ade:	5d                   	pop    %ebp
80104adf:	c3                   	ret    

80104ae0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104ae0:	f3 0f 1e fb          	endbr32 
80104ae4:	55                   	push   %ebp
80104ae5:	89 e5                	mov    %esp,%ebp
80104ae7:	53                   	push   %ebx
80104ae8:	83 ec 04             	sub    $0x4,%esp
80104aeb:	9c                   	pushf  
80104aec:	5b                   	pop    %ebx
  asm volatile("cli");
80104aed:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104aee:	e8 9d ee ff ff       	call   80103990 <mycpu>
80104af3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104af9:	85 c0                	test   %eax,%eax
80104afb:	74 13                	je     80104b10 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104afd:	e8 8e ee ff ff       	call   80103990 <mycpu>
80104b02:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104b09:	83 c4 04             	add    $0x4,%esp
80104b0c:	5b                   	pop    %ebx
80104b0d:	5d                   	pop    %ebp
80104b0e:	c3                   	ret    
80104b0f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104b10:	e8 7b ee ff ff       	call   80103990 <mycpu>
80104b15:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b1b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b21:	eb da                	jmp    80104afd <pushcli+0x1d>
80104b23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b30 <popcli>:

void
popcli(void)
{
80104b30:	f3 0f 1e fb          	endbr32 
80104b34:	55                   	push   %ebp
80104b35:	89 e5                	mov    %esp,%ebp
80104b37:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b3a:	9c                   	pushf  
80104b3b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b3c:	f6 c4 02             	test   $0x2,%ah
80104b3f:	75 31                	jne    80104b72 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104b41:	e8 4a ee ff ff       	call   80103990 <mycpu>
80104b46:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b4d:	78 30                	js     80104b7f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b4f:	e8 3c ee ff ff       	call   80103990 <mycpu>
80104b54:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b5a:	85 d2                	test   %edx,%edx
80104b5c:	74 02                	je     80104b60 <popcli+0x30>
    sti();
}
80104b5e:	c9                   	leave  
80104b5f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b60:	e8 2b ee ff ff       	call   80103990 <mycpu>
80104b65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b6b:	85 c0                	test   %eax,%eax
80104b6d:	74 ef                	je     80104b5e <popcli+0x2e>
  asm volatile("sti");
80104b6f:	fb                   	sti    
}
80104b70:	c9                   	leave  
80104b71:	c3                   	ret    
    panic("popcli - interruptible");
80104b72:	83 ec 0c             	sub    $0xc,%esp
80104b75:	68 67 7f 10 80       	push   $0x80107f67
80104b7a:	e8 11 b8 ff ff       	call   80100390 <panic>
    panic("popcli");
80104b7f:	83 ec 0c             	sub    $0xc,%esp
80104b82:	68 7e 7f 10 80       	push   $0x80107f7e
80104b87:	e8 04 b8 ff ff       	call   80100390 <panic>
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b90 <holding>:
{
80104b90:	f3 0f 1e fb          	endbr32 
80104b94:	55                   	push   %ebp
80104b95:	89 e5                	mov    %esp,%ebp
80104b97:	56                   	push   %esi
80104b98:	53                   	push   %ebx
80104b99:	8b 75 08             	mov    0x8(%ebp),%esi
80104b9c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104b9e:	e8 3d ff ff ff       	call   80104ae0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104ba3:	8b 06                	mov    (%esi),%eax
80104ba5:	85 c0                	test   %eax,%eax
80104ba7:	75 0f                	jne    80104bb8 <holding+0x28>
  popcli();
80104ba9:	e8 82 ff ff ff       	call   80104b30 <popcli>
}
80104bae:	89 d8                	mov    %ebx,%eax
80104bb0:	5b                   	pop    %ebx
80104bb1:	5e                   	pop    %esi
80104bb2:	5d                   	pop    %ebp
80104bb3:	c3                   	ret    
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104bb8:	8b 5e 08             	mov    0x8(%esi),%ebx
80104bbb:	e8 d0 ed ff ff       	call   80103990 <mycpu>
80104bc0:	39 c3                	cmp    %eax,%ebx
80104bc2:	0f 94 c3             	sete   %bl
  popcli();
80104bc5:	e8 66 ff ff ff       	call   80104b30 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104bca:	0f b6 db             	movzbl %bl,%ebx
}
80104bcd:	89 d8                	mov    %ebx,%eax
80104bcf:	5b                   	pop    %ebx
80104bd0:	5e                   	pop    %esi
80104bd1:	5d                   	pop    %ebp
80104bd2:	c3                   	ret    
80104bd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104be0 <acquire>:
{
80104be0:	f3 0f 1e fb          	endbr32 
80104be4:	55                   	push   %ebp
80104be5:	89 e5                	mov    %esp,%ebp
80104be7:	56                   	push   %esi
80104be8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104be9:	e8 f2 fe ff ff       	call   80104ae0 <pushcli>
  if(holding(lk))
80104bee:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104bf1:	83 ec 0c             	sub    $0xc,%esp
80104bf4:	53                   	push   %ebx
80104bf5:	e8 96 ff ff ff       	call   80104b90 <holding>
80104bfa:	83 c4 10             	add    $0x10,%esp
80104bfd:	85 c0                	test   %eax,%eax
80104bff:	0f 85 7f 00 00 00    	jne    80104c84 <acquire+0xa4>
80104c05:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104c07:	ba 01 00 00 00       	mov    $0x1,%edx
80104c0c:	eb 05                	jmp    80104c13 <acquire+0x33>
80104c0e:	66 90                	xchg   %ax,%ax
80104c10:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c13:	89 d0                	mov    %edx,%eax
80104c15:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c18:	85 c0                	test   %eax,%eax
80104c1a:	75 f4                	jne    80104c10 <acquire+0x30>
  __sync_synchronize();
80104c1c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c21:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c24:	e8 67 ed ff ff       	call   80103990 <mycpu>
80104c29:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104c2c:	89 e8                	mov    %ebp,%eax
80104c2e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c30:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104c36:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104c3c:	77 22                	ja     80104c60 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104c3e:	8b 50 04             	mov    0x4(%eax),%edx
80104c41:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104c45:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104c48:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104c4a:	83 fe 0a             	cmp    $0xa,%esi
80104c4d:	75 e1                	jne    80104c30 <acquire+0x50>
}
80104c4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c52:	5b                   	pop    %ebx
80104c53:	5e                   	pop    %esi
80104c54:	5d                   	pop    %ebp
80104c55:	c3                   	ret    
80104c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104c60:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104c64:	83 c3 34             	add    $0x34,%ebx
80104c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c76:	83 c0 04             	add    $0x4,%eax
80104c79:	39 d8                	cmp    %ebx,%eax
80104c7b:	75 f3                	jne    80104c70 <acquire+0x90>
}
80104c7d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c80:	5b                   	pop    %ebx
80104c81:	5e                   	pop    %esi
80104c82:	5d                   	pop    %ebp
80104c83:	c3                   	ret    
    panic("acquire");
80104c84:	83 ec 0c             	sub    $0xc,%esp
80104c87:	68 85 7f 10 80       	push   $0x80107f85
80104c8c:	e8 ff b6 ff ff       	call   80100390 <panic>
80104c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop

80104ca0 <release>:
{
80104ca0:	f3 0f 1e fb          	endbr32 
80104ca4:	55                   	push   %ebp
80104ca5:	89 e5                	mov    %esp,%ebp
80104ca7:	53                   	push   %ebx
80104ca8:	83 ec 10             	sub    $0x10,%esp
80104cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104cae:	53                   	push   %ebx
80104caf:	e8 dc fe ff ff       	call   80104b90 <holding>
80104cb4:	83 c4 10             	add    $0x10,%esp
80104cb7:	85 c0                	test   %eax,%eax
80104cb9:	74 22                	je     80104cdd <release+0x3d>
  lk->pcs[0] = 0;
80104cbb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104cc2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104cc9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104cce:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104cd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd7:	c9                   	leave  
  popcli();
80104cd8:	e9 53 fe ff ff       	jmp    80104b30 <popcli>
    panic("release");
80104cdd:	83 ec 0c             	sub    $0xc,%esp
80104ce0:	68 8d 7f 10 80       	push   $0x80107f8d
80104ce5:	e8 a6 b6 ff ff       	call   80100390 <panic>
80104cea:	66 90                	xchg   %ax,%ax
80104cec:	66 90                	xchg   %ax,%ax
80104cee:	66 90                	xchg   %ax,%ax

80104cf0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104cf0:	f3 0f 1e fb          	endbr32 
80104cf4:	55                   	push   %ebp
80104cf5:	89 e5                	mov    %esp,%ebp
80104cf7:	57                   	push   %edi
80104cf8:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104cfe:	53                   	push   %ebx
80104cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104d02:	89 d7                	mov    %edx,%edi
80104d04:	09 cf                	or     %ecx,%edi
80104d06:	83 e7 03             	and    $0x3,%edi
80104d09:	75 25                	jne    80104d30 <memset+0x40>
    c &= 0xFF;
80104d0b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d0e:	c1 e0 18             	shl    $0x18,%eax
80104d11:	89 fb                	mov    %edi,%ebx
80104d13:	c1 e9 02             	shr    $0x2,%ecx
80104d16:	c1 e3 10             	shl    $0x10,%ebx
80104d19:	09 d8                	or     %ebx,%eax
80104d1b:	09 f8                	or     %edi,%eax
80104d1d:	c1 e7 08             	shl    $0x8,%edi
80104d20:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104d22:	89 d7                	mov    %edx,%edi
80104d24:	fc                   	cld    
80104d25:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104d27:	5b                   	pop    %ebx
80104d28:	89 d0                	mov    %edx,%eax
80104d2a:	5f                   	pop    %edi
80104d2b:	5d                   	pop    %ebp
80104d2c:	c3                   	ret    
80104d2d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104d30:	89 d7                	mov    %edx,%edi
80104d32:	fc                   	cld    
80104d33:	f3 aa                	rep stos %al,%es:(%edi)
80104d35:	5b                   	pop    %ebx
80104d36:	89 d0                	mov    %edx,%eax
80104d38:	5f                   	pop    %edi
80104d39:	5d                   	pop    %ebp
80104d3a:	c3                   	ret    
80104d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d3f:	90                   	nop

80104d40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d40:	f3 0f 1e fb          	endbr32 
80104d44:	55                   	push   %ebp
80104d45:	89 e5                	mov    %esp,%ebp
80104d47:	56                   	push   %esi
80104d48:	8b 75 10             	mov    0x10(%ebp),%esi
80104d4b:	8b 55 08             	mov    0x8(%ebp),%edx
80104d4e:	53                   	push   %ebx
80104d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d52:	85 f6                	test   %esi,%esi
80104d54:	74 2a                	je     80104d80 <memcmp+0x40>
80104d56:	01 c6                	add    %eax,%esi
80104d58:	eb 10                	jmp    80104d6a <memcmp+0x2a>
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d60:	83 c0 01             	add    $0x1,%eax
80104d63:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d66:	39 f0                	cmp    %esi,%eax
80104d68:	74 16                	je     80104d80 <memcmp+0x40>
    if(*s1 != *s2)
80104d6a:	0f b6 0a             	movzbl (%edx),%ecx
80104d6d:	0f b6 18             	movzbl (%eax),%ebx
80104d70:	38 d9                	cmp    %bl,%cl
80104d72:	74 ec                	je     80104d60 <memcmp+0x20>
      return *s1 - *s2;
80104d74:	0f b6 c1             	movzbl %cl,%eax
80104d77:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104d79:	5b                   	pop    %ebx
80104d7a:	5e                   	pop    %esi
80104d7b:	5d                   	pop    %ebp
80104d7c:	c3                   	ret    
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi
80104d80:	5b                   	pop    %ebx
  return 0;
80104d81:	31 c0                	xor    %eax,%eax
}
80104d83:	5e                   	pop    %esi
80104d84:	5d                   	pop    %ebp
80104d85:	c3                   	ret    
80104d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi

80104d90 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104d90:	f3 0f 1e fb          	endbr32 
80104d94:	55                   	push   %ebp
80104d95:	89 e5                	mov    %esp,%ebp
80104d97:	57                   	push   %edi
80104d98:	8b 55 08             	mov    0x8(%ebp),%edx
80104d9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d9e:	56                   	push   %esi
80104d9f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104da2:	39 d6                	cmp    %edx,%esi
80104da4:	73 2a                	jae    80104dd0 <memmove+0x40>
80104da6:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104da9:	39 fa                	cmp    %edi,%edx
80104dab:	73 23                	jae    80104dd0 <memmove+0x40>
80104dad:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104db0:	85 c9                	test   %ecx,%ecx
80104db2:	74 13                	je     80104dc7 <memmove+0x37>
80104db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104db8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104dbc:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104dbf:	83 e8 01             	sub    $0x1,%eax
80104dc2:	83 f8 ff             	cmp    $0xffffffff,%eax
80104dc5:	75 f1                	jne    80104db8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104dc7:	5e                   	pop    %esi
80104dc8:	89 d0                	mov    %edx,%eax
80104dca:	5f                   	pop    %edi
80104dcb:	5d                   	pop    %ebp
80104dcc:	c3                   	ret    
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80104dd0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104dd3:	89 d7                	mov    %edx,%edi
80104dd5:	85 c9                	test   %ecx,%ecx
80104dd7:	74 ee                	je     80104dc7 <memmove+0x37>
80104dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104de0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104de1:	39 f0                	cmp    %esi,%eax
80104de3:	75 fb                	jne    80104de0 <memmove+0x50>
}
80104de5:	5e                   	pop    %esi
80104de6:	89 d0                	mov    %edx,%eax
80104de8:	5f                   	pop    %edi
80104de9:	5d                   	pop    %ebp
80104dea:	c3                   	ret    
80104deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104def:	90                   	nop

80104df0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104df0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80104df4:	eb 9a                	jmp    80104d90 <memmove>
80104df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi

80104e00 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e00:	f3 0f 1e fb          	endbr32 
80104e04:	55                   	push   %ebp
80104e05:	89 e5                	mov    %esp,%ebp
80104e07:	56                   	push   %esi
80104e08:	8b 75 10             	mov    0x10(%ebp),%esi
80104e0b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e0e:	53                   	push   %ebx
80104e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104e12:	85 f6                	test   %esi,%esi
80104e14:	74 32                	je     80104e48 <strncmp+0x48>
80104e16:	01 c6                	add    %eax,%esi
80104e18:	eb 14                	jmp    80104e2e <strncmp+0x2e>
80104e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e20:	38 da                	cmp    %bl,%dl
80104e22:	75 14                	jne    80104e38 <strncmp+0x38>
    n--, p++, q++;
80104e24:	83 c0 01             	add    $0x1,%eax
80104e27:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e2a:	39 f0                	cmp    %esi,%eax
80104e2c:	74 1a                	je     80104e48 <strncmp+0x48>
80104e2e:	0f b6 11             	movzbl (%ecx),%edx
80104e31:	0f b6 18             	movzbl (%eax),%ebx
80104e34:	84 d2                	test   %dl,%dl
80104e36:	75 e8                	jne    80104e20 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104e38:	0f b6 c2             	movzbl %dl,%eax
80104e3b:	29 d8                	sub    %ebx,%eax
}
80104e3d:	5b                   	pop    %ebx
80104e3e:	5e                   	pop    %esi
80104e3f:	5d                   	pop    %ebp
80104e40:	c3                   	ret    
80104e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e48:	5b                   	pop    %ebx
    return 0;
80104e49:	31 c0                	xor    %eax,%eax
}
80104e4b:	5e                   	pop    %esi
80104e4c:	5d                   	pop    %ebp
80104e4d:	c3                   	ret    
80104e4e:	66 90                	xchg   %ax,%ax

80104e50 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e50:	f3 0f 1e fb          	endbr32 
80104e54:	55                   	push   %ebp
80104e55:	89 e5                	mov    %esp,%ebp
80104e57:	57                   	push   %edi
80104e58:	56                   	push   %esi
80104e59:	8b 75 08             	mov    0x8(%ebp),%esi
80104e5c:	53                   	push   %ebx
80104e5d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e60:	89 f2                	mov    %esi,%edx
80104e62:	eb 1b                	jmp    80104e7f <strncpy+0x2f>
80104e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e68:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e6f:	83 c2 01             	add    $0x1,%edx
80104e72:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104e76:	89 f9                	mov    %edi,%ecx
80104e78:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e7b:	84 c9                	test   %cl,%cl
80104e7d:	74 09                	je     80104e88 <strncpy+0x38>
80104e7f:	89 c3                	mov    %eax,%ebx
80104e81:	83 e8 01             	sub    $0x1,%eax
80104e84:	85 db                	test   %ebx,%ebx
80104e86:	7f e0                	jg     80104e68 <strncpy+0x18>
    ;
  while(n-- > 0)
80104e88:	89 d1                	mov    %edx,%ecx
80104e8a:	85 c0                	test   %eax,%eax
80104e8c:	7e 15                	jle    80104ea3 <strncpy+0x53>
80104e8e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104e90:	83 c1 01             	add    $0x1,%ecx
80104e93:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104e97:	89 c8                	mov    %ecx,%eax
80104e99:	f7 d0                	not    %eax
80104e9b:	01 d0                	add    %edx,%eax
80104e9d:	01 d8                	add    %ebx,%eax
80104e9f:	85 c0                	test   %eax,%eax
80104ea1:	7f ed                	jg     80104e90 <strncpy+0x40>
  return os;
}
80104ea3:	5b                   	pop    %ebx
80104ea4:	89 f0                	mov    %esi,%eax
80104ea6:	5e                   	pop    %esi
80104ea7:	5f                   	pop    %edi
80104ea8:	5d                   	pop    %ebp
80104ea9:	c3                   	ret    
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104eb0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104eb0:	f3 0f 1e fb          	endbr32 
80104eb4:	55                   	push   %ebp
80104eb5:	89 e5                	mov    %esp,%ebp
80104eb7:	56                   	push   %esi
80104eb8:	8b 55 10             	mov    0x10(%ebp),%edx
80104ebb:	8b 75 08             	mov    0x8(%ebp),%esi
80104ebe:	53                   	push   %ebx
80104ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ec2:	85 d2                	test   %edx,%edx
80104ec4:	7e 21                	jle    80104ee7 <safestrcpy+0x37>
80104ec6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104eca:	89 f2                	mov    %esi,%edx
80104ecc:	eb 12                	jmp    80104ee0 <safestrcpy+0x30>
80104ece:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ed0:	0f b6 08             	movzbl (%eax),%ecx
80104ed3:	83 c0 01             	add    $0x1,%eax
80104ed6:	83 c2 01             	add    $0x1,%edx
80104ed9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104edc:	84 c9                	test   %cl,%cl
80104ede:	74 04                	je     80104ee4 <safestrcpy+0x34>
80104ee0:	39 d8                	cmp    %ebx,%eax
80104ee2:	75 ec                	jne    80104ed0 <safestrcpy+0x20>
    ;
  *s = 0;
80104ee4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104ee7:	89 f0                	mov    %esi,%eax
80104ee9:	5b                   	pop    %ebx
80104eea:	5e                   	pop    %esi
80104eeb:	5d                   	pop    %ebp
80104eec:	c3                   	ret    
80104eed:	8d 76 00             	lea    0x0(%esi),%esi

80104ef0 <strlen>:

int
strlen(const char *s)
{
80104ef0:	f3 0f 1e fb          	endbr32 
80104ef4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ef5:	31 c0                	xor    %eax,%eax
{
80104ef7:	89 e5                	mov    %esp,%ebp
80104ef9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104efc:	80 3a 00             	cmpb   $0x0,(%edx)
80104eff:	74 10                	je     80104f11 <strlen+0x21>
80104f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f08:	83 c0 01             	add    $0x1,%eax
80104f0b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f0f:	75 f7                	jne    80104f08 <strlen+0x18>
    ;
  return n;
}
80104f11:	5d                   	pop    %ebp
80104f12:	c3                   	ret    

80104f13 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f13:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f17:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104f1b:	55                   	push   %ebp
  pushl %ebx
80104f1c:	53                   	push   %ebx
  pushl %esi
80104f1d:	56                   	push   %esi
  pushl %edi
80104f1e:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f1f:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f21:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104f23:	5f                   	pop    %edi
  popl %esi
80104f24:	5e                   	pop    %esi
  popl %ebx
80104f25:	5b                   	pop    %ebx
  popl %ebp
80104f26:	5d                   	pop    %ebp
  ret
80104f27:	c3                   	ret    
80104f28:	66 90                	xchg   %ax,%ax
80104f2a:	66 90                	xchg   %ax,%ax
80104f2c:	66 90                	xchg   %ax,%ax
80104f2e:	66 90                	xchg   %ax,%ax

80104f30 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104f30:	f3 0f 1e fb          	endbr32 
80104f34:	55                   	push   %ebp
80104f35:	89 e5                	mov    %esp,%ebp
80104f37:	53                   	push   %ebx
80104f38:	83 ec 04             	sub    $0x4,%esp
80104f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104f3e:	e8 dd ea ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f43:	8b 00                	mov    (%eax),%eax
80104f45:	39 d8                	cmp    %ebx,%eax
80104f47:	76 17                	jbe    80104f60 <fetchint+0x30>
80104f49:	8d 53 04             	lea    0x4(%ebx),%edx
80104f4c:	39 d0                	cmp    %edx,%eax
80104f4e:	72 10                	jb     80104f60 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104f50:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f53:	8b 13                	mov    (%ebx),%edx
80104f55:	89 10                	mov    %edx,(%eax)
  return 0;
80104f57:	31 c0                	xor    %eax,%eax
}
80104f59:	83 c4 04             	add    $0x4,%esp
80104f5c:	5b                   	pop    %ebx
80104f5d:	5d                   	pop    %ebp
80104f5e:	c3                   	ret    
80104f5f:	90                   	nop
    return -1;
80104f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f65:	eb f2                	jmp    80104f59 <fetchint+0x29>
80104f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f6e:	66 90                	xchg   %ax,%ax

80104f70 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f70:	f3 0f 1e fb          	endbr32 
80104f74:	55                   	push   %ebp
80104f75:	89 e5                	mov    %esp,%ebp
80104f77:	53                   	push   %ebx
80104f78:	83 ec 04             	sub    $0x4,%esp
80104f7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f7e:	e8 9d ea ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz)
80104f83:	39 18                	cmp    %ebx,(%eax)
80104f85:	76 31                	jbe    80104fb8 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104f87:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f8a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f8c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f8e:	39 d3                	cmp    %edx,%ebx
80104f90:	73 26                	jae    80104fb8 <fetchstr+0x48>
80104f92:	89 d8                	mov    %ebx,%eax
80104f94:	eb 11                	jmp    80104fa7 <fetchstr+0x37>
80104f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f9d:	8d 76 00             	lea    0x0(%esi),%esi
80104fa0:	83 c0 01             	add    $0x1,%eax
80104fa3:	39 c2                	cmp    %eax,%edx
80104fa5:	76 11                	jbe    80104fb8 <fetchstr+0x48>
    if(*s == 0)
80104fa7:	80 38 00             	cmpb   $0x0,(%eax)
80104faa:	75 f4                	jne    80104fa0 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
80104fac:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104faf:	29 d8                	sub    %ebx,%eax
}
80104fb1:	5b                   	pop    %ebx
80104fb2:	5d                   	pop    %ebp
80104fb3:	c3                   	ret    
80104fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fb8:	83 c4 04             	add    $0x4,%esp
    return -1;
80104fbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc0:	5b                   	pop    %ebx
80104fc1:	5d                   	pop    %ebp
80104fc2:	c3                   	ret    
80104fc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fd0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104fd0:	f3 0f 1e fb          	endbr32 
80104fd4:	55                   	push   %ebp
80104fd5:	89 e5                	mov    %esp,%ebp
80104fd7:	56                   	push   %esi
80104fd8:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fd9:	e8 42 ea ff ff       	call   80103a20 <myproc>
80104fde:	8b 55 08             	mov    0x8(%ebp),%edx
80104fe1:	8b 40 20             	mov    0x20(%eax),%eax
80104fe4:	8b 40 44             	mov    0x44(%eax),%eax
80104fe7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fea:	e8 31 ea ff ff       	call   80103a20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fef:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ff2:	8b 00                	mov    (%eax),%eax
80104ff4:	39 c6                	cmp    %eax,%esi
80104ff6:	73 18                	jae    80105010 <argint+0x40>
80104ff8:	8d 53 08             	lea    0x8(%ebx),%edx
80104ffb:	39 d0                	cmp    %edx,%eax
80104ffd:	72 11                	jb     80105010 <argint+0x40>
  *ip = *(int*)(addr);
80104fff:	8b 45 0c             	mov    0xc(%ebp),%eax
80105002:	8b 53 04             	mov    0x4(%ebx),%edx
80105005:	89 10                	mov    %edx,(%eax)
  return 0;
80105007:	31 c0                	xor    %eax,%eax
}
80105009:	5b                   	pop    %ebx
8010500a:	5e                   	pop    %esi
8010500b:	5d                   	pop    %ebp
8010500c:	c3                   	ret    
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105015:	eb f2                	jmp    80105009 <argint+0x39>
80105017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010501e:	66 90                	xchg   %ax,%ax

80105020 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105020:	f3 0f 1e fb          	endbr32 
80105024:	55                   	push   %ebp
80105025:	89 e5                	mov    %esp,%ebp
80105027:	56                   	push   %esi
80105028:	53                   	push   %ebx
80105029:	83 ec 10             	sub    $0x10,%esp
8010502c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010502f:	e8 ec e9 ff ff       	call   80103a20 <myproc>
 
  if(argint(n, &i) < 0)
80105034:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105037:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80105039:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010503c:	50                   	push   %eax
8010503d:	ff 75 08             	pushl  0x8(%ebp)
80105040:	e8 8b ff ff ff       	call   80104fd0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105045:	83 c4 10             	add    $0x10,%esp
80105048:	85 c0                	test   %eax,%eax
8010504a:	78 24                	js     80105070 <argptr+0x50>
8010504c:	85 db                	test   %ebx,%ebx
8010504e:	78 20                	js     80105070 <argptr+0x50>
80105050:	8b 16                	mov    (%esi),%edx
80105052:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105055:	39 c2                	cmp    %eax,%edx
80105057:	76 17                	jbe    80105070 <argptr+0x50>
80105059:	01 c3                	add    %eax,%ebx
8010505b:	39 da                	cmp    %ebx,%edx
8010505d:	72 11                	jb     80105070 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010505f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105062:	89 02                	mov    %eax,(%edx)
  return 0;
80105064:	31 c0                	xor    %eax,%eax
}
80105066:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105069:	5b                   	pop    %ebx
8010506a:	5e                   	pop    %esi
8010506b:	5d                   	pop    %ebp
8010506c:	c3                   	ret    
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105075:	eb ef                	jmp    80105066 <argptr+0x46>
80105077:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010507e:	66 90                	xchg   %ax,%ax

80105080 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105080:	f3 0f 1e fb          	endbr32 
80105084:	55                   	push   %ebp
80105085:	89 e5                	mov    %esp,%ebp
80105087:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010508a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010508d:	50                   	push   %eax
8010508e:	ff 75 08             	pushl  0x8(%ebp)
80105091:	e8 3a ff ff ff       	call   80104fd0 <argint>
80105096:	83 c4 10             	add    $0x10,%esp
80105099:	85 c0                	test   %eax,%eax
8010509b:	78 13                	js     801050b0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010509d:	83 ec 08             	sub    $0x8,%esp
801050a0:	ff 75 0c             	pushl  0xc(%ebp)
801050a3:	ff 75 f4             	pushl  -0xc(%ebp)
801050a6:	e8 c5 fe ff ff       	call   80104f70 <fetchstr>
801050ab:	83 c4 10             	add    $0x10,%esp
}
801050ae:	c9                   	leave  
801050af:	c3                   	ret    
801050b0:	c9                   	leave  
    return -1;
801050b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050b6:	c3                   	ret    
801050b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050be:	66 90                	xchg   %ax,%ax

801050c0 <syscall>:
[SYS_getCpuBurstTime] sys_getCpuBurstTime,
};

void
syscall(void)
{
801050c0:	f3 0f 1e fb          	endbr32 
801050c4:	55                   	push   %ebp
801050c5:	89 e5                	mov    %esp,%ebp
801050c7:	53                   	push   %ebx
801050c8:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801050cb:	e8 50 e9 ff ff       	call   80103a20 <myproc>
801050d0:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801050d2:	8b 40 20             	mov    0x20(%eax),%eax
801050d5:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801050d8:	8d 50 ff             	lea    -0x1(%eax),%edx
801050db:	83 fa 1c             	cmp    $0x1c,%edx
801050de:	77 20                	ja     80105100 <syscall+0x40>
801050e0:	8b 14 85 c0 7f 10 80 	mov    -0x7fef8040(,%eax,4),%edx
801050e7:	85 d2                	test   %edx,%edx
801050e9:	74 15                	je     80105100 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801050eb:	ff d2                	call   *%edx
801050ed:	89 c2                	mov    %eax,%edx
801050ef:	8b 43 20             	mov    0x20(%ebx),%eax
801050f2:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801050f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050f8:	c9                   	leave  
801050f9:	c3                   	ret    
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105100:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105101:	8d 43 74             	lea    0x74(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105104:	50                   	push   %eax
80105105:	ff 73 10             	pushl  0x10(%ebx)
80105108:	68 95 7f 10 80       	push   $0x80107f95
8010510d:	e8 9e b5 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80105112:	8b 43 20             	mov    0x20(%ebx),%eax
80105115:	83 c4 10             	add    $0x10,%esp
80105118:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010511f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105122:	c9                   	leave  
80105123:	c3                   	ret    
80105124:	66 90                	xchg   %ax,%ax
80105126:	66 90                	xchg   %ax,%ax
80105128:	66 90                	xchg   %ax,%ax
8010512a:	66 90                	xchg   %ax,%ax
8010512c:	66 90                	xchg   %ax,%ax
8010512e:	66 90                	xchg   %ax,%ax

80105130 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	57                   	push   %edi
80105134:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105135:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105138:	53                   	push   %ebx
80105139:	83 ec 34             	sub    $0x34,%esp
8010513c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010513f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105142:	57                   	push   %edi
80105143:	50                   	push   %eax
{
80105144:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105147:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010514a:	e8 21 cf ff ff       	call   80102070 <nameiparent>
8010514f:	83 c4 10             	add    $0x10,%esp
80105152:	85 c0                	test   %eax,%eax
80105154:	0f 84 46 01 00 00    	je     801052a0 <create+0x170>
    return 0;
  ilock(dp);
8010515a:	83 ec 0c             	sub    $0xc,%esp
8010515d:	89 c3                	mov    %eax,%ebx
8010515f:	50                   	push   %eax
80105160:	e8 1b c6 ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105165:	83 c4 0c             	add    $0xc,%esp
80105168:	6a 00                	push   $0x0
8010516a:	57                   	push   %edi
8010516b:	53                   	push   %ebx
8010516c:	e8 5f cb ff ff       	call   80101cd0 <dirlookup>
80105171:	83 c4 10             	add    $0x10,%esp
80105174:	89 c6                	mov    %eax,%esi
80105176:	85 c0                	test   %eax,%eax
80105178:	74 56                	je     801051d0 <create+0xa0>
    iunlockput(dp);
8010517a:	83 ec 0c             	sub    $0xc,%esp
8010517d:	53                   	push   %ebx
8010517e:	e8 9d c8 ff ff       	call   80101a20 <iunlockput>
    ilock(ip);
80105183:	89 34 24             	mov    %esi,(%esp)
80105186:	e8 f5 c5 ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010518b:	83 c4 10             	add    $0x10,%esp
8010518e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105193:	75 1b                	jne    801051b0 <create+0x80>
80105195:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010519a:	75 14                	jne    801051b0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010519c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010519f:	89 f0                	mov    %esi,%eax
801051a1:	5b                   	pop    %ebx
801051a2:	5e                   	pop    %esi
801051a3:	5f                   	pop    %edi
801051a4:	5d                   	pop    %ebp
801051a5:	c3                   	ret    
801051a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ad:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	56                   	push   %esi
    return 0;
801051b4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801051b6:	e8 65 c8 ff ff       	call   80101a20 <iunlockput>
    return 0;
801051bb:	83 c4 10             	add    $0x10,%esp
}
801051be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051c1:	89 f0                	mov    %esi,%eax
801051c3:	5b                   	pop    %ebx
801051c4:	5e                   	pop    %esi
801051c5:	5f                   	pop    %edi
801051c6:	5d                   	pop    %ebp
801051c7:	c3                   	ret    
801051c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051cf:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801051d0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801051d4:	83 ec 08             	sub    $0x8,%esp
801051d7:	50                   	push   %eax
801051d8:	ff 33                	pushl  (%ebx)
801051da:	e8 21 c4 ff ff       	call   80101600 <ialloc>
801051df:	83 c4 10             	add    $0x10,%esp
801051e2:	89 c6                	mov    %eax,%esi
801051e4:	85 c0                	test   %eax,%eax
801051e6:	0f 84 cd 00 00 00    	je     801052b9 <create+0x189>
  ilock(ip);
801051ec:	83 ec 0c             	sub    $0xc,%esp
801051ef:	50                   	push   %eax
801051f0:	e8 8b c5 ff ff       	call   80101780 <ilock>
  ip->major = major;
801051f5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801051f9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801051fd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105201:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105205:	b8 01 00 00 00       	mov    $0x1,%eax
8010520a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010520e:	89 34 24             	mov    %esi,(%esp)
80105211:	e8 aa c4 ff ff       	call   801016c0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105216:	83 c4 10             	add    $0x10,%esp
80105219:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010521e:	74 30                	je     80105250 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105220:	83 ec 04             	sub    $0x4,%esp
80105223:	ff 76 04             	pushl  0x4(%esi)
80105226:	57                   	push   %edi
80105227:	53                   	push   %ebx
80105228:	e8 63 cd ff ff       	call   80101f90 <dirlink>
8010522d:	83 c4 10             	add    $0x10,%esp
80105230:	85 c0                	test   %eax,%eax
80105232:	78 78                	js     801052ac <create+0x17c>
  iunlockput(dp);
80105234:	83 ec 0c             	sub    $0xc,%esp
80105237:	53                   	push   %ebx
80105238:	e8 e3 c7 ff ff       	call   80101a20 <iunlockput>
  return ip;
8010523d:	83 c4 10             	add    $0x10,%esp
}
80105240:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105243:	89 f0                	mov    %esi,%eax
80105245:	5b                   	pop    %ebx
80105246:	5e                   	pop    %esi
80105247:	5f                   	pop    %edi
80105248:	5d                   	pop    %ebp
80105249:	c3                   	ret    
8010524a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105250:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105253:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105258:	53                   	push   %ebx
80105259:	e8 62 c4 ff ff       	call   801016c0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010525e:	83 c4 0c             	add    $0xc,%esp
80105261:	ff 76 04             	pushl  0x4(%esi)
80105264:	68 54 80 10 80       	push   $0x80108054
80105269:	56                   	push   %esi
8010526a:	e8 21 cd ff ff       	call   80101f90 <dirlink>
8010526f:	83 c4 10             	add    $0x10,%esp
80105272:	85 c0                	test   %eax,%eax
80105274:	78 18                	js     8010528e <create+0x15e>
80105276:	83 ec 04             	sub    $0x4,%esp
80105279:	ff 73 04             	pushl  0x4(%ebx)
8010527c:	68 53 80 10 80       	push   $0x80108053
80105281:	56                   	push   %esi
80105282:	e8 09 cd ff ff       	call   80101f90 <dirlink>
80105287:	83 c4 10             	add    $0x10,%esp
8010528a:	85 c0                	test   %eax,%eax
8010528c:	79 92                	jns    80105220 <create+0xf0>
      panic("create dots");
8010528e:	83 ec 0c             	sub    $0xc,%esp
80105291:	68 47 80 10 80       	push   $0x80108047
80105296:	e8 f5 b0 ff ff       	call   80100390 <panic>
8010529b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010529f:	90                   	nop
}
801052a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801052a3:	31 f6                	xor    %esi,%esi
}
801052a5:	5b                   	pop    %ebx
801052a6:	89 f0                	mov    %esi,%eax
801052a8:	5e                   	pop    %esi
801052a9:	5f                   	pop    %edi
801052aa:	5d                   	pop    %ebp
801052ab:	c3                   	ret    
    panic("create: dirlink");
801052ac:	83 ec 0c             	sub    $0xc,%esp
801052af:	68 56 80 10 80       	push   $0x80108056
801052b4:	e8 d7 b0 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801052b9:	83 ec 0c             	sub    $0xc,%esp
801052bc:	68 38 80 10 80       	push   $0x80108038
801052c1:	e8 ca b0 ff ff       	call   80100390 <panic>
801052c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052cd:	8d 76 00             	lea    0x0(%esi),%esi

801052d0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	56                   	push   %esi
801052d4:	89 d6                	mov    %edx,%esi
801052d6:	53                   	push   %ebx
801052d7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801052d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801052dc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052df:	50                   	push   %eax
801052e0:	6a 00                	push   $0x0
801052e2:	e8 e9 fc ff ff       	call   80104fd0 <argint>
801052e7:	83 c4 10             	add    $0x10,%esp
801052ea:	85 c0                	test   %eax,%eax
801052ec:	78 2a                	js     80105318 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052f2:	77 24                	ja     80105318 <argfd.constprop.0+0x48>
801052f4:	e8 27 e7 ff ff       	call   80103a20 <myproc>
801052f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052fc:	8b 44 90 30          	mov    0x30(%eax,%edx,4),%eax
80105300:	85 c0                	test   %eax,%eax
80105302:	74 14                	je     80105318 <argfd.constprop.0+0x48>
  if(pfd)
80105304:	85 db                	test   %ebx,%ebx
80105306:	74 02                	je     8010530a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105308:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010530a:	89 06                	mov    %eax,(%esi)
  return 0;
8010530c:	31 c0                	xor    %eax,%eax
}
8010530e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105311:	5b                   	pop    %ebx
80105312:	5e                   	pop    %esi
80105313:	5d                   	pop    %ebp
80105314:	c3                   	ret    
80105315:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010531d:	eb ef                	jmp    8010530e <argfd.constprop.0+0x3e>
8010531f:	90                   	nop

80105320 <sys_dup>:
{
80105320:	f3 0f 1e fb          	endbr32 
80105324:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105325:	31 c0                	xor    %eax,%eax
{
80105327:	89 e5                	mov    %esp,%ebp
80105329:	56                   	push   %esi
8010532a:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
8010532b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010532e:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105331:	e8 9a ff ff ff       	call   801052d0 <argfd.constprop.0>
80105336:	85 c0                	test   %eax,%eax
80105338:	78 1e                	js     80105358 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
8010533a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
8010533d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010533f:	e8 dc e6 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105348:	8b 54 98 30          	mov    0x30(%eax,%ebx,4),%edx
8010534c:	85 d2                	test   %edx,%edx
8010534e:	74 20                	je     80105370 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105350:	83 c3 01             	add    $0x1,%ebx
80105353:	83 fb 10             	cmp    $0x10,%ebx
80105356:	75 f0                	jne    80105348 <sys_dup+0x28>
}
80105358:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010535b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105360:	89 d8                	mov    %ebx,%eax
80105362:	5b                   	pop    %ebx
80105363:	5e                   	pop    %esi
80105364:	5d                   	pop    %ebp
80105365:	c3                   	ret    
80105366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105370:	89 74 98 30          	mov    %esi,0x30(%eax,%ebx,4)
  filedup(f);
80105374:	83 ec 0c             	sub    $0xc,%esp
80105377:	ff 75 f4             	pushl  -0xc(%ebp)
8010537a:	e8 11 bb ff ff       	call   80100e90 <filedup>
  return fd;
8010537f:	83 c4 10             	add    $0x10,%esp
}
80105382:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105385:	89 d8                	mov    %ebx,%eax
80105387:	5b                   	pop    %ebx
80105388:	5e                   	pop    %esi
80105389:	5d                   	pop    %ebp
8010538a:	c3                   	ret    
8010538b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010538f:	90                   	nop

80105390 <sys_read>:
{
80105390:	f3 0f 1e fb          	endbr32 
80105394:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105395:	31 c0                	xor    %eax,%eax
{
80105397:	89 e5                	mov    %esp,%ebp
80105399:	83 ec 18             	sub    $0x18,%esp
  readCount++;
8010539c:	83 05 bc b5 10 80 01 	addl   $0x1,0x8010b5bc
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053a3:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053a6:	e8 25 ff ff ff       	call   801052d0 <argfd.constprop.0>
801053ab:	85 c0                	test   %eax,%eax
801053ad:	78 49                	js     801053f8 <sys_read+0x68>
801053af:	83 ec 08             	sub    $0x8,%esp
801053b2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053b5:	50                   	push   %eax
801053b6:	6a 02                	push   $0x2
801053b8:	e8 13 fc ff ff       	call   80104fd0 <argint>
801053bd:	83 c4 10             	add    $0x10,%esp
801053c0:	85 c0                	test   %eax,%eax
801053c2:	78 34                	js     801053f8 <sys_read+0x68>
801053c4:	83 ec 04             	sub    $0x4,%esp
801053c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ca:	ff 75 f0             	pushl  -0x10(%ebp)
801053cd:	50                   	push   %eax
801053ce:	6a 01                	push   $0x1
801053d0:	e8 4b fc ff ff       	call   80105020 <argptr>
801053d5:	83 c4 10             	add    $0x10,%esp
801053d8:	85 c0                	test   %eax,%eax
801053da:	78 1c                	js     801053f8 <sys_read+0x68>
  return fileread(f, p, n);
801053dc:	83 ec 04             	sub    $0x4,%esp
801053df:	ff 75 f0             	pushl  -0x10(%ebp)
801053e2:	ff 75 f4             	pushl  -0xc(%ebp)
801053e5:	ff 75 ec             	pushl  -0x14(%ebp)
801053e8:	e8 23 bc ff ff       	call   80101010 <fileread>
801053ed:	83 c4 10             	add    $0x10,%esp
}
801053f0:	c9                   	leave  
801053f1:	c3                   	ret    
801053f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053f8:	c9                   	leave  
    return -1;
801053f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053fe:	c3                   	ret    
801053ff:	90                   	nop

80105400 <sys_write>:
{
80105400:	f3 0f 1e fb          	endbr32 
80105404:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105405:	31 c0                	xor    %eax,%eax
{
80105407:	89 e5                	mov    %esp,%ebp
80105409:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010540c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010540f:	e8 bc fe ff ff       	call   801052d0 <argfd.constprop.0>
80105414:	85 c0                	test   %eax,%eax
80105416:	78 48                	js     80105460 <sys_write+0x60>
80105418:	83 ec 08             	sub    $0x8,%esp
8010541b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010541e:	50                   	push   %eax
8010541f:	6a 02                	push   $0x2
80105421:	e8 aa fb ff ff       	call   80104fd0 <argint>
80105426:	83 c4 10             	add    $0x10,%esp
80105429:	85 c0                	test   %eax,%eax
8010542b:	78 33                	js     80105460 <sys_write+0x60>
8010542d:	83 ec 04             	sub    $0x4,%esp
80105430:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105433:	ff 75 f0             	pushl  -0x10(%ebp)
80105436:	50                   	push   %eax
80105437:	6a 01                	push   $0x1
80105439:	e8 e2 fb ff ff       	call   80105020 <argptr>
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	85 c0                	test   %eax,%eax
80105443:	78 1b                	js     80105460 <sys_write+0x60>
  return filewrite(f, p, n);
80105445:	83 ec 04             	sub    $0x4,%esp
80105448:	ff 75 f0             	pushl  -0x10(%ebp)
8010544b:	ff 75 f4             	pushl  -0xc(%ebp)
8010544e:	ff 75 ec             	pushl  -0x14(%ebp)
80105451:	e8 5a bc ff ff       	call   801010b0 <filewrite>
80105456:	83 c4 10             	add    $0x10,%esp
}
80105459:	c9                   	leave  
8010545a:	c3                   	ret    
8010545b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010545f:	90                   	nop
80105460:	c9                   	leave  
    return -1;
80105461:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105466:	c3                   	ret    
80105467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010546e:	66 90                	xchg   %ax,%ax

80105470 <sys_close>:
{
80105470:	f3 0f 1e fb          	endbr32 
80105474:	55                   	push   %ebp
80105475:	89 e5                	mov    %esp,%ebp
80105477:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010547a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010547d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105480:	e8 4b fe ff ff       	call   801052d0 <argfd.constprop.0>
80105485:	85 c0                	test   %eax,%eax
80105487:	78 27                	js     801054b0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105489:	e8 92 e5 ff ff       	call   80103a20 <myproc>
8010548e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105491:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105494:	c7 44 90 30 00 00 00 	movl   $0x0,0x30(%eax,%edx,4)
8010549b:	00 
  fileclose(f);
8010549c:	ff 75 f4             	pushl  -0xc(%ebp)
8010549f:	e8 3c ba ff ff       	call   80100ee0 <fileclose>
  return 0;
801054a4:	83 c4 10             	add    $0x10,%esp
801054a7:	31 c0                	xor    %eax,%eax
}
801054a9:	c9                   	leave  
801054aa:	c3                   	ret    
801054ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054af:	90                   	nop
801054b0:	c9                   	leave  
    return -1;
801054b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054b6:	c3                   	ret    
801054b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054be:	66 90                	xchg   %ax,%ax

801054c0 <sys_fstat>:
{
801054c0:	f3 0f 1e fb          	endbr32 
801054c4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054c5:	31 c0                	xor    %eax,%eax
{
801054c7:	89 e5                	mov    %esp,%ebp
801054c9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054cc:	8d 55 f0             	lea    -0x10(%ebp),%edx
801054cf:	e8 fc fd ff ff       	call   801052d0 <argfd.constprop.0>
801054d4:	85 c0                	test   %eax,%eax
801054d6:	78 30                	js     80105508 <sys_fstat+0x48>
801054d8:	83 ec 04             	sub    $0x4,%esp
801054db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054de:	6a 14                	push   $0x14
801054e0:	50                   	push   %eax
801054e1:	6a 01                	push   $0x1
801054e3:	e8 38 fb ff ff       	call   80105020 <argptr>
801054e8:	83 c4 10             	add    $0x10,%esp
801054eb:	85 c0                	test   %eax,%eax
801054ed:	78 19                	js     80105508 <sys_fstat+0x48>
  return filestat(f, st);
801054ef:	83 ec 08             	sub    $0x8,%esp
801054f2:	ff 75 f4             	pushl  -0xc(%ebp)
801054f5:	ff 75 f0             	pushl  -0x10(%ebp)
801054f8:	e8 c3 ba ff ff       	call   80100fc0 <filestat>
801054fd:	83 c4 10             	add    $0x10,%esp
}
80105500:	c9                   	leave  
80105501:	c3                   	ret    
80105502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105508:	c9                   	leave  
    return -1;
80105509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010550e:	c3                   	ret    
8010550f:	90                   	nop

80105510 <sys_link>:
{
80105510:	f3 0f 1e fb          	endbr32 
80105514:	55                   	push   %ebp
80105515:	89 e5                	mov    %esp,%ebp
80105517:	57                   	push   %edi
80105518:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105519:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010551c:	53                   	push   %ebx
8010551d:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105520:	50                   	push   %eax
80105521:	6a 00                	push   $0x0
80105523:	e8 58 fb ff ff       	call   80105080 <argstr>
80105528:	83 c4 10             	add    $0x10,%esp
8010552b:	85 c0                	test   %eax,%eax
8010552d:	0f 88 ff 00 00 00    	js     80105632 <sys_link+0x122>
80105533:	83 ec 08             	sub    $0x8,%esp
80105536:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105539:	50                   	push   %eax
8010553a:	6a 01                	push   $0x1
8010553c:	e8 3f fb ff ff       	call   80105080 <argstr>
80105541:	83 c4 10             	add    $0x10,%esp
80105544:	85 c0                	test   %eax,%eax
80105546:	0f 88 e6 00 00 00    	js     80105632 <sys_link+0x122>
  begin_op();
8010554c:	e8 ff d7 ff ff       	call   80102d50 <begin_op>
  if((ip = namei(old)) == 0){
80105551:	83 ec 0c             	sub    $0xc,%esp
80105554:	ff 75 d4             	pushl  -0x2c(%ebp)
80105557:	e8 f4 ca ff ff       	call   80102050 <namei>
8010555c:	83 c4 10             	add    $0x10,%esp
8010555f:	89 c3                	mov    %eax,%ebx
80105561:	85 c0                	test   %eax,%eax
80105563:	0f 84 e8 00 00 00    	je     80105651 <sys_link+0x141>
  ilock(ip);
80105569:	83 ec 0c             	sub    $0xc,%esp
8010556c:	50                   	push   %eax
8010556d:	e8 0e c2 ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010557a:	0f 84 b9 00 00 00    	je     80105639 <sys_link+0x129>
  iupdate(ip);
80105580:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105583:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105588:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010558b:	53                   	push   %ebx
8010558c:	e8 2f c1 ff ff       	call   801016c0 <iupdate>
  iunlock(ip);
80105591:	89 1c 24             	mov    %ebx,(%esp)
80105594:	e8 c7 c2 ff ff       	call   80101860 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105599:	58                   	pop    %eax
8010559a:	5a                   	pop    %edx
8010559b:	57                   	push   %edi
8010559c:	ff 75 d0             	pushl  -0x30(%ebp)
8010559f:	e8 cc ca ff ff       	call   80102070 <nameiparent>
801055a4:	83 c4 10             	add    $0x10,%esp
801055a7:	89 c6                	mov    %eax,%esi
801055a9:	85 c0                	test   %eax,%eax
801055ab:	74 5f                	je     8010560c <sys_link+0xfc>
  ilock(dp);
801055ad:	83 ec 0c             	sub    $0xc,%esp
801055b0:	50                   	push   %eax
801055b1:	e8 ca c1 ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055b6:	8b 03                	mov    (%ebx),%eax
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	39 06                	cmp    %eax,(%esi)
801055bd:	75 41                	jne    80105600 <sys_link+0xf0>
801055bf:	83 ec 04             	sub    $0x4,%esp
801055c2:	ff 73 04             	pushl  0x4(%ebx)
801055c5:	57                   	push   %edi
801055c6:	56                   	push   %esi
801055c7:	e8 c4 c9 ff ff       	call   80101f90 <dirlink>
801055cc:	83 c4 10             	add    $0x10,%esp
801055cf:	85 c0                	test   %eax,%eax
801055d1:	78 2d                	js     80105600 <sys_link+0xf0>
  iunlockput(dp);
801055d3:	83 ec 0c             	sub    $0xc,%esp
801055d6:	56                   	push   %esi
801055d7:	e8 44 c4 ff ff       	call   80101a20 <iunlockput>
  iput(ip);
801055dc:	89 1c 24             	mov    %ebx,(%esp)
801055df:	e8 cc c2 ff ff       	call   801018b0 <iput>
  end_op();
801055e4:	e8 d7 d7 ff ff       	call   80102dc0 <end_op>
  return 0;
801055e9:	83 c4 10             	add    $0x10,%esp
801055ec:	31 c0                	xor    %eax,%eax
}
801055ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f1:	5b                   	pop    %ebx
801055f2:	5e                   	pop    %esi
801055f3:	5f                   	pop    %edi
801055f4:	5d                   	pop    %ebp
801055f5:	c3                   	ret    
801055f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055fd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	56                   	push   %esi
80105604:	e8 17 c4 ff ff       	call   80101a20 <iunlockput>
    goto bad;
80105609:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	53                   	push   %ebx
80105610:	e8 6b c1 ff ff       	call   80101780 <ilock>
  ip->nlink--;
80105615:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010561a:	89 1c 24             	mov    %ebx,(%esp)
8010561d:	e8 9e c0 ff ff       	call   801016c0 <iupdate>
  iunlockput(ip);
80105622:	89 1c 24             	mov    %ebx,(%esp)
80105625:	e8 f6 c3 ff ff       	call   80101a20 <iunlockput>
  end_op();
8010562a:	e8 91 d7 ff ff       	call   80102dc0 <end_op>
  return -1;
8010562f:	83 c4 10             	add    $0x10,%esp
80105632:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105637:	eb b5                	jmp    801055ee <sys_link+0xde>
    iunlockput(ip);
80105639:	83 ec 0c             	sub    $0xc,%esp
8010563c:	53                   	push   %ebx
8010563d:	e8 de c3 ff ff       	call   80101a20 <iunlockput>
    end_op();
80105642:	e8 79 d7 ff ff       	call   80102dc0 <end_op>
    return -1;
80105647:	83 c4 10             	add    $0x10,%esp
8010564a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564f:	eb 9d                	jmp    801055ee <sys_link+0xde>
    end_op();
80105651:	e8 6a d7 ff ff       	call   80102dc0 <end_op>
    return -1;
80105656:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010565b:	eb 91                	jmp    801055ee <sys_link+0xde>
8010565d:	8d 76 00             	lea    0x0(%esi),%esi

80105660 <sys_unlink>:
{
80105660:	f3 0f 1e fb          	endbr32 
80105664:	55                   	push   %ebp
80105665:	89 e5                	mov    %esp,%ebp
80105667:	57                   	push   %edi
80105668:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105669:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010566c:	53                   	push   %ebx
8010566d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105670:	50                   	push   %eax
80105671:	6a 00                	push   $0x0
80105673:	e8 08 fa ff ff       	call   80105080 <argstr>
80105678:	83 c4 10             	add    $0x10,%esp
8010567b:	85 c0                	test   %eax,%eax
8010567d:	0f 88 7d 01 00 00    	js     80105800 <sys_unlink+0x1a0>
  begin_op();
80105683:	e8 c8 d6 ff ff       	call   80102d50 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105688:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010568b:	83 ec 08             	sub    $0x8,%esp
8010568e:	53                   	push   %ebx
8010568f:	ff 75 c0             	pushl  -0x40(%ebp)
80105692:	e8 d9 c9 ff ff       	call   80102070 <nameiparent>
80105697:	83 c4 10             	add    $0x10,%esp
8010569a:	89 c6                	mov    %eax,%esi
8010569c:	85 c0                	test   %eax,%eax
8010569e:	0f 84 66 01 00 00    	je     8010580a <sys_unlink+0x1aa>
  ilock(dp);
801056a4:	83 ec 0c             	sub    $0xc,%esp
801056a7:	50                   	push   %eax
801056a8:	e8 d3 c0 ff ff       	call   80101780 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801056ad:	58                   	pop    %eax
801056ae:	5a                   	pop    %edx
801056af:	68 54 80 10 80       	push   $0x80108054
801056b4:	53                   	push   %ebx
801056b5:	e8 f6 c5 ff ff       	call   80101cb0 <namecmp>
801056ba:	83 c4 10             	add    $0x10,%esp
801056bd:	85 c0                	test   %eax,%eax
801056bf:	0f 84 03 01 00 00    	je     801057c8 <sys_unlink+0x168>
801056c5:	83 ec 08             	sub    $0x8,%esp
801056c8:	68 53 80 10 80       	push   $0x80108053
801056cd:	53                   	push   %ebx
801056ce:	e8 dd c5 ff ff       	call   80101cb0 <namecmp>
801056d3:	83 c4 10             	add    $0x10,%esp
801056d6:	85 c0                	test   %eax,%eax
801056d8:	0f 84 ea 00 00 00    	je     801057c8 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
801056de:	83 ec 04             	sub    $0x4,%esp
801056e1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056e4:	50                   	push   %eax
801056e5:	53                   	push   %ebx
801056e6:	56                   	push   %esi
801056e7:	e8 e4 c5 ff ff       	call   80101cd0 <dirlookup>
801056ec:	83 c4 10             	add    $0x10,%esp
801056ef:	89 c3                	mov    %eax,%ebx
801056f1:	85 c0                	test   %eax,%eax
801056f3:	0f 84 cf 00 00 00    	je     801057c8 <sys_unlink+0x168>
  ilock(ip);
801056f9:	83 ec 0c             	sub    $0xc,%esp
801056fc:	50                   	push   %eax
801056fd:	e8 7e c0 ff ff       	call   80101780 <ilock>
  if(ip->nlink < 1)
80105702:	83 c4 10             	add    $0x10,%esp
80105705:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010570a:	0f 8e 23 01 00 00    	jle    80105833 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105710:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105715:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105718:	74 66                	je     80105780 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010571a:	83 ec 04             	sub    $0x4,%esp
8010571d:	6a 10                	push   $0x10
8010571f:	6a 00                	push   $0x0
80105721:	57                   	push   %edi
80105722:	e8 c9 f5 ff ff       	call   80104cf0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105727:	6a 10                	push   $0x10
80105729:	ff 75 c4             	pushl  -0x3c(%ebp)
8010572c:	57                   	push   %edi
8010572d:	56                   	push   %esi
8010572e:	e8 4d c4 ff ff       	call   80101b80 <writei>
80105733:	83 c4 20             	add    $0x20,%esp
80105736:	83 f8 10             	cmp    $0x10,%eax
80105739:	0f 85 e7 00 00 00    	jne    80105826 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
8010573f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105744:	0f 84 96 00 00 00    	je     801057e0 <sys_unlink+0x180>
  iunlockput(dp);
8010574a:	83 ec 0c             	sub    $0xc,%esp
8010574d:	56                   	push   %esi
8010574e:	e8 cd c2 ff ff       	call   80101a20 <iunlockput>
  ip->nlink--;
80105753:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105758:	89 1c 24             	mov    %ebx,(%esp)
8010575b:	e8 60 bf ff ff       	call   801016c0 <iupdate>
  iunlockput(ip);
80105760:	89 1c 24             	mov    %ebx,(%esp)
80105763:	e8 b8 c2 ff ff       	call   80101a20 <iunlockput>
  end_op();
80105768:	e8 53 d6 ff ff       	call   80102dc0 <end_op>
  return 0;
8010576d:	83 c4 10             	add    $0x10,%esp
80105770:	31 c0                	xor    %eax,%eax
}
80105772:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105775:	5b                   	pop    %ebx
80105776:	5e                   	pop    %esi
80105777:	5f                   	pop    %edi
80105778:	5d                   	pop    %ebp
80105779:	c3                   	ret    
8010577a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105780:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105784:	76 94                	jbe    8010571a <sys_unlink+0xba>
80105786:	ba 20 00 00 00       	mov    $0x20,%edx
8010578b:	eb 0b                	jmp    80105798 <sys_unlink+0x138>
8010578d:	8d 76 00             	lea    0x0(%esi),%esi
80105790:	83 c2 10             	add    $0x10,%edx
80105793:	39 53 58             	cmp    %edx,0x58(%ebx)
80105796:	76 82                	jbe    8010571a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105798:	6a 10                	push   $0x10
8010579a:	52                   	push   %edx
8010579b:	57                   	push   %edi
8010579c:	53                   	push   %ebx
8010579d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801057a0:	e8 db c2 ff ff       	call   80101a80 <readi>
801057a5:	83 c4 10             	add    $0x10,%esp
801057a8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801057ab:	83 f8 10             	cmp    $0x10,%eax
801057ae:	75 69                	jne    80105819 <sys_unlink+0x1b9>
    if(de.inum != 0)
801057b0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801057b5:	74 d9                	je     80105790 <sys_unlink+0x130>
    iunlockput(ip);
801057b7:	83 ec 0c             	sub    $0xc,%esp
801057ba:	53                   	push   %ebx
801057bb:	e8 60 c2 ff ff       	call   80101a20 <iunlockput>
    goto bad;
801057c0:	83 c4 10             	add    $0x10,%esp
801057c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057c7:	90                   	nop
  iunlockput(dp);
801057c8:	83 ec 0c             	sub    $0xc,%esp
801057cb:	56                   	push   %esi
801057cc:	e8 4f c2 ff ff       	call   80101a20 <iunlockput>
  end_op();
801057d1:	e8 ea d5 ff ff       	call   80102dc0 <end_op>
  return -1;
801057d6:	83 c4 10             	add    $0x10,%esp
801057d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057de:	eb 92                	jmp    80105772 <sys_unlink+0x112>
    iupdate(dp);
801057e0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801057e3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801057e8:	56                   	push   %esi
801057e9:	e8 d2 be ff ff       	call   801016c0 <iupdate>
801057ee:	83 c4 10             	add    $0x10,%esp
801057f1:	e9 54 ff ff ff       	jmp    8010574a <sys_unlink+0xea>
801057f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105805:	e9 68 ff ff ff       	jmp    80105772 <sys_unlink+0x112>
    end_op();
8010580a:	e8 b1 d5 ff ff       	call   80102dc0 <end_op>
    return -1;
8010580f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105814:	e9 59 ff ff ff       	jmp    80105772 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105819:	83 ec 0c             	sub    $0xc,%esp
8010581c:	68 78 80 10 80       	push   $0x80108078
80105821:	e8 6a ab ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105826:	83 ec 0c             	sub    $0xc,%esp
80105829:	68 8a 80 10 80       	push   $0x8010808a
8010582e:	e8 5d ab ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105833:	83 ec 0c             	sub    $0xc,%esp
80105836:	68 66 80 10 80       	push   $0x80108066
8010583b:	e8 50 ab ff ff       	call   80100390 <panic>

80105840 <sys_open>:

int
sys_open(void)
{
80105840:	f3 0f 1e fb          	endbr32 
80105844:	55                   	push   %ebp
80105845:	89 e5                	mov    %esp,%ebp
80105847:	57                   	push   %edi
80105848:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105849:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
8010584c:	53                   	push   %ebx
8010584d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105850:	50                   	push   %eax
80105851:	6a 00                	push   $0x0
80105853:	e8 28 f8 ff ff       	call   80105080 <argstr>
80105858:	83 c4 10             	add    $0x10,%esp
8010585b:	85 c0                	test   %eax,%eax
8010585d:	0f 88 8a 00 00 00    	js     801058ed <sys_open+0xad>
80105863:	83 ec 08             	sub    $0x8,%esp
80105866:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105869:	50                   	push   %eax
8010586a:	6a 01                	push   $0x1
8010586c:	e8 5f f7 ff ff       	call   80104fd0 <argint>
80105871:	83 c4 10             	add    $0x10,%esp
80105874:	85 c0                	test   %eax,%eax
80105876:	78 75                	js     801058ed <sys_open+0xad>
    return -1;

  begin_op();
80105878:	e8 d3 d4 ff ff       	call   80102d50 <begin_op>

  if(omode & O_CREATE){
8010587d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105881:	75 75                	jne    801058f8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105883:	83 ec 0c             	sub    $0xc,%esp
80105886:	ff 75 e0             	pushl  -0x20(%ebp)
80105889:	e8 c2 c7 ff ff       	call   80102050 <namei>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	89 c6                	mov    %eax,%esi
80105893:	85 c0                	test   %eax,%eax
80105895:	74 7e                	je     80105915 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105897:	83 ec 0c             	sub    $0xc,%esp
8010589a:	50                   	push   %eax
8010589b:	e8 e0 be ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801058a0:	83 c4 10             	add    $0x10,%esp
801058a3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801058a8:	0f 84 c2 00 00 00    	je     80105970 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801058ae:	e8 6d b5 ff ff       	call   80100e20 <filealloc>
801058b3:	89 c7                	mov    %eax,%edi
801058b5:	85 c0                	test   %eax,%eax
801058b7:	74 23                	je     801058dc <sys_open+0x9c>
  struct proc *curproc = myproc();
801058b9:	e8 62 e1 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058be:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801058c0:	8b 54 98 30          	mov    0x30(%eax,%ebx,4),%edx
801058c4:	85 d2                	test   %edx,%edx
801058c6:	74 60                	je     80105928 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801058c8:	83 c3 01             	add    $0x1,%ebx
801058cb:	83 fb 10             	cmp    $0x10,%ebx
801058ce:	75 f0                	jne    801058c0 <sys_open+0x80>
    if(f)
      fileclose(f);
801058d0:	83 ec 0c             	sub    $0xc,%esp
801058d3:	57                   	push   %edi
801058d4:	e8 07 b6 ff ff       	call   80100ee0 <fileclose>
801058d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801058dc:	83 ec 0c             	sub    $0xc,%esp
801058df:	56                   	push   %esi
801058e0:	e8 3b c1 ff ff       	call   80101a20 <iunlockput>
    end_op();
801058e5:	e8 d6 d4 ff ff       	call   80102dc0 <end_op>
    return -1;
801058ea:	83 c4 10             	add    $0x10,%esp
801058ed:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058f2:	eb 6d                	jmp    80105961 <sys_open+0x121>
801058f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801058fe:	31 c9                	xor    %ecx,%ecx
80105900:	ba 02 00 00 00       	mov    $0x2,%edx
80105905:	6a 00                	push   $0x0
80105907:	e8 24 f8 ff ff       	call   80105130 <create>
    if(ip == 0){
8010590c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010590f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105911:	85 c0                	test   %eax,%eax
80105913:	75 99                	jne    801058ae <sys_open+0x6e>
      end_op();
80105915:	e8 a6 d4 ff ff       	call   80102dc0 <end_op>
      return -1;
8010591a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010591f:	eb 40                	jmp    80105961 <sys_open+0x121>
80105921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105928:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010592b:	89 7c 98 30          	mov    %edi,0x30(%eax,%ebx,4)
  iunlock(ip);
8010592f:	56                   	push   %esi
80105930:	e8 2b bf ff ff       	call   80101860 <iunlock>
  end_op();
80105935:	e8 86 d4 ff ff       	call   80102dc0 <end_op>

  f->type = FD_INODE;
8010593a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105940:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105943:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105946:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105949:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010594b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105952:	f7 d0                	not    %eax
80105954:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105957:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010595a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010595d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105961:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105964:	89 d8                	mov    %ebx,%eax
80105966:	5b                   	pop    %ebx
80105967:	5e                   	pop    %esi
80105968:	5f                   	pop    %edi
80105969:	5d                   	pop    %ebp
8010596a:	c3                   	ret    
8010596b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010596f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105970:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105973:	85 c9                	test   %ecx,%ecx
80105975:	0f 84 33 ff ff ff    	je     801058ae <sys_open+0x6e>
8010597b:	e9 5c ff ff ff       	jmp    801058dc <sys_open+0x9c>

80105980 <sys_mkdir>:

int
sys_mkdir(void)
{
80105980:	f3 0f 1e fb          	endbr32 
80105984:	55                   	push   %ebp
80105985:	89 e5                	mov    %esp,%ebp
80105987:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010598a:	e8 c1 d3 ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010598f:	83 ec 08             	sub    $0x8,%esp
80105992:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105995:	50                   	push   %eax
80105996:	6a 00                	push   $0x0
80105998:	e8 e3 f6 ff ff       	call   80105080 <argstr>
8010599d:	83 c4 10             	add    $0x10,%esp
801059a0:	85 c0                	test   %eax,%eax
801059a2:	78 34                	js     801059d8 <sys_mkdir+0x58>
801059a4:	83 ec 0c             	sub    $0xc,%esp
801059a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059aa:	31 c9                	xor    %ecx,%ecx
801059ac:	ba 01 00 00 00       	mov    $0x1,%edx
801059b1:	6a 00                	push   $0x0
801059b3:	e8 78 f7 ff ff       	call   80105130 <create>
801059b8:	83 c4 10             	add    $0x10,%esp
801059bb:	85 c0                	test   %eax,%eax
801059bd:	74 19                	je     801059d8 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059bf:	83 ec 0c             	sub    $0xc,%esp
801059c2:	50                   	push   %eax
801059c3:	e8 58 c0 ff ff       	call   80101a20 <iunlockput>
  end_op();
801059c8:	e8 f3 d3 ff ff       	call   80102dc0 <end_op>
  return 0;
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	31 c0                	xor    %eax,%eax
}
801059d2:	c9                   	leave  
801059d3:	c3                   	ret    
801059d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801059d8:	e8 e3 d3 ff ff       	call   80102dc0 <end_op>
    return -1;
801059dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059e2:	c9                   	leave  
801059e3:	c3                   	ret    
801059e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059ef:	90                   	nop

801059f0 <sys_mknod>:

int
sys_mknod(void)
{
801059f0:	f3 0f 1e fb          	endbr32 
801059f4:	55                   	push   %ebp
801059f5:	89 e5                	mov    %esp,%ebp
801059f7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801059fa:	e8 51 d3 ff ff       	call   80102d50 <begin_op>
  if((argstr(0, &path)) < 0 ||
801059ff:	83 ec 08             	sub    $0x8,%esp
80105a02:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a05:	50                   	push   %eax
80105a06:	6a 00                	push   $0x0
80105a08:	e8 73 f6 ff ff       	call   80105080 <argstr>
80105a0d:	83 c4 10             	add    $0x10,%esp
80105a10:	85 c0                	test   %eax,%eax
80105a12:	78 64                	js     80105a78 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105a14:	83 ec 08             	sub    $0x8,%esp
80105a17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a1a:	50                   	push   %eax
80105a1b:	6a 01                	push   $0x1
80105a1d:	e8 ae f5 ff ff       	call   80104fd0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a22:	83 c4 10             	add    $0x10,%esp
80105a25:	85 c0                	test   %eax,%eax
80105a27:	78 4f                	js     80105a78 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105a29:	83 ec 08             	sub    $0x8,%esp
80105a2c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a2f:	50                   	push   %eax
80105a30:	6a 02                	push   $0x2
80105a32:	e8 99 f5 ff ff       	call   80104fd0 <argint>
     argint(1, &major) < 0 ||
80105a37:	83 c4 10             	add    $0x10,%esp
80105a3a:	85 c0                	test   %eax,%eax
80105a3c:	78 3a                	js     80105a78 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a3e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a42:	83 ec 0c             	sub    $0xc,%esp
80105a45:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a49:	ba 03 00 00 00       	mov    $0x3,%edx
80105a4e:	50                   	push   %eax
80105a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a52:	e8 d9 f6 ff ff       	call   80105130 <create>
     argint(2, &minor) < 0 ||
80105a57:	83 c4 10             	add    $0x10,%esp
80105a5a:	85 c0                	test   %eax,%eax
80105a5c:	74 1a                	je     80105a78 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a5e:	83 ec 0c             	sub    $0xc,%esp
80105a61:	50                   	push   %eax
80105a62:	e8 b9 bf ff ff       	call   80101a20 <iunlockput>
  end_op();
80105a67:	e8 54 d3 ff ff       	call   80102dc0 <end_op>
  return 0;
80105a6c:	83 c4 10             	add    $0x10,%esp
80105a6f:	31 c0                	xor    %eax,%eax
}
80105a71:	c9                   	leave  
80105a72:	c3                   	ret    
80105a73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a77:	90                   	nop
    end_op();
80105a78:	e8 43 d3 ff ff       	call   80102dc0 <end_op>
    return -1;
80105a7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a82:	c9                   	leave  
80105a83:	c3                   	ret    
80105a84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a8f:	90                   	nop

80105a90 <sys_chdir>:

int
sys_chdir(void)
{
80105a90:	f3 0f 1e fb          	endbr32 
80105a94:	55                   	push   %ebp
80105a95:	89 e5                	mov    %esp,%ebp
80105a97:	56                   	push   %esi
80105a98:	53                   	push   %ebx
80105a99:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a9c:	e8 7f df ff ff       	call   80103a20 <myproc>
80105aa1:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105aa3:	e8 a8 d2 ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105aa8:	83 ec 08             	sub    $0x8,%esp
80105aab:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aae:	50                   	push   %eax
80105aaf:	6a 00                	push   $0x0
80105ab1:	e8 ca f5 ff ff       	call   80105080 <argstr>
80105ab6:	83 c4 10             	add    $0x10,%esp
80105ab9:	85 c0                	test   %eax,%eax
80105abb:	78 73                	js     80105b30 <sys_chdir+0xa0>
80105abd:	83 ec 0c             	sub    $0xc,%esp
80105ac0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ac3:	e8 88 c5 ff ff       	call   80102050 <namei>
80105ac8:	83 c4 10             	add    $0x10,%esp
80105acb:	89 c3                	mov    %eax,%ebx
80105acd:	85 c0                	test   %eax,%eax
80105acf:	74 5f                	je     80105b30 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105ad1:	83 ec 0c             	sub    $0xc,%esp
80105ad4:	50                   	push   %eax
80105ad5:	e8 a6 bc ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
80105ada:	83 c4 10             	add    $0x10,%esp
80105add:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ae2:	75 2c                	jne    80105b10 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ae4:	83 ec 0c             	sub    $0xc,%esp
80105ae7:	53                   	push   %ebx
80105ae8:	e8 73 bd ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
80105aed:	58                   	pop    %eax
80105aee:	ff 76 70             	pushl  0x70(%esi)
80105af1:	e8 ba bd ff ff       	call   801018b0 <iput>
  end_op();
80105af6:	e8 c5 d2 ff ff       	call   80102dc0 <end_op>
  curproc->cwd = ip;
80105afb:	89 5e 70             	mov    %ebx,0x70(%esi)
  return 0;
80105afe:	83 c4 10             	add    $0x10,%esp
80105b01:	31 c0                	xor    %eax,%eax
}
80105b03:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b06:	5b                   	pop    %ebx
80105b07:	5e                   	pop    %esi
80105b08:	5d                   	pop    %ebp
80105b09:	c3                   	ret    
80105b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105b10:	83 ec 0c             	sub    $0xc,%esp
80105b13:	53                   	push   %ebx
80105b14:	e8 07 bf ff ff       	call   80101a20 <iunlockput>
    end_op();
80105b19:	e8 a2 d2 ff ff       	call   80102dc0 <end_op>
    return -1;
80105b1e:	83 c4 10             	add    $0x10,%esp
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b26:	eb db                	jmp    80105b03 <sys_chdir+0x73>
80105b28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b2f:	90                   	nop
    end_op();
80105b30:	e8 8b d2 ff ff       	call   80102dc0 <end_op>
    return -1;
80105b35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b3a:	eb c7                	jmp    80105b03 <sys_chdir+0x73>
80105b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b40 <sys_exec>:

int
sys_exec(void)
{
80105b40:	f3 0f 1e fb          	endbr32 
80105b44:	55                   	push   %ebp
80105b45:	89 e5                	mov    %esp,%ebp
80105b47:	57                   	push   %edi
80105b48:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b49:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b4f:	53                   	push   %ebx
80105b50:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b56:	50                   	push   %eax
80105b57:	6a 00                	push   $0x0
80105b59:	e8 22 f5 ff ff       	call   80105080 <argstr>
80105b5e:	83 c4 10             	add    $0x10,%esp
80105b61:	85 c0                	test   %eax,%eax
80105b63:	0f 88 8b 00 00 00    	js     80105bf4 <sys_exec+0xb4>
80105b69:	83 ec 08             	sub    $0x8,%esp
80105b6c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b72:	50                   	push   %eax
80105b73:	6a 01                	push   $0x1
80105b75:	e8 56 f4 ff ff       	call   80104fd0 <argint>
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	85 c0                	test   %eax,%eax
80105b7f:	78 73                	js     80105bf4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b81:	83 ec 04             	sub    $0x4,%esp
80105b84:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105b8a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b8c:	68 80 00 00 00       	push   $0x80
80105b91:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105b97:	6a 00                	push   $0x0
80105b99:	50                   	push   %eax
80105b9a:	e8 51 f1 ff ff       	call   80104cf0 <memset>
80105b9f:	83 c4 10             	add    $0x10,%esp
80105ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105ba8:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105bae:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105bb5:	83 ec 08             	sub    $0x8,%esp
80105bb8:	57                   	push   %edi
80105bb9:	01 f0                	add    %esi,%eax
80105bbb:	50                   	push   %eax
80105bbc:	e8 6f f3 ff ff       	call   80104f30 <fetchint>
80105bc1:	83 c4 10             	add    $0x10,%esp
80105bc4:	85 c0                	test   %eax,%eax
80105bc6:	78 2c                	js     80105bf4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80105bc8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105bce:	85 c0                	test   %eax,%eax
80105bd0:	74 36                	je     80105c08 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105bd2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105bd8:	83 ec 08             	sub    $0x8,%esp
80105bdb:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105bde:	52                   	push   %edx
80105bdf:	50                   	push   %eax
80105be0:	e8 8b f3 ff ff       	call   80104f70 <fetchstr>
80105be5:	83 c4 10             	add    $0x10,%esp
80105be8:	85 c0                	test   %eax,%eax
80105bea:	78 08                	js     80105bf4 <sys_exec+0xb4>
  for(i=0;; i++){
80105bec:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105bef:	83 fb 20             	cmp    $0x20,%ebx
80105bf2:	75 b4                	jne    80105ba8 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105bf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bfc:	5b                   	pop    %ebx
80105bfd:	5e                   	pop    %esi
80105bfe:	5f                   	pop    %edi
80105bff:	5d                   	pop    %ebp
80105c00:	c3                   	ret    
80105c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105c08:	83 ec 08             	sub    $0x8,%esp
80105c0b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105c11:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c18:	00 00 00 00 
  return exec(path, argv);
80105c1c:	50                   	push   %eax
80105c1d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105c23:	e8 58 ae ff ff       	call   80100a80 <exec>
80105c28:	83 c4 10             	add    $0x10,%esp
}
80105c2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c2e:	5b                   	pop    %ebx
80105c2f:	5e                   	pop    %esi
80105c30:	5f                   	pop    %edi
80105c31:	5d                   	pop    %ebp
80105c32:	c3                   	ret    
80105c33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c40 <sys_pipe>:

int
sys_pipe(void)
{
80105c40:	f3 0f 1e fb          	endbr32 
80105c44:	55                   	push   %ebp
80105c45:	89 e5                	mov    %esp,%ebp
80105c47:	57                   	push   %edi
80105c48:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c49:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c4c:	53                   	push   %ebx
80105c4d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c50:	6a 08                	push   $0x8
80105c52:	50                   	push   %eax
80105c53:	6a 00                	push   $0x0
80105c55:	e8 c6 f3 ff ff       	call   80105020 <argptr>
80105c5a:	83 c4 10             	add    $0x10,%esp
80105c5d:	85 c0                	test   %eax,%eax
80105c5f:	78 4e                	js     80105caf <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c61:	83 ec 08             	sub    $0x8,%esp
80105c64:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c67:	50                   	push   %eax
80105c68:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c6b:	50                   	push   %eax
80105c6c:	e8 9f d7 ff ff       	call   80103410 <pipealloc>
80105c71:	83 c4 10             	add    $0x10,%esp
80105c74:	85 c0                	test   %eax,%eax
80105c76:	78 37                	js     80105caf <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c78:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c7b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c7d:	e8 9e dd ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105c88:	8b 74 98 30          	mov    0x30(%eax,%ebx,4),%esi
80105c8c:	85 f6                	test   %esi,%esi
80105c8e:	74 30                	je     80105cc0 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105c90:	83 c3 01             	add    $0x1,%ebx
80105c93:	83 fb 10             	cmp    $0x10,%ebx
80105c96:	75 f0                	jne    80105c88 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105c98:	83 ec 0c             	sub    $0xc,%esp
80105c9b:	ff 75 e0             	pushl  -0x20(%ebp)
80105c9e:	e8 3d b2 ff ff       	call   80100ee0 <fileclose>
    fileclose(wf);
80105ca3:	58                   	pop    %eax
80105ca4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105ca7:	e8 34 b2 ff ff       	call   80100ee0 <fileclose>
    return -1;
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cb4:	eb 4b                	jmp    80105d01 <sys_pipe+0xc1>
80105cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105cc0:	8d 73 0c             	lea    0xc(%ebx),%esi
80105cc3:	89 3c b0             	mov    %edi,(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cc6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105cc9:	e8 52 dd ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cce:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
80105cd0:	8b 4c 90 30          	mov    0x30(%eax,%edx,4),%ecx
80105cd4:	85 c9                	test   %ecx,%ecx
80105cd6:	74 18                	je     80105cf0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105cd8:	83 c2 01             	add    $0x1,%edx
80105cdb:	83 fa 10             	cmp    $0x10,%edx
80105cde:	75 f0                	jne    80105cd0 <sys_pipe+0x90>
      myproc()->ofile[fd0] = 0;
80105ce0:	e8 3b dd ff ff       	call   80103a20 <myproc>
80105ce5:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)
80105cec:	eb aa                	jmp    80105c98 <sys_pipe+0x58>
80105cee:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105cf0:	89 7c 90 30          	mov    %edi,0x30(%eax,%edx,4)
  }
  fd[0] = fd0;
80105cf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cf7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105cf9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cfc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105cff:	31 c0                	xor    %eax,%eax
}
80105d01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d04:	5b                   	pop    %ebx
80105d05:	5e                   	pop    %esi
80105d06:	5f                   	pop    %edi
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret    
80105d09:	66 90                	xchg   %ax,%ax
80105d0b:	66 90                	xchg   %ax,%ax
80105d0d:	66 90                	xchg   %ax,%ax
80105d0f:	90                   	nop

80105d10 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105d10:	f3 0f 1e fb          	endbr32 
  return fork();
80105d14:	e9 f7 e0 ff ff       	jmp    80103e10 <fork>
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d20 <sys_thread_create>:
}

int sys_thread_create(void) {
80105d20:	f3 0f 1e fb          	endbr32 
80105d24:	55                   	push   %ebp
80105d25:	89 e5                	mov    %esp,%ebp
80105d27:	83 ec 20             	sub    $0x20,%esp
  int stackptr = 0;
  if (argint(0, &stackptr) < 0) {
80105d2a:	8d 45 f4             	lea    -0xc(%ebp),%eax
  int stackptr = 0;
80105d2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if (argint(0, &stackptr) < 0) {
80105d34:	50                   	push   %eax
80105d35:	6a 00                	push   $0x0
80105d37:	e8 94 f2 ff ff       	call   80104fd0 <argint>
80105d3c:	83 c4 10             	add    $0x10,%esp
80105d3f:	85 c0                	test   %eax,%eax
80105d41:	78 15                	js     80105d58 <sys_thread_create+0x38>
    return -1;
  }
  return thread_create((void*) stackptr);
80105d43:	83 ec 0c             	sub    $0xc,%esp
80105d46:	ff 75 f4             	pushl  -0xc(%ebp)
80105d49:	e8 52 df ff ff       	call   80103ca0 <thread_create>
80105d4e:	83 c4 10             	add    $0x10,%esp
}
80105d51:	c9                   	leave  
80105d52:	c3                   	ret    
80105d53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d57:	90                   	nop
80105d58:	c9                   	leave  
    return -1;
80105d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d5e:	c3                   	ret    
80105d5f:	90                   	nop

80105d60 <sys_exit>:

int
sys_exit(void)
{
80105d60:	f3 0f 1e fb          	endbr32 
80105d64:	55                   	push   %ebp
80105d65:	89 e5                	mov    %esp,%ebp
80105d67:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d6a:	e8 71 e4 ff ff       	call   801041e0 <exit>
  return 0;  // not reached
}
80105d6f:	31 c0                	xor    %eax,%eax
80105d71:	c9                   	leave  
80105d72:	c3                   	ret    
80105d73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d80 <sys_join>:

int sys_join(void) {
80105d80:	f3 0f 1e fb          	endbr32 
  return join();
80105d84:	e9 b7 e6 ff ff       	jmp    80104440 <join>
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d90 <sys_wait>:
}

int
sys_wait(void)
{
80105d90:	f3 0f 1e fb          	endbr32 
  return wait();
80105d94:	e9 f7 e7 ff ff       	jmp    80104590 <wait>
80105d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105da0 <sys_kill>:
}

int
sys_kill(void)
{
80105da0:	f3 0f 1e fb          	endbr32 
80105da4:	55                   	push   %ebp
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105daa:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dad:	50                   	push   %eax
80105dae:	6a 00                	push   $0x0
80105db0:	e8 1b f2 ff ff       	call   80104fd0 <argint>
80105db5:	83 c4 10             	add    $0x10,%esp
80105db8:	85 c0                	test   %eax,%eax
80105dba:	78 14                	js     80105dd0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105dbc:	83 ec 0c             	sub    $0xc,%esp
80105dbf:	ff 75 f4             	pushl  -0xc(%ebp)
80105dc2:	e8 89 e9 ff ff       	call   80104750 <kill>
80105dc7:	83 c4 10             	add    $0x10,%esp
}
80105dca:	c9                   	leave  
80105dcb:	c3                   	ret    
80105dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dd0:	c9                   	leave  
    return -1;
80105dd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105dd6:	c3                   	ret    
80105dd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dde:	66 90                	xchg   %ax,%ax

80105de0 <sys_getpid>:

int
sys_getpid(void)
{
80105de0:	f3 0f 1e fb          	endbr32 
80105de4:	55                   	push   %ebp
80105de5:	89 e5                	mov    %esp,%ebp
80105de7:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105dea:	e8 31 dc ff ff       	call   80103a20 <myproc>
80105def:	8b 40 10             	mov    0x10(%eax),%eax
}
80105df2:	c9                   	leave  
80105df3:	c3                   	ret    
80105df4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dff:	90                   	nop

80105e00 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e00:	f3 0f 1e fb          	endbr32 
80105e04:	55                   	push   %ebp
80105e05:	89 e5                	mov    %esp,%ebp
80105e07:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e08:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e0b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e0e:	50                   	push   %eax
80105e0f:	6a 00                	push   $0x0
80105e11:	e8 ba f1 ff ff       	call   80104fd0 <argint>
80105e16:	83 c4 10             	add    $0x10,%esp
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	78 23                	js     80105e40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e1d:	e8 fe db ff ff       	call   80103a20 <myproc>
  if(growproc(n) < 0)
80105e22:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e25:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e27:	ff 75 f4             	pushl  -0xc(%ebp)
80105e2a:	e8 21 dd ff ff       	call   80103b50 <growproc>
80105e2f:	83 c4 10             	add    $0x10,%esp
80105e32:	85 c0                	test   %eax,%eax
80105e34:	78 0a                	js     80105e40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e36:	89 d8                	mov    %ebx,%eax
80105e38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e3b:	c9                   	leave  
80105e3c:	c3                   	ret    
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105e40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e45:	eb ef                	jmp    80105e36 <sys_sbrk+0x36>
80105e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4e:	66 90                	xchg   %ax,%ax

80105e50 <sys_sleep>:

int
sys_sleep(void)
{
80105e50:	f3 0f 1e fb          	endbr32 
80105e54:	55                   	push   %ebp
80105e55:	89 e5                	mov    %esp,%ebp
80105e57:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e58:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e5b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e5e:	50                   	push   %eax
80105e5f:	6a 00                	push   $0x0
80105e61:	e8 6a f1 ff ff       	call   80104fd0 <argint>
80105e66:	83 c4 10             	add    $0x10,%esp
80105e69:	85 c0                	test   %eax,%eax
80105e6b:	0f 88 86 00 00 00    	js     80105ef7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e71:	83 ec 0c             	sub    $0xc,%esp
80105e74:	68 c0 63 11 80       	push   $0x801163c0
80105e79:	e8 62 ed ff ff       	call   80104be0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105e81:	8b 1d 00 6c 11 80    	mov    0x80116c00,%ebx
  while(ticks - ticks0 < n){
80105e87:	83 c4 10             	add    $0x10,%esp
80105e8a:	85 d2                	test   %edx,%edx
80105e8c:	75 23                	jne    80105eb1 <sys_sleep+0x61>
80105e8e:	eb 50                	jmp    80105ee0 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e90:	83 ec 08             	sub    $0x8,%esp
80105e93:	68 c0 63 11 80       	push   $0x801163c0
80105e98:	68 00 6c 11 80       	push   $0x80116c00
80105e9d:	e8 de e4 ff ff       	call   80104380 <sleep>
  while(ticks - ticks0 < n){
80105ea2:	a1 00 6c 11 80       	mov    0x80116c00,%eax
80105ea7:	83 c4 10             	add    $0x10,%esp
80105eaa:	29 d8                	sub    %ebx,%eax
80105eac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105eaf:	73 2f                	jae    80105ee0 <sys_sleep+0x90>
    if(myproc()->killed){
80105eb1:	e8 6a db ff ff       	call   80103a20 <myproc>
80105eb6:	8b 40 2c             	mov    0x2c(%eax),%eax
80105eb9:	85 c0                	test   %eax,%eax
80105ebb:	74 d3                	je     80105e90 <sys_sleep+0x40>
      release(&tickslock);
80105ebd:	83 ec 0c             	sub    $0xc,%esp
80105ec0:	68 c0 63 11 80       	push   $0x801163c0
80105ec5:	e8 d6 ed ff ff       	call   80104ca0 <release>
  }
  release(&tickslock);
  return 0;
}
80105eca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105ecd:	83 c4 10             	add    $0x10,%esp
80105ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ed5:	c9                   	leave  
80105ed6:	c3                   	ret    
80105ed7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ede:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105ee0:	83 ec 0c             	sub    $0xc,%esp
80105ee3:	68 c0 63 11 80       	push   $0x801163c0
80105ee8:	e8 b3 ed ff ff       	call   80104ca0 <release>
  return 0;
80105eed:	83 c4 10             	add    $0x10,%esp
80105ef0:	31 c0                	xor    %eax,%eax
}
80105ef2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef5:	c9                   	leave  
80105ef6:	c3                   	ret    
    return -1;
80105ef7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105efc:	eb f4                	jmp    80105ef2 <sys_sleep+0xa2>
80105efe:	66 90                	xchg   %ax,%ax

80105f00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f00:	f3 0f 1e fb          	endbr32 
80105f04:	55                   	push   %ebp
80105f05:	89 e5                	mov    %esp,%ebp
80105f07:	53                   	push   %ebx
80105f08:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f0b:	68 c0 63 11 80       	push   $0x801163c0
80105f10:	e8 cb ec ff ff       	call   80104be0 <acquire>
  xticks = ticks;
80105f15:	8b 1d 00 6c 11 80    	mov    0x80116c00,%ebx
  release(&tickslock);
80105f1b:	c7 04 24 c0 63 11 80 	movl   $0x801163c0,(%esp)
80105f22:	e8 79 ed ff ff       	call   80104ca0 <release>
  return xticks;
}
80105f27:	89 d8                	mov    %ebx,%eax
80105f29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f2c:	c9                   	leave  
80105f2d:	c3                   	ret    
80105f2e:	66 90                	xchg   %ax,%ax

80105f30 <sys_getHelloWorld>:

int
sys_getHelloWorld(void) {
80105f30:	f3 0f 1e fb          	endbr32 
  return getHelloWorld();
80105f34:	e9 87 e9 ff ff       	jmp    801048c0 <getHelloWorld>
80105f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f40 <sys_getProcCount>:
}

int
sys_getProcCount(void) {
80105f40:	f3 0f 1e fb          	endbr32 
  return getProcCount();
80105f44:	e9 97 e9 ff ff       	jmp    801048e0 <getProcCount>
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f50 <sys_getReadCount>:
}

extern int readCount;

int sys_getReadCount(void) {
80105f50:	f3 0f 1e fb          	endbr32 
80105f54:	55                   	push   %ebp
80105f55:	89 e5                	mov    %esp,%ebp
80105f57:	83 ec 10             	sub    $0x10,%esp
  cprintf("%d", readCount);
80105f5a:	ff 35 bc b5 10 80    	pushl  0x8010b5bc
80105f60:	68 ed 7e 10 80       	push   $0x80107eed
80105f65:	e8 46 a7 ff ff       	call   801006b0 <cprintf>
  return readCount;
}
80105f6a:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
80105f6f:	c9                   	leave  
80105f70:	c3                   	ret    
80105f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7f:	90                   	nop

80105f80 <sys_getTurnaroundTime>:

int sys_getTurnaroundTime(void) {
80105f80:	f3 0f 1e fb          	endbr32 
80105f84:	55                   	push   %ebp
80105f85:	89 e5                	mov    %esp,%ebp
80105f87:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105f8a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f8d:	50                   	push   %eax
80105f8e:	6a 00                	push   $0x0
80105f90:	e8 3b f0 ff ff       	call   80104fd0 <argint>
80105f95:	83 c4 10             	add    $0x10,%esp
80105f98:	85 c0                	test   %eax,%eax
80105f9a:	78 14                	js     80105fb0 <sys_getTurnaroundTime+0x30>
    return -1;
  return getTurnaroundTime(pid);
80105f9c:	83 ec 0c             	sub    $0xc,%esp
80105f9f:	ff 75 f4             	pushl  -0xc(%ebp)
80105fa2:	e8 99 e0 ff ff       	call   80104040 <getTurnaroundTime>
80105fa7:	83 c4 10             	add    $0x10,%esp
}
80105faa:	c9                   	leave  
80105fab:	c3                   	ret    
80105fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fb0:	c9                   	leave  
    return -1;
80105fb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fb6:	c3                   	ret    
80105fb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbe:	66 90                	xchg   %ax,%ax

80105fc0 <sys_getWaitingTime>:

int sys_getWaitingTime(void) {
80105fc0:	f3 0f 1e fb          	endbr32 
80105fc4:	55                   	push   %ebp
80105fc5:	89 e5                	mov    %esp,%ebp
80105fc7:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105fca:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fcd:	50                   	push   %eax
80105fce:	6a 00                	push   $0x0
80105fd0:	e8 fb ef ff ff       	call   80104fd0 <argint>
80105fd5:	83 c4 10             	add    $0x10,%esp
80105fd8:	85 c0                	test   %eax,%eax
80105fda:	78 14                	js     80105ff0 <sys_getWaitingTime+0x30>
    return -1;
  return getWaitingTime(pid);
80105fdc:	83 ec 0c             	sub    $0xc,%esp
80105fdf:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe2:	e8 a9 e0 ff ff       	call   80104090 <getWaitingTime>
80105fe7:	83 c4 10             	add    $0x10,%esp
}
80105fea:	c9                   	leave  
80105feb:	c3                   	ret    
80105fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ff0:	c9                   	leave  
    return -1;
80105ff1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ff6:	c3                   	ret    
80105ff7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ffe:	66 90                	xchg   %ax,%ax

80106000 <sys_getCpuBurstTime>:

int sys_getCpuBurstTime(void) {
80106000:	f3 0f 1e fb          	endbr32 
80106004:	55                   	push   %ebp
80106005:	89 e5                	mov    %esp,%ebp
80106007:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010600a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010600d:	50                   	push   %eax
8010600e:	6a 00                	push   $0x0
80106010:	e8 bb ef ff ff       	call   80104fd0 <argint>
80106015:	83 c4 10             	add    $0x10,%esp
80106018:	85 c0                	test   %eax,%eax
8010601a:	78 14                	js     80106030 <sys_getCpuBurstTime+0x30>
    return -1;
  return getCpuBurstTime(pid);
8010601c:	83 ec 0c             	sub    $0xc,%esp
8010601f:	ff 75 f4             	pushl  -0xc(%ebp)
80106022:	e8 b9 e0 ff ff       	call   801040e0 <getCpuBurstTime>
80106027:	83 c4 10             	add    $0x10,%esp
}
8010602a:	c9                   	leave  
8010602b:	c3                   	ret    
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106030:	c9                   	leave  
    return -1;
80106031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106036:	c3                   	ret    

80106037 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106037:	1e                   	push   %ds
  pushl %es
80106038:	06                   	push   %es
  pushl %fs
80106039:	0f a0                	push   %fs
  pushl %gs
8010603b:	0f a8                	push   %gs
  pushal
8010603d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010603e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106042:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106044:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106046:	54                   	push   %esp
  call trap
80106047:	e8 c4 00 00 00       	call   80106110 <trap>
  addl $4, %esp
8010604c:	83 c4 04             	add    $0x4,%esp

8010604f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010604f:	61                   	popa   
  popl %gs
80106050:	0f a9                	pop    %gs
  popl %fs
80106052:	0f a1                	pop    %fs
  popl %es
80106054:	07                   	pop    %es
  popl %ds
80106055:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106056:	83 c4 08             	add    $0x8,%esp
  iret
80106059:	cf                   	iret   
8010605a:	66 90                	xchg   %ax,%ax
8010605c:	66 90                	xchg   %ax,%ax
8010605e:	66 90                	xchg   %ax,%ax

80106060 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106060:	f3 0f 1e fb          	endbr32 
80106064:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106065:	31 c0                	xor    %eax,%eax
{
80106067:	89 e5                	mov    %esp,%ebp
80106069:	83 ec 08             	sub    $0x8,%esp
8010606c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106070:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106077:	c7 04 c5 02 64 11 80 	movl   $0x8e000008,-0x7fee9bfe(,%eax,8)
8010607e:	08 00 00 8e 
80106082:	66 89 14 c5 00 64 11 	mov    %dx,-0x7fee9c00(,%eax,8)
80106089:	80 
8010608a:	c1 ea 10             	shr    $0x10,%edx
8010608d:	66 89 14 c5 06 64 11 	mov    %dx,-0x7fee9bfa(,%eax,8)
80106094:	80 
  for(i = 0; i < 256; i++)
80106095:	83 c0 01             	add    $0x1,%eax
80106098:	3d 00 01 00 00       	cmp    $0x100,%eax
8010609d:	75 d1                	jne    80106070 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010609f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060a2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801060a7:	c7 05 02 66 11 80 08 	movl   $0xef000008,0x80116602
801060ae:	00 00 ef 
  initlock(&tickslock, "time");
801060b1:	68 99 80 10 80       	push   $0x80108099
801060b6:	68 c0 63 11 80       	push   $0x801163c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060bb:	66 a3 00 66 11 80    	mov    %ax,0x80116600
801060c1:	c1 e8 10             	shr    $0x10,%eax
801060c4:	66 a3 06 66 11 80    	mov    %ax,0x80116606
  initlock(&tickslock, "time");
801060ca:	e8 91 e9 ff ff       	call   80104a60 <initlock>
}
801060cf:	83 c4 10             	add    $0x10,%esp
801060d2:	c9                   	leave  
801060d3:	c3                   	ret    
801060d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060df:	90                   	nop

801060e0 <idtinit>:

void
idtinit(void)
{
801060e0:	f3 0f 1e fb          	endbr32 
801060e4:	55                   	push   %ebp
  pd[0] = size-1;
801060e5:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801060ea:	89 e5                	mov    %esp,%ebp
801060ec:	83 ec 10             	sub    $0x10,%esp
801060ef:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801060f3:	b8 00 64 11 80       	mov    $0x80116400,%eax
801060f8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801060fc:	c1 e8 10             	shr    $0x10,%eax
801060ff:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106103:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106106:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106109:	c9                   	leave  
8010610a:	c3                   	ret    
8010610b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010610f:	90                   	nop

80106110 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106110:	f3 0f 1e fb          	endbr32 
80106114:	55                   	push   %ebp
80106115:	89 e5                	mov    %esp,%ebp
80106117:	57                   	push   %edi
80106118:	56                   	push   %esi
80106119:	53                   	push   %ebx
8010611a:	83 ec 1c             	sub    $0x1c,%esp
8010611d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106120:	8b 43 30             	mov    0x30(%ebx),%eax
80106123:	83 f8 40             	cmp    $0x40,%eax
80106126:	0f 84 f4 01 00 00    	je     80106320 <trap+0x210>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010612c:	83 e8 20             	sub    $0x20,%eax
8010612f:	83 f8 1f             	cmp    $0x1f,%eax
80106132:	77 08                	ja     8010613c <trap+0x2c>
80106134:	3e ff 24 85 40 81 10 	notrack jmp *-0x7fef7ec0(,%eax,4)
8010613b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010613c:	e8 df d8 ff ff       	call   80103a20 <myproc>
80106141:	8b 7b 38             	mov    0x38(%ebx),%edi
80106144:	85 c0                	test   %eax,%eax
80106146:	0f 84 23 02 00 00    	je     8010636f <trap+0x25f>
8010614c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106150:	0f 84 19 02 00 00    	je     8010636f <trap+0x25f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106156:	0f 20 d1             	mov    %cr2,%ecx
80106159:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010615c:	e8 9f d8 ff ff       	call   80103a00 <cpuid>
80106161:	8b 73 30             	mov    0x30(%ebx),%esi
80106164:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106167:	8b 43 34             	mov    0x34(%ebx),%eax
8010616a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010616d:	e8 ae d8 ff ff       	call   80103a20 <myproc>
80106172:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106175:	e8 a6 d8 ff ff       	call   80103a20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010617a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010617d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106180:	51                   	push   %ecx
80106181:	57                   	push   %edi
80106182:	52                   	push   %edx
80106183:	ff 75 e4             	pushl  -0x1c(%ebp)
80106186:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106187:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010618a:	83 c6 74             	add    $0x74,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010618d:	56                   	push   %esi
8010618e:	ff 70 10             	pushl  0x10(%eax)
80106191:	68 fc 80 10 80       	push   $0x801080fc
80106196:	e8 15 a5 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010619b:	83 c4 20             	add    $0x20,%esp
8010619e:	e8 7d d8 ff ff       	call   80103a20 <myproc>
801061a3:	c7 40 2c 01 00 00 00 	movl   $0x1,0x2c(%eax)
  }

  updateTimes();
801061aa:	e8 31 de ff ff       	call   80103fe0 <updateTimes>

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061af:	e8 6c d8 ff ff       	call   80103a20 <myproc>
801061b4:	85 c0                	test   %eax,%eax
801061b6:	74 1d                	je     801061d5 <trap+0xc5>
801061b8:	e8 63 d8 ff ff       	call   80103a20 <myproc>
801061bd:	8b 50 2c             	mov    0x2c(%eax),%edx
801061c0:	85 d2                	test   %edx,%edx
801061c2:	74 11                	je     801061d5 <trap+0xc5>
801061c4:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061c8:	83 e0 03             	and    $0x3,%eax
801061cb:	66 83 f8 03          	cmp    $0x3,%ax
801061cf:	0f 84 83 01 00 00    	je     80106358 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801061d5:	e8 46 d8 ff ff       	call   80103a20 <myproc>
801061da:	85 c0                	test   %eax,%eax
801061dc:	74 0f                	je     801061ed <trap+0xdd>
801061de:	e8 3d d8 ff ff       	call   80103a20 <myproc>
801061e3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801061e7:	0f 84 03 01 00 00    	je     801062f0 <trap+0x1e0>
      yield();
    }
  }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061ed:	e8 2e d8 ff ff       	call   80103a20 <myproc>
801061f2:	85 c0                	test   %eax,%eax
801061f4:	74 1d                	je     80106213 <trap+0x103>
801061f6:	e8 25 d8 ff ff       	call   80103a20 <myproc>
801061fb:	8b 40 2c             	mov    0x2c(%eax),%eax
801061fe:	85 c0                	test   %eax,%eax
80106200:	74 11                	je     80106213 <trap+0x103>
80106202:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106206:	83 e0 03             	and    $0x3,%eax
80106209:	66 83 f8 03          	cmp    $0x3,%ax
8010620d:	0f 84 36 01 00 00    	je     80106349 <trap+0x239>
    exit();
}
80106213:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106216:	5b                   	pop    %ebx
80106217:	5e                   	pop    %esi
80106218:	5f                   	pop    %edi
80106219:	5d                   	pop    %ebp
8010621a:	c3                   	ret    
    ideintr();
8010621b:	e8 e0 bf ff ff       	call   80102200 <ideintr>
    lapiceoi();
80106220:	e8 bb c6 ff ff       	call   801028e0 <lapiceoi>
  updateTimes();
80106225:	e8 b6 dd ff ff       	call   80103fe0 <updateTimes>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010622a:	e8 f1 d7 ff ff       	call   80103a20 <myproc>
8010622f:	85 c0                	test   %eax,%eax
80106231:	75 85                	jne    801061b8 <trap+0xa8>
80106233:	eb a0                	jmp    801061d5 <trap+0xc5>
    if(cpuid() == 0){
80106235:	e8 c6 d7 ff ff       	call   80103a00 <cpuid>
8010623a:	85 c0                	test   %eax,%eax
8010623c:	75 e2                	jne    80106220 <trap+0x110>
      acquire(&tickslock);
8010623e:	83 ec 0c             	sub    $0xc,%esp
80106241:	68 c0 63 11 80       	push   $0x801163c0
80106246:	e8 95 e9 ff ff       	call   80104be0 <acquire>
      wakeup(&ticks);
8010624b:	c7 04 24 00 6c 11 80 	movl   $0x80116c00,(%esp)
      ticks++;
80106252:	83 05 00 6c 11 80 01 	addl   $0x1,0x80116c00
      wakeup(&ticks);
80106259:	e8 82 e4 ff ff       	call   801046e0 <wakeup>
      release(&tickslock);
8010625e:	c7 04 24 c0 63 11 80 	movl   $0x801163c0,(%esp)
80106265:	e8 36 ea ff ff       	call   80104ca0 <release>
8010626a:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010626d:	eb b1                	jmp    80106220 <trap+0x110>
    kbdintr();
8010626f:	e8 2c c5 ff ff       	call   801027a0 <kbdintr>
    lapiceoi();
80106274:	e8 67 c6 ff ff       	call   801028e0 <lapiceoi>
  updateTimes();
80106279:	e8 62 dd ff ff       	call   80103fe0 <updateTimes>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010627e:	e8 9d d7 ff ff       	call   80103a20 <myproc>
80106283:	85 c0                	test   %eax,%eax
80106285:	0f 85 2d ff ff ff    	jne    801061b8 <trap+0xa8>
8010628b:	e9 45 ff ff ff       	jmp    801061d5 <trap+0xc5>
    uartintr();
80106290:	e8 7b 02 00 00       	call   80106510 <uartintr>
    lapiceoi();
80106295:	e8 46 c6 ff ff       	call   801028e0 <lapiceoi>
  updateTimes();
8010629a:	e8 41 dd ff ff       	call   80103fe0 <updateTimes>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010629f:	e8 7c d7 ff ff       	call   80103a20 <myproc>
801062a4:	85 c0                	test   %eax,%eax
801062a6:	0f 85 0c ff ff ff    	jne    801061b8 <trap+0xa8>
801062ac:	e9 24 ff ff ff       	jmp    801061d5 <trap+0xc5>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062b1:	8b 7b 38             	mov    0x38(%ebx),%edi
801062b4:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801062b8:	e8 43 d7 ff ff       	call   80103a00 <cpuid>
801062bd:	57                   	push   %edi
801062be:	56                   	push   %esi
801062bf:	50                   	push   %eax
801062c0:	68 a4 80 10 80       	push   $0x801080a4
801062c5:	e8 e6 a3 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801062ca:	e8 11 c6 ff ff       	call   801028e0 <lapiceoi>
    break;
801062cf:	83 c4 10             	add    $0x10,%esp
  updateTimes();
801062d2:	e8 09 dd ff ff       	call   80103fe0 <updateTimes>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801062d7:	e8 44 d7 ff ff       	call   80103a20 <myproc>
801062dc:	85 c0                	test   %eax,%eax
801062de:	0f 85 d4 fe ff ff    	jne    801061b8 <trap+0xa8>
801062e4:	e9 ec fe ff ff       	jmp    801061d5 <trap+0xc5>
801062e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
801062f0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801062f4:	0f 85 f3 fe ff ff    	jne    801061ed <trap+0xdd>
    if (ticks % QUANTUM == 0) {
801062fa:	69 05 00 6c 11 80 cd 	imul   $0xcccccccd,0x80116c00,%eax
80106301:	cc cc cc 
80106304:	d1 c8                	ror    %eax
80106306:	3d 99 99 99 19       	cmp    $0x19999999,%eax
8010630b:	0f 87 dc fe ff ff    	ja     801061ed <trap+0xdd>
      yield();
80106311:	e8 1a e0 ff ff       	call   80104330 <yield>
80106316:	e9 d2 fe ff ff       	jmp    801061ed <trap+0xdd>
8010631b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010631f:	90                   	nop
    if(myproc()->killed)
80106320:	e8 fb d6 ff ff       	call   80103a20 <myproc>
80106325:	8b 70 2c             	mov    0x2c(%eax),%esi
80106328:	85 f6                	test   %esi,%esi
8010632a:	75 3c                	jne    80106368 <trap+0x258>
    myproc()->tf = tf;
8010632c:	e8 ef d6 ff ff       	call   80103a20 <myproc>
80106331:	89 58 20             	mov    %ebx,0x20(%eax)
    syscall();
80106334:	e8 87 ed ff ff       	call   801050c0 <syscall>
    if(myproc()->killed)
80106339:	e8 e2 d6 ff ff       	call   80103a20 <myproc>
8010633e:	8b 48 2c             	mov    0x2c(%eax),%ecx
80106341:	85 c9                	test   %ecx,%ecx
80106343:	0f 84 ca fe ff ff    	je     80106213 <trap+0x103>
}
80106349:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010634c:	5b                   	pop    %ebx
8010634d:	5e                   	pop    %esi
8010634e:	5f                   	pop    %edi
8010634f:	5d                   	pop    %ebp
      exit();
80106350:	e9 8b de ff ff       	jmp    801041e0 <exit>
80106355:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106358:	e8 83 de ff ff       	call   801041e0 <exit>
8010635d:	e9 73 fe ff ff       	jmp    801061d5 <trap+0xc5>
80106362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106368:	e8 73 de ff ff       	call   801041e0 <exit>
8010636d:	eb bd                	jmp    8010632c <trap+0x21c>
8010636f:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106372:	e8 89 d6 ff ff       	call   80103a00 <cpuid>
80106377:	83 ec 0c             	sub    $0xc,%esp
8010637a:	56                   	push   %esi
8010637b:	57                   	push   %edi
8010637c:	50                   	push   %eax
8010637d:	ff 73 30             	pushl  0x30(%ebx)
80106380:	68 c8 80 10 80       	push   $0x801080c8
80106385:	e8 26 a3 ff ff       	call   801006b0 <cprintf>
      panic("trap");
8010638a:	83 c4 14             	add    $0x14,%esp
8010638d:	68 9e 80 10 80       	push   $0x8010809e
80106392:	e8 f9 9f ff ff       	call   80100390 <panic>
80106397:	66 90                	xchg   %ax,%ax
80106399:	66 90                	xchg   %ax,%ax
8010639b:	66 90                	xchg   %ax,%ax
8010639d:	66 90                	xchg   %ax,%ax
8010639f:	90                   	nop

801063a0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801063a0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801063a4:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
801063a9:	85 c0                	test   %eax,%eax
801063ab:	74 1b                	je     801063c8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801063ad:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063b2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801063b3:	a8 01                	test   $0x1,%al
801063b5:	74 11                	je     801063c8 <uartgetc+0x28>
801063b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063bc:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801063bd:	0f b6 c0             	movzbl %al,%eax
801063c0:	c3                   	ret    
801063c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063cd:	c3                   	ret    
801063ce:	66 90                	xchg   %ax,%ax

801063d0 <uartputc.part.0>:
uartputc(int c)
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	57                   	push   %edi
801063d4:	89 c7                	mov    %eax,%edi
801063d6:	56                   	push   %esi
801063d7:	be fd 03 00 00       	mov    $0x3fd,%esi
801063dc:	53                   	push   %ebx
801063dd:	bb 80 00 00 00       	mov    $0x80,%ebx
801063e2:	83 ec 0c             	sub    $0xc,%esp
801063e5:	eb 1b                	jmp    80106402 <uartputc.part.0+0x32>
801063e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ee:	66 90                	xchg   %ax,%ax
    microdelay(10);
801063f0:	83 ec 0c             	sub    $0xc,%esp
801063f3:	6a 0a                	push   $0xa
801063f5:	e8 06 c5 ff ff       	call   80102900 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801063fa:	83 c4 10             	add    $0x10,%esp
801063fd:	83 eb 01             	sub    $0x1,%ebx
80106400:	74 07                	je     80106409 <uartputc.part.0+0x39>
80106402:	89 f2                	mov    %esi,%edx
80106404:	ec                   	in     (%dx),%al
80106405:	a8 20                	test   $0x20,%al
80106407:	74 e7                	je     801063f0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106409:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010640e:	89 f8                	mov    %edi,%eax
80106410:	ee                   	out    %al,(%dx)
}
80106411:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106414:	5b                   	pop    %ebx
80106415:	5e                   	pop    %esi
80106416:	5f                   	pop    %edi
80106417:	5d                   	pop    %ebp
80106418:	c3                   	ret    
80106419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106420 <uartinit>:
{
80106420:	f3 0f 1e fb          	endbr32 
80106424:	55                   	push   %ebp
80106425:	31 c9                	xor    %ecx,%ecx
80106427:	89 c8                	mov    %ecx,%eax
80106429:	89 e5                	mov    %esp,%ebp
8010642b:	57                   	push   %edi
8010642c:	56                   	push   %esi
8010642d:	53                   	push   %ebx
8010642e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106433:	89 da                	mov    %ebx,%edx
80106435:	83 ec 0c             	sub    $0xc,%esp
80106438:	ee                   	out    %al,(%dx)
80106439:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010643e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106443:	89 fa                	mov    %edi,%edx
80106445:	ee                   	out    %al,(%dx)
80106446:	b8 0c 00 00 00       	mov    $0xc,%eax
8010644b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106450:	ee                   	out    %al,(%dx)
80106451:	be f9 03 00 00       	mov    $0x3f9,%esi
80106456:	89 c8                	mov    %ecx,%eax
80106458:	89 f2                	mov    %esi,%edx
8010645a:	ee                   	out    %al,(%dx)
8010645b:	b8 03 00 00 00       	mov    $0x3,%eax
80106460:	89 fa                	mov    %edi,%edx
80106462:	ee                   	out    %al,(%dx)
80106463:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106468:	89 c8                	mov    %ecx,%eax
8010646a:	ee                   	out    %al,(%dx)
8010646b:	b8 01 00 00 00       	mov    $0x1,%eax
80106470:	89 f2                	mov    %esi,%edx
80106472:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106473:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106478:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106479:	3c ff                	cmp    $0xff,%al
8010647b:	74 52                	je     801064cf <uartinit+0xaf>
  uart = 1;
8010647d:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
80106484:	00 00 00 
80106487:	89 da                	mov    %ebx,%edx
80106489:	ec                   	in     (%dx),%al
8010648a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010648f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106490:	83 ec 08             	sub    $0x8,%esp
80106493:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106498:	bb c0 81 10 80       	mov    $0x801081c0,%ebx
  ioapicenable(IRQ_COM1, 0);
8010649d:	6a 00                	push   $0x0
8010649f:	6a 04                	push   $0x4
801064a1:	e8 aa bf ff ff       	call   80102450 <ioapicenable>
801064a6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801064a9:	b8 78 00 00 00       	mov    $0x78,%eax
801064ae:	eb 04                	jmp    801064b4 <uartinit+0x94>
801064b0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801064b4:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
801064ba:	85 d2                	test   %edx,%edx
801064bc:	74 08                	je     801064c6 <uartinit+0xa6>
    uartputc(*p);
801064be:	0f be c0             	movsbl %al,%eax
801064c1:	e8 0a ff ff ff       	call   801063d0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801064c6:	89 f0                	mov    %esi,%eax
801064c8:	83 c3 01             	add    $0x1,%ebx
801064cb:	84 c0                	test   %al,%al
801064cd:	75 e1                	jne    801064b0 <uartinit+0x90>
}
801064cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064d2:	5b                   	pop    %ebx
801064d3:	5e                   	pop    %esi
801064d4:	5f                   	pop    %edi
801064d5:	5d                   	pop    %ebp
801064d6:	c3                   	ret    
801064d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064de:	66 90                	xchg   %ax,%ax

801064e0 <uartputc>:
{
801064e0:	f3 0f 1e fb          	endbr32 
801064e4:	55                   	push   %ebp
  if(!uart)
801064e5:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
{
801064eb:	89 e5                	mov    %esp,%ebp
801064ed:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801064f0:	85 d2                	test   %edx,%edx
801064f2:	74 0c                	je     80106500 <uartputc+0x20>
}
801064f4:	5d                   	pop    %ebp
801064f5:	e9 d6 fe ff ff       	jmp    801063d0 <uartputc.part.0>
801064fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106500:	5d                   	pop    %ebp
80106501:	c3                   	ret    
80106502:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106510 <uartintr>:

void
uartintr(void)
{
80106510:	f3 0f 1e fb          	endbr32 
80106514:	55                   	push   %ebp
80106515:	89 e5                	mov    %esp,%ebp
80106517:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010651a:	68 a0 63 10 80       	push   $0x801063a0
8010651f:	e8 3c a3 ff ff       	call   80100860 <consoleintr>
}
80106524:	83 c4 10             	add    $0x10,%esp
80106527:	c9                   	leave  
80106528:	c3                   	ret    

80106529 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106529:	6a 00                	push   $0x0
  pushl $0
8010652b:	6a 00                	push   $0x0
  jmp alltraps
8010652d:	e9 05 fb ff ff       	jmp    80106037 <alltraps>

80106532 <vector1>:
.globl vector1
vector1:
  pushl $0
80106532:	6a 00                	push   $0x0
  pushl $1
80106534:	6a 01                	push   $0x1
  jmp alltraps
80106536:	e9 fc fa ff ff       	jmp    80106037 <alltraps>

8010653b <vector2>:
.globl vector2
vector2:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $2
8010653d:	6a 02                	push   $0x2
  jmp alltraps
8010653f:	e9 f3 fa ff ff       	jmp    80106037 <alltraps>

80106544 <vector3>:
.globl vector3
vector3:
  pushl $0
80106544:	6a 00                	push   $0x0
  pushl $3
80106546:	6a 03                	push   $0x3
  jmp alltraps
80106548:	e9 ea fa ff ff       	jmp    80106037 <alltraps>

8010654d <vector4>:
.globl vector4
vector4:
  pushl $0
8010654d:	6a 00                	push   $0x0
  pushl $4
8010654f:	6a 04                	push   $0x4
  jmp alltraps
80106551:	e9 e1 fa ff ff       	jmp    80106037 <alltraps>

80106556 <vector5>:
.globl vector5
vector5:
  pushl $0
80106556:	6a 00                	push   $0x0
  pushl $5
80106558:	6a 05                	push   $0x5
  jmp alltraps
8010655a:	e9 d8 fa ff ff       	jmp    80106037 <alltraps>

8010655f <vector6>:
.globl vector6
vector6:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $6
80106561:	6a 06                	push   $0x6
  jmp alltraps
80106563:	e9 cf fa ff ff       	jmp    80106037 <alltraps>

80106568 <vector7>:
.globl vector7
vector7:
  pushl $0
80106568:	6a 00                	push   $0x0
  pushl $7
8010656a:	6a 07                	push   $0x7
  jmp alltraps
8010656c:	e9 c6 fa ff ff       	jmp    80106037 <alltraps>

80106571 <vector8>:
.globl vector8
vector8:
  pushl $8
80106571:	6a 08                	push   $0x8
  jmp alltraps
80106573:	e9 bf fa ff ff       	jmp    80106037 <alltraps>

80106578 <vector9>:
.globl vector9
vector9:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $9
8010657a:	6a 09                	push   $0x9
  jmp alltraps
8010657c:	e9 b6 fa ff ff       	jmp    80106037 <alltraps>

80106581 <vector10>:
.globl vector10
vector10:
  pushl $10
80106581:	6a 0a                	push   $0xa
  jmp alltraps
80106583:	e9 af fa ff ff       	jmp    80106037 <alltraps>

80106588 <vector11>:
.globl vector11
vector11:
  pushl $11
80106588:	6a 0b                	push   $0xb
  jmp alltraps
8010658a:	e9 a8 fa ff ff       	jmp    80106037 <alltraps>

8010658f <vector12>:
.globl vector12
vector12:
  pushl $12
8010658f:	6a 0c                	push   $0xc
  jmp alltraps
80106591:	e9 a1 fa ff ff       	jmp    80106037 <alltraps>

80106596 <vector13>:
.globl vector13
vector13:
  pushl $13
80106596:	6a 0d                	push   $0xd
  jmp alltraps
80106598:	e9 9a fa ff ff       	jmp    80106037 <alltraps>

8010659d <vector14>:
.globl vector14
vector14:
  pushl $14
8010659d:	6a 0e                	push   $0xe
  jmp alltraps
8010659f:	e9 93 fa ff ff       	jmp    80106037 <alltraps>

801065a4 <vector15>:
.globl vector15
vector15:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $15
801065a6:	6a 0f                	push   $0xf
  jmp alltraps
801065a8:	e9 8a fa ff ff       	jmp    80106037 <alltraps>

801065ad <vector16>:
.globl vector16
vector16:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $16
801065af:	6a 10                	push   $0x10
  jmp alltraps
801065b1:	e9 81 fa ff ff       	jmp    80106037 <alltraps>

801065b6 <vector17>:
.globl vector17
vector17:
  pushl $17
801065b6:	6a 11                	push   $0x11
  jmp alltraps
801065b8:	e9 7a fa ff ff       	jmp    80106037 <alltraps>

801065bd <vector18>:
.globl vector18
vector18:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $18
801065bf:	6a 12                	push   $0x12
  jmp alltraps
801065c1:	e9 71 fa ff ff       	jmp    80106037 <alltraps>

801065c6 <vector19>:
.globl vector19
vector19:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $19
801065c8:	6a 13                	push   $0x13
  jmp alltraps
801065ca:	e9 68 fa ff ff       	jmp    80106037 <alltraps>

801065cf <vector20>:
.globl vector20
vector20:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $20
801065d1:	6a 14                	push   $0x14
  jmp alltraps
801065d3:	e9 5f fa ff ff       	jmp    80106037 <alltraps>

801065d8 <vector21>:
.globl vector21
vector21:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $21
801065da:	6a 15                	push   $0x15
  jmp alltraps
801065dc:	e9 56 fa ff ff       	jmp    80106037 <alltraps>

801065e1 <vector22>:
.globl vector22
vector22:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $22
801065e3:	6a 16                	push   $0x16
  jmp alltraps
801065e5:	e9 4d fa ff ff       	jmp    80106037 <alltraps>

801065ea <vector23>:
.globl vector23
vector23:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $23
801065ec:	6a 17                	push   $0x17
  jmp alltraps
801065ee:	e9 44 fa ff ff       	jmp    80106037 <alltraps>

801065f3 <vector24>:
.globl vector24
vector24:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $24
801065f5:	6a 18                	push   $0x18
  jmp alltraps
801065f7:	e9 3b fa ff ff       	jmp    80106037 <alltraps>

801065fc <vector25>:
.globl vector25
vector25:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $25
801065fe:	6a 19                	push   $0x19
  jmp alltraps
80106600:	e9 32 fa ff ff       	jmp    80106037 <alltraps>

80106605 <vector26>:
.globl vector26
vector26:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $26
80106607:	6a 1a                	push   $0x1a
  jmp alltraps
80106609:	e9 29 fa ff ff       	jmp    80106037 <alltraps>

8010660e <vector27>:
.globl vector27
vector27:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $27
80106610:	6a 1b                	push   $0x1b
  jmp alltraps
80106612:	e9 20 fa ff ff       	jmp    80106037 <alltraps>

80106617 <vector28>:
.globl vector28
vector28:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $28
80106619:	6a 1c                	push   $0x1c
  jmp alltraps
8010661b:	e9 17 fa ff ff       	jmp    80106037 <alltraps>

80106620 <vector29>:
.globl vector29
vector29:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $29
80106622:	6a 1d                	push   $0x1d
  jmp alltraps
80106624:	e9 0e fa ff ff       	jmp    80106037 <alltraps>

80106629 <vector30>:
.globl vector30
vector30:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $30
8010662b:	6a 1e                	push   $0x1e
  jmp alltraps
8010662d:	e9 05 fa ff ff       	jmp    80106037 <alltraps>

80106632 <vector31>:
.globl vector31
vector31:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $31
80106634:	6a 1f                	push   $0x1f
  jmp alltraps
80106636:	e9 fc f9 ff ff       	jmp    80106037 <alltraps>

8010663b <vector32>:
.globl vector32
vector32:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $32
8010663d:	6a 20                	push   $0x20
  jmp alltraps
8010663f:	e9 f3 f9 ff ff       	jmp    80106037 <alltraps>

80106644 <vector33>:
.globl vector33
vector33:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $33
80106646:	6a 21                	push   $0x21
  jmp alltraps
80106648:	e9 ea f9 ff ff       	jmp    80106037 <alltraps>

8010664d <vector34>:
.globl vector34
vector34:
  pushl $0
8010664d:	6a 00                	push   $0x0
  pushl $34
8010664f:	6a 22                	push   $0x22
  jmp alltraps
80106651:	e9 e1 f9 ff ff       	jmp    80106037 <alltraps>

80106656 <vector35>:
.globl vector35
vector35:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $35
80106658:	6a 23                	push   $0x23
  jmp alltraps
8010665a:	e9 d8 f9 ff ff       	jmp    80106037 <alltraps>

8010665f <vector36>:
.globl vector36
vector36:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $36
80106661:	6a 24                	push   $0x24
  jmp alltraps
80106663:	e9 cf f9 ff ff       	jmp    80106037 <alltraps>

80106668 <vector37>:
.globl vector37
vector37:
  pushl $0
80106668:	6a 00                	push   $0x0
  pushl $37
8010666a:	6a 25                	push   $0x25
  jmp alltraps
8010666c:	e9 c6 f9 ff ff       	jmp    80106037 <alltraps>

80106671 <vector38>:
.globl vector38
vector38:
  pushl $0
80106671:	6a 00                	push   $0x0
  pushl $38
80106673:	6a 26                	push   $0x26
  jmp alltraps
80106675:	e9 bd f9 ff ff       	jmp    80106037 <alltraps>

8010667a <vector39>:
.globl vector39
vector39:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $39
8010667c:	6a 27                	push   $0x27
  jmp alltraps
8010667e:	e9 b4 f9 ff ff       	jmp    80106037 <alltraps>

80106683 <vector40>:
.globl vector40
vector40:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $40
80106685:	6a 28                	push   $0x28
  jmp alltraps
80106687:	e9 ab f9 ff ff       	jmp    80106037 <alltraps>

8010668c <vector41>:
.globl vector41
vector41:
  pushl $0
8010668c:	6a 00                	push   $0x0
  pushl $41
8010668e:	6a 29                	push   $0x29
  jmp alltraps
80106690:	e9 a2 f9 ff ff       	jmp    80106037 <alltraps>

80106695 <vector42>:
.globl vector42
vector42:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $42
80106697:	6a 2a                	push   $0x2a
  jmp alltraps
80106699:	e9 99 f9 ff ff       	jmp    80106037 <alltraps>

8010669e <vector43>:
.globl vector43
vector43:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $43
801066a0:	6a 2b                	push   $0x2b
  jmp alltraps
801066a2:	e9 90 f9 ff ff       	jmp    80106037 <alltraps>

801066a7 <vector44>:
.globl vector44
vector44:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $44
801066a9:	6a 2c                	push   $0x2c
  jmp alltraps
801066ab:	e9 87 f9 ff ff       	jmp    80106037 <alltraps>

801066b0 <vector45>:
.globl vector45
vector45:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $45
801066b2:	6a 2d                	push   $0x2d
  jmp alltraps
801066b4:	e9 7e f9 ff ff       	jmp    80106037 <alltraps>

801066b9 <vector46>:
.globl vector46
vector46:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $46
801066bb:	6a 2e                	push   $0x2e
  jmp alltraps
801066bd:	e9 75 f9 ff ff       	jmp    80106037 <alltraps>

801066c2 <vector47>:
.globl vector47
vector47:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $47
801066c4:	6a 2f                	push   $0x2f
  jmp alltraps
801066c6:	e9 6c f9 ff ff       	jmp    80106037 <alltraps>

801066cb <vector48>:
.globl vector48
vector48:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $48
801066cd:	6a 30                	push   $0x30
  jmp alltraps
801066cf:	e9 63 f9 ff ff       	jmp    80106037 <alltraps>

801066d4 <vector49>:
.globl vector49
vector49:
  pushl $0
801066d4:	6a 00                	push   $0x0
  pushl $49
801066d6:	6a 31                	push   $0x31
  jmp alltraps
801066d8:	e9 5a f9 ff ff       	jmp    80106037 <alltraps>

801066dd <vector50>:
.globl vector50
vector50:
  pushl $0
801066dd:	6a 00                	push   $0x0
  pushl $50
801066df:	6a 32                	push   $0x32
  jmp alltraps
801066e1:	e9 51 f9 ff ff       	jmp    80106037 <alltraps>

801066e6 <vector51>:
.globl vector51
vector51:
  pushl $0
801066e6:	6a 00                	push   $0x0
  pushl $51
801066e8:	6a 33                	push   $0x33
  jmp alltraps
801066ea:	e9 48 f9 ff ff       	jmp    80106037 <alltraps>

801066ef <vector52>:
.globl vector52
vector52:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $52
801066f1:	6a 34                	push   $0x34
  jmp alltraps
801066f3:	e9 3f f9 ff ff       	jmp    80106037 <alltraps>

801066f8 <vector53>:
.globl vector53
vector53:
  pushl $0
801066f8:	6a 00                	push   $0x0
  pushl $53
801066fa:	6a 35                	push   $0x35
  jmp alltraps
801066fc:	e9 36 f9 ff ff       	jmp    80106037 <alltraps>

80106701 <vector54>:
.globl vector54
vector54:
  pushl $0
80106701:	6a 00                	push   $0x0
  pushl $54
80106703:	6a 36                	push   $0x36
  jmp alltraps
80106705:	e9 2d f9 ff ff       	jmp    80106037 <alltraps>

8010670a <vector55>:
.globl vector55
vector55:
  pushl $0
8010670a:	6a 00                	push   $0x0
  pushl $55
8010670c:	6a 37                	push   $0x37
  jmp alltraps
8010670e:	e9 24 f9 ff ff       	jmp    80106037 <alltraps>

80106713 <vector56>:
.globl vector56
vector56:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $56
80106715:	6a 38                	push   $0x38
  jmp alltraps
80106717:	e9 1b f9 ff ff       	jmp    80106037 <alltraps>

8010671c <vector57>:
.globl vector57
vector57:
  pushl $0
8010671c:	6a 00                	push   $0x0
  pushl $57
8010671e:	6a 39                	push   $0x39
  jmp alltraps
80106720:	e9 12 f9 ff ff       	jmp    80106037 <alltraps>

80106725 <vector58>:
.globl vector58
vector58:
  pushl $0
80106725:	6a 00                	push   $0x0
  pushl $58
80106727:	6a 3a                	push   $0x3a
  jmp alltraps
80106729:	e9 09 f9 ff ff       	jmp    80106037 <alltraps>

8010672e <vector59>:
.globl vector59
vector59:
  pushl $0
8010672e:	6a 00                	push   $0x0
  pushl $59
80106730:	6a 3b                	push   $0x3b
  jmp alltraps
80106732:	e9 00 f9 ff ff       	jmp    80106037 <alltraps>

80106737 <vector60>:
.globl vector60
vector60:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $60
80106739:	6a 3c                	push   $0x3c
  jmp alltraps
8010673b:	e9 f7 f8 ff ff       	jmp    80106037 <alltraps>

80106740 <vector61>:
.globl vector61
vector61:
  pushl $0
80106740:	6a 00                	push   $0x0
  pushl $61
80106742:	6a 3d                	push   $0x3d
  jmp alltraps
80106744:	e9 ee f8 ff ff       	jmp    80106037 <alltraps>

80106749 <vector62>:
.globl vector62
vector62:
  pushl $0
80106749:	6a 00                	push   $0x0
  pushl $62
8010674b:	6a 3e                	push   $0x3e
  jmp alltraps
8010674d:	e9 e5 f8 ff ff       	jmp    80106037 <alltraps>

80106752 <vector63>:
.globl vector63
vector63:
  pushl $0
80106752:	6a 00                	push   $0x0
  pushl $63
80106754:	6a 3f                	push   $0x3f
  jmp alltraps
80106756:	e9 dc f8 ff ff       	jmp    80106037 <alltraps>

8010675b <vector64>:
.globl vector64
vector64:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $64
8010675d:	6a 40                	push   $0x40
  jmp alltraps
8010675f:	e9 d3 f8 ff ff       	jmp    80106037 <alltraps>

80106764 <vector65>:
.globl vector65
vector65:
  pushl $0
80106764:	6a 00                	push   $0x0
  pushl $65
80106766:	6a 41                	push   $0x41
  jmp alltraps
80106768:	e9 ca f8 ff ff       	jmp    80106037 <alltraps>

8010676d <vector66>:
.globl vector66
vector66:
  pushl $0
8010676d:	6a 00                	push   $0x0
  pushl $66
8010676f:	6a 42                	push   $0x42
  jmp alltraps
80106771:	e9 c1 f8 ff ff       	jmp    80106037 <alltraps>

80106776 <vector67>:
.globl vector67
vector67:
  pushl $0
80106776:	6a 00                	push   $0x0
  pushl $67
80106778:	6a 43                	push   $0x43
  jmp alltraps
8010677a:	e9 b8 f8 ff ff       	jmp    80106037 <alltraps>

8010677f <vector68>:
.globl vector68
vector68:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $68
80106781:	6a 44                	push   $0x44
  jmp alltraps
80106783:	e9 af f8 ff ff       	jmp    80106037 <alltraps>

80106788 <vector69>:
.globl vector69
vector69:
  pushl $0
80106788:	6a 00                	push   $0x0
  pushl $69
8010678a:	6a 45                	push   $0x45
  jmp alltraps
8010678c:	e9 a6 f8 ff ff       	jmp    80106037 <alltraps>

80106791 <vector70>:
.globl vector70
vector70:
  pushl $0
80106791:	6a 00                	push   $0x0
  pushl $70
80106793:	6a 46                	push   $0x46
  jmp alltraps
80106795:	e9 9d f8 ff ff       	jmp    80106037 <alltraps>

8010679a <vector71>:
.globl vector71
vector71:
  pushl $0
8010679a:	6a 00                	push   $0x0
  pushl $71
8010679c:	6a 47                	push   $0x47
  jmp alltraps
8010679e:	e9 94 f8 ff ff       	jmp    80106037 <alltraps>

801067a3 <vector72>:
.globl vector72
vector72:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $72
801067a5:	6a 48                	push   $0x48
  jmp alltraps
801067a7:	e9 8b f8 ff ff       	jmp    80106037 <alltraps>

801067ac <vector73>:
.globl vector73
vector73:
  pushl $0
801067ac:	6a 00                	push   $0x0
  pushl $73
801067ae:	6a 49                	push   $0x49
  jmp alltraps
801067b0:	e9 82 f8 ff ff       	jmp    80106037 <alltraps>

801067b5 <vector74>:
.globl vector74
vector74:
  pushl $0
801067b5:	6a 00                	push   $0x0
  pushl $74
801067b7:	6a 4a                	push   $0x4a
  jmp alltraps
801067b9:	e9 79 f8 ff ff       	jmp    80106037 <alltraps>

801067be <vector75>:
.globl vector75
vector75:
  pushl $0
801067be:	6a 00                	push   $0x0
  pushl $75
801067c0:	6a 4b                	push   $0x4b
  jmp alltraps
801067c2:	e9 70 f8 ff ff       	jmp    80106037 <alltraps>

801067c7 <vector76>:
.globl vector76
vector76:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $76
801067c9:	6a 4c                	push   $0x4c
  jmp alltraps
801067cb:	e9 67 f8 ff ff       	jmp    80106037 <alltraps>

801067d0 <vector77>:
.globl vector77
vector77:
  pushl $0
801067d0:	6a 00                	push   $0x0
  pushl $77
801067d2:	6a 4d                	push   $0x4d
  jmp alltraps
801067d4:	e9 5e f8 ff ff       	jmp    80106037 <alltraps>

801067d9 <vector78>:
.globl vector78
vector78:
  pushl $0
801067d9:	6a 00                	push   $0x0
  pushl $78
801067db:	6a 4e                	push   $0x4e
  jmp alltraps
801067dd:	e9 55 f8 ff ff       	jmp    80106037 <alltraps>

801067e2 <vector79>:
.globl vector79
vector79:
  pushl $0
801067e2:	6a 00                	push   $0x0
  pushl $79
801067e4:	6a 4f                	push   $0x4f
  jmp alltraps
801067e6:	e9 4c f8 ff ff       	jmp    80106037 <alltraps>

801067eb <vector80>:
.globl vector80
vector80:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $80
801067ed:	6a 50                	push   $0x50
  jmp alltraps
801067ef:	e9 43 f8 ff ff       	jmp    80106037 <alltraps>

801067f4 <vector81>:
.globl vector81
vector81:
  pushl $0
801067f4:	6a 00                	push   $0x0
  pushl $81
801067f6:	6a 51                	push   $0x51
  jmp alltraps
801067f8:	e9 3a f8 ff ff       	jmp    80106037 <alltraps>

801067fd <vector82>:
.globl vector82
vector82:
  pushl $0
801067fd:	6a 00                	push   $0x0
  pushl $82
801067ff:	6a 52                	push   $0x52
  jmp alltraps
80106801:	e9 31 f8 ff ff       	jmp    80106037 <alltraps>

80106806 <vector83>:
.globl vector83
vector83:
  pushl $0
80106806:	6a 00                	push   $0x0
  pushl $83
80106808:	6a 53                	push   $0x53
  jmp alltraps
8010680a:	e9 28 f8 ff ff       	jmp    80106037 <alltraps>

8010680f <vector84>:
.globl vector84
vector84:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $84
80106811:	6a 54                	push   $0x54
  jmp alltraps
80106813:	e9 1f f8 ff ff       	jmp    80106037 <alltraps>

80106818 <vector85>:
.globl vector85
vector85:
  pushl $0
80106818:	6a 00                	push   $0x0
  pushl $85
8010681a:	6a 55                	push   $0x55
  jmp alltraps
8010681c:	e9 16 f8 ff ff       	jmp    80106037 <alltraps>

80106821 <vector86>:
.globl vector86
vector86:
  pushl $0
80106821:	6a 00                	push   $0x0
  pushl $86
80106823:	6a 56                	push   $0x56
  jmp alltraps
80106825:	e9 0d f8 ff ff       	jmp    80106037 <alltraps>

8010682a <vector87>:
.globl vector87
vector87:
  pushl $0
8010682a:	6a 00                	push   $0x0
  pushl $87
8010682c:	6a 57                	push   $0x57
  jmp alltraps
8010682e:	e9 04 f8 ff ff       	jmp    80106037 <alltraps>

80106833 <vector88>:
.globl vector88
vector88:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $88
80106835:	6a 58                	push   $0x58
  jmp alltraps
80106837:	e9 fb f7 ff ff       	jmp    80106037 <alltraps>

8010683c <vector89>:
.globl vector89
vector89:
  pushl $0
8010683c:	6a 00                	push   $0x0
  pushl $89
8010683e:	6a 59                	push   $0x59
  jmp alltraps
80106840:	e9 f2 f7 ff ff       	jmp    80106037 <alltraps>

80106845 <vector90>:
.globl vector90
vector90:
  pushl $0
80106845:	6a 00                	push   $0x0
  pushl $90
80106847:	6a 5a                	push   $0x5a
  jmp alltraps
80106849:	e9 e9 f7 ff ff       	jmp    80106037 <alltraps>

8010684e <vector91>:
.globl vector91
vector91:
  pushl $0
8010684e:	6a 00                	push   $0x0
  pushl $91
80106850:	6a 5b                	push   $0x5b
  jmp alltraps
80106852:	e9 e0 f7 ff ff       	jmp    80106037 <alltraps>

80106857 <vector92>:
.globl vector92
vector92:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $92
80106859:	6a 5c                	push   $0x5c
  jmp alltraps
8010685b:	e9 d7 f7 ff ff       	jmp    80106037 <alltraps>

80106860 <vector93>:
.globl vector93
vector93:
  pushl $0
80106860:	6a 00                	push   $0x0
  pushl $93
80106862:	6a 5d                	push   $0x5d
  jmp alltraps
80106864:	e9 ce f7 ff ff       	jmp    80106037 <alltraps>

80106869 <vector94>:
.globl vector94
vector94:
  pushl $0
80106869:	6a 00                	push   $0x0
  pushl $94
8010686b:	6a 5e                	push   $0x5e
  jmp alltraps
8010686d:	e9 c5 f7 ff ff       	jmp    80106037 <alltraps>

80106872 <vector95>:
.globl vector95
vector95:
  pushl $0
80106872:	6a 00                	push   $0x0
  pushl $95
80106874:	6a 5f                	push   $0x5f
  jmp alltraps
80106876:	e9 bc f7 ff ff       	jmp    80106037 <alltraps>

8010687b <vector96>:
.globl vector96
vector96:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $96
8010687d:	6a 60                	push   $0x60
  jmp alltraps
8010687f:	e9 b3 f7 ff ff       	jmp    80106037 <alltraps>

80106884 <vector97>:
.globl vector97
vector97:
  pushl $0
80106884:	6a 00                	push   $0x0
  pushl $97
80106886:	6a 61                	push   $0x61
  jmp alltraps
80106888:	e9 aa f7 ff ff       	jmp    80106037 <alltraps>

8010688d <vector98>:
.globl vector98
vector98:
  pushl $0
8010688d:	6a 00                	push   $0x0
  pushl $98
8010688f:	6a 62                	push   $0x62
  jmp alltraps
80106891:	e9 a1 f7 ff ff       	jmp    80106037 <alltraps>

80106896 <vector99>:
.globl vector99
vector99:
  pushl $0
80106896:	6a 00                	push   $0x0
  pushl $99
80106898:	6a 63                	push   $0x63
  jmp alltraps
8010689a:	e9 98 f7 ff ff       	jmp    80106037 <alltraps>

8010689f <vector100>:
.globl vector100
vector100:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $100
801068a1:	6a 64                	push   $0x64
  jmp alltraps
801068a3:	e9 8f f7 ff ff       	jmp    80106037 <alltraps>

801068a8 <vector101>:
.globl vector101
vector101:
  pushl $0
801068a8:	6a 00                	push   $0x0
  pushl $101
801068aa:	6a 65                	push   $0x65
  jmp alltraps
801068ac:	e9 86 f7 ff ff       	jmp    80106037 <alltraps>

801068b1 <vector102>:
.globl vector102
vector102:
  pushl $0
801068b1:	6a 00                	push   $0x0
  pushl $102
801068b3:	6a 66                	push   $0x66
  jmp alltraps
801068b5:	e9 7d f7 ff ff       	jmp    80106037 <alltraps>

801068ba <vector103>:
.globl vector103
vector103:
  pushl $0
801068ba:	6a 00                	push   $0x0
  pushl $103
801068bc:	6a 67                	push   $0x67
  jmp alltraps
801068be:	e9 74 f7 ff ff       	jmp    80106037 <alltraps>

801068c3 <vector104>:
.globl vector104
vector104:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $104
801068c5:	6a 68                	push   $0x68
  jmp alltraps
801068c7:	e9 6b f7 ff ff       	jmp    80106037 <alltraps>

801068cc <vector105>:
.globl vector105
vector105:
  pushl $0
801068cc:	6a 00                	push   $0x0
  pushl $105
801068ce:	6a 69                	push   $0x69
  jmp alltraps
801068d0:	e9 62 f7 ff ff       	jmp    80106037 <alltraps>

801068d5 <vector106>:
.globl vector106
vector106:
  pushl $0
801068d5:	6a 00                	push   $0x0
  pushl $106
801068d7:	6a 6a                	push   $0x6a
  jmp alltraps
801068d9:	e9 59 f7 ff ff       	jmp    80106037 <alltraps>

801068de <vector107>:
.globl vector107
vector107:
  pushl $0
801068de:	6a 00                	push   $0x0
  pushl $107
801068e0:	6a 6b                	push   $0x6b
  jmp alltraps
801068e2:	e9 50 f7 ff ff       	jmp    80106037 <alltraps>

801068e7 <vector108>:
.globl vector108
vector108:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $108
801068e9:	6a 6c                	push   $0x6c
  jmp alltraps
801068eb:	e9 47 f7 ff ff       	jmp    80106037 <alltraps>

801068f0 <vector109>:
.globl vector109
vector109:
  pushl $0
801068f0:	6a 00                	push   $0x0
  pushl $109
801068f2:	6a 6d                	push   $0x6d
  jmp alltraps
801068f4:	e9 3e f7 ff ff       	jmp    80106037 <alltraps>

801068f9 <vector110>:
.globl vector110
vector110:
  pushl $0
801068f9:	6a 00                	push   $0x0
  pushl $110
801068fb:	6a 6e                	push   $0x6e
  jmp alltraps
801068fd:	e9 35 f7 ff ff       	jmp    80106037 <alltraps>

80106902 <vector111>:
.globl vector111
vector111:
  pushl $0
80106902:	6a 00                	push   $0x0
  pushl $111
80106904:	6a 6f                	push   $0x6f
  jmp alltraps
80106906:	e9 2c f7 ff ff       	jmp    80106037 <alltraps>

8010690b <vector112>:
.globl vector112
vector112:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $112
8010690d:	6a 70                	push   $0x70
  jmp alltraps
8010690f:	e9 23 f7 ff ff       	jmp    80106037 <alltraps>

80106914 <vector113>:
.globl vector113
vector113:
  pushl $0
80106914:	6a 00                	push   $0x0
  pushl $113
80106916:	6a 71                	push   $0x71
  jmp alltraps
80106918:	e9 1a f7 ff ff       	jmp    80106037 <alltraps>

8010691d <vector114>:
.globl vector114
vector114:
  pushl $0
8010691d:	6a 00                	push   $0x0
  pushl $114
8010691f:	6a 72                	push   $0x72
  jmp alltraps
80106921:	e9 11 f7 ff ff       	jmp    80106037 <alltraps>

80106926 <vector115>:
.globl vector115
vector115:
  pushl $0
80106926:	6a 00                	push   $0x0
  pushl $115
80106928:	6a 73                	push   $0x73
  jmp alltraps
8010692a:	e9 08 f7 ff ff       	jmp    80106037 <alltraps>

8010692f <vector116>:
.globl vector116
vector116:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $116
80106931:	6a 74                	push   $0x74
  jmp alltraps
80106933:	e9 ff f6 ff ff       	jmp    80106037 <alltraps>

80106938 <vector117>:
.globl vector117
vector117:
  pushl $0
80106938:	6a 00                	push   $0x0
  pushl $117
8010693a:	6a 75                	push   $0x75
  jmp alltraps
8010693c:	e9 f6 f6 ff ff       	jmp    80106037 <alltraps>

80106941 <vector118>:
.globl vector118
vector118:
  pushl $0
80106941:	6a 00                	push   $0x0
  pushl $118
80106943:	6a 76                	push   $0x76
  jmp alltraps
80106945:	e9 ed f6 ff ff       	jmp    80106037 <alltraps>

8010694a <vector119>:
.globl vector119
vector119:
  pushl $0
8010694a:	6a 00                	push   $0x0
  pushl $119
8010694c:	6a 77                	push   $0x77
  jmp alltraps
8010694e:	e9 e4 f6 ff ff       	jmp    80106037 <alltraps>

80106953 <vector120>:
.globl vector120
vector120:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $120
80106955:	6a 78                	push   $0x78
  jmp alltraps
80106957:	e9 db f6 ff ff       	jmp    80106037 <alltraps>

8010695c <vector121>:
.globl vector121
vector121:
  pushl $0
8010695c:	6a 00                	push   $0x0
  pushl $121
8010695e:	6a 79                	push   $0x79
  jmp alltraps
80106960:	e9 d2 f6 ff ff       	jmp    80106037 <alltraps>

80106965 <vector122>:
.globl vector122
vector122:
  pushl $0
80106965:	6a 00                	push   $0x0
  pushl $122
80106967:	6a 7a                	push   $0x7a
  jmp alltraps
80106969:	e9 c9 f6 ff ff       	jmp    80106037 <alltraps>

8010696e <vector123>:
.globl vector123
vector123:
  pushl $0
8010696e:	6a 00                	push   $0x0
  pushl $123
80106970:	6a 7b                	push   $0x7b
  jmp alltraps
80106972:	e9 c0 f6 ff ff       	jmp    80106037 <alltraps>

80106977 <vector124>:
.globl vector124
vector124:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $124
80106979:	6a 7c                	push   $0x7c
  jmp alltraps
8010697b:	e9 b7 f6 ff ff       	jmp    80106037 <alltraps>

80106980 <vector125>:
.globl vector125
vector125:
  pushl $0
80106980:	6a 00                	push   $0x0
  pushl $125
80106982:	6a 7d                	push   $0x7d
  jmp alltraps
80106984:	e9 ae f6 ff ff       	jmp    80106037 <alltraps>

80106989 <vector126>:
.globl vector126
vector126:
  pushl $0
80106989:	6a 00                	push   $0x0
  pushl $126
8010698b:	6a 7e                	push   $0x7e
  jmp alltraps
8010698d:	e9 a5 f6 ff ff       	jmp    80106037 <alltraps>

80106992 <vector127>:
.globl vector127
vector127:
  pushl $0
80106992:	6a 00                	push   $0x0
  pushl $127
80106994:	6a 7f                	push   $0x7f
  jmp alltraps
80106996:	e9 9c f6 ff ff       	jmp    80106037 <alltraps>

8010699b <vector128>:
.globl vector128
vector128:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $128
8010699d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801069a2:	e9 90 f6 ff ff       	jmp    80106037 <alltraps>

801069a7 <vector129>:
.globl vector129
vector129:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $129
801069a9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801069ae:	e9 84 f6 ff ff       	jmp    80106037 <alltraps>

801069b3 <vector130>:
.globl vector130
vector130:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $130
801069b5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801069ba:	e9 78 f6 ff ff       	jmp    80106037 <alltraps>

801069bf <vector131>:
.globl vector131
vector131:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $131
801069c1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801069c6:	e9 6c f6 ff ff       	jmp    80106037 <alltraps>

801069cb <vector132>:
.globl vector132
vector132:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $132
801069cd:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801069d2:	e9 60 f6 ff ff       	jmp    80106037 <alltraps>

801069d7 <vector133>:
.globl vector133
vector133:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $133
801069d9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801069de:	e9 54 f6 ff ff       	jmp    80106037 <alltraps>

801069e3 <vector134>:
.globl vector134
vector134:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $134
801069e5:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801069ea:	e9 48 f6 ff ff       	jmp    80106037 <alltraps>

801069ef <vector135>:
.globl vector135
vector135:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $135
801069f1:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801069f6:	e9 3c f6 ff ff       	jmp    80106037 <alltraps>

801069fb <vector136>:
.globl vector136
vector136:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $136
801069fd:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106a02:	e9 30 f6 ff ff       	jmp    80106037 <alltraps>

80106a07 <vector137>:
.globl vector137
vector137:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $137
80106a09:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106a0e:	e9 24 f6 ff ff       	jmp    80106037 <alltraps>

80106a13 <vector138>:
.globl vector138
vector138:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $138
80106a15:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106a1a:	e9 18 f6 ff ff       	jmp    80106037 <alltraps>

80106a1f <vector139>:
.globl vector139
vector139:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $139
80106a21:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106a26:	e9 0c f6 ff ff       	jmp    80106037 <alltraps>

80106a2b <vector140>:
.globl vector140
vector140:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $140
80106a2d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106a32:	e9 00 f6 ff ff       	jmp    80106037 <alltraps>

80106a37 <vector141>:
.globl vector141
vector141:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $141
80106a39:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106a3e:	e9 f4 f5 ff ff       	jmp    80106037 <alltraps>

80106a43 <vector142>:
.globl vector142
vector142:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $142
80106a45:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106a4a:	e9 e8 f5 ff ff       	jmp    80106037 <alltraps>

80106a4f <vector143>:
.globl vector143
vector143:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $143
80106a51:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106a56:	e9 dc f5 ff ff       	jmp    80106037 <alltraps>

80106a5b <vector144>:
.globl vector144
vector144:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $144
80106a5d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106a62:	e9 d0 f5 ff ff       	jmp    80106037 <alltraps>

80106a67 <vector145>:
.globl vector145
vector145:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $145
80106a69:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106a6e:	e9 c4 f5 ff ff       	jmp    80106037 <alltraps>

80106a73 <vector146>:
.globl vector146
vector146:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $146
80106a75:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a7a:	e9 b8 f5 ff ff       	jmp    80106037 <alltraps>

80106a7f <vector147>:
.globl vector147
vector147:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $147
80106a81:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106a86:	e9 ac f5 ff ff       	jmp    80106037 <alltraps>

80106a8b <vector148>:
.globl vector148
vector148:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $148
80106a8d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106a92:	e9 a0 f5 ff ff       	jmp    80106037 <alltraps>

80106a97 <vector149>:
.globl vector149
vector149:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $149
80106a99:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106a9e:	e9 94 f5 ff ff       	jmp    80106037 <alltraps>

80106aa3 <vector150>:
.globl vector150
vector150:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $150
80106aa5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106aaa:	e9 88 f5 ff ff       	jmp    80106037 <alltraps>

80106aaf <vector151>:
.globl vector151
vector151:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $151
80106ab1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106ab6:	e9 7c f5 ff ff       	jmp    80106037 <alltraps>

80106abb <vector152>:
.globl vector152
vector152:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $152
80106abd:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106ac2:	e9 70 f5 ff ff       	jmp    80106037 <alltraps>

80106ac7 <vector153>:
.globl vector153
vector153:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $153
80106ac9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106ace:	e9 64 f5 ff ff       	jmp    80106037 <alltraps>

80106ad3 <vector154>:
.globl vector154
vector154:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $154
80106ad5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106ada:	e9 58 f5 ff ff       	jmp    80106037 <alltraps>

80106adf <vector155>:
.globl vector155
vector155:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $155
80106ae1:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106ae6:	e9 4c f5 ff ff       	jmp    80106037 <alltraps>

80106aeb <vector156>:
.globl vector156
vector156:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $156
80106aed:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106af2:	e9 40 f5 ff ff       	jmp    80106037 <alltraps>

80106af7 <vector157>:
.globl vector157
vector157:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $157
80106af9:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106afe:	e9 34 f5 ff ff       	jmp    80106037 <alltraps>

80106b03 <vector158>:
.globl vector158
vector158:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $158
80106b05:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106b0a:	e9 28 f5 ff ff       	jmp    80106037 <alltraps>

80106b0f <vector159>:
.globl vector159
vector159:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $159
80106b11:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106b16:	e9 1c f5 ff ff       	jmp    80106037 <alltraps>

80106b1b <vector160>:
.globl vector160
vector160:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $160
80106b1d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106b22:	e9 10 f5 ff ff       	jmp    80106037 <alltraps>

80106b27 <vector161>:
.globl vector161
vector161:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $161
80106b29:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106b2e:	e9 04 f5 ff ff       	jmp    80106037 <alltraps>

80106b33 <vector162>:
.globl vector162
vector162:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $162
80106b35:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106b3a:	e9 f8 f4 ff ff       	jmp    80106037 <alltraps>

80106b3f <vector163>:
.globl vector163
vector163:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $163
80106b41:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106b46:	e9 ec f4 ff ff       	jmp    80106037 <alltraps>

80106b4b <vector164>:
.globl vector164
vector164:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $164
80106b4d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106b52:	e9 e0 f4 ff ff       	jmp    80106037 <alltraps>

80106b57 <vector165>:
.globl vector165
vector165:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $165
80106b59:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106b5e:	e9 d4 f4 ff ff       	jmp    80106037 <alltraps>

80106b63 <vector166>:
.globl vector166
vector166:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $166
80106b65:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106b6a:	e9 c8 f4 ff ff       	jmp    80106037 <alltraps>

80106b6f <vector167>:
.globl vector167
vector167:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $167
80106b71:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b76:	e9 bc f4 ff ff       	jmp    80106037 <alltraps>

80106b7b <vector168>:
.globl vector168
vector168:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $168
80106b7d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106b82:	e9 b0 f4 ff ff       	jmp    80106037 <alltraps>

80106b87 <vector169>:
.globl vector169
vector169:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $169
80106b89:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106b8e:	e9 a4 f4 ff ff       	jmp    80106037 <alltraps>

80106b93 <vector170>:
.globl vector170
vector170:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $170
80106b95:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106b9a:	e9 98 f4 ff ff       	jmp    80106037 <alltraps>

80106b9f <vector171>:
.globl vector171
vector171:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $171
80106ba1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106ba6:	e9 8c f4 ff ff       	jmp    80106037 <alltraps>

80106bab <vector172>:
.globl vector172
vector172:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $172
80106bad:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106bb2:	e9 80 f4 ff ff       	jmp    80106037 <alltraps>

80106bb7 <vector173>:
.globl vector173
vector173:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $173
80106bb9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106bbe:	e9 74 f4 ff ff       	jmp    80106037 <alltraps>

80106bc3 <vector174>:
.globl vector174
vector174:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $174
80106bc5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106bca:	e9 68 f4 ff ff       	jmp    80106037 <alltraps>

80106bcf <vector175>:
.globl vector175
vector175:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $175
80106bd1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106bd6:	e9 5c f4 ff ff       	jmp    80106037 <alltraps>

80106bdb <vector176>:
.globl vector176
vector176:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $176
80106bdd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106be2:	e9 50 f4 ff ff       	jmp    80106037 <alltraps>

80106be7 <vector177>:
.globl vector177
vector177:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $177
80106be9:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106bee:	e9 44 f4 ff ff       	jmp    80106037 <alltraps>

80106bf3 <vector178>:
.globl vector178
vector178:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $178
80106bf5:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106bfa:	e9 38 f4 ff ff       	jmp    80106037 <alltraps>

80106bff <vector179>:
.globl vector179
vector179:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $179
80106c01:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106c06:	e9 2c f4 ff ff       	jmp    80106037 <alltraps>

80106c0b <vector180>:
.globl vector180
vector180:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $180
80106c0d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106c12:	e9 20 f4 ff ff       	jmp    80106037 <alltraps>

80106c17 <vector181>:
.globl vector181
vector181:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $181
80106c19:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106c1e:	e9 14 f4 ff ff       	jmp    80106037 <alltraps>

80106c23 <vector182>:
.globl vector182
vector182:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $182
80106c25:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106c2a:	e9 08 f4 ff ff       	jmp    80106037 <alltraps>

80106c2f <vector183>:
.globl vector183
vector183:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $183
80106c31:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106c36:	e9 fc f3 ff ff       	jmp    80106037 <alltraps>

80106c3b <vector184>:
.globl vector184
vector184:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $184
80106c3d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106c42:	e9 f0 f3 ff ff       	jmp    80106037 <alltraps>

80106c47 <vector185>:
.globl vector185
vector185:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $185
80106c49:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106c4e:	e9 e4 f3 ff ff       	jmp    80106037 <alltraps>

80106c53 <vector186>:
.globl vector186
vector186:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $186
80106c55:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106c5a:	e9 d8 f3 ff ff       	jmp    80106037 <alltraps>

80106c5f <vector187>:
.globl vector187
vector187:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $187
80106c61:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106c66:	e9 cc f3 ff ff       	jmp    80106037 <alltraps>

80106c6b <vector188>:
.globl vector188
vector188:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $188
80106c6d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106c72:	e9 c0 f3 ff ff       	jmp    80106037 <alltraps>

80106c77 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $189
80106c79:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c7e:	e9 b4 f3 ff ff       	jmp    80106037 <alltraps>

80106c83 <vector190>:
.globl vector190
vector190:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $190
80106c85:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106c8a:	e9 a8 f3 ff ff       	jmp    80106037 <alltraps>

80106c8f <vector191>:
.globl vector191
vector191:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $191
80106c91:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106c96:	e9 9c f3 ff ff       	jmp    80106037 <alltraps>

80106c9b <vector192>:
.globl vector192
vector192:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $192
80106c9d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106ca2:	e9 90 f3 ff ff       	jmp    80106037 <alltraps>

80106ca7 <vector193>:
.globl vector193
vector193:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $193
80106ca9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106cae:	e9 84 f3 ff ff       	jmp    80106037 <alltraps>

80106cb3 <vector194>:
.globl vector194
vector194:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $194
80106cb5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106cba:	e9 78 f3 ff ff       	jmp    80106037 <alltraps>

80106cbf <vector195>:
.globl vector195
vector195:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $195
80106cc1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106cc6:	e9 6c f3 ff ff       	jmp    80106037 <alltraps>

80106ccb <vector196>:
.globl vector196
vector196:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $196
80106ccd:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106cd2:	e9 60 f3 ff ff       	jmp    80106037 <alltraps>

80106cd7 <vector197>:
.globl vector197
vector197:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $197
80106cd9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106cde:	e9 54 f3 ff ff       	jmp    80106037 <alltraps>

80106ce3 <vector198>:
.globl vector198
vector198:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $198
80106ce5:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106cea:	e9 48 f3 ff ff       	jmp    80106037 <alltraps>

80106cef <vector199>:
.globl vector199
vector199:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $199
80106cf1:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106cf6:	e9 3c f3 ff ff       	jmp    80106037 <alltraps>

80106cfb <vector200>:
.globl vector200
vector200:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $200
80106cfd:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106d02:	e9 30 f3 ff ff       	jmp    80106037 <alltraps>

80106d07 <vector201>:
.globl vector201
vector201:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $201
80106d09:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106d0e:	e9 24 f3 ff ff       	jmp    80106037 <alltraps>

80106d13 <vector202>:
.globl vector202
vector202:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $202
80106d15:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106d1a:	e9 18 f3 ff ff       	jmp    80106037 <alltraps>

80106d1f <vector203>:
.globl vector203
vector203:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $203
80106d21:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106d26:	e9 0c f3 ff ff       	jmp    80106037 <alltraps>

80106d2b <vector204>:
.globl vector204
vector204:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $204
80106d2d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106d32:	e9 00 f3 ff ff       	jmp    80106037 <alltraps>

80106d37 <vector205>:
.globl vector205
vector205:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $205
80106d39:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106d3e:	e9 f4 f2 ff ff       	jmp    80106037 <alltraps>

80106d43 <vector206>:
.globl vector206
vector206:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $206
80106d45:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106d4a:	e9 e8 f2 ff ff       	jmp    80106037 <alltraps>

80106d4f <vector207>:
.globl vector207
vector207:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $207
80106d51:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106d56:	e9 dc f2 ff ff       	jmp    80106037 <alltraps>

80106d5b <vector208>:
.globl vector208
vector208:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $208
80106d5d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106d62:	e9 d0 f2 ff ff       	jmp    80106037 <alltraps>

80106d67 <vector209>:
.globl vector209
vector209:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $209
80106d69:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106d6e:	e9 c4 f2 ff ff       	jmp    80106037 <alltraps>

80106d73 <vector210>:
.globl vector210
vector210:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $210
80106d75:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d7a:	e9 b8 f2 ff ff       	jmp    80106037 <alltraps>

80106d7f <vector211>:
.globl vector211
vector211:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $211
80106d81:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106d86:	e9 ac f2 ff ff       	jmp    80106037 <alltraps>

80106d8b <vector212>:
.globl vector212
vector212:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $212
80106d8d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106d92:	e9 a0 f2 ff ff       	jmp    80106037 <alltraps>

80106d97 <vector213>:
.globl vector213
vector213:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $213
80106d99:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106d9e:	e9 94 f2 ff ff       	jmp    80106037 <alltraps>

80106da3 <vector214>:
.globl vector214
vector214:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $214
80106da5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106daa:	e9 88 f2 ff ff       	jmp    80106037 <alltraps>

80106daf <vector215>:
.globl vector215
vector215:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $215
80106db1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106db6:	e9 7c f2 ff ff       	jmp    80106037 <alltraps>

80106dbb <vector216>:
.globl vector216
vector216:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $216
80106dbd:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106dc2:	e9 70 f2 ff ff       	jmp    80106037 <alltraps>

80106dc7 <vector217>:
.globl vector217
vector217:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $217
80106dc9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106dce:	e9 64 f2 ff ff       	jmp    80106037 <alltraps>

80106dd3 <vector218>:
.globl vector218
vector218:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $218
80106dd5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106dda:	e9 58 f2 ff ff       	jmp    80106037 <alltraps>

80106ddf <vector219>:
.globl vector219
vector219:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $219
80106de1:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106de6:	e9 4c f2 ff ff       	jmp    80106037 <alltraps>

80106deb <vector220>:
.globl vector220
vector220:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $220
80106ded:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106df2:	e9 40 f2 ff ff       	jmp    80106037 <alltraps>

80106df7 <vector221>:
.globl vector221
vector221:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $221
80106df9:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106dfe:	e9 34 f2 ff ff       	jmp    80106037 <alltraps>

80106e03 <vector222>:
.globl vector222
vector222:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $222
80106e05:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106e0a:	e9 28 f2 ff ff       	jmp    80106037 <alltraps>

80106e0f <vector223>:
.globl vector223
vector223:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $223
80106e11:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106e16:	e9 1c f2 ff ff       	jmp    80106037 <alltraps>

80106e1b <vector224>:
.globl vector224
vector224:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $224
80106e1d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106e22:	e9 10 f2 ff ff       	jmp    80106037 <alltraps>

80106e27 <vector225>:
.globl vector225
vector225:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $225
80106e29:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106e2e:	e9 04 f2 ff ff       	jmp    80106037 <alltraps>

80106e33 <vector226>:
.globl vector226
vector226:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $226
80106e35:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106e3a:	e9 f8 f1 ff ff       	jmp    80106037 <alltraps>

80106e3f <vector227>:
.globl vector227
vector227:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $227
80106e41:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106e46:	e9 ec f1 ff ff       	jmp    80106037 <alltraps>

80106e4b <vector228>:
.globl vector228
vector228:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $228
80106e4d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106e52:	e9 e0 f1 ff ff       	jmp    80106037 <alltraps>

80106e57 <vector229>:
.globl vector229
vector229:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $229
80106e59:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106e5e:	e9 d4 f1 ff ff       	jmp    80106037 <alltraps>

80106e63 <vector230>:
.globl vector230
vector230:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $230
80106e65:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106e6a:	e9 c8 f1 ff ff       	jmp    80106037 <alltraps>

80106e6f <vector231>:
.globl vector231
vector231:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $231
80106e71:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e76:	e9 bc f1 ff ff       	jmp    80106037 <alltraps>

80106e7b <vector232>:
.globl vector232
vector232:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $232
80106e7d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106e82:	e9 b0 f1 ff ff       	jmp    80106037 <alltraps>

80106e87 <vector233>:
.globl vector233
vector233:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $233
80106e89:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106e8e:	e9 a4 f1 ff ff       	jmp    80106037 <alltraps>

80106e93 <vector234>:
.globl vector234
vector234:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $234
80106e95:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106e9a:	e9 98 f1 ff ff       	jmp    80106037 <alltraps>

80106e9f <vector235>:
.globl vector235
vector235:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $235
80106ea1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ea6:	e9 8c f1 ff ff       	jmp    80106037 <alltraps>

80106eab <vector236>:
.globl vector236
vector236:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $236
80106ead:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106eb2:	e9 80 f1 ff ff       	jmp    80106037 <alltraps>

80106eb7 <vector237>:
.globl vector237
vector237:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $237
80106eb9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106ebe:	e9 74 f1 ff ff       	jmp    80106037 <alltraps>

80106ec3 <vector238>:
.globl vector238
vector238:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $238
80106ec5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106eca:	e9 68 f1 ff ff       	jmp    80106037 <alltraps>

80106ecf <vector239>:
.globl vector239
vector239:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $239
80106ed1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106ed6:	e9 5c f1 ff ff       	jmp    80106037 <alltraps>

80106edb <vector240>:
.globl vector240
vector240:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $240
80106edd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106ee2:	e9 50 f1 ff ff       	jmp    80106037 <alltraps>

80106ee7 <vector241>:
.globl vector241
vector241:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $241
80106ee9:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106eee:	e9 44 f1 ff ff       	jmp    80106037 <alltraps>

80106ef3 <vector242>:
.globl vector242
vector242:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $242
80106ef5:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106efa:	e9 38 f1 ff ff       	jmp    80106037 <alltraps>

80106eff <vector243>:
.globl vector243
vector243:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $243
80106f01:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106f06:	e9 2c f1 ff ff       	jmp    80106037 <alltraps>

80106f0b <vector244>:
.globl vector244
vector244:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $244
80106f0d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106f12:	e9 20 f1 ff ff       	jmp    80106037 <alltraps>

80106f17 <vector245>:
.globl vector245
vector245:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $245
80106f19:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106f1e:	e9 14 f1 ff ff       	jmp    80106037 <alltraps>

80106f23 <vector246>:
.globl vector246
vector246:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $246
80106f25:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106f2a:	e9 08 f1 ff ff       	jmp    80106037 <alltraps>

80106f2f <vector247>:
.globl vector247
vector247:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $247
80106f31:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106f36:	e9 fc f0 ff ff       	jmp    80106037 <alltraps>

80106f3b <vector248>:
.globl vector248
vector248:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $248
80106f3d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106f42:	e9 f0 f0 ff ff       	jmp    80106037 <alltraps>

80106f47 <vector249>:
.globl vector249
vector249:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $249
80106f49:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106f4e:	e9 e4 f0 ff ff       	jmp    80106037 <alltraps>

80106f53 <vector250>:
.globl vector250
vector250:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $250
80106f55:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106f5a:	e9 d8 f0 ff ff       	jmp    80106037 <alltraps>

80106f5f <vector251>:
.globl vector251
vector251:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $251
80106f61:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106f66:	e9 cc f0 ff ff       	jmp    80106037 <alltraps>

80106f6b <vector252>:
.globl vector252
vector252:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $252
80106f6d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106f72:	e9 c0 f0 ff ff       	jmp    80106037 <alltraps>

80106f77 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $253
80106f79:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f7e:	e9 b4 f0 ff ff       	jmp    80106037 <alltraps>

80106f83 <vector254>:
.globl vector254
vector254:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $254
80106f85:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106f8a:	e9 a8 f0 ff ff       	jmp    80106037 <alltraps>

80106f8f <vector255>:
.globl vector255
vector255:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $255
80106f91:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106f96:	e9 9c f0 ff ff       	jmp    80106037 <alltraps>
80106f9b:	66 90                	xchg   %ax,%ax
80106f9d:	66 90                	xchg   %ax,%ax
80106f9f:	90                   	nop

80106fa0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	57                   	push   %edi
80106fa4:	56                   	push   %esi
80106fa5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106fa7:	c1 ea 16             	shr    $0x16,%edx
{
80106faa:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106fab:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106fae:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106fb1:	8b 1f                	mov    (%edi),%ebx
80106fb3:	f6 c3 01             	test   $0x1,%bl
80106fb6:	74 28                	je     80106fe0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fb8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fbe:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106fc4:	89 f0                	mov    %esi,%eax
}
80106fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106fc9:	c1 e8 0a             	shr    $0xa,%eax
80106fcc:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fd1:	01 d8                	add    %ebx,%eax
}
80106fd3:	5b                   	pop    %ebx
80106fd4:	5e                   	pop    %esi
80106fd5:	5f                   	pop    %edi
80106fd6:	5d                   	pop    %ebp
80106fd7:	c3                   	ret    
80106fd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fdf:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106fe0:	85 c9                	test   %ecx,%ecx
80106fe2:	74 2c                	je     80107010 <walkpgdir+0x70>
80106fe4:	e8 67 b6 ff ff       	call   80102650 <kalloc>
80106fe9:	89 c3                	mov    %eax,%ebx
80106feb:	85 c0                	test   %eax,%eax
80106fed:	74 21                	je     80107010 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106fef:	83 ec 04             	sub    $0x4,%esp
80106ff2:	68 00 10 00 00       	push   $0x1000
80106ff7:	6a 00                	push   $0x0
80106ff9:	50                   	push   %eax
80106ffa:	e8 f1 dc ff ff       	call   80104cf0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106fff:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107005:	83 c4 10             	add    $0x10,%esp
80107008:	83 c8 07             	or     $0x7,%eax
8010700b:	89 07                	mov    %eax,(%edi)
8010700d:	eb b5                	jmp    80106fc4 <walkpgdir+0x24>
8010700f:	90                   	nop
}
80107010:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107013:	31 c0                	xor    %eax,%eax
}
80107015:	5b                   	pop    %ebx
80107016:	5e                   	pop    %esi
80107017:	5f                   	pop    %edi
80107018:	5d                   	pop    %ebp
80107019:	c3                   	ret    
8010701a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107020 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107026:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010702a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010702b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107030:	89 d6                	mov    %edx,%esi
{
80107032:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107033:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107039:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010703c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010703f:	8b 45 08             	mov    0x8(%ebp),%eax
80107042:	29 f0                	sub    %esi,%eax
80107044:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107047:	eb 1f                	jmp    80107068 <mappages+0x48>
80107049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107050:	f6 00 01             	testb  $0x1,(%eax)
80107053:	75 45                	jne    8010709a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107055:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107058:	83 cb 01             	or     $0x1,%ebx
8010705b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010705d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107060:	74 2e                	je     80107090 <mappages+0x70>
      break;
    a += PGSIZE;
80107062:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107068:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010706b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107070:	89 f2                	mov    %esi,%edx
80107072:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107075:	89 f8                	mov    %edi,%eax
80107077:	e8 24 ff ff ff       	call   80106fa0 <walkpgdir>
8010707c:	85 c0                	test   %eax,%eax
8010707e:	75 d0                	jne    80107050 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107080:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107083:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107088:	5b                   	pop    %ebx
80107089:	5e                   	pop    %esi
8010708a:	5f                   	pop    %edi
8010708b:	5d                   	pop    %ebp
8010708c:	c3                   	ret    
8010708d:	8d 76 00             	lea    0x0(%esi),%esi
80107090:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107093:	31 c0                	xor    %eax,%eax
}
80107095:	5b                   	pop    %ebx
80107096:	5e                   	pop    %esi
80107097:	5f                   	pop    %edi
80107098:	5d                   	pop    %ebp
80107099:	c3                   	ret    
      panic("remap");
8010709a:	83 ec 0c             	sub    $0xc,%esp
8010709d:	68 c8 81 10 80       	push   $0x801081c8
801070a2:	e8 e9 92 ff ff       	call   80100390 <panic>
801070a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ae:	66 90                	xchg   %ax,%ax

801070b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	89 c6                	mov    %eax,%esi
801070b7:	53                   	push   %ebx
801070b8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801070ba:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801070c0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801070c6:	83 ec 1c             	sub    $0x1c,%esp
801070c9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801070cc:	39 da                	cmp    %ebx,%edx
801070ce:	73 5b                	jae    8010712b <deallocuvm.part.0+0x7b>
801070d0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801070d3:	89 d7                	mov    %edx,%edi
801070d5:	eb 14                	jmp    801070eb <deallocuvm.part.0+0x3b>
801070d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070de:	66 90                	xchg   %ax,%ax
801070e0:	81 c7 00 10 00 00    	add    $0x1000,%edi
801070e6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801070e9:	76 40                	jbe    8010712b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
801070eb:	31 c9                	xor    %ecx,%ecx
801070ed:	89 fa                	mov    %edi,%edx
801070ef:	89 f0                	mov    %esi,%eax
801070f1:	e8 aa fe ff ff       	call   80106fa0 <walkpgdir>
801070f6:	89 c3                	mov    %eax,%ebx
    if(!pte)
801070f8:	85 c0                	test   %eax,%eax
801070fa:	74 44                	je     80107140 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801070fc:	8b 00                	mov    (%eax),%eax
801070fe:	a8 01                	test   $0x1,%al
80107100:	74 de                	je     801070e0 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107102:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107107:	74 47                	je     80107150 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107109:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010710c:	05 00 00 00 80       	add    $0x80000000,%eax
80107111:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107117:	50                   	push   %eax
80107118:	e8 73 b3 ff ff       	call   80102490 <kfree>
      *pte = 0;
8010711d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107123:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107126:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107129:	77 c0                	ja     801070eb <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010712b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010712e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107131:	5b                   	pop    %ebx
80107132:	5e                   	pop    %esi
80107133:	5f                   	pop    %edi
80107134:	5d                   	pop    %ebp
80107135:	c3                   	ret    
80107136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010713d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107140:	89 fa                	mov    %edi,%edx
80107142:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107148:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010714e:	eb 96                	jmp    801070e6 <deallocuvm.part.0+0x36>
        panic("kfree");
80107150:	83 ec 0c             	sub    $0xc,%esp
80107153:	68 46 7b 10 80       	push   $0x80107b46
80107158:	e8 33 92 ff ff       	call   80100390 <panic>
8010715d:	8d 76 00             	lea    0x0(%esi),%esi

80107160 <seginit>:
{
80107160:	f3 0f 1e fb          	endbr32 
80107164:	55                   	push   %ebp
80107165:	89 e5                	mov    %esp,%ebp
80107167:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010716a:	e8 91 c8 ff ff       	call   80103a00 <cpuid>
  pd[0] = size-1;
8010716f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107174:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010717a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010717e:	c7 80 18 38 11 80 ff 	movl   $0xffff,-0x7feec7e8(%eax)
80107185:	ff 00 00 
80107188:	c7 80 1c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7e4(%eax)
8010718f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107192:	c7 80 20 38 11 80 ff 	movl   $0xffff,-0x7feec7e0(%eax)
80107199:	ff 00 00 
8010719c:	c7 80 24 38 11 80 00 	movl   $0xcf9200,-0x7feec7dc(%eax)
801071a3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801071a6:	c7 80 28 38 11 80 ff 	movl   $0xffff,-0x7feec7d8(%eax)
801071ad:	ff 00 00 
801071b0:	c7 80 2c 38 11 80 00 	movl   $0xcffa00,-0x7feec7d4(%eax)
801071b7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801071ba:	c7 80 30 38 11 80 ff 	movl   $0xffff,-0x7feec7d0(%eax)
801071c1:	ff 00 00 
801071c4:	c7 80 34 38 11 80 00 	movl   $0xcff200,-0x7feec7cc(%eax)
801071cb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071ce:	05 10 38 11 80       	add    $0x80113810,%eax
  pd[1] = (uint)p;
801071d3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071d7:	c1 e8 10             	shr    $0x10,%eax
801071da:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801071de:	8d 45 f2             	lea    -0xe(%ebp),%eax
801071e1:	0f 01 10             	lgdtl  (%eax)
}
801071e4:	c9                   	leave  
801071e5:	c3                   	ret    
801071e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071ed:	8d 76 00             	lea    0x0(%esi),%esi

801071f0 <switchkvm>:
{
801071f0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071f4:	a1 04 6c 11 80       	mov    0x80116c04,%eax
801071f9:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801071fe:	0f 22 d8             	mov    %eax,%cr3
}
80107201:	c3                   	ret    
80107202:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107210 <switchuvm>:
{
80107210:	f3 0f 1e fb          	endbr32 
80107214:	55                   	push   %ebp
80107215:	89 e5                	mov    %esp,%ebp
80107217:	57                   	push   %edi
80107218:	56                   	push   %esi
80107219:	53                   	push   %ebx
8010721a:	83 ec 1c             	sub    $0x1c,%esp
8010721d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107220:	85 f6                	test   %esi,%esi
80107222:	0f 84 cb 00 00 00    	je     801072f3 <switchuvm+0xe3>
  if(p->kstack == 0)
80107228:	8b 46 08             	mov    0x8(%esi),%eax
8010722b:	85 c0                	test   %eax,%eax
8010722d:	0f 84 da 00 00 00    	je     8010730d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107233:	8b 46 04             	mov    0x4(%esi),%eax
80107236:	85 c0                	test   %eax,%eax
80107238:	0f 84 c2 00 00 00    	je     80107300 <switchuvm+0xf0>
  pushcli();
8010723e:	e8 9d d8 ff ff       	call   80104ae0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107243:	e8 48 c7 ff ff       	call   80103990 <mycpu>
80107248:	89 c3                	mov    %eax,%ebx
8010724a:	e8 41 c7 ff ff       	call   80103990 <mycpu>
8010724f:	89 c7                	mov    %eax,%edi
80107251:	e8 3a c7 ff ff       	call   80103990 <mycpu>
80107256:	83 c7 08             	add    $0x8,%edi
80107259:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010725c:	e8 2f c7 ff ff       	call   80103990 <mycpu>
80107261:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107264:	ba 67 00 00 00       	mov    $0x67,%edx
80107269:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107270:	83 c0 08             	add    $0x8,%eax
80107273:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010727a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010727f:	83 c1 08             	add    $0x8,%ecx
80107282:	c1 e8 18             	shr    $0x18,%eax
80107285:	c1 e9 10             	shr    $0x10,%ecx
80107288:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010728e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107294:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107299:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072a0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801072a5:	e8 e6 c6 ff ff       	call   80103990 <mycpu>
801072aa:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072b1:	e8 da c6 ff ff       	call   80103990 <mycpu>
801072b6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072ba:	8b 5e 08             	mov    0x8(%esi),%ebx
801072bd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072c3:	e8 c8 c6 ff ff       	call   80103990 <mycpu>
801072c8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072cb:	e8 c0 c6 ff ff       	call   80103990 <mycpu>
801072d0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801072d4:	b8 28 00 00 00       	mov    $0x28,%eax
801072d9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072dc:	8b 46 04             	mov    0x4(%esi),%eax
801072df:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801072e4:	0f 22 d8             	mov    %eax,%cr3
}
801072e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072ea:	5b                   	pop    %ebx
801072eb:	5e                   	pop    %esi
801072ec:	5f                   	pop    %edi
801072ed:	5d                   	pop    %ebp
  popcli();
801072ee:	e9 3d d8 ff ff       	jmp    80104b30 <popcli>
    panic("switchuvm: no process");
801072f3:	83 ec 0c             	sub    $0xc,%esp
801072f6:	68 ce 81 10 80       	push   $0x801081ce
801072fb:	e8 90 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107300:	83 ec 0c             	sub    $0xc,%esp
80107303:	68 f9 81 10 80       	push   $0x801081f9
80107308:	e8 83 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
8010730d:	83 ec 0c             	sub    $0xc,%esp
80107310:	68 e4 81 10 80       	push   $0x801081e4
80107315:	e8 76 90 ff ff       	call   80100390 <panic>
8010731a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107320 <inituvm>:
{
80107320:	f3 0f 1e fb          	endbr32 
80107324:	55                   	push   %ebp
80107325:	89 e5                	mov    %esp,%ebp
80107327:	57                   	push   %edi
80107328:	56                   	push   %esi
80107329:	53                   	push   %ebx
8010732a:	83 ec 1c             	sub    $0x1c,%esp
8010732d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107330:	8b 75 10             	mov    0x10(%ebp),%esi
80107333:	8b 7d 08             	mov    0x8(%ebp),%edi
80107336:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107339:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010733f:	77 4b                	ja     8010738c <inituvm+0x6c>
  mem = kalloc();
80107341:	e8 0a b3 ff ff       	call   80102650 <kalloc>
  memset(mem, 0, PGSIZE);
80107346:	83 ec 04             	sub    $0x4,%esp
80107349:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010734e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107350:	6a 00                	push   $0x0
80107352:	50                   	push   %eax
80107353:	e8 98 d9 ff ff       	call   80104cf0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107358:	58                   	pop    %eax
80107359:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010735f:	5a                   	pop    %edx
80107360:	6a 06                	push   $0x6
80107362:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107367:	31 d2                	xor    %edx,%edx
80107369:	50                   	push   %eax
8010736a:	89 f8                	mov    %edi,%eax
8010736c:	e8 af fc ff ff       	call   80107020 <mappages>
  memmove(mem, init, sz);
80107371:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107374:	89 75 10             	mov    %esi,0x10(%ebp)
80107377:	83 c4 10             	add    $0x10,%esp
8010737a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010737d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107380:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107383:	5b                   	pop    %ebx
80107384:	5e                   	pop    %esi
80107385:	5f                   	pop    %edi
80107386:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107387:	e9 04 da ff ff       	jmp    80104d90 <memmove>
    panic("inituvm: more than a page");
8010738c:	83 ec 0c             	sub    $0xc,%esp
8010738f:	68 0d 82 10 80       	push   $0x8010820d
80107394:	e8 f7 8f ff ff       	call   80100390 <panic>
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073a0 <loaduvm>:
{
801073a0:	f3 0f 1e fb          	endbr32 
801073a4:	55                   	push   %ebp
801073a5:	89 e5                	mov    %esp,%ebp
801073a7:	57                   	push   %edi
801073a8:	56                   	push   %esi
801073a9:	53                   	push   %ebx
801073aa:	83 ec 1c             	sub    $0x1c,%esp
801073ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801073b0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801073b3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801073b8:	0f 85 99 00 00 00    	jne    80107457 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801073be:	01 f0                	add    %esi,%eax
801073c0:	89 f3                	mov    %esi,%ebx
801073c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073c5:	8b 45 14             	mov    0x14(%ebp),%eax
801073c8:	01 f0                	add    %esi,%eax
801073ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801073cd:	85 f6                	test   %esi,%esi
801073cf:	75 15                	jne    801073e6 <loaduvm+0x46>
801073d1:	eb 6d                	jmp    80107440 <loaduvm+0xa0>
801073d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073d7:	90                   	nop
801073d8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073de:	89 f0                	mov    %esi,%eax
801073e0:	29 d8                	sub    %ebx,%eax
801073e2:	39 c6                	cmp    %eax,%esi
801073e4:	76 5a                	jbe    80107440 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073e6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801073e9:	8b 45 08             	mov    0x8(%ebp),%eax
801073ec:	31 c9                	xor    %ecx,%ecx
801073ee:	29 da                	sub    %ebx,%edx
801073f0:	e8 ab fb ff ff       	call   80106fa0 <walkpgdir>
801073f5:	85 c0                	test   %eax,%eax
801073f7:	74 51                	je     8010744a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
801073f9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073fb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801073fe:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107403:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107408:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010740e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107411:	29 d9                	sub    %ebx,%ecx
80107413:	05 00 00 00 80       	add    $0x80000000,%eax
80107418:	57                   	push   %edi
80107419:	51                   	push   %ecx
8010741a:	50                   	push   %eax
8010741b:	ff 75 10             	pushl  0x10(%ebp)
8010741e:	e8 5d a6 ff ff       	call   80101a80 <readi>
80107423:	83 c4 10             	add    $0x10,%esp
80107426:	39 f8                	cmp    %edi,%eax
80107428:	74 ae                	je     801073d8 <loaduvm+0x38>
}
8010742a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010742d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107432:	5b                   	pop    %ebx
80107433:	5e                   	pop    %esi
80107434:	5f                   	pop    %edi
80107435:	5d                   	pop    %ebp
80107436:	c3                   	ret    
80107437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010743e:	66 90                	xchg   %ax,%ax
80107440:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107443:	31 c0                	xor    %eax,%eax
}
80107445:	5b                   	pop    %ebx
80107446:	5e                   	pop    %esi
80107447:	5f                   	pop    %edi
80107448:	5d                   	pop    %ebp
80107449:	c3                   	ret    
      panic("loaduvm: address should exist");
8010744a:	83 ec 0c             	sub    $0xc,%esp
8010744d:	68 27 82 10 80       	push   $0x80108227
80107452:	e8 39 8f ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107457:	83 ec 0c             	sub    $0xc,%esp
8010745a:	68 c8 82 10 80       	push   $0x801082c8
8010745f:	e8 2c 8f ff ff       	call   80100390 <panic>
80107464:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010746b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010746f:	90                   	nop

80107470 <allocuvm>:
{
80107470:	f3 0f 1e fb          	endbr32 
80107474:	55                   	push   %ebp
80107475:	89 e5                	mov    %esp,%ebp
80107477:	57                   	push   %edi
80107478:	56                   	push   %esi
80107479:	53                   	push   %ebx
8010747a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010747d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107480:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107483:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107486:	85 c0                	test   %eax,%eax
80107488:	0f 88 b2 00 00 00    	js     80107540 <allocuvm+0xd0>
  if(newsz < oldsz)
8010748e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107491:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107494:	0f 82 96 00 00 00    	jb     80107530 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010749a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801074a0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801074a6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074a9:	77 40                	ja     801074eb <allocuvm+0x7b>
801074ab:	e9 83 00 00 00       	jmp    80107533 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801074b0:	83 ec 04             	sub    $0x4,%esp
801074b3:	68 00 10 00 00       	push   $0x1000
801074b8:	6a 00                	push   $0x0
801074ba:	50                   	push   %eax
801074bb:	e8 30 d8 ff ff       	call   80104cf0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801074c0:	58                   	pop    %eax
801074c1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074c7:	5a                   	pop    %edx
801074c8:	6a 06                	push   $0x6
801074ca:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074cf:	89 f2                	mov    %esi,%edx
801074d1:	50                   	push   %eax
801074d2:	89 f8                	mov    %edi,%eax
801074d4:	e8 47 fb ff ff       	call   80107020 <mappages>
801074d9:	83 c4 10             	add    $0x10,%esp
801074dc:	85 c0                	test   %eax,%eax
801074de:	78 78                	js     80107558 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801074e0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074e6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074e9:	76 48                	jbe    80107533 <allocuvm+0xc3>
    mem = kalloc();
801074eb:	e8 60 b1 ff ff       	call   80102650 <kalloc>
801074f0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801074f2:	85 c0                	test   %eax,%eax
801074f4:	75 ba                	jne    801074b0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801074f6:	83 ec 0c             	sub    $0xc,%esp
801074f9:	68 45 82 10 80       	push   $0x80108245
801074fe:	e8 ad 91 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107503:	8b 45 0c             	mov    0xc(%ebp),%eax
80107506:	83 c4 10             	add    $0x10,%esp
80107509:	39 45 10             	cmp    %eax,0x10(%ebp)
8010750c:	74 32                	je     80107540 <allocuvm+0xd0>
8010750e:	8b 55 10             	mov    0x10(%ebp),%edx
80107511:	89 c1                	mov    %eax,%ecx
80107513:	89 f8                	mov    %edi,%eax
80107515:	e8 96 fb ff ff       	call   801070b0 <deallocuvm.part.0>
      return 0;
8010751a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107521:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107524:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107527:	5b                   	pop    %ebx
80107528:	5e                   	pop    %esi
80107529:	5f                   	pop    %edi
8010752a:	5d                   	pop    %ebp
8010752b:	c3                   	ret    
8010752c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107530:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107533:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107536:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107539:	5b                   	pop    %ebx
8010753a:	5e                   	pop    %esi
8010753b:	5f                   	pop    %edi
8010753c:	5d                   	pop    %ebp
8010753d:	c3                   	ret    
8010753e:	66 90                	xchg   %ax,%ax
    return 0;
80107540:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107547:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010754a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010754d:	5b                   	pop    %ebx
8010754e:	5e                   	pop    %esi
8010754f:	5f                   	pop    %edi
80107550:	5d                   	pop    %ebp
80107551:	c3                   	ret    
80107552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107558:	83 ec 0c             	sub    $0xc,%esp
8010755b:	68 5d 82 10 80       	push   $0x8010825d
80107560:	e8 4b 91 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107565:	8b 45 0c             	mov    0xc(%ebp),%eax
80107568:	83 c4 10             	add    $0x10,%esp
8010756b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010756e:	74 0c                	je     8010757c <allocuvm+0x10c>
80107570:	8b 55 10             	mov    0x10(%ebp),%edx
80107573:	89 c1                	mov    %eax,%ecx
80107575:	89 f8                	mov    %edi,%eax
80107577:	e8 34 fb ff ff       	call   801070b0 <deallocuvm.part.0>
      kfree(mem);
8010757c:	83 ec 0c             	sub    $0xc,%esp
8010757f:	53                   	push   %ebx
80107580:	e8 0b af ff ff       	call   80102490 <kfree>
      return 0;
80107585:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010758c:	83 c4 10             	add    $0x10,%esp
}
8010758f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107592:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107595:	5b                   	pop    %ebx
80107596:	5e                   	pop    %esi
80107597:	5f                   	pop    %edi
80107598:	5d                   	pop    %ebp
80107599:	c3                   	ret    
8010759a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075a0 <deallocuvm>:
{
801075a0:	f3 0f 1e fb          	endbr32 
801075a4:	55                   	push   %ebp
801075a5:	89 e5                	mov    %esp,%ebp
801075a7:	8b 55 0c             	mov    0xc(%ebp),%edx
801075aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
801075ad:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801075b0:	39 d1                	cmp    %edx,%ecx
801075b2:	73 0c                	jae    801075c0 <deallocuvm+0x20>
}
801075b4:	5d                   	pop    %ebp
801075b5:	e9 f6 fa ff ff       	jmp    801070b0 <deallocuvm.part.0>
801075ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075c0:	89 d0                	mov    %edx,%eax
801075c2:	5d                   	pop    %ebp
801075c3:	c3                   	ret    
801075c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075cf:	90                   	nop

801075d0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801075d0:	f3 0f 1e fb          	endbr32 
801075d4:	55                   	push   %ebp
801075d5:	89 e5                	mov    %esp,%ebp
801075d7:	57                   	push   %edi
801075d8:	56                   	push   %esi
801075d9:	53                   	push   %ebx
801075da:	83 ec 0c             	sub    $0xc,%esp
801075dd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801075e0:	85 f6                	test   %esi,%esi
801075e2:	74 55                	je     80107639 <freevm+0x69>
  if(newsz >= oldsz)
801075e4:	31 c9                	xor    %ecx,%ecx
801075e6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801075eb:	89 f0                	mov    %esi,%eax
801075ed:	89 f3                	mov    %esi,%ebx
801075ef:	e8 bc fa ff ff       	call   801070b0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801075f4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801075fa:	eb 0b                	jmp    80107607 <freevm+0x37>
801075fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107600:	83 c3 04             	add    $0x4,%ebx
80107603:	39 df                	cmp    %ebx,%edi
80107605:	74 23                	je     8010762a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107607:	8b 03                	mov    (%ebx),%eax
80107609:	a8 01                	test   $0x1,%al
8010760b:	74 f3                	je     80107600 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010760d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107612:	83 ec 0c             	sub    $0xc,%esp
80107615:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107618:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010761d:	50                   	push   %eax
8010761e:	e8 6d ae ff ff       	call   80102490 <kfree>
80107623:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107626:	39 df                	cmp    %ebx,%edi
80107628:	75 dd                	jne    80107607 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010762a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010762d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107630:	5b                   	pop    %ebx
80107631:	5e                   	pop    %esi
80107632:	5f                   	pop    %edi
80107633:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107634:	e9 57 ae ff ff       	jmp    80102490 <kfree>
    panic("freevm: no pgdir");
80107639:	83 ec 0c             	sub    $0xc,%esp
8010763c:	68 79 82 10 80       	push   $0x80108279
80107641:	e8 4a 8d ff ff       	call   80100390 <panic>
80107646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010764d:	8d 76 00             	lea    0x0(%esi),%esi

80107650 <setupkvm>:
{
80107650:	f3 0f 1e fb          	endbr32 
80107654:	55                   	push   %ebp
80107655:	89 e5                	mov    %esp,%ebp
80107657:	56                   	push   %esi
80107658:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107659:	e8 f2 af ff ff       	call   80102650 <kalloc>
8010765e:	89 c6                	mov    %eax,%esi
80107660:	85 c0                	test   %eax,%eax
80107662:	74 42                	je     801076a6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107664:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107667:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
8010766c:	68 00 10 00 00       	push   $0x1000
80107671:	6a 00                	push   $0x0
80107673:	50                   	push   %eax
80107674:	e8 77 d6 ff ff       	call   80104cf0 <memset>
80107679:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010767c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010767f:	83 ec 08             	sub    $0x8,%esp
80107682:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107685:	ff 73 0c             	pushl  0xc(%ebx)
80107688:	8b 13                	mov    (%ebx),%edx
8010768a:	50                   	push   %eax
8010768b:	29 c1                	sub    %eax,%ecx
8010768d:	89 f0                	mov    %esi,%eax
8010768f:	e8 8c f9 ff ff       	call   80107020 <mappages>
80107694:	83 c4 10             	add    $0x10,%esp
80107697:	85 c0                	test   %eax,%eax
80107699:	78 15                	js     801076b0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010769b:	83 c3 10             	add    $0x10,%ebx
8010769e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801076a4:	75 d6                	jne    8010767c <setupkvm+0x2c>
}
801076a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076a9:	89 f0                	mov    %esi,%eax
801076ab:	5b                   	pop    %ebx
801076ac:	5e                   	pop    %esi
801076ad:	5d                   	pop    %ebp
801076ae:	c3                   	ret    
801076af:	90                   	nop
      freevm(pgdir);
801076b0:	83 ec 0c             	sub    $0xc,%esp
801076b3:	56                   	push   %esi
      return 0;
801076b4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076b6:	e8 15 ff ff ff       	call   801075d0 <freevm>
      return 0;
801076bb:	83 c4 10             	add    $0x10,%esp
}
801076be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076c1:	89 f0                	mov    %esi,%eax
801076c3:	5b                   	pop    %ebx
801076c4:	5e                   	pop    %esi
801076c5:	5d                   	pop    %ebp
801076c6:	c3                   	ret    
801076c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ce:	66 90                	xchg   %ax,%ax

801076d0 <kvmalloc>:
{
801076d0:	f3 0f 1e fb          	endbr32 
801076d4:	55                   	push   %ebp
801076d5:	89 e5                	mov    %esp,%ebp
801076d7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076da:	e8 71 ff ff ff       	call   80107650 <setupkvm>
801076df:	a3 04 6c 11 80       	mov    %eax,0x80116c04
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076e4:	05 00 00 00 80       	add    $0x80000000,%eax
801076e9:	0f 22 d8             	mov    %eax,%cr3
}
801076ec:	c9                   	leave  
801076ed:	c3                   	ret    
801076ee:	66 90                	xchg   %ax,%ax

801076f0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801076f0:	f3 0f 1e fb          	endbr32 
801076f4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801076f5:	31 c9                	xor    %ecx,%ecx
{
801076f7:	89 e5                	mov    %esp,%ebp
801076f9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801076fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801076ff:	8b 45 08             	mov    0x8(%ebp),%eax
80107702:	e8 99 f8 ff ff       	call   80106fa0 <walkpgdir>
  if(pte == 0)
80107707:	85 c0                	test   %eax,%eax
80107709:	74 05                	je     80107710 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
8010770b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010770e:	c9                   	leave  
8010770f:	c3                   	ret    
    panic("clearpteu");
80107710:	83 ec 0c             	sub    $0xc,%esp
80107713:	68 8a 82 10 80       	push   $0x8010828a
80107718:	e8 73 8c ff ff       	call   80100390 <panic>
8010771d:	8d 76 00             	lea    0x0(%esi),%esi

80107720 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107720:	f3 0f 1e fb          	endbr32 
80107724:	55                   	push   %ebp
80107725:	89 e5                	mov    %esp,%ebp
80107727:	57                   	push   %edi
80107728:	56                   	push   %esi
80107729:	53                   	push   %ebx
8010772a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010772d:	e8 1e ff ff ff       	call   80107650 <setupkvm>
80107732:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107735:	85 c0                	test   %eax,%eax
80107737:	0f 84 9b 00 00 00    	je     801077d8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010773d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107740:	85 c9                	test   %ecx,%ecx
80107742:	0f 84 90 00 00 00    	je     801077d8 <copyuvm+0xb8>
80107748:	31 f6                	xor    %esi,%esi
8010774a:	eb 46                	jmp    80107792 <copyuvm+0x72>
8010774c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107750:	83 ec 04             	sub    $0x4,%esp
80107753:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107759:	68 00 10 00 00       	push   $0x1000
8010775e:	57                   	push   %edi
8010775f:	50                   	push   %eax
80107760:	e8 2b d6 ff ff       	call   80104d90 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107765:	58                   	pop    %eax
80107766:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010776c:	5a                   	pop    %edx
8010776d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107770:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107775:	89 f2                	mov    %esi,%edx
80107777:	50                   	push   %eax
80107778:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010777b:	e8 a0 f8 ff ff       	call   80107020 <mappages>
80107780:	83 c4 10             	add    $0x10,%esp
80107783:	85 c0                	test   %eax,%eax
80107785:	78 61                	js     801077e8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107787:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010778d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107790:	76 46                	jbe    801077d8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107792:	8b 45 08             	mov    0x8(%ebp),%eax
80107795:	31 c9                	xor    %ecx,%ecx
80107797:	89 f2                	mov    %esi,%edx
80107799:	e8 02 f8 ff ff       	call   80106fa0 <walkpgdir>
8010779e:	85 c0                	test   %eax,%eax
801077a0:	74 61                	je     80107803 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801077a2:	8b 00                	mov    (%eax),%eax
801077a4:	a8 01                	test   $0x1,%al
801077a6:	74 4e                	je     801077f6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801077a8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801077aa:	25 ff 0f 00 00       	and    $0xfff,%eax
801077af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801077b2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801077b8:	e8 93 ae ff ff       	call   80102650 <kalloc>
801077bd:	89 c3                	mov    %eax,%ebx
801077bf:	85 c0                	test   %eax,%eax
801077c1:	75 8d                	jne    80107750 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801077c3:	83 ec 0c             	sub    $0xc,%esp
801077c6:	ff 75 e0             	pushl  -0x20(%ebp)
801077c9:	e8 02 fe ff ff       	call   801075d0 <freevm>
  return 0;
801077ce:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077d5:	83 c4 10             	add    $0x10,%esp
}
801077d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077de:	5b                   	pop    %ebx
801077df:	5e                   	pop    %esi
801077e0:	5f                   	pop    %edi
801077e1:	5d                   	pop    %ebp
801077e2:	c3                   	ret    
801077e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077e7:	90                   	nop
      kfree(mem);
801077e8:	83 ec 0c             	sub    $0xc,%esp
801077eb:	53                   	push   %ebx
801077ec:	e8 9f ac ff ff       	call   80102490 <kfree>
      goto bad;
801077f1:	83 c4 10             	add    $0x10,%esp
801077f4:	eb cd                	jmp    801077c3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801077f6:	83 ec 0c             	sub    $0xc,%esp
801077f9:	68 ae 82 10 80       	push   $0x801082ae
801077fe:	e8 8d 8b ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107803:	83 ec 0c             	sub    $0xc,%esp
80107806:	68 94 82 10 80       	push   $0x80108294
8010780b:	e8 80 8b ff ff       	call   80100390 <panic>

80107810 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107810:	f3 0f 1e fb          	endbr32 
80107814:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107815:	31 c9                	xor    %ecx,%ecx
{
80107817:	89 e5                	mov    %esp,%ebp
80107819:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
8010781c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010781f:	8b 45 08             	mov    0x8(%ebp),%eax
80107822:	e8 79 f7 ff ff       	call   80106fa0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107827:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107829:	c9                   	leave  
  if((*pte & PTE_U) == 0)
8010782a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010782c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107831:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107834:	05 00 00 00 80       	add    $0x80000000,%eax
80107839:	83 fa 05             	cmp    $0x5,%edx
8010783c:	ba 00 00 00 00       	mov    $0x0,%edx
80107841:	0f 45 c2             	cmovne %edx,%eax
}
80107844:	c3                   	ret    
80107845:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010784c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107850 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107850:	f3 0f 1e fb          	endbr32 
80107854:	55                   	push   %ebp
80107855:	89 e5                	mov    %esp,%ebp
80107857:	57                   	push   %edi
80107858:	56                   	push   %esi
80107859:	53                   	push   %ebx
8010785a:	83 ec 0c             	sub    $0xc,%esp
8010785d:	8b 75 14             	mov    0x14(%ebp),%esi
80107860:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107863:	85 f6                	test   %esi,%esi
80107865:	75 3c                	jne    801078a3 <copyout+0x53>
80107867:	eb 67                	jmp    801078d0 <copyout+0x80>
80107869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107870:	8b 55 0c             	mov    0xc(%ebp),%edx
80107873:	89 fb                	mov    %edi,%ebx
80107875:	29 d3                	sub    %edx,%ebx
80107877:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010787d:	39 f3                	cmp    %esi,%ebx
8010787f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107882:	29 fa                	sub    %edi,%edx
80107884:	83 ec 04             	sub    $0x4,%esp
80107887:	01 c2                	add    %eax,%edx
80107889:	53                   	push   %ebx
8010788a:	ff 75 10             	pushl  0x10(%ebp)
8010788d:	52                   	push   %edx
8010788e:	e8 fd d4 ff ff       	call   80104d90 <memmove>
    len -= n;
    buf += n;
80107893:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107896:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
8010789c:	83 c4 10             	add    $0x10,%esp
8010789f:	29 de                	sub    %ebx,%esi
801078a1:	74 2d                	je     801078d0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
801078a3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078a5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801078a8:	89 55 0c             	mov    %edx,0xc(%ebp)
801078ab:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
801078b1:	57                   	push   %edi
801078b2:	ff 75 08             	pushl  0x8(%ebp)
801078b5:	e8 56 ff ff ff       	call   80107810 <uva2ka>
    if(pa0 == 0)
801078ba:	83 c4 10             	add    $0x10,%esp
801078bd:	85 c0                	test   %eax,%eax
801078bf:	75 af                	jne    80107870 <copyout+0x20>
  }
  return 0;
}
801078c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078c9:	5b                   	pop    %ebx
801078ca:	5e                   	pop    %esi
801078cb:	5f                   	pop    %edi
801078cc:	5d                   	pop    %ebp
801078cd:	c3                   	ret    
801078ce:	66 90                	xchg   %ax,%ax
801078d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078d3:	31 c0                	xor    %eax,%eax
}
801078d5:	5b                   	pop    %ebx
801078d6:	5e                   	pop    %esi
801078d7:	5f                   	pop    %edi
801078d8:	5d                   	pop    %ebp
801078d9:	c3                   	ret    
