
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
  12:	56                   	push   %esi
  13:	be 01 00 00 00       	mov    $0x1,%esi
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 18             	sub    $0x18,%esp
  1d:	8b 01                	mov    (%ecx),%eax
  1f:	8b 59 04             	mov    0x4(%ecx),%ebx
  22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  25:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  28:	83 f8 01             	cmp    $0x1,%eax
  2b:	7e 50                	jle    7d <main+0x7d>
  2d:	8d 76 00             	lea    0x0(%esi),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 77 03 00 00       	call   3b3 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 c7                	mov    %eax,%edi
  41:	85 c0                	test   %eax,%eax
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 3f 03 00 00       	call   39b <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 0a 03 00 00       	call   373 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 57 09 00 00       	push   $0x957
  71:	6a 01                	push   $0x1
  73:	e8 b8 04 00 00       	call   530 <printf>
      exit();
  78:	e8 f6 02 00 00       	call   373 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 e7 02 00 00       	call   373 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	f3 0f 1e fb          	endbr32 
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	56                   	push   %esi
  98:	8b 75 08             	mov    0x8(%ebp),%esi
  9b:	53                   	push   %ebx
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  9c:	eb 19                	jmp    b7 <cat+0x27>
  9e:	66 90                	xchg   %ax,%ax
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 c0 0c 00 00       	push   $0xcc0
  a9:	6a 01                	push   $0x1
  ab:	e8 e3 02 00 00       	call   393 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 c0 0c 00 00       	push   $0xcc0
  c4:	56                   	push   %esi
  c5:	e8 c1 02 00 00       	call   38b <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret    
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 34 09 00 00       	push   $0x934
  e4:	6a 01                	push   $0x1
  e6:	e8 45 04 00 00       	call   530 <printf>
      exit();
  eb:	e8 83 02 00 00       	call   373 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 46 09 00 00       	push   $0x946
  f7:	6a 01                	push   $0x1
  f9:	e8 32 04 00 00       	call   530 <printf>
    exit();
  fe:	e8 70 02 00 00       	call   373 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 115:	31 c0                	xor    %eax,%eax
{
 117:	89 e5                	mov    %esp,%ebp
 119:	53                   	push   %ebx
 11a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 127:	83 c0 01             	add    $0x1,%eax
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	89 c8                	mov    %ecx,%eax
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	53                   	push   %ebx
 148:	8b 4d 08             	mov    0x8(%ebp),%ecx
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 14e:	0f b6 01             	movzbl (%ecx),%eax
 151:	0f b6 1a             	movzbl (%edx),%ebx
 154:	84 c0                	test   %al,%al
 156:	75 19                	jne    171 <strcmp+0x31>
 158:	eb 26                	jmp    180 <strcmp+0x40>
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 160:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 164:	83 c1 01             	add    $0x1,%ecx
 167:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 16a:	0f b6 1a             	movzbl (%edx),%ebx
 16d:	84 c0                	test   %al,%al
 16f:	74 0f                	je     180 <strcmp+0x40>
 171:	38 d8                	cmp    %bl,%al
 173:	74 eb                	je     160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 175:	29 d8                	sub    %ebx,%eax
}
 177:	5b                   	pop    %ebx
 178:	5d                   	pop    %ebp
 179:	c3                   	ret    
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 182:	29 d8                	sub    %ebx,%eax
}
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 19a:	80 3a 00             	cmpb   $0x0,(%edx)
 19d:	74 21                	je     1c0 <strlen+0x30>
 19f:	31 c0                	xor    %eax,%eax
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a8:	83 c0 01             	add    $0x1,%eax
 1ab:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1af:	89 c1                	mov    %eax,%ecx
 1b1:	75 f5                	jne    1a8 <strlen+0x18>
    ;
  return n;
}
 1b3:	89 c8                	mov    %ecx,%eax
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1db:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	89 d7                	mov    %edx,%edi
 1e3:	fc                   	cld    
 1e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e6:	89 d0                	mov    %edx,%eax
 1e8:	5f                   	pop    %edi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fe:	0f b6 10             	movzbl (%eax),%edx
 201:	84 d2                	test   %dl,%dl
 203:	75 16                	jne    21b <strchr+0x2b>
 205:	eb 21                	jmp    228 <strchr+0x38>
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax
 210:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 214:	83 c0 01             	add    $0x1,%eax
 217:	84 d2                	test   %dl,%dl
 219:	74 0d                	je     228 <strchr+0x38>
    if(*s == c)
 21b:	38 d1                	cmp    %dl,%cl
 21d:	75 f1                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 228:	31 c0                	xor    %eax,%eax
}
 22a:	5d                   	pop    %ebp
 22b:	c3                   	ret    
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 239:	31 f6                	xor    %esi,%esi
{
 23b:	53                   	push   %ebx
 23c:	89 f3                	mov    %esi,%ebx
 23e:	83 ec 1c             	sub    $0x1c,%esp
 241:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 244:	eb 33                	jmp    279 <gets+0x49>
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	8d 45 e7             	lea    -0x19(%ebp),%eax
 256:	6a 01                	push   $0x1
 258:	50                   	push   %eax
 259:	6a 00                	push   $0x0
 25b:	e8 2b 01 00 00       	call   38b <read>
    if(cc < 1)
 260:	83 c4 10             	add    $0x10,%esp
 263:	85 c0                	test   %eax,%eax
 265:	7e 1c                	jle    283 <gets+0x53>
      break;
    buf[i++] = c;
 267:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 26b:	83 c7 01             	add    $0x1,%edi
 26e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 271:	3c 0a                	cmp    $0xa,%al
 273:	74 23                	je     298 <gets+0x68>
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 1f                	je     298 <gets+0x68>
  for(i=0; i+1 < max; ){
 279:	83 c3 01             	add    $0x1,%ebx
 27c:	89 fe                	mov    %edi,%esi
 27e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 281:	7c cd                	jl     250 <gets+0x20>
 283:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 285:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 288:	c6 03 00             	movb   $0x0,(%ebx)
}
 28b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28e:	5b                   	pop    %ebx
 28f:	5e                   	pop    %esi
 290:	5f                   	pop    %edi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 297:	90                   	nop
 298:	8b 75 08             	mov    0x8(%ebp),%esi
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	01 de                	add    %ebx,%esi
 2a0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2a2:	c6 03 00             	movb   $0x0,(%ebx)
}
 2a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a8:	5b                   	pop    %ebx
 2a9:	5e                   	pop    %esi
 2aa:	5f                   	pop    %edi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	8d 76 00             	lea    0x0(%esi),%esi

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	56                   	push   %esi
 2b8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	6a 00                	push   $0x0
 2be:	ff 75 08             	pushl  0x8(%ebp)
 2c1:	e8 ed 00 00 00       	call   3b3 <open>
  if(fd < 0)
 2c6:	83 c4 10             	add    $0x10,%esp
 2c9:	85 c0                	test   %eax,%eax
 2cb:	78 2b                	js     2f8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2cd:	83 ec 08             	sub    $0x8,%esp
 2d0:	ff 75 0c             	pushl  0xc(%ebp)
 2d3:	89 c3                	mov    %eax,%ebx
 2d5:	50                   	push   %eax
 2d6:	e8 f0 00 00 00       	call   3cb <fstat>
  close(fd);
 2db:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2de:	89 c6                	mov    %eax,%esi
  close(fd);
 2e0:	e8 b6 00 00 00       	call   39b <close>
  return r;
 2e5:	83 c4 10             	add    $0x10,%esp
}
 2e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2eb:	89 f0                	mov    %esi,%eax
 2ed:	5b                   	pop    %ebx
 2ee:	5e                   	pop    %esi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret    
 2f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2fd:	eb e9                	jmp    2e8 <stat+0x38>
 2ff:	90                   	nop

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	53                   	push   %ebx
 308:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30b:	0f be 02             	movsbl (%edx),%eax
 30e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 311:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 314:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 319:	77 1a                	ja     335 <atoi+0x35>
 31b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 31f:	90                   	nop
    n = n*10 + *s++ - '0';
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	89 c8                	mov    %ecx,%eax
 337:	5b                   	pop    %ebx
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	57                   	push   %edi
 348:	8b 45 10             	mov    0x10(%ebp),%eax
 34b:	8b 55 08             	mov    0x8(%ebp),%edx
 34e:	56                   	push   %esi
 34f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 352:	85 c0                	test   %eax,%eax
 354:	7e 0f                	jle    365 <memmove+0x25>
 356:	01 d0                	add    %edx,%eax
  dst = vdst;
 358:	89 d7                	mov    %edx,%edi
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <getHelloWorld>:
SYSCALL(getHelloWorld)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <getProcCount>:
SYSCALL(getProcCount)
 41b:	b8 17 00 00 00       	mov    $0x17,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <getReadCount>:
