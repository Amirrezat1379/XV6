
_sysTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(void) {
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
    getHelloWorld();
  15:	e8 19 03 00 00       	call   333 <getHelloWorld>
    printf (1, "\nsuccessful!\n");
  1a:	83 ec 08             	sub    $0x8,%esp
  1d:	68 54 08 00 00       	push   $0x854
  22:	6a 01                	push   $0x1
  24:	e8 27 04 00 00       	call   450 <printf>
    exit();
  29:	e8 65 02 00 00       	call   293 <exit>
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	f3 0f 1e fb          	endbr32 
  34:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  35:	31 c0                	xor    %eax,%eax
{
  37:	89 e5                	mov    %esp,%ebp
  39:	53                   	push   %ebx
  3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	89 c8                	mov    %ecx,%eax
  50:	5b                   	pop    %ebx
  51:	5d                   	pop    %ebp
  52:	c3                   	ret    
  53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6e:	0f b6 01             	movzbl (%ecx),%eax
  71:	0f b6 1a             	movzbl (%edx),%ebx
  74:	84 c0                	test   %al,%al
  76:	75 19                	jne    91 <strcmp+0x31>
  78:	eb 26                	jmp    a0 <strcmp+0x40>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  84:	83 c1 01             	add    $0x1,%ecx
  87:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  8a:	0f b6 1a             	movzbl (%edx),%ebx
  8d:	84 c0                	test   %al,%al
  8f:	74 0f                	je     a0 <strcmp+0x40>
  91:	38 d8                	cmp    %bl,%al
  93:	74 eb                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  95:	29 d8                	sub    %ebx,%eax
}
  97:	5b                   	pop    %ebx
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ae:	66 90                	xchg   %ax,%ax

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 3a 00             	cmpb   $0x0,(%edx)
  bd:	74 21                	je     e0 <strlen+0x30>
  bf:	31 c0                	xor    %eax,%eax
  c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  c8:	83 c0 01             	add    $0x1,%eax
  cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  cf:	89 c1                	mov    %eax,%ecx
  d1:	75 f5                	jne    c8 <strlen+0x18>
    ;
  return n;
}
  d3:	89 c8                	mov    %ecx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
  e0:	31 c9                	xor    %ecx,%ecx
}
  e2:	5d                   	pop    %ebp
  e3:	89 c8                	mov    %ecx,%eax
  e5:	c3                   	ret    
  e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ed:	8d 76 00             	lea    0x0(%esi),%esi

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 101:	89 d7                	mov    %edx,%edi
 103:	fc                   	cld    
 104:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 106:	89 d0                	mov    %edx,%eax
 108:	5f                   	pop    %edi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 11e:	0f b6 10             	movzbl (%eax),%edx
 121:	84 d2                	test   %dl,%dl
 123:	75 16                	jne    13b <strchr+0x2b>
 125:	eb 21                	jmp    148 <strchr+0x38>
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax
 130:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 134:	83 c0 01             	add    $0x1,%eax
 137:	84 d2                	test   %dl,%dl
 139:	74 0d                	je     148 <strchr+0x38>
    if(*s == c)
 13b:	38 d1                	cmp    %dl,%cl
 13d:	75 f1                	jne    130 <strchr+0x20>
      return (char*)s;
  return 0;
}
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 148:	31 c0                	xor    %eax,%eax
}
 14a:	5d                   	pop    %ebp
 14b:	c3                   	ret    
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <gets>:

