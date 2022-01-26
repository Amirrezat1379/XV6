
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	bf 01 00 00 00       	mov    $0x1,%edi
  17:	56                   	push   %esi
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 08             	sub    $0x8,%esp
  1d:	8b 59 04             	mov    0x4(%ecx),%ebx
  20:	8b 31                	mov    (%ecx),%esi
  22:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  25:	83 fe 01             	cmp    $0x1,%esi
  28:	7e 3a                	jle    64 <main+0x64>
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 11 03 00 00       	call   34b <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 93 02 00 00       	call   2e3 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 bb 08 00 00       	push   $0x8bb
  58:	6a 02                	push   $0x2
  5a:	e8 41 04 00 00       	call   4a0 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 a4 08 00 00       	push   $0x8a4
  6b:	6a 02                	push   $0x2
  6d:	e8 2e 04 00 00       	call   4a0 <printf>
    exit();
  72:	e8 6c 02 00 00       	call   2e3 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	f3 0f 1e fb          	endbr32 
  84:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  85:	31 c0                	xor    %eax,%eax
{
  87:	89 e5                	mov    %esp,%ebp
  89:	53                   	push   %ebx
  8a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	89 c8                	mov    %ecx,%eax
  a0:	5b                   	pop    %ebx
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	53                   	push   %ebx
  b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  be:	0f b6 01             	movzbl (%ecx),%eax
  c1:	0f b6 1a             	movzbl (%edx),%ebx
  c4:	84 c0                	test   %al,%al
  c6:	75 19                	jne    e1 <strcmp+0x31>
  c8:	eb 26                	jmp    f0 <strcmp+0x40>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  d4:	83 c1 01             	add    $0x1,%ecx
  d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  da:	0f b6 1a             	movzbl (%edx),%ebx
  dd:	84 c0                	test   %al,%al
  df:	74 0f                	je     f0 <strcmp+0x40>
  e1:	38 d8                	cmp    %bl,%al
  e3:	74 eb                	je     d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  e5:	29 d8                	sub    %ebx,%eax
}
  e7:	5b                   	pop    %ebx
  e8:	5d                   	pop    %ebp
  e9:	c3                   	ret    
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fe:	66 90                	xchg   %ax,%ax

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	f3 0f 1e fb          	endbr32 
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 10a:	80 3a 00             	cmpb   $0x0,(%edx)
 10d:	74 21                	je     130 <strlen+0x30>
 10f:	31 c0                	xor    %eax,%eax
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 118:	83 c0 01             	add    $0x1,%eax
 11b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 11f:	89 c1                	mov    %eax,%ecx
 121:	75 f5                	jne    118 <strlen+0x18>
    ;
  return n;
}
 123:	89 c8                	mov    %ecx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 130:	31 c9                	xor    %ecx,%ecx
}
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	57                   	push   %edi
 148:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 14b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	89 d7                	mov    %edx,%edi
 153:	fc                   	cld    
 154:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 156:	89 d0                	mov    %edx,%eax
 158:	5f                   	pop    %edi
 159:	5d                   	pop    %ebp
 15a:	c3                   	ret    
 15b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 15f:	90                   	nop

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16e:	0f b6 10             	movzbl (%eax),%edx
 171:	84 d2                	test   %dl,%dl
 173:	75 16                	jne    18b <strchr+0x2b>
 175:	eb 21                	jmp    198 <strchr+0x38>
 177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17e:	66 90                	xchg   %ax,%ax
 180:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 184:	83 c0 01             	add    $0x1,%eax
 187:	84 d2                	test   %dl,%dl
 189:	74 0d                	je     198 <strchr+0x38>
    if(*s == c)
 18b:	38 d1                	cmp    %dl,%cl
 18d:	75 f1                	jne    180 <strchr+0x20>
      return (char*)s;
  return 0;
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 198:	31 c0                	xor    %eax,%eax
}
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret    
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	57                   	push   %edi
 1a8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a9:	31 f6                	xor    %esi,%esi
{
 1ab:	53                   	push   %ebx
 1ac:	89 f3                	mov    %esi,%ebx
 1ae:	83 ec 1c             	sub    $0x1c,%esp
 1b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1b4:	eb 33                	jmp    1e9 <gets+0x49>
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1c6:	6a 01                	push   $0x1
 1c8:	50                   	push   %eax
 1c9:	6a 00                	push   $0x0
 1cb:	e8 2b 01 00 00       	call   2fb <read>
    if(cc < 1)
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	85 c0                	test   %eax,%eax
 1d5:	7e 1c                	jle    1f3 <gets+0x53>
      break;
    buf[i++] = c;
 1d7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1db:	83 c7 01             	add    $0x1,%edi
 1de:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1e1:	3c 0a                	cmp    $0xa,%al
 1e3:	74 23                	je     208 <gets+0x68>
 1e5:	3c 0d                	cmp    $0xd,%al
 1e7:	74 1f                	je     208 <gets+0x68>
  for(i=0; i+1 < max; ){
 1e9:	83 c3 01             	add    $0x1,%ebx
 1ec:	89 fe                	mov    %edi,%esi
 1ee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1f1:	7c cd                	jl     1c0 <gets+0x20>
 1f3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1f8:	c6 03 00             	movb   $0x0,(%ebx)
}
 1fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fe:	5b                   	pop    %ebx
 1ff:	5e                   	pop    %esi
 200:	5f                   	pop    %edi
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 207:	90                   	nop
 208:	8b 75 08             	mov    0x8(%ebp),%esi
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	01 de                	add    %ebx,%esi
 210:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 212:	c6 03 00             	movb   $0x0,(%ebx)
}
 215:	8d 65 f4             	lea    -0xc(%ebp),%esp
 218:	5b                   	pop    %ebx
 219:	5e                   	pop    %esi
 21a:	5f                   	pop    %edi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	56                   	push   %esi
 228:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	6a 00                	push   $0x0
 22e:	ff 75 08             	pushl  0x8(%ebp)
 231:	e8 ed 00 00 00       	call   323 <open>
  if(fd < 0)
 236:	83 c4 10             	add    $0x10,%esp
 239:	85 c0                	test   %eax,%eax
 23b:	78 2b                	js     268 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 23d:	83 ec 08             	sub    $0x8,%esp
 240:	ff 75 0c             	pushl  0xc(%ebp)
 243:	89 c3                	mov    %eax,%ebx
 245:	50                   	push   %eax
 246:	e8 f0 00 00 00       	call   33b <fstat>
  close(fd);
 24b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 24e:	89 c6                	mov    %eax,%esi
  close(fd);
 250:	e8 b6 00 00 00       	call   30b <close>
  return r;
 255:	83 c4 10             	add    $0x10,%esp
}
 258:	8d 65 f8             	lea    -0x8(%ebp),%esp
 25b:	89 f0                	mov    %esi,%eax
 25d:	5b                   	pop    %ebx
 25e:	5e                   	pop    %esi
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 268:	be ff ff ff ff       	mov    $0xffffffff,%esi
 26d:	eb e9                	jmp    258 <stat+0x38>
 26f:	90                   	nop

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	53                   	push   %ebx
 278:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27b:	0f be 02             	movsbl (%edx),%eax
 27e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 281:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 284:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 289:	77 1a                	ja     2a5 <atoi+0x35>
 28b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 28f:	90                   	nop
    n = n*10 + *s++ - '0';
 290:	83 c2 01             	add    $0x1,%edx
 293:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 296:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 29a:	0f be 02             	movsbl (%edx),%eax
 29d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	89 c8                	mov    %ecx,%eax
 2a7:	5b                   	pop    %ebx
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	57                   	push   %edi
 2b8:	8b 45 10             	mov    0x10(%ebp),%eax
 2bb:	8b 55 08             	mov    0x8(%ebp),%edx
 2be:	56                   	push   %esi
 2bf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c2:	85 c0                	test   %eax,%eax
 2c4:	7e 0f                	jle    2d5 <memmove+0x25>
 2c6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2c8:	89 d7                	mov    %edx,%edi
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2d1:	39 f8                	cmp    %edi,%eax
 2d3:	75 fb                	jne    2d0 <memmove+0x20>
  return vdst;
}
 2d5:	5e                   	pop    %esi
 2d6:	89 d0                	mov    %edx,%eax
 2d8:	5f                   	pop    %edi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    