SYSCALL(getReadCount)
 423:	b8 18 00 00 00       	mov    $0x18,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <thread_create>:
SYSCALL(thread_create)
 42b:	b8 19 00 00 00       	mov    $0x19,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <join>:
SYSCALL(join)
 433:	b8 1a 00 00 00       	mov    $0x1a,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 43b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <getWaitingTime>:
SYSCALL(getWaitingTime)
 443:	b8 1c 00 00 00       	mov    $0x1c,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 44b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <setPriority>:
SYSCALL(setPriority)
 453:	b8 1e 00 00 00       	mov    $0x1e,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <changePolicy>:
SYSCALL(changePolicy)
 45b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 463:	b8 20 00 00 00       	mov    $0x20,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 46b:	b8 21 00 00 00       	mov    $0x21,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 473:	b8 22 00 00 00       	mov    $0x22,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
 489:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 48c:	89 d1                	mov    %edx,%ecx
{
 48e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 491:	85 d2                	test   %edx,%edx
 493:	0f 89 7f 00 00 00    	jns    518 <printint+0x98>
 499:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49d:	74 79                	je     518 <printint+0x98>
    neg = 1;
 49f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4a6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4a8:	31 db                	xor    %ebx,%ebx
 4aa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b0:	89 c8                	mov    %ecx,%eax
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	89 cf                	mov    %ecx,%edi
 4b6:	f7 75 c4             	divl   -0x3c(%ebp)
 4b9:	0f b6 92 74 09 00 00 	movzbl 0x974(%edx),%edx
 4c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4c3:	89 d8                	mov    %ebx,%eax
 4c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4c8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4cb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4ce:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4d1:	76 dd                	jbe    4b0 <printint+0x30>
  if(neg)
 4d3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4d6:	85 c9                	test   %ecx,%ecx
 4d8:	74 0c                	je     4e6 <printint+0x66>
    buf[i++] = '-';
 4da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4df:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4e1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4e6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4e9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4ed:	eb 07                	jmp    4f6 <printint+0x76>
 4ef:	90                   	nop
 4f0:	0f b6 13             	movzbl (%ebx),%edx
 4f3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4f6:	83 ec 04             	sub    $0x4,%esp
 4f9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4fc:	6a 01                	push   $0x1
 4fe:	56                   	push   %esi
 4ff:	57                   	push   %edi
 500:	e8 8e fe ff ff       	call   393 <write>
  while(--i >= 0)
 505:	83 c4 10             	add    $0x10,%esp
 508:	39 de                	cmp    %ebx,%esi
 50a:	75 e4                	jne    4f0 <printint+0x70>
    putc(fd, buf[i]);
}
 50c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret    
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 518:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 51f:	eb 87                	jmp    4a8 <printint+0x28>
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 530:	f3 0f 1e fb          	endbr32 
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	57                   	push   %edi
 538:	56                   	push   %esi
 539:	53                   	push   %ebx
 53a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 53d:	8b 75 0c             	mov    0xc(%ebp),%esi
 540:	0f b6 1e             	movzbl (%esi),%ebx
 543:	84 db                	test   %bl,%bl
 545:	0f 84 b4 00 00 00    	je     5ff <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 54b:	8d 45 10             	lea    0x10(%ebp),%eax
 54e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 551:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 554:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 556:	89 45 d0             	mov    %eax,-0x30(%ebp)
 559:	eb 33                	jmp    58e <printf+0x5e>
 55b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop
 560:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 563:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 568:	83 f8 25             	cmp    $0x25,%eax
 56b:	74 17                	je     584 <printf+0x54>
  write(fd, &c, 1);
 56d:	83 ec 04             	sub    $0x4,%esp
 570:	88 5d e7             	mov    %bl,-0x19(%ebp)
 573:	6a 01                	push   $0x1
 575:	57                   	push   %edi
 576:	ff 75 08             	pushl  0x8(%ebp)
 579:	e8 15 fe ff ff       	call   393 <write>
 57e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 581:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 584:	0f b6 1e             	movzbl (%esi),%ebx
 587:	83 c6 01             	add    $0x1,%esi
 58a:	84 db                	test   %bl,%bl
 58c:	74 71                	je     5ff <printf+0xcf>
    c = fmt[i] & 0xff;
 58e:	0f be cb             	movsbl %bl,%ecx
 591:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 594:	85 d2                	test   %edx,%edx
 596:	74 c8                	je     560 <printf+0x30>
      }
    } else if(state == '%'){
 598:	83 fa 25             	cmp    $0x25,%edx
 59b:	75 e7                	jne    584 <printf+0x54>
      if(c == 'd'){
 59d:	83 f8 64             	cmp    $0x64,%eax
 5a0:	0f 84 9a 00 00 00    	je     640 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5a6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5ac:	83 f9 70             	cmp    $0x70,%ecx
 5af:	74 5f                	je     610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5b1:	83 f8 73             	cmp    $0x73,%eax
 5b4:	0f 84 d6 00 00 00    	je     690 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ba:	83 f8 63             	cmp    $0x63,%eax
 5bd:	0f 84 8d 00 00 00    	je     650 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5c3:	83 f8 25             	cmp    $0x25,%eax
 5c6:	0f 84 b4 00 00 00    	je     680 <printf+0x150>
  write(fd, &c, 1);
 5cc:	83 ec 04             	sub    $0x4,%esp
 5cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5d3:	6a 01                	push   $0x1
 5d5:	57                   	push   %edi
 5d6:	ff 75 08             	pushl  0x8(%ebp)
 5d9:	e8 b5 fd ff ff       	call   393 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5de:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5e1:	83 c4 0c             	add    $0xc,%esp
 5e4:	6a 01                	push   $0x1
 5e6:	83 c6 01             	add    $0x1,%esi
 5e9:	57                   	push   %edi
 5ea:	ff 75 08             	pushl  0x8(%ebp)
 5ed:	e8 a1 fd ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 5f2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5f6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5fb:	84 db                	test   %bl,%bl
 5fd:	75 8f                	jne    58e <printf+0x5e>
    }
  }
}
 5ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 602:	5b                   	pop    %ebx
 603:	5e                   	pop    %esi
 604:	5f                   	pop    %edi
 605:	5d                   	pop    %ebp
 606:	c3                   	ret    
 607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 10 00 00 00       	mov    $0x10,%ecx
 618:	6a 00                	push   $0x0
 61a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 61d:	8b 45 08             	mov    0x8(%ebp),%eax
 620:	8b 13                	mov    (%ebx),%edx
 622:	e8 59 fe ff ff       	call   480 <printint>
        ap++;
 627:	89 d8                	mov    %ebx,%eax
 629:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62c:	31 d2                	xor    %edx,%edx
        ap++;
 62e:	83 c0 04             	add    $0x4,%eax
 631:	89 45 d0             	mov    %eax,-0x30(%ebp)
 634:	e9 4b ff ff ff       	jmp    584 <printf+0x54>
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 0a 00 00 00       	mov    $0xa,%ecx
 648:	6a 01                	push   $0x1
 64a:	eb ce                	jmp    61a <printf+0xea>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 650:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 653:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 656:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 658:	6a 01                	push   $0x1
        ap++;
 65a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 65d:	57                   	push   %edi
 65e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 661:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 664:	e8 2a fd ff ff       	call   393 <write>
        ap++;
 669:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 66c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 0e ff ff ff       	jmp    584 <printf+0x54>
 676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 680:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
 686:	e9 59 ff ff ff       	jmp    5e4 <printf+0xb4>
 68b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop
        s = (char*)*ap;
 690:	8b 45 d0             	mov    -0x30(%ebp),%eax
 693:	8b 18                	mov    (%eax),%ebx
        ap++;
 695:	83 c0 04             	add    $0x4,%eax
 698:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 69b:	85 db                	test   %ebx,%ebx
 69d:	74 17                	je     6b6 <printf+0x186>
        while(*s != 0){
 69f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6a2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6a4:	84 c0                	test   %al,%al
 6a6:	0f 84 d8 fe ff ff    	je     584 <printf+0x54>
 6ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6af:	89 de                	mov    %ebx,%esi
 6b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6b4:	eb 1a                	jmp    6d0 <printf+0x1a0>
          s = "(null)";
 6b6:	bb 6c 09 00 00       	mov    $0x96c,%ebx
        while(*s != 0){
 6bb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6be:	b8 28 00 00 00       	mov    $0x28,%eax
 6c3:	89 de                	mov    %ebx,%esi
 6c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
  write(fd, &c, 1);
 6d0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6d3:	83 c6 01             	add    $0x1,%esi
 6d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d9:	6a 01                	push   $0x1
 6db:	57                   	push   %edi
 6dc:	53                   	push   %ebx
 6dd:	e8 b1 fc ff ff       	call   393 <write>
        while(*s != 0){
 6e2:	0f b6 06             	movzbl (%esi),%eax
 6e5:	83 c4 10             	add    $0x10,%esp
 6e8:	84 c0                	test   %al,%al
 6ea:	75 e4                	jne    6d0 <printf+0x1a0>
 6ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6ef:	31 d2                	xor    %edx,%edx
 6f1:	e9 8e fe ff ff       	jmp    584 <printf+0x54>
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	f3 0f 1e fb          	endbr32 
 704:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 705:	a1 a0 0c 00 00       	mov    0xca0,%eax
{
 70a:	89 e5                	mov    %esp,%ebp
 70c:	57                   	push   %edi
 70d:	56                   	push   %esi
 70e:	53                   	push   %ebx
 70f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 712:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 714:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 717:	39 c8                	cmp    %ecx,%eax
 719:	73 15                	jae    730 <free+0x30>
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
 720:	39 d1                	cmp    %edx,%ecx
 722:	72 14                	jb     738 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	39 d0                	cmp    %edx,%eax
 726:	73 10                	jae    738 <free+0x38>
{
 728:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	8b 10                	mov    (%eax),%edx
 72c:	39 c8                	cmp    %ecx,%eax
 72e:	72 f0                	jb     720 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	39 d0                	cmp    %edx,%eax
 732:	72 f4                	jb     728 <free+0x28>
 734:	39 d1                	cmp    %edx,%ecx
 736:	73 f0                	jae    728 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 738:	8b 73 fc             	mov    -0x4(%ebx),%esi
 73b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 73e:	39 fa                	cmp    %edi,%edx
 740:	74 1e                	je     760 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 742:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 745:	8b 50 04             	mov    0x4(%eax),%edx
 748:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 74b:	39 f1                	cmp    %esi,%ecx
 74d:	74 28                	je     777 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 74f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 751:	5b                   	pop    %ebx
  freep = p;
 752:	a3 a0 0c 00 00       	mov    %eax,0xca0
}
 757:	5e                   	pop    %esi
 758:	5f                   	pop    %edi
 759:	5d                   	pop    %ebp
 75a:	c3                   	ret    
 75b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 760:	03 72 04             	add    0x4(%edx),%esi
 763:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 766:	8b 10                	mov    (%eax),%edx
 768:	8b 12                	mov    (%edx),%edx
 76a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 76d:	8b 50 04             	mov    0x4(%eax),%edx
 770:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	75 d8                	jne    74f <free+0x4f>
    p->s.size += bp->s.size;
 777:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 77a:	a3 a0 0c 00 00       	mov    %eax,0xca0
    p->s.size += bp->s.size;
 77f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 782:	8b 53 f8             	mov    -0x8(%ebx),%edx
 785:	89 10                	mov    %edx,(%eax)
}
 787:	5b                   	pop    %ebx
 788:	5e                   	pop    %esi
 789:	5f                   	pop    %edi
 78a:	5d                   	pop    %ebp
 78b:	c3                   	ret    
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	f3 0f 1e fb          	endbr32 
 794:	55                   	push   %ebp
 795:	89 e5                	mov    %esp,%ebp
 797:	57                   	push   %edi
 798:	56                   	push   %esi
 799:	53                   	push   %ebx
 79a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7a0:	8b 3d a0 0c 00 00    	mov    0xca0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	8d 70 07             	lea    0x7(%eax),%esi
 7a9:	c1 ee 03             	shr    $0x3,%esi
 7ac:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7af:	85 ff                	test   %edi,%edi
 7b1:	0f 84 a9 00 00 00    	je     860 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7b9:	8b 48 04             	mov    0x4(%eax),%ecx
 7bc:	39 f1                	cmp    %esi,%ecx
 7be:	73 6d                	jae    82d <malloc+0x9d>
 7c0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7c6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7cb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ce:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7d5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7d8:	eb 17                	jmp    7f1 <malloc+0x61>
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7e5:	39 f1                	cmp    %esi,%ecx
 7e7:	73 4f                	jae    838 <malloc+0xa8>
 7e9:	8b 3d a0 0c 00 00    	mov    0xca0,%edi
 7ef:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f1:	39 c7                	cmp    %eax,%edi
 7f3:	75 eb                	jne    7e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7f5:	83 ec 0c             	sub    $0xc,%esp
 7f8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7fb:	e8 fb fb ff ff       	call   3fb <sbrk>
  if(p == (char*)-1)
 800:	83 c4 10             	add    $0x10,%esp
 803:	83 f8 ff             	cmp    $0xffffffff,%eax
 806:	74 1b                	je     823 <malloc+0x93>
  hp->s.size = nu;
 808:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 80b:	83 ec 0c             	sub    $0xc,%esp
 80e:	83 c0 08             	add    $0x8,%eax
 811:	50                   	push   %eax
 812:	e8 e9 fe ff ff       	call   700 <free>
  return freep;
 817:	a1 a0 0c 00 00       	mov    0xca0,%eax
      if((p = morecore(nunits)) == 0)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	85 c0                	test   %eax,%eax
 821:	75 bd                	jne    7e0 <malloc+0x50>
        return 0;
  }
}
 823:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 826:	31 c0                	xor    %eax,%eax
}
 828:	5b                   	pop    %ebx
 829:	5e                   	pop    %esi
 82a:	5f                   	pop    %edi
 82b:	5d                   	pop    %ebp
 82c:	c3                   	ret    
    if(p->s.size >= nunits){
 82d:	89 c2                	mov    %eax,%edx
 82f:	89 f8                	mov    %edi,%eax
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 838:	39 ce                	cmp    %ecx,%esi
 83a:	74 54                	je     890 <malloc+0x100>
        p->s.size -= nunits;
 83c:	29 f1                	sub    %esi,%ecx
 83e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 841:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 844:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 847:	a3 a0 0c 00 00       	mov    %eax,0xca0
}
 84c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 84f:	8d 42 08             	lea    0x8(%edx),%eax
}
 852:	5b                   	pop    %ebx
 853:	5e                   	pop    %esi
 854:	5f                   	pop    %edi
 855:	5d                   	pop    %ebp
 856:	c3                   	ret    
 857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 860:	c7 05 a0 0c 00 00 a4 	movl   $0xca4,0xca0
 867:	0c 00 00 
    base.s.size = 0;
 86a:	bf a4 0c 00 00       	mov    $0xca4,%edi
    base.s.ptr = freep = prevp = &base;
 86f:	c7 05 a4 0c 00 00 a4 	movl   $0xca4,0xca4
 876:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 879:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 87b:	c7 05 a8 0c 00 00 00 	movl   $0x0,0xca8
 882:	00 00 00 
    if(p->s.size >= nunits){
 885:	e9 36 ff ff ff       	jmp    7c0 <malloc+0x30>
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 890:	8b 0a                	mov    (%edx),%ecx
 892:	89 08                	mov    %ecx,(%eax)
 894:	eb b1                	jmp    847 <malloc+0xb7>
 896:	66 90                	xchg   %ax,%ax
 898:	66 90                	xchg   %ax,%ax
 89a:	66 90                	xchg   %ax,%ax
 89c:	66 90                	xchg   %ax,%ax
 89e:	66 90                	xchg   %ax,%ax

000008a0 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 8a0:	f3 0f 1e fb          	endbr32 
 8a4:	55                   	push   %ebp
 8a5:	89 e5                	mov    %esp,%ebp
 8a7:	53                   	push   %ebx
 8a8:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 8ab:	68 00 20 00 00       	push   $0x2000
 8b0:	e8 db fe ff ff       	call   790 <malloc>
    void *stack;

    if (fptr == 0)
 8b5:	83 c4 10             	add    $0x10,%esp
 8b8:	85 c0                	test   %eax,%eax
 8ba:	74 59                	je     915 <thread_creator+0x75>
 8bc:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 8be:	25 ff 0f 00 00       	and    $0xfff,%eax
 8c3:	75 1b                	jne    8e0 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 8c5:	83 ec 0c             	sub    $0xc,%esp
 8c8:	53                   	push   %ebx
 8c9:	e8 5d fb ff ff       	call   42b <thread_create>

    if (thread_id < 0)
 8ce:	83 c4 10             	add    $0x10,%esp
 8d1:	85 c0                	test   %eax,%eax
 8d3:	78 23                	js     8f8 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 8d5:	74 45                	je     91c <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 8d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8da:	c9                   	leave  
 8db:	c3                   	ret    
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 8e0:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 8e2:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 8e5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 8eb:	53                   	push   %ebx
 8ec:	e8 3a fb ff ff       	call   42b <thread_create>
    if (thread_id < 0)
 8f1:	83 c4 10             	add    $0x10,%esp
 8f4:	85 c0                	test   %eax,%eax
 8f6:	79 dd                	jns    8d5 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 8f8:	83 ec 08             	sub    $0x8,%esp
 8fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8fe:	68 85 09 00 00       	push   $0x985
 903:	6a 01                	push   $0x1
 905:	e8 26 fc ff ff       	call   530 <printf>
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 90d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 910:	83 c4 10             	add    $0x10,%esp
 913:	c9                   	leave  
 914:	c3                   	ret    
        return -1;
 915:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 91a:	eb bb                	jmp    8d7 <thread_creator+0x37>
        (fn)(args);
 91c:	83 ec 0c             	sub    $0xc,%esp
 91f:	ff 75 0c             	pushl  0xc(%ebp)
 922:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 925:	89 1c 24             	mov    %ebx,(%esp)
 928:	e8 d3 fd ff ff       	call   700 <free>
        exit();
 92d:	e8 41 fa ff ff       	call   373 <exit>