char*
gets(char *buf, int max)
{
 150:	f3 0f 1e fb          	endbr32 
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	57                   	push   %edi
 158:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 159:	31 f6                	xor    %esi,%esi
{
 15b:	53                   	push   %ebx
 15c:	89 f3                	mov    %esi,%ebx
 15e:	83 ec 1c             	sub    $0x1c,%esp
 161:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 164:	eb 33                	jmp    199 <gets+0x49>
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	8d 45 e7             	lea    -0x19(%ebp),%eax
 176:	6a 01                	push   $0x1
 178:	50                   	push   %eax
 179:	6a 00                	push   $0x0
 17b:	e8 2b 01 00 00       	call   2ab <read>
    if(cc < 1)
 180:	83 c4 10             	add    $0x10,%esp
 183:	85 c0                	test   %eax,%eax
 185:	7e 1c                	jle    1a3 <gets+0x53>
      break;
    buf[i++] = c;
 187:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 18b:	83 c7 01             	add    $0x1,%edi
 18e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 191:	3c 0a                	cmp    $0xa,%al
 193:	74 23                	je     1b8 <gets+0x68>
 195:	3c 0d                	cmp    $0xd,%al
 197:	74 1f                	je     1b8 <gets+0x68>
  for(i=0; i+1 < max; ){
 199:	83 c3 01             	add    $0x1,%ebx
 19c:	89 fe                	mov    %edi,%esi
 19e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a1:	7c cd                	jl     170 <gets+0x20>
 1a3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1a8:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ae:	5b                   	pop    %ebx
 1af:	5e                   	pop    %esi
 1b0:	5f                   	pop    %edi
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b7:	90                   	nop
 1b8:	8b 75 08             	mov    0x8(%ebp),%esi
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	01 de                	add    %ebx,%esi
 1c0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1c2:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c8:	5b                   	pop    %ebx
 1c9:	5e                   	pop    %esi
 1ca:	5f                   	pop    %edi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	56                   	push   %esi
 1d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	6a 00                	push   $0x0
 1de:	ff 75 08             	pushl  0x8(%ebp)
 1e1:	e8 ed 00 00 00       	call   2d3 <open>
  if(fd < 0)
 1e6:	83 c4 10             	add    $0x10,%esp
 1e9:	85 c0                	test   %eax,%eax
 1eb:	78 2b                	js     218 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1ed:	83 ec 08             	sub    $0x8,%esp
 1f0:	ff 75 0c             	pushl  0xc(%ebp)
 1f3:	89 c3                	mov    %eax,%ebx
 1f5:	50                   	push   %eax
 1f6:	e8 f0 00 00 00       	call   2eb <fstat>
  close(fd);
 1fb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1fe:	89 c6                	mov    %eax,%esi
  close(fd);
 200:	e8 b6 00 00 00       	call   2bb <close>
  return r;
 205:	83 c4 10             	add    $0x10,%esp
}
 208:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20b:	89 f0                	mov    %esi,%eax
 20d:	5b                   	pop    %ebx
 20e:	5e                   	pop    %esi
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 218:	be ff ff ff ff       	mov    $0xffffffff,%esi
 21d:	eb e9                	jmp    208 <stat+0x38>
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	53                   	push   %ebx
 228:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22b:	0f be 02             	movsbl (%edx),%eax
 22e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 231:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 234:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 239:	77 1a                	ja     255 <atoi+0x35>
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop
    n = n*10 + *s++ - '0';
 240:	83 c2 01             	add    $0x1,%edx
 243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 24a:	0f be 02             	movsbl (%edx),%eax
 24d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	89 c8                	mov    %ecx,%eax
 257:	5b                   	pop    %ebx
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	57                   	push   %edi
 268:	8b 45 10             	mov    0x10(%ebp),%eax
 26b:	8b 55 08             	mov    0x8(%ebp),%edx
 26e:	56                   	push   %esi
 26f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	85 c0                	test   %eax,%eax
 274:	7e 0f                	jle    285 <memmove+0x25>
 276:	01 d0                	add    %edx,%eax
  dst = vdst;
 278:	89 d7                	mov    %edx,%edi
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
  return vdst;
}
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret    

0000028b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28b:	b8 01 00 00 00       	mov    $0x1,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <exit>:
SYSCALL(exit)
 293:	b8 02 00 00 00       	mov    $0x2,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <wait>:
SYSCALL(wait)
 29b:	b8 03 00 00 00       	mov    $0x3,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <pipe>:
SYSCALL(pipe)
 2a3:	b8 04 00 00 00       	mov    $0x4,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <read>:
SYSCALL(read)
 2ab:	b8 05 00 00 00       	mov    $0x5,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <write>:
SYSCALL(write)
 2b3:	b8 10 00 00 00       	mov    $0x10,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <close>:
SYSCALL(close)
 2bb:	b8 15 00 00 00       	mov    $0x15,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <kill>:
SYSCALL(kill)
 2c3:	b8 06 00 00 00       	mov    $0x6,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <exec>:
SYSCALL(exec)
 2cb:	b8 07 00 00 00       	mov    $0x7,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <open>:
SYSCALL(open)
 2d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mknod>:
SYSCALL(mknod)
 2db:	b8 11 00 00 00       	mov    $0x11,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <unlink>:
SYSCALL(unlink)
 2e3:	b8 12 00 00 00       	mov    $0x12,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <fstat>:
SYSCALL(fstat)
 2eb:	b8 08 00 00 00       	mov    $0x8,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <link>:
SYSCALL(link)
 2f3:	b8 13 00 00 00       	mov    $0x13,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <mkdir>:
SYSCALL(mkdir)
 2fb:	b8 14 00 00 00       	mov    $0x14,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <chdir>:
SYSCALL(chdir)
 303:	b8 09 00 00 00       	mov    $0x9,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <dup>:
SYSCALL(dup)
 30b:	b8 0a 00 00 00       	mov    $0xa,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <getpid>:
SYSCALL(getpid)
 313:	b8 0b 00 00 00       	mov    $0xb,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sbrk>:
SYSCALL(sbrk)
 31b:	b8 0c 00 00 00       	mov    $0xc,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <sleep>:
SYSCALL(sleep)
 323:	b8 0d 00 00 00       	mov    $0xd,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <uptime>:
SYSCALL(uptime)
 32b:	b8 0e 00 00 00       	mov    $0xe,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <getHelloWorld>:
SYSCALL(getHelloWorld)
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <getProcCount>:
SYSCALL(getProcCount)
 33b:	b8 17 00 00 00       	mov    $0x17,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <getReadCount>:
SYSCALL(getReadCount)
 343:	b8 18 00 00 00       	mov    $0x18,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <thread_create>:
SYSCALL(thread_create)
 34b:	b8 19 00 00 00       	mov    $0x19,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <join>:
SYSCALL(join)
 353:	b8 1a 00 00 00       	mov    $0x1a,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 35b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getWaitingTime>:
SYSCALL(getWaitingTime)
 363:	b8 1c 00 00 00       	mov    $0x1c,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 36b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <setPriority>:
SYSCALL(setPriority)
 373:	b8 1e 00 00 00       	mov    $0x1e,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <changePolicy>:
SYSCALL(changePolicy)
 37b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 383:	b8 20 00 00 00       	mov    $0x20,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 38b:	b8 21 00 00 00       	mov    $0x21,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 393:	b8 22 00 00 00       	mov    $0x22,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	83 ec 3c             	sub    $0x3c,%esp
 3a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ac:	89 d1                	mov    %edx,%ecx
{
 3ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3b1:	85 d2                	test   %edx,%edx
 3b3:	0f 89 7f 00 00 00    	jns    438 <printint+0x98>
 3b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3bd:	74 79                	je     438 <printint+0x98>
    neg = 1;
 3bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3c8:	31 db                	xor    %ebx,%ebx
 3ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3d0:	89 c8                	mov    %ecx,%eax
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	89 cf                	mov    %ecx,%edi
 3d6:	f7 75 c4             	divl   -0x3c(%ebp)
 3d9:	0f b6 92 6c 08 00 00 	movzbl 0x86c(%edx),%edx
 3e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3e3:	89 d8                	mov    %ebx,%eax
 3e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 3e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 3eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3f1:	76 dd                	jbe    3d0 <printint+0x30>
  if(neg)
 3f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3f6:	85 c9                	test   %ecx,%ecx
 3f8:	74 0c                	je     406 <printint+0x66>
    buf[i++] = '-';
 3fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 3ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 401:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 406:	8b 7d b8             	mov    -0x48(%ebp),%edi
 409:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 40d:	eb 07                	jmp    416 <printint+0x76>
 40f:	90                   	nop
 410:	0f b6 13             	movzbl (%ebx),%edx
 413:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 416:	83 ec 04             	sub    $0x4,%esp
 419:	88 55 d7             	mov    %dl,-0x29(%ebp)
 41c:	6a 01                	push   $0x1
 41e:	56                   	push   %esi
 41f:	57                   	push   %edi
 420:	e8 8e fe ff ff       	call   2b3 <write>
  while(--i >= 0)
 425:	83 c4 10             	add    $0x10,%esp
 428:	39 de                	cmp    %ebx,%esi
 42a:	75 e4                	jne    410 <printint+0x70>
    putc(fd, buf[i]);
}
 42c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 438:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 43f:	eb 87                	jmp    3c8 <printint+0x28>
 441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 450:	f3 0f 1e fb          	endbr32 
 454:	55                   	push   %ebp
 455:	89 e5                	mov    %esp,%ebp
 457:	57                   	push   %edi
 458:	56                   	push   %esi
 459:	53                   	push   %ebx
 45a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 45d:	8b 75 0c             	mov    0xc(%ebp),%esi
 460:	0f b6 1e             	movzbl (%esi),%ebx
 463:	84 db                	test   %bl,%bl
 465:	0f 84 b4 00 00 00    	je     51f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 46b:	8d 45 10             	lea    0x10(%ebp),%eax
 46e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 471:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 474:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 476:	89 45 d0             	mov    %eax,-0x30(%ebp)
 479:	eb 33                	jmp    4ae <printf+0x5e>
 47b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop
 480:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 483:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	74 17                	je     4a4 <printf+0x54>
  write(fd, &c, 1);
 48d:	83 ec 04             	sub    $0x4,%esp
 490:	88 5d e7             	mov    %bl,-0x19(%ebp)
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 15 fe ff ff       	call   2b3 <write>
 49e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4a1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4a4:	0f b6 1e             	movzbl (%esi),%ebx
 4a7:	83 c6 01             	add    $0x1,%esi
 4aa:	84 db                	test   %bl,%bl
 4ac:	74 71                	je     51f <printf+0xcf>
    c = fmt[i] & 0xff;
 4ae:	0f be cb             	movsbl %bl,%ecx
 4b1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4b4:	85 d2                	test   %edx,%edx
 4b6:	74 c8                	je     480 <printf+0x30>
      }
    } else if(state == '%'){
 4b8:	83 fa 25             	cmp    $0x25,%edx
 4bb:	75 e7                	jne    4a4 <printf+0x54>
      if(c == 'd'){
 4bd:	83 f8 64             	cmp    $0x64,%eax
 4c0:	0f 84 9a 00 00 00    	je     560 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4c6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4cc:	83 f9 70             	cmp    $0x70,%ecx
 4cf:	74 5f                	je     530 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4d1:	83 f8 73             	cmp    $0x73,%eax
 4d4:	0f 84 d6 00 00 00    	je     5b0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4da:	83 f8 63             	cmp    $0x63,%eax
 4dd:	0f 84 8d 00 00 00    	je     570 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4e3:	83 f8 25             	cmp    $0x25,%eax
 4e6:	0f 84 b4 00 00 00    	je     5a0 <printf+0x150>
  write(fd, &c, 1);
 4ec:	83 ec 04             	sub    $0x4,%esp
 4ef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4f3:	6a 01                	push   $0x1
 4f5:	57                   	push   %edi
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 b5 fd ff ff       	call   2b3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4fe:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 501:	83 c4 0c             	add    $0xc,%esp
 504:	6a 01                	push   $0x1
 506:	83 c6 01             	add    $0x1,%esi
 509:	57                   	push   %edi
 50a:	ff 75 08             	pushl  0x8(%ebp)
 50d:	e8 a1 fd ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 512:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 516:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 519:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 51b:	84 db                	test   %bl,%bl
 51d:	75 8f                	jne    4ae <printf+0x5e>
    }
  }
}
 51f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 522:	5b                   	pop    %ebx
 523:	5e                   	pop    %esi
 524:	5f                   	pop    %edi
 525:	5d                   	pop    %ebp
 526:	c3                   	ret    
 527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	b9 10 00 00 00       	mov    $0x10,%ecx
 538:	6a 00                	push   $0x0
 53a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	8b 13                	mov    (%ebx),%edx
 542:	e8 59 fe ff ff       	call   3a0 <printint>
        ap++;
 547:	89 d8                	mov    %ebx,%eax
 549:	83 c4 10             	add    $0x10,%esp
      state = 0;
 54c:	31 d2                	xor    %edx,%edx
        ap++;
 54e:	83 c0 04             	add    $0x4,%eax
 551:	89 45 d0             	mov    %eax,-0x30(%ebp)
 554:	e9 4b ff ff ff       	jmp    4a4 <printf+0x54>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 0a 00 00 00       	mov    $0xa,%ecx
 568:	6a 01                	push   $0x1
 56a:	eb ce                	jmp    53a <printf+0xea>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 573:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 576:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 578:	6a 01                	push   $0x1
        ap++;
 57a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 57d:	57                   	push   %edi
 57e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 581:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 584:	e8 2a fd ff ff       	call   2b3 <write>
        ap++;
 589:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 58c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 0e ff ff ff       	jmp    4a4 <printf+0x54>
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	e9 59 ff ff ff       	jmp    504 <printf+0xb4>
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	74 17                	je     5d6 <printf+0x186>
        while(*s != 0){
 5bf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5c2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5c4:	84 c0                	test   %al,%al
 5c6:	0f 84 d8 fe ff ff    	je     4a4 <printf+0x54>
 5cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5cf:	89 de                	mov    %ebx,%esi
 5d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5d4:	eb 1a                	jmp    5f0 <printf+0x1a0>
          s = "(null)";
 5d6:	bb 62 08 00 00       	mov    $0x862,%ebx
        while(*s != 0){
 5db:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5de:	b8 28 00 00 00       	mov    $0x28,%eax
 5e3:	89 de                	mov    %ebx,%esi
 5e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5f3:	83 c6 01             	add    $0x1,%esi
 5f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f9:	6a 01                	push   $0x1
 5fb:	57                   	push   %edi
 5fc:	53                   	push   %ebx
 5fd:	e8 b1 fc ff ff       	call   2b3 <write>
        while(*s != 0){
 602:	0f b6 06             	movzbl (%esi),%eax
 605:	83 c4 10             	add    $0x10,%esp
 608:	84 c0                	test   %al,%al
 60a:	75 e4                	jne    5f0 <printf+0x1a0>
 60c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 8e fe ff ff       	jmp    4a4 <printf+0x54>
 616:	66 90                	xchg   %ax,%ax
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	f3 0f 1e fb          	endbr32 
 624:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 625:	a1 5c 0b 00 00       	mov    0xb5c,%eax
{
 62a:	89 e5                	mov    %esp,%ebp
 62c:	57                   	push   %edi
 62d:	56                   	push   %esi
 62e:	53                   	push   %ebx
 62f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 632:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 634:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 637:	39 c8                	cmp    %ecx,%eax
 639:	73 15                	jae    650 <free+0x30>
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
 640:	39 d1                	cmp    %edx,%ecx
 642:	72 14                	jb     658 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 644:	39 d0                	cmp    %edx,%eax
 646:	73 10                	jae    658 <free+0x38>
{
 648:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64a:	8b 10                	mov    (%eax),%edx
 64c:	39 c8                	cmp    %ecx,%eax
 64e:	72 f0                	jb     640 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 650:	39 d0                	cmp    %edx,%eax
 652:	72 f4                	jb     648 <free+0x28>
 654:	39 d1                	cmp    %edx,%ecx
 656:	73 f0                	jae    648 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 fa                	cmp    %edi,%edx
 660:	74 1e                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 662:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 665:	8b 50 04             	mov    0x4(%eax),%edx
 668:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 66b:	39 f1                	cmp    %esi,%ecx
 66d:	74 28                	je     697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 66f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 671:	5b                   	pop    %ebx
  freep = p;
 672:	a3 5c 0b 00 00       	mov    %eax,0xb5c
}
 677:	5e                   	pop    %esi
 678:	5f                   	pop    %edi
 679:	5d                   	pop    %ebp
 67a:	c3                   	ret    
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 d8                	jne    66f <free+0x4f>
    p->s.size += bp->s.size;
 697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 69a:	a3 5c 0b 00 00       	mov    %eax,0xb5c
    p->s.size += bp->s.size;
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6a5:	89 10                	mov    %edx,(%eax)
}
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret    
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	f3 0f 1e fb          	endbr32 
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	57                   	push   %edi
 6b8:	56                   	push   %esi
 6b9:	53                   	push   %ebx
 6ba:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6bd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6c0:	8b 3d 5c 0b 00 00    	mov    0xb5c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c6:	8d 70 07             	lea    0x7(%eax),%esi
 6c9:	c1 ee 03             	shr    $0x3,%esi
 6cc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6cf:	85 ff                	test   %edi,%edi
 6d1:	0f 84 a9 00 00 00    	je     780 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 6d9:	8b 48 04             	mov    0x4(%eax),%ecx
 6dc:	39 f1                	cmp    %esi,%ecx
 6de:	73 6d                	jae    74d <malloc+0x9d>
 6e0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6e6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6eb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ee:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6f5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6f8:	eb 17                	jmp    711 <malloc+0x61>
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 702:	8b 4a 04             	mov    0x4(%edx),%ecx
 705:	39 f1                	cmp    %esi,%ecx
 707:	73 4f                	jae    758 <malloc+0xa8>
 709:	8b 3d 5c 0b 00 00    	mov    0xb5c,%edi
 70f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	39 c7                	cmp    %eax,%edi
 713:	75 eb                	jne    700 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 715:	83 ec 0c             	sub    $0xc,%esp
 718:	ff 75 e4             	pushl  -0x1c(%ebp)
 71b:	e8 fb fb ff ff       	call   31b <sbrk>
  if(p == (char*)-1)
 720:	83 c4 10             	add    $0x10,%esp
 723:	83 f8 ff             	cmp    $0xffffffff,%eax
 726:	74 1b                	je     743 <malloc+0x93>
  hp->s.size = nu;
 728:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	83 c0 08             	add    $0x8,%eax
 731:	50                   	push   %eax
 732:	e8 e9 fe ff ff       	call   620 <free>
  return freep;
 737:	a1 5c 0b 00 00       	mov    0xb5c,%eax
      if((p = morecore(nunits)) == 0)
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	85 c0                	test   %eax,%eax
 741:	75 bd                	jne    700 <malloc+0x50>
        return 0;
  }
}
 743:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 746:	31 c0                	xor    %eax,%eax
}
 748:	5b                   	pop    %ebx
 749:	5e                   	pop    %esi
 74a:	5f                   	pop    %edi
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
    if(p->s.size >= nunits){
 74d:	89 c2                	mov    %eax,%edx
 74f:	89 f8                	mov    %edi,%eax
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 758:	39 ce                	cmp    %ecx,%esi
 75a:	74 54                	je     7b0 <malloc+0x100>
        p->s.size -= nunits;
 75c:	29 f1                	sub    %esi,%ecx
 75e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 761:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 764:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 767:	a3 5c 0b 00 00       	mov    %eax,0xb5c
}
 76c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 76f:	8d 42 08             	lea    0x8(%edx),%eax
}
 772:	5b                   	pop    %ebx
 773:	5e                   	pop    %esi
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 5c 0b 00 00 60 	movl   $0xb60,0xb5c
 787:	0b 00 00 
    base.s.size = 0;
 78a:	bf 60 0b 00 00       	mov    $0xb60,%edi
    base.s.ptr = freep = prevp = &base;
 78f:	c7 05 60 0b 00 00 60 	movl   $0xb60,0xb60
 796:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 799:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 79b:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7a2:	00 00 00 
    if(p->s.size >= nunits){
 7a5:	e9 36 ff ff ff       	jmp    6e0 <malloc+0x30>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 0a                	mov    (%edx),%ecx
 7b2:	89 08                	mov    %ecx,(%eax)
 7b4:	eb b1                	jmp    767 <malloc+0xb7>
 7b6:	66 90                	xchg   %ax,%ax
 7b8:	66 90                	xchg   %ax,%ax
 7ba:	66 90                	xchg   %ax,%ax
 7bc:	66 90                	xchg   %ax,%ax
 7be:	66 90                	xchg   %ax,%ax

000007c0 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 7c0:	f3 0f 1e fb          	endbr32 
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	53                   	push   %ebx
 7c8:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 7cb:	68 00 20 00 00       	push   $0x2000
 7d0:	e8 db fe ff ff       	call   6b0 <malloc>
    void *stack;

    if (fptr == 0)
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	85 c0                	test   %eax,%eax
 7da:	74 59                	je     835 <thread_creator+0x75>
 7dc:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 7de:	25 ff 0f 00 00       	and    $0xfff,%eax
 7e3:	75 1b                	jne    800 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 7e5:	83 ec 0c             	sub    $0xc,%esp
 7e8:	53                   	push   %ebx
 7e9:	e8 5d fb ff ff       	call   34b <thread_create>

    if (thread_id < 0)
 7ee:	83 c4 10             	add    $0x10,%esp
 7f1:	85 c0                	test   %eax,%eax
 7f3:	78 23                	js     818 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 7f5:	74 45                	je     83c <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 7f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7fa:	c9                   	leave  
 7fb:	c3                   	ret    
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 800:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 802:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 805:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 80b:	53                   	push   %ebx
 80c:	e8 3a fb ff ff       	call   34b <thread_create>
    if (thread_id < 0)
 811:	83 c4 10             	add    $0x10,%esp
 814:	85 c0                	test   %eax,%eax
 816:	79 dd                	jns    7f5 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 818:	83 ec 08             	sub    $0x8,%esp
 81b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 81e:	68 7d 08 00 00       	push   $0x87d
 823:	6a 01                	push   $0x1
 825:	e8 26 fc ff ff       	call   450 <printf>
 82a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 82d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 830:	83 c4 10             	add    $0x10,%esp
 833:	c9                   	leave  
 834:	c3                   	ret    
        return -1;
 835:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 83a:	eb bb                	jmp    7f7 <thread_creator+0x37>
        (fn)(args);
 83c:	83 ec 0c             	sub    $0xc,%esp
 83f:	ff 75 0c             	pushl  0xc(%ebp)
 842:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 845:	89 1c 24             	mov    %ebx,(%esp)
 848:	e8 d3 fd ff ff       	call   620 <free>
        exit();
 84d:	e8 41 fa ff ff       	call   293 <exit>