000002db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2db:	b8 01 00 00 00       	mov    $0x1,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <exit>:
SYSCALL(exit)
 2e3:	b8 02 00 00 00       	mov    $0x2,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <wait>:
SYSCALL(wait)
 2eb:	b8 03 00 00 00       	mov    $0x3,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <pipe>:
SYSCALL(pipe)
 2f3:	b8 04 00 00 00       	mov    $0x4,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <read>:
SYSCALL(read)
 2fb:	b8 05 00 00 00       	mov    $0x5,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <write>:
SYSCALL(write)
 303:	b8 10 00 00 00       	mov    $0x10,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <close>:
SYSCALL(close)
 30b:	b8 15 00 00 00       	mov    $0x15,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <kill>:
SYSCALL(kill)
 313:	b8 06 00 00 00       	mov    $0x6,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <exec>:
SYSCALL(exec)
 31b:	b8 07 00 00 00       	mov    $0x7,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <open>:
SYSCALL(open)
 323:	b8 0f 00 00 00       	mov    $0xf,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mknod>:
SYSCALL(mknod)
 32b:	b8 11 00 00 00       	mov    $0x11,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <unlink>:
SYSCALL(unlink)
 333:	b8 12 00 00 00       	mov    $0x12,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <fstat>:
SYSCALL(fstat)
 33b:	b8 08 00 00 00       	mov    $0x8,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <link>:
SYSCALL(link)
 343:	b8 13 00 00 00       	mov    $0x13,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mkdir>:
SYSCALL(mkdir)
 34b:	b8 14 00 00 00       	mov    $0x14,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <chdir>:
SYSCALL(chdir)
 353:	b8 09 00 00 00       	mov    $0x9,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <dup>:
SYSCALL(dup)
 35b:	b8 0a 00 00 00       	mov    $0xa,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getpid>:
SYSCALL(getpid)
 363:	b8 0b 00 00 00       	mov    $0xb,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <sbrk>:
SYSCALL(sbrk)
 36b:	b8 0c 00 00 00       	mov    $0xc,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <sleep>:
SYSCALL(sleep)
 373:	b8 0d 00 00 00       	mov    $0xd,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <uptime>:
SYSCALL(uptime)
 37b:	b8 0e 00 00 00       	mov    $0xe,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <getHelloWorld>:
SYSCALL(getHelloWorld)
 383:	b8 16 00 00 00       	mov    $0x16,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <getProcCount>:
SYSCALL(getProcCount)
 38b:	b8 17 00 00 00       	mov    $0x17,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <getReadCount>:
SYSCALL(getReadCount)
 393:	b8 18 00 00 00       	mov    $0x18,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <thread_create>:
SYSCALL(thread_create)
 39b:	b8 19 00 00 00       	mov    $0x19,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <join>:
SYSCALL(join)
 3a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 3ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <getWaitingTime>:
SYSCALL(getWaitingTime)
 3b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 3bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <setPriority>:
SYSCALL(setPriority)
 3c3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <changePolicy>:
SYSCALL(changePolicy)
 3cb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 3d3:	b8 20 00 00 00       	mov    $0x20,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 3db:	b8 21 00 00 00       	mov    $0x21,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 3e3:	b8 22 00 00 00       	mov    $0x22,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	90                   	nop

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 3c             	sub    $0x3c,%esp
 3f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3fc:	89 d1                	mov    %edx,%ecx
{
 3fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 401:	85 d2                	test   %edx,%edx
 403:	0f 89 7f 00 00 00    	jns    488 <printint+0x98>
 409:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 40d:	74 79                	je     488 <printint+0x98>
    neg = 1;
 40f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 416:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 418:	31 db                	xor    %ebx,%ebx
 41a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 cf                	mov    %ecx,%edi
 426:	f7 75 c4             	divl   -0x3c(%ebp)
 429:	0f b6 92 e0 08 00 00 	movzbl 0x8e0(%edx),%edx
 430:	89 45 c0             	mov    %eax,-0x40(%ebp)
 433:	89 d8                	mov    %ebx,%eax
 435:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 438:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 43b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 43e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 441:	76 dd                	jbe    420 <printint+0x30>
  if(neg)
 443:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 446:	85 c9                	test   %ecx,%ecx
 448:	74 0c                	je     456 <printint+0x66>
    buf[i++] = '-';
 44a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 44f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 451:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 456:	8b 7d b8             	mov    -0x48(%ebp),%edi
 459:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 45d:	eb 07                	jmp    466 <printint+0x76>
 45f:	90                   	nop
 460:	0f b6 13             	movzbl (%ebx),%edx
 463:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 466:	83 ec 04             	sub    $0x4,%esp
 469:	88 55 d7             	mov    %dl,-0x29(%ebp)
 46c:	6a 01                	push   $0x1
 46e:	56                   	push   %esi
 46f:	57                   	push   %edi
 470:	e8 8e fe ff ff       	call   303 <write>
  while(--i >= 0)
 475:	83 c4 10             	add    $0x10,%esp
 478:	39 de                	cmp    %ebx,%esi
 47a:	75 e4                	jne    460 <printint+0x70>
    putc(fd, buf[i]);
}
 47c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47f:	5b                   	pop    %ebx
 480:	5e                   	pop    %esi
 481:	5f                   	pop    %edi
 482:	5d                   	pop    %ebp
 483:	c3                   	ret    
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 488:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 48f:	eb 87                	jmp    418 <printint+0x28>
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	f3 0f 1e fb          	endbr32 
 4a4:	55                   	push   %ebp
 4a5:	89 e5                	mov    %esp,%ebp
 4a7:	57                   	push   %edi
 4a8:	56                   	push   %esi
 4a9:	53                   	push   %ebx
 4aa:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ad:	8b 75 0c             	mov    0xc(%ebp),%esi
 4b0:	0f b6 1e             	movzbl (%esi),%ebx
 4b3:	84 db                	test   %bl,%bl
 4b5:	0f 84 b4 00 00 00    	je     56f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4bb:	8d 45 10             	lea    0x10(%ebp),%eax
 4be:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4c1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4c4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4c9:	eb 33                	jmp    4fe <printf+0x5e>
 4cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
 4d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4d3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4d8:	83 f8 25             	cmp    $0x25,%eax
 4db:	74 17                	je     4f4 <printf+0x54>
  write(fd, &c, 1);
 4dd:	83 ec 04             	sub    $0x4,%esp
 4e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4e3:	6a 01                	push   $0x1
 4e5:	57                   	push   %edi
 4e6:	ff 75 08             	pushl  0x8(%ebp)
 4e9:	e8 15 fe ff ff       	call   303 <write>
 4ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4f1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4f4:	0f b6 1e             	movzbl (%esi),%ebx
 4f7:	83 c6 01             	add    $0x1,%esi
 4fa:	84 db                	test   %bl,%bl
 4fc:	74 71                	je     56f <printf+0xcf>
    c = fmt[i] & 0xff;
 4fe:	0f be cb             	movsbl %bl,%ecx
 501:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 504:	85 d2                	test   %edx,%edx
 506:	74 c8                	je     4d0 <printf+0x30>
      }
    } else if(state == '%'){
 508:	83 fa 25             	cmp    $0x25,%edx
 50b:	75 e7                	jne    4f4 <printf+0x54>
      if(c == 'd'){
 50d:	83 f8 64             	cmp    $0x64,%eax
 510:	0f 84 9a 00 00 00    	je     5b0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 516:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 51c:	83 f9 70             	cmp    $0x70,%ecx
 51f:	74 5f                	je     580 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 521:	83 f8 73             	cmp    $0x73,%eax
 524:	0f 84 d6 00 00 00    	je     600 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52a:	83 f8 63             	cmp    $0x63,%eax
 52d:	0f 84 8d 00 00 00    	je     5c0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 533:	83 f8 25             	cmp    $0x25,%eax
 536:	0f 84 b4 00 00 00    	je     5f0 <printf+0x150>
  write(fd, &c, 1);
 53c:	83 ec 04             	sub    $0x4,%esp
 53f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 543:	6a 01                	push   $0x1
 545:	57                   	push   %edi
 546:	ff 75 08             	pushl  0x8(%ebp)
 549:	e8 b5 fd ff ff       	call   303 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 54e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 551:	83 c4 0c             	add    $0xc,%esp
 554:	6a 01                	push   $0x1
 556:	83 c6 01             	add    $0x1,%esi
 559:	57                   	push   %edi
 55a:	ff 75 08             	pushl  0x8(%ebp)
 55d:	e8 a1 fd ff ff       	call   303 <write>
  for(i = 0; fmt[i]; i++){
 562:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 566:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 569:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 56b:	84 db                	test   %bl,%bl
 56d:	75 8f                	jne    4fe <printf+0x5e>
    }
  }
}
 56f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 572:	5b                   	pop    %ebx
 573:	5e                   	pop    %esi
 574:	5f                   	pop    %edi
 575:	5d                   	pop    %ebp
 576:	c3                   	ret    
 577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 10 00 00 00       	mov    $0x10,%ecx
 588:	6a 00                	push   $0x0
 58a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	8b 13                	mov    (%ebx),%edx
 592:	e8 59 fe ff ff       	call   3f0 <printint>
        ap++;
 597:	89 d8                	mov    %ebx,%eax
 599:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59c:	31 d2                	xor    %edx,%edx
        ap++;
 59e:	83 c0 04             	add    $0x4,%eax
 5a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a4:	e9 4b ff ff ff       	jmp    4f4 <printf+0x54>
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	6a 01                	push   $0x1
 5ba:	eb ce                	jmp    58a <printf+0xea>
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5c8:	6a 01                	push   $0x1
        ap++;
 5ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5cd:	57                   	push   %edi
 5ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d4:	e8 2a fd ff ff       	call   303 <write>
        ap++;
 5d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5df:	31 d2                	xor    %edx,%edx
 5e1:	e9 0e ff ff ff       	jmp    4f4 <printf+0x54>
 5e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
 5f6:	e9 59 ff ff ff       	jmp    554 <printf+0xb4>
 5fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
        s = (char*)*ap;
 600:	8b 45 d0             	mov    -0x30(%ebp),%eax
 603:	8b 18                	mov    (%eax),%ebx
        ap++;
 605:	83 c0 04             	add    $0x4,%eax
 608:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 60b:	85 db                	test   %ebx,%ebx
 60d:	74 17                	je     626 <printf+0x186>
        while(*s != 0){
 60f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 612:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 614:	84 c0                	test   %al,%al
 616:	0f 84 d8 fe ff ff    	je     4f4 <printf+0x54>
 61c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 61f:	89 de                	mov    %ebx,%esi
 621:	8b 5d 08             	mov    0x8(%ebp),%ebx
 624:	eb 1a                	jmp    640 <printf+0x1a0>
          s = "(null)";
 626:	bb d7 08 00 00       	mov    $0x8d7,%ebx
        while(*s != 0){
 62b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 62e:	b8 28 00 00 00       	mov    $0x28,%eax
 633:	89 de                	mov    %ebx,%esi
 635:	8b 5d 08             	mov    0x8(%ebp),%ebx
 638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
  write(fd, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
          s++;
 643:	83 c6 01             	add    $0x1,%esi
 646:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 649:	6a 01                	push   $0x1
 64b:	57                   	push   %edi
 64c:	53                   	push   %ebx
 64d:	e8 b1 fc ff ff       	call   303 <write>
        while(*s != 0){
 652:	0f b6 06             	movzbl (%esi),%eax
 655:	83 c4 10             	add    $0x10,%esp
 658:	84 c0                	test   %al,%al
 65a:	75 e4                	jne    640 <printf+0x1a0>
 65c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 65f:	31 d2                	xor    %edx,%edx
 661:	e9 8e fe ff ff       	jmp    4f4 <printf+0x54>
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	f3 0f 1e fb          	endbr32 
 674:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 675:	a1 e0 0b 00 00       	mov    0xbe0,%eax
{
 67a:	89 e5                	mov    %esp,%ebp
 67c:	57                   	push   %edi
 67d:	56                   	push   %esi
 67e:	53                   	push   %ebx
 67f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 682:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 684:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 687:	39 c8                	cmp    %ecx,%eax
 689:	73 15                	jae    6a0 <free+0x30>
 68b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
 690:	39 d1                	cmp    %edx,%ecx
 692:	72 14                	jb     6a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 694:	39 d0                	cmp    %edx,%eax
 696:	73 10                	jae    6a8 <free+0x38>
{
 698:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69a:	8b 10                	mov    (%eax),%edx
 69c:	39 c8                	cmp    %ecx,%eax
 69e:	72 f0                	jb     690 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a0:	39 d0                	cmp    %edx,%eax
 6a2:	72 f4                	jb     698 <free+0x28>
 6a4:	39 d1                	cmp    %edx,%ecx
 6a6:	73 f0                	jae    698 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ae:	39 fa                	cmp    %edi,%edx
 6b0:	74 1e                	je     6d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6b5:	8b 50 04             	mov    0x4(%eax),%edx
 6b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6bb:	39 f1                	cmp    %esi,%ecx
 6bd:	74 28                	je     6e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6c1:	5b                   	pop    %ebx
  freep = p;
 6c2:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 6c7:	5e                   	pop    %esi
 6c8:	5f                   	pop    %edi
 6c9:	5d                   	pop    %ebp
 6ca:	c3                   	ret    
 6cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6d0:	03 72 04             	add    0x4(%edx),%esi
 6d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	8b 10                	mov    (%eax),%edx
 6d8:	8b 12                	mov    (%edx),%edx
 6da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 50 04             	mov    0x4(%eax),%edx
 6e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	75 d8                	jne    6bf <free+0x4f>
    p->s.size += bp->s.size;
 6e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ea:	a3 e0 0b 00 00       	mov    %eax,0xbe0
    p->s.size += bp->s.size;
 6ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6f5:	89 10                	mov    %edx,(%eax)
}
 6f7:	5b                   	pop    %ebx
 6f8:	5e                   	pop    %esi
 6f9:	5f                   	pop    %edi
 6fa:	5d                   	pop    %ebp
 6fb:	c3                   	ret    
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	f3 0f 1e fb          	endbr32 
 704:	55                   	push   %ebp
 705:	89 e5                	mov    %esp,%ebp
 707:	57                   	push   %edi
 708:	56                   	push   %esi
 709:	53                   	push   %ebx
 70a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 710:	8b 3d e0 0b 00 00    	mov    0xbe0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 716:	8d 70 07             	lea    0x7(%eax),%esi
 719:	c1 ee 03             	shr    $0x3,%esi
 71c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 71f:	85 ff                	test   %edi,%edi
 721:	0f 84 a9 00 00 00    	je     7d0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 727:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 729:	8b 48 04             	mov    0x4(%eax),%ecx
 72c:	39 f1                	cmp    %esi,%ecx
 72e:	73 6d                	jae    79d <malloc+0x9d>
 730:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 736:	bb 00 10 00 00       	mov    $0x1000,%ebx
 73b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 73e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 745:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 748:	eb 17                	jmp    761 <malloc+0x61>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 750:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 752:	8b 4a 04             	mov    0x4(%edx),%ecx
 755:	39 f1                	cmp    %esi,%ecx
 757:	73 4f                	jae    7a8 <malloc+0xa8>
 759:	8b 3d e0 0b 00 00    	mov    0xbe0,%edi
 75f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 761:	39 c7                	cmp    %eax,%edi
 763:	75 eb                	jne    750 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 765:	83 ec 0c             	sub    $0xc,%esp
 768:	ff 75 e4             	pushl  -0x1c(%ebp)
 76b:	e8 fb fb ff ff       	call   36b <sbrk>
  if(p == (char*)-1)
 770:	83 c4 10             	add    $0x10,%esp
 773:	83 f8 ff             	cmp    $0xffffffff,%eax
 776:	74 1b                	je     793 <malloc+0x93>
  hp->s.size = nu;
 778:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 77b:	83 ec 0c             	sub    $0xc,%esp
 77e:	83 c0 08             	add    $0x8,%eax
 781:	50                   	push   %eax
 782:	e8 e9 fe ff ff       	call   670 <free>
  return freep;
 787:	a1 e0 0b 00 00       	mov    0xbe0,%eax
      if((p = morecore(nunits)) == 0)
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	85 c0                	test   %eax,%eax
 791:	75 bd                	jne    750 <malloc+0x50>
        return 0;
  }
}
 793:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 796:	31 c0                	xor    %eax,%eax
}
 798:	5b                   	pop    %ebx
 799:	5e                   	pop    %esi
 79a:	5f                   	pop    %edi
 79b:	5d                   	pop    %ebp
 79c:	c3                   	ret    
    if(p->s.size >= nunits){
 79d:	89 c2                	mov    %eax,%edx
 79f:	89 f8                	mov    %edi,%eax
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7a8:	39 ce                	cmp    %ecx,%esi
 7aa:	74 54                	je     800 <malloc+0x100>
        p->s.size -= nunits;
 7ac:	29 f1                	sub    %esi,%ecx
 7ae:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7b1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7b4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7b7:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 7bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7bf:	8d 42 08             	lea    0x8(%edx),%eax
}
 7c2:	5b                   	pop    %ebx
 7c3:	5e                   	pop    %esi
 7c4:	5f                   	pop    %edi
 7c5:	5d                   	pop    %ebp
 7c6:	c3                   	ret    
 7c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ce:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 e0 0b 00 00 e4 	movl   $0xbe4,0xbe0
 7d7:	0b 00 00 
    base.s.size = 0;
 7da:	bf e4 0b 00 00       	mov    $0xbe4,%edi
    base.s.ptr = freep = prevp = &base;
 7df:	c7 05 e4 0b 00 00 e4 	movl   $0xbe4,0xbe4
 7e6:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7eb:	c7 05 e8 0b 00 00 00 	movl   $0x0,0xbe8
 7f2:	00 00 00 
    if(p->s.size >= nunits){
 7f5:	e9 36 ff ff ff       	jmp    730 <malloc+0x30>
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 800:	8b 0a                	mov    (%edx),%ecx
 802:	89 08                	mov    %ecx,(%eax)
 804:	eb b1                	jmp    7b7 <malloc+0xb7>
 806:	66 90                	xchg   %ax,%ax
 808:	66 90                	xchg   %ax,%ax
 80a:	66 90                	xchg   %ax,%ax
 80c:	66 90                	xchg   %ax,%ax
 80e:	66 90                	xchg   %ax,%ax

00000810 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 810:	f3 0f 1e fb          	endbr32 
 814:	55                   	push   %ebp
 815:	89 e5                	mov    %esp,%ebp
 817:	53                   	push   %ebx
 818:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 81b:	68 00 20 00 00       	push   $0x2000
 820:	e8 db fe ff ff       	call   700 <malloc>
    void *stack;

    if (fptr == 0)
 825:	83 c4 10             	add    $0x10,%esp
 828:	85 c0                	test   %eax,%eax
 82a:	74 59                	je     885 <thread_creator+0x75>
 82c:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 82e:	25 ff 0f 00 00       	and    $0xfff,%eax
 833:	75 1b                	jne    850 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 835:	83 ec 0c             	sub    $0xc,%esp
 838:	53                   	push   %ebx
 839:	e8 5d fb ff ff       	call   39b <thread_create>

    if (thread_id < 0)
 83e:	83 c4 10             	add    $0x10,%esp
 841:	85 c0                	test   %eax,%eax
 843:	78 23                	js     868 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 845:	74 45                	je     88c <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 847:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 84a:	c9                   	leave  
 84b:	c3                   	ret    
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 850:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 852:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 855:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 85b:	53                   	push   %ebx
 85c:	e8 3a fb ff ff       	call   39b <thread_create>
    if (thread_id < 0)
 861:	83 c4 10             	add    $0x10,%esp
 864:	85 c0                	test   %eax,%eax
 866:	79 dd                	jns    845 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 868:	83 ec 08             	sub    $0x8,%esp
 86b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 86e:	68 f1 08 00 00       	push   $0x8f1
 873:	6a 01                	push   $0x1
 875:	e8 26 fc ff ff       	call   4a0 <printf>
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 87d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 880:	83 c4 10             	add    $0x10,%esp
 883:	c9                   	leave  
 884:	c3                   	ret    
        return -1;
 885:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 88a:	eb bb                	jmp    847 <thread_creator+0x37>
        (fn)(args);
 88c:	83 ec 0c             	sub    $0xc,%esp
 88f:	ff 75 0c             	pushl  0xc(%ebp)
 892:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 895:	89 1c 24             	mov    %ebx,(%esp)
 898:	e8 d3 fd ff ff       	call   670 <free>
        exit();
 89d:	e8 41 fa ff ff       	call   2e3 <exit>
