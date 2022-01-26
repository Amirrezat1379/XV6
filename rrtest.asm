
_rrtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define NUM 6
// int stack[4096] __attribute__ ((aligned (4096)));
int stack[4096] __attribute__ ((aligned (4096)));

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
    changePolicy(0);
    int main_pid = getpid();
  14:	bb 06 00 00 00       	mov    $0x6,%ebx
{
  19:	51                   	push   %ecx
  1a:	83 ec 24             	sub    $0x24,%esp
    changePolicy(0);
  1d:	6a 00                	push   $0x0
  1f:	e8 a7 04 00 00       	call   4cb <changePolicy>
    int main_pid = getpid();
  24:	e8 3a 04 00 00       	call   463 <getpid>
  29:	83 c4 10             	add    $0x10,%esp
  2c:	89 c6                	mov    %eax,%esi


    //make NUM child process
    for (int i = 0; i < NUM; i++)
    {
        if (fork() > 0)
  2e:	e8 a8 03 00 00       	call   3db <fork>
  33:	85 c0                	test   %eax,%eax
  35:	7f 05                	jg     3c <main+0x3c>
    for (int i = 0; i < NUM; i++)
  37:	83 eb 01             	sub    $0x1,%ebx
  3a:	75 f2                	jne    2e <main+0x2e>
            break;
    }

    if (main_pid != getpid())
  3c:	e8 22 04 00 00       	call   463 <getpid>
  41:	39 f0                	cmp    %esi,%eax
  43:	0f 84 d8 00 00 00    	je     121 <main+0x121>
    {
        //print pid with i
        for (int i = 0; i < 8; i++){
  49:	31 db                	xor    %ebx,%ebx
  4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  4f:	90                   	nop
            int pid = getpid();
  50:	e8 0e 04 00 00       	call   463 <getpid>
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  55:	53                   	push   %ebx
        for (int i = 0; i < 8; i++){
  56:	83 c3 01             	add    $0x1,%ebx
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  59:	50                   	push   %eax
  5a:	68 a4 09 00 00       	push   $0x9a4
  5f:	6a 01                	push   $0x1
  61:	e8 3a 05 00 00       	call   5a0 <printf>
        for (int i = 0; i < 8; i++){
  66:	83 c4 10             	add    $0x10,%esp
  69:	83 fb 08             	cmp    $0x8,%ebx
  6c:	75 e2                	jne    50 <main+0x50>
        }

        int thisPid = getpid(); 
  6e:	e8 f0 03 00 00       	call   463 <getpid>
        int turnAroundTime = getTurnaroundTime(thisPid);
  73:	83 ec 0c             	sub    $0xc,%esp
  76:	50                   	push   %eax
        int thisPid = getpid(); 
  77:	89 c3                	mov    %eax,%ebx
        int turnAroundTime = getTurnaroundTime(thisPid);
  79:	e8 2d 04 00 00       	call   4ab <getTurnaroundTime>
        int waitingTime = getWaitingTime(thisPid);
  7e:	89 1c 24             	mov    %ebx,(%esp)
        int turnAroundTime = getTurnaroundTime(thisPid);
  81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        int waitingTime = getWaitingTime(thisPid);
  84:	e8 2a 04 00 00       	call   4b3 <getWaitingTime>
        int cbpTime = getCpuBurstTime(thisPid);
  89:	89 1c 24             	mov    %ebx,(%esp)
        int waitingTime = getWaitingTime(thisPid);
  8c:	89 c7                	mov    %eax,%edi
        int cbpTime = getCpuBurstTime(thisPid);
  8e:	e8 28 04 00 00       	call   4bb <getCpuBurstTime>
  93:	89 c6                	mov    %eax,%esi
        wait();
  95:	e8 51 03 00 00       	call   3eb <wait>
        printf(1,"cccccccccccppppptttttttttt %d\n",cbpTime);
  9a:	83 c4 0c             	add    $0xc,%esp
  9d:	56                   	push   %esi
  9e:	68 94 0a 00 00       	push   $0xa94
  a3:	6a 01                	push   $0x1
  a5:	e8 f6 04 00 00       	call   5a0 <printf>
        sum=cbpTime;
        s[0] += sum;

        printf(1,"cccccccccccppppptttttttttt suuummmm %d\n",sum);
  aa:	83 c4 0c             	add    $0xc,%esp
  ad:	56                   	push   %esi
  ae:	68 b4 0a 00 00       	push   $0xab4
  b3:	6a 01                	push   $0x1
  b5:	e8 e6 04 00 00       	call   5a0 <printf>


        printf(1, " Process ID : %d\n", thisPid);
  ba:	83 c4 0c             	add    $0xc,%esp
  bd:	53                   	push   %ebx
  be:	68 b7 09 00 00       	push   $0x9b7
  c3:	6a 01                	push   $0x1
  c5:	e8 d6 04 00 00       	call   5a0 <printf>
        printf(1,"--------------------------\n");
  ca:	59                   	pop    %ecx
  cb:	5b                   	pop    %ebx
  cc:	68 c9 09 00 00       	push   $0x9c9
  d1:	6a 01                	push   $0x1
  d3:	e8 c8 04 00 00       	call   5a0 <printf>
        printf(1, "| TurnAround Time = %d  | \n", turnAroundTime);
  d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  db:	83 c4 0c             	add    $0xc,%esp
  de:	52                   	push   %edx
  df:	68 e5 09 00 00       	push   $0x9e5
  e4:	6a 01                	push   $0x1
  e6:	e8 b5 04 00 00       	call   5a0 <printf>
        printf(1, "| Waiting Time = %d     | \n", waitingTime);
  eb:	83 c4 0c             	add    $0xc,%esp
  ee:	57                   	push   %edi
  ef:	68 01 0a 00 00       	push   $0xa01
  f4:	6a 01                	push   $0x1
  f6:	e8 a5 04 00 00       	call   5a0 <printf>
        printf(1, "| CPU Burst Time = %d    | \n", cbpTime);
  fb:	83 c4 0c             	add    $0xc,%esp
  fe:	56                   	push   %esi
  ff:	68 1d 0a 00 00       	push   $0xa1d
 104:	6a 01                	push   $0x1
 106:	e8 95 04 00 00       	call   5a0 <printf>
        printf(1, "\n\n");
 10b:	5e                   	pop    %esi
 10c:	5f                   	pop    %edi
 10d:	68 3a 0a 00 00       	push   $0xa3a
 112:	6a 01                	push   $0x1
 114:	e8 87 04 00 00       	call   5a0 <printf>
 119:	83 c4 10             	add    $0x10,%esp

    //wait to finish
    // wait();

    
    exit();
 11c:	e8 c2 02 00 00       	call   3e3 <exit>
        wait();
 121:	e8 c5 02 00 00       	call   3eb <wait>
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
 126:	bb 06 00 00 00       	mov    $0x6,%ebx
 12b:	e8 a3 03 00 00       	call   4d3 <getAllTurnTime>
 130:	52                   	push   %edx
 131:	99                   	cltd   
 132:	f7 fb                	idiv   %ebx
 134:	50                   	push   %eax
 135:	68 3d 0a 00 00       	push   $0xa3d
 13a:	6a 01                	push   $0x1
 13c:	e8 5f 04 00 00       	call   5a0 <printf>
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
 141:	e8 95 03 00 00       	call   4db <getAllWaitingTime>
 146:	83 c4 0c             	add    $0xc,%esp
 149:	99                   	cltd   
 14a:	f7 fb                	idiv   %ebx
 14c:	50                   	push   %eax
 14d:	68 5b 0a 00 00       	push   $0xa5b
 152:	6a 01                	push   $0x1
 154:	e8 47 04 00 00       	call   5a0 <printf>
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
 159:	e8 85 03 00 00       	call   4e3 <getAllRunningTime>
 15e:	83 c4 0c             	add    $0xc,%esp
 161:	99                   	cltd   
 162:	f7 fb                	idiv   %ebx
 164:	50                   	push   %eax
 165:	68 76 0a 00 00       	push   $0xa76
 16a:	6a 01                	push   $0x1
 16c:	e8 2f 04 00 00       	call   5a0 <printf>
 171:	83 c4 10             	add    $0x10,%esp
 174:	eb a6                	jmp    11c <main+0x11c>
 176:	66 90                	xchg   %ax,%ax
 178:	66 90                	xchg   %ax,%ax
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 185:	31 c0                	xor    %eax,%eax
{
 187:	89 e5                	mov    %esp,%ebp
 189:	53                   	push   %ebx
 18a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 18d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	89 c8                	mov    %ecx,%eax
 1a0:	5b                   	pop    %ebx
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	53                   	push   %ebx
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1be:	0f b6 01             	movzbl (%ecx),%eax
 1c1:	0f b6 1a             	movzbl (%edx),%ebx
 1c4:	84 c0                	test   %al,%al
 1c6:	75 19                	jne    1e1 <strcmp+0x31>
 1c8:	eb 26                	jmp    1f0 <strcmp+0x40>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1d4:	83 c1 01             	add    $0x1,%ecx
 1d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1da:	0f b6 1a             	movzbl (%edx),%ebx
 1dd:	84 c0                	test   %al,%al
 1df:	74 0f                	je     1f0 <strcmp+0x40>
 1e1:	38 d8                	cmp    %bl,%al
 1e3:	74 eb                	je     1d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1e5:	29 d8                	sub    %ebx,%eax
}
 1e7:	5b                   	pop    %ebx
 1e8:	5d                   	pop    %ebp
 1e9:	c3                   	ret    
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	f3 0f 1e fb          	endbr32 
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 20a:	80 3a 00             	cmpb   $0x0,(%edx)
 20d:	74 21                	je     230 <strlen+0x30>
 20f:	31 c0                	xor    %eax,%eax
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 218:	83 c0 01             	add    $0x1,%eax
 21b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 21f:	89 c1                	mov    %eax,%ecx
 221:	75 f5                	jne    218 <strlen+0x18>
    ;
  return n;
}
 223:	89 c8                	mov    %ecx,%eax
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret    
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	f3 0f 1e fb          	endbr32 
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	57                   	push   %edi
 248:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 24b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	89 d7                	mov    %edx,%edi
 253:	fc                   	cld    
 254:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 256:	89 d0                	mov    %edx,%eax
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	8b 45 08             	mov    0x8(%ebp),%eax
 26a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26e:	0f b6 10             	movzbl (%eax),%edx
 271:	84 d2                	test   %dl,%dl
 273:	75 16                	jne    28b <strchr+0x2b>
 275:	eb 21                	jmp    298 <strchr+0x38>
 277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27e:	66 90                	xchg   %ax,%ax
 280:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 284:	83 c0 01             	add    $0x1,%eax
 287:	84 d2                	test   %dl,%dl
 289:	74 0d                	je     298 <strchr+0x38>
    if(*s == c)
 28b:	38 d1                	cmp    %dl,%cl
 28d:	75 f1                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
}
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
 291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 298:	31 c0                	xor    %eax,%eax
}
 29a:	5d                   	pop    %ebp
 29b:	c3                   	ret    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	f3 0f 1e fb          	endbr32 
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	57                   	push   %edi
 2a8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a9:	31 f6                	xor    %esi,%esi
{
 2ab:	53                   	push   %ebx
 2ac:	89 f3                	mov    %esi,%ebx
 2ae:	83 ec 1c             	sub    $0x1c,%esp
 2b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2b4:	eb 33                	jmp    2e9 <gets+0x49>
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2c6:	6a 01                	push   $0x1
 2c8:	50                   	push   %eax
 2c9:	6a 00                	push   $0x0
 2cb:	e8 2b 01 00 00       	call   3fb <read>
    if(cc < 1)
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	85 c0                	test   %eax,%eax
 2d5:	7e 1c                	jle    2f3 <gets+0x53>
      break;
    buf[i++] = c;
 2d7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2db:	83 c7 01             	add    $0x1,%edi
 2de:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2e1:	3c 0a                	cmp    $0xa,%al
 2e3:	74 23                	je     308 <gets+0x68>
 2e5:	3c 0d                	cmp    $0xd,%al
 2e7:	74 1f                	je     308 <gets+0x68>
  for(i=0; i+1 < max; ){
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	89 fe                	mov    %edi,%esi
 2ee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2f1:	7c cd                	jl     2c0 <gets+0x20>
 2f3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2f8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fe:	5b                   	pop    %ebx
 2ff:	5e                   	pop    %esi
 300:	5f                   	pop    %edi
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 307:	90                   	nop
 308:	8b 75 08             	mov    0x8(%ebp),%esi
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	01 de                	add    %ebx,%esi
 310:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 312:	c6 03 00             	movb   $0x0,(%ebx)
}
 315:	8d 65 f4             	lea    -0xc(%ebp),%esp
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	5f                   	pop    %edi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	56                   	push   %esi
 328:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	6a 00                	push   $0x0
 32e:	ff 75 08             	pushl  0x8(%ebp)
 331:	e8 ed 00 00 00       	call   423 <open>
  if(fd < 0)
 336:	83 c4 10             	add    $0x10,%esp
 339:	85 c0                	test   %eax,%eax
 33b:	78 2b                	js     368 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 33d:	83 ec 08             	sub    $0x8,%esp
 340:	ff 75 0c             	pushl  0xc(%ebp)
 343:	89 c3                	mov    %eax,%ebx
 345:	50                   	push   %eax
 346:	e8 f0 00 00 00       	call   43b <fstat>
  close(fd);
 34b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 34e:	89 c6                	mov    %eax,%esi
  close(fd);
 350:	e8 b6 00 00 00       	call   40b <close>
  return r;
 355:	83 c4 10             	add    $0x10,%esp
}
 358:	8d 65 f8             	lea    -0x8(%ebp),%esp
 35b:	89 f0                	mov    %esi,%eax
 35d:	5b                   	pop    %ebx
 35e:	5e                   	pop    %esi
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 368:	be ff ff ff ff       	mov    $0xffffffff,%esi
 36d:	eb e9                	jmp    358 <stat+0x38>
 36f:	90                   	nop

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	53                   	push   %ebx
 378:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37b:	0f be 02             	movsbl (%edx),%eax
 37e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 381:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 384:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 389:	77 1a                	ja     3a5 <atoi+0x35>
 38b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 38f:	90                   	nop
    n = n*10 + *s++ - '0';
 390:	83 c2 01             	add    $0x1,%edx
 393:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 396:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 39a:	0f be 02             	movsbl (%edx),%eax
 39d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	89 c8                	mov    %ecx,%eax
 3a7:	5b                   	pop    %ebx
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	f3 0f 1e fb          	endbr32 
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	57                   	push   %edi
 3b8:	8b 45 10             	mov    0x10(%ebp),%eax
 3bb:	8b 55 08             	mov    0x8(%ebp),%edx
 3be:	56                   	push   %esi
 3bf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3c2:	85 c0                	test   %eax,%eax
 3c4:	7e 0f                	jle    3d5 <memmove+0x25>
 3c6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3c8:	89 d7                	mov    %edx,%edi
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3db:	b8 01 00 00 00       	mov    $0x1,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <exit>:
SYSCALL(exit)
 3e3:	b8 02 00 00 00       	mov    $0x2,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <wait>:
SYSCALL(wait)
 3eb:	b8 03 00 00 00       	mov    $0x3,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <pipe>:
SYSCALL(pipe)
 3f3:	b8 04 00 00 00       	mov    $0x4,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <read>:
SYSCALL(read)
 3fb:	b8 05 00 00 00       	mov    $0x5,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <write>:
SYSCALL(write)
 403:	b8 10 00 00 00       	mov    $0x10,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <close>:
SYSCALL(close)
 40b:	b8 15 00 00 00       	mov    $0x15,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <kill>:
SYSCALL(kill)
 413:	b8 06 00 00 00       	mov    $0x6,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exec>:
SYSCALL(exec)
 41b:	b8 07 00 00 00       	mov    $0x7,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <open>:
SYSCALL(open)
 423:	b8 0f 00 00 00       	mov    $0xf,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <mknod>:
SYSCALL(mknod)
 42b:	b8 11 00 00 00       	mov    $0x11,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <unlink>:
SYSCALL(unlink)
 433:	b8 12 00 00 00       	mov    $0x12,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <fstat>:
SYSCALL(fstat)
 43b:	b8 08 00 00 00       	mov    $0x8,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <link>:
SYSCALL(link)
 443:	b8 13 00 00 00       	mov    $0x13,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mkdir>:
SYSCALL(mkdir)
 44b:	b8 14 00 00 00       	mov    $0x14,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <chdir>:
SYSCALL(chdir)
 453:	b8 09 00 00 00       	mov    $0x9,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <dup>:
SYSCALL(dup)
 45b:	b8 0a 00 00 00       	mov    $0xa,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getpid>:
SYSCALL(getpid)
 463:	b8 0b 00 00 00       	mov    $0xb,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <sbrk>:
SYSCALL(sbrk)
 46b:	b8 0c 00 00 00       	mov    $0xc,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sleep>:
SYSCALL(sleep)
 473:	b8 0d 00 00 00       	mov    $0xd,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <uptime>:
SYSCALL(uptime)
 47b:	b8 0e 00 00 00       	mov    $0xe,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <getHelloWorld>:
SYSCALL(getHelloWorld)
 483:	b8 16 00 00 00       	mov    $0x16,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <getProcCount>:
SYSCALL(getProcCount)
 48b:	b8 17 00 00 00       	mov    $0x17,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <getReadCount>:
SYSCALL(getReadCount)
 493:	b8 18 00 00 00       	mov    $0x18,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <thread_create>:
SYSCALL(thread_create)
 49b:	b8 19 00 00 00       	mov    $0x19,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <join>:
SYSCALL(join)
 4a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 4ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getWaitingTime>:
SYSCALL(getWaitingTime)
 4b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 4bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <setPriority>:
SYSCALL(setPriority)
 4c3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <changePolicy>:
SYSCALL(changePolicy)
 4cb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 4d3:	b8 20 00 00 00       	mov    $0x20,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 4db:	b8 21 00 00 00       	mov    $0x21,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 4e3:	b8 22 00 00 00       	mov    $0x22,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    
 4eb:	66 90                	xchg   %ax,%ax
 4ed:	66 90                	xchg   %ax,%ax
 4ef:	90                   	nop

000004f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 3c             	sub    $0x3c,%esp
 4f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4fc:	89 d1                	mov    %edx,%ecx
{
 4fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 501:	85 d2                	test   %edx,%edx
 503:	0f 89 7f 00 00 00    	jns    588 <printint+0x98>
 509:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 50d:	74 79                	je     588 <printint+0x98>
    neg = 1;
 50f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 516:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 518:	31 db                	xor    %ebx,%ebx
 51a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 51d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 520:	89 c8                	mov    %ecx,%eax
 522:	31 d2                	xor    %edx,%edx
 524:	89 cf                	mov    %ecx,%edi
 526:	f7 75 c4             	divl   -0x3c(%ebp)
 529:	0f b6 92 e4 0a 00 00 	movzbl 0xae4(%edx),%edx
 530:	89 45 c0             	mov    %eax,-0x40(%ebp)
 533:	89 d8                	mov    %ebx,%eax
 535:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 538:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 53b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 53e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 541:	76 dd                	jbe    520 <printint+0x30>
  if(neg)
 543:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 546:	85 c9                	test   %ecx,%ecx
 548:	74 0c                	je     556 <printint+0x66>
    buf[i++] = '-';
 54a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 54f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 551:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 556:	8b 7d b8             	mov    -0x48(%ebp),%edi
 559:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 55d:	eb 07                	jmp    566 <printint+0x76>
 55f:	90                   	nop
 560:	0f b6 13             	movzbl (%ebx),%edx
 563:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 566:	83 ec 04             	sub    $0x4,%esp
 569:	88 55 d7             	mov    %dl,-0x29(%ebp)
 56c:	6a 01                	push   $0x1
 56e:	56                   	push   %esi
 56f:	57                   	push   %edi
 570:	e8 8e fe ff ff       	call   403 <write>
  while(--i >= 0)
 575:	83 c4 10             	add    $0x10,%esp
 578:	39 de                	cmp    %ebx,%esi
 57a:	75 e4                	jne    560 <printint+0x70>
    putc(fd, buf[i]);
}
 57c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57f:	5b                   	pop    %ebx
 580:	5e                   	pop    %esi
 581:	5f                   	pop    %edi
 582:	5d                   	pop    %ebp
 583:	c3                   	ret    
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 588:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 58f:	eb 87                	jmp    518 <printint+0x28>
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	f3 0f 1e fb          	endbr32 
 5a4:	55                   	push   %ebp
 5a5:	89 e5                	mov    %esp,%ebp
 5a7:	57                   	push   %edi
 5a8:	56                   	push   %esi
 5a9:	53                   	push   %ebx
 5aa:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ad:	8b 75 0c             	mov    0xc(%ebp),%esi
 5b0:	0f b6 1e             	movzbl (%esi),%ebx
 5b3:	84 db                	test   %bl,%bl
 5b5:	0f 84 b4 00 00 00    	je     66f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 5bb:	8d 45 10             	lea    0x10(%ebp),%eax
 5be:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5c1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5c4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5c6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c9:	eb 33                	jmp    5fe <printf+0x5e>
 5cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop
 5d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5d3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5d8:	83 f8 25             	cmp    $0x25,%eax
 5db:	74 17                	je     5f4 <printf+0x54>
  write(fd, &c, 1);
 5dd:	83 ec 04             	sub    $0x4,%esp
 5e0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5e3:	6a 01                	push   $0x1
 5e5:	57                   	push   %edi
 5e6:	ff 75 08             	pushl  0x8(%ebp)
 5e9:	e8 15 fe ff ff       	call   403 <write>
 5ee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5f1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5f4:	0f b6 1e             	movzbl (%esi),%ebx
 5f7:	83 c6 01             	add    $0x1,%esi
 5fa:	84 db                	test   %bl,%bl
 5fc:	74 71                	je     66f <printf+0xcf>
    c = fmt[i] & 0xff;
 5fe:	0f be cb             	movsbl %bl,%ecx
 601:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 604:	85 d2                	test   %edx,%edx
 606:	74 c8                	je     5d0 <printf+0x30>
      }
    } else if(state == '%'){
 608:	83 fa 25             	cmp    $0x25,%edx
 60b:	75 e7                	jne    5f4 <printf+0x54>
      if(c == 'd'){
 60d:	83 f8 64             	cmp    $0x64,%eax
 610:	0f 84 9a 00 00 00    	je     6b0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 616:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 61c:	83 f9 70             	cmp    $0x70,%ecx
 61f:	74 5f                	je     680 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 621:	83 f8 73             	cmp    $0x73,%eax
 624:	0f 84 d6 00 00 00    	je     700 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 62a:	83 f8 63             	cmp    $0x63,%eax
 62d:	0f 84 8d 00 00 00    	je     6c0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 633:	83 f8 25             	cmp    $0x25,%eax
 636:	0f 84 b4 00 00 00    	je     6f0 <printf+0x150>
  write(fd, &c, 1);
 63c:	83 ec 04             	sub    $0x4,%esp
 63f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 643:	6a 01                	push   $0x1
 645:	57                   	push   %edi
 646:	ff 75 08             	pushl  0x8(%ebp)
 649:	e8 b5 fd ff ff       	call   403 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 64e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 651:	83 c4 0c             	add    $0xc,%esp
 654:	6a 01                	push   $0x1
 656:	83 c6 01             	add    $0x1,%esi
 659:	57                   	push   %edi
 65a:	ff 75 08             	pushl  0x8(%ebp)
 65d:	e8 a1 fd ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 662:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 666:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 669:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 66b:	84 db                	test   %bl,%bl
 66d:	75 8f                	jne    5fe <printf+0x5e>
    }
  }
}
 66f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 672:	5b                   	pop    %ebx
 673:	5e                   	pop    %esi
 674:	5f                   	pop    %edi
 675:	5d                   	pop    %ebp
 676:	c3                   	ret    
 677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	b9 10 00 00 00       	mov    $0x10,%ecx
 688:	6a 00                	push   $0x0
 68a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 68d:	8b 45 08             	mov    0x8(%ebp),%eax
 690:	8b 13                	mov    (%ebx),%edx
 692:	e8 59 fe ff ff       	call   4f0 <printint>
        ap++;
 697:	89 d8                	mov    %ebx,%eax
 699:	83 c4 10             	add    $0x10,%esp
      state = 0;
 69c:	31 d2                	xor    %edx,%edx
        ap++;
 69e:	83 c0 04             	add    $0x4,%eax
 6a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6a4:	e9 4b ff ff ff       	jmp    5f4 <printf+0x54>
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6b8:	6a 01                	push   $0x1
 6ba:	eb ce                	jmp    68a <printf+0xea>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6c8:	6a 01                	push   $0x1
        ap++;
 6ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6cd:	57                   	push   %edi
 6ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d4:	e8 2a fd ff ff       	call   403 <write>
        ap++;
 6d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6df:	31 d2                	xor    %edx,%edx
 6e1:	e9 0e ff ff ff       	jmp    5f4 <printf+0x54>
 6e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6f3:	83 ec 04             	sub    $0x4,%esp
 6f6:	e9 59 ff ff ff       	jmp    654 <printf+0xb4>
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
        s = (char*)*ap;
 700:	8b 45 d0             	mov    -0x30(%ebp),%eax
 703:	8b 18                	mov    (%eax),%ebx
        ap++;
 705:	83 c0 04             	add    $0x4,%eax
 708:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 70b:	85 db                	test   %ebx,%ebx
 70d:	74 17                	je     726 <printf+0x186>
        while(*s != 0){
 70f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 712:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 714:	84 c0                	test   %al,%al
 716:	0f 84 d8 fe ff ff    	je     5f4 <printf+0x54>
 71c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 71f:	89 de                	mov    %ebx,%esi
 721:	8b 5d 08             	mov    0x8(%ebp),%ebx
 724:	eb 1a                	jmp    740 <printf+0x1a0>
          s = "(null)";
 726:	bb dc 0a 00 00       	mov    $0xadc,%ebx
        while(*s != 0){
 72b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 72e:	b8 28 00 00 00       	mov    $0x28,%eax
 733:	89 de                	mov    %ebx,%esi
 735:	8b 5d 08             	mov    0x8(%ebp),%ebx
 738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
          s++;
 743:	83 c6 01             	add    $0x1,%esi
 746:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 749:	6a 01                	push   $0x1
 74b:	57                   	push   %edi
 74c:	53                   	push   %ebx
 74d:	e8 b1 fc ff ff       	call   403 <write>
        while(*s != 0){
 752:	0f b6 06             	movzbl (%esi),%eax
 755:	83 c4 10             	add    $0x10,%esp
 758:	84 c0                	test   %al,%al
 75a:	75 e4                	jne    740 <printf+0x1a0>
 75c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 75f:	31 d2                	xor    %edx,%edx
 761:	e9 8e fe ff ff       	jmp    5f4 <printf+0x54>
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	f3 0f 1e fb          	endbr32 
 774:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 775:	a1 00 10 00 00       	mov    0x1000,%eax
{
 77a:	89 e5                	mov    %esp,%ebp
 77c:	57                   	push   %edi
 77d:	56                   	push   %esi
 77e:	53                   	push   %ebx
 77f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 782:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 784:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 787:	39 c8                	cmp    %ecx,%eax
 789:	73 15                	jae    7a0 <free+0x30>
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
 790:	39 d1                	cmp    %edx,%ecx
 792:	72 14                	jb     7a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	39 d0                	cmp    %edx,%eax
 796:	73 10                	jae    7a8 <free+0x38>
{
 798:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	8b 10                	mov    (%eax),%edx
 79c:	39 c8                	cmp    %ecx,%eax
 79e:	72 f0                	jb     790 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	39 d0                	cmp    %edx,%eax
 7a2:	72 f4                	jb     798 <free+0x28>
 7a4:	39 d1                	cmp    %edx,%ecx
 7a6:	73 f0                	jae    798 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ae:	39 fa                	cmp    %edi,%edx
 7b0:	74 1e                	je     7d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7b5:	8b 50 04             	mov    0x4(%eax),%edx
 7b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7bb:	39 f1                	cmp    %esi,%ecx
 7bd:	74 28                	je     7e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7c1:	5b                   	pop    %ebx
  freep = p;
 7c2:	a3 00 10 00 00       	mov    %eax,0x1000
}
 7c7:	5e                   	pop    %esi
 7c8:	5f                   	pop    %edi
 7c9:	5d                   	pop    %ebp
 7ca:	c3                   	ret    
 7cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7d0:	03 72 04             	add    0x4(%edx),%esi
 7d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d6:	8b 10                	mov    (%eax),%edx
 7d8:	8b 12                	mov    (%edx),%edx
 7da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7dd:	8b 50 04             	mov    0x4(%eax),%edx
 7e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e3:	39 f1                	cmp    %esi,%ecx
 7e5:	75 d8                	jne    7bf <free+0x4f>
    p->s.size += bp->s.size;
 7e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ea:	a3 00 10 00 00       	mov    %eax,0x1000
    p->s.size += bp->s.size;
 7ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7f5:	89 10                	mov    %edx,(%eax)
}
 7f7:	5b                   	pop    %ebx
 7f8:	5e                   	pop    %esi
 7f9:	5f                   	pop    %edi
 7fa:	5d                   	pop    %ebp
 7fb:	c3                   	ret    
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	f3 0f 1e fb          	endbr32 
 804:	55                   	push   %ebp
 805:	89 e5                	mov    %esp,%ebp
 807:	57                   	push   %edi
 808:	56                   	push   %esi
 809:	53                   	push   %ebx
 80a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 810:	8b 3d 00 10 00 00    	mov    0x1000,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 816:	8d 70 07             	lea    0x7(%eax),%esi
 819:	c1 ee 03             	shr    $0x3,%esi
 81c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 81f:	85 ff                	test   %edi,%edi
 821:	0f 84 a9 00 00 00    	je     8d0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 827:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 829:	8b 48 04             	mov    0x4(%eax),%ecx
 82c:	39 f1                	cmp    %esi,%ecx
 82e:	73 6d                	jae    89d <malloc+0x9d>
 830:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 836:	bb 00 10 00 00       	mov    $0x1000,%ebx
 83b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 83e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 845:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 848:	eb 17                	jmp    861 <malloc+0x61>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 852:	8b 4a 04             	mov    0x4(%edx),%ecx
 855:	39 f1                	cmp    %esi,%ecx
 857:	73 4f                	jae    8a8 <malloc+0xa8>
 859:	8b 3d 00 10 00 00    	mov    0x1000,%edi
 85f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 c7                	cmp    %eax,%edi
 863:	75 eb                	jne    850 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 865:	83 ec 0c             	sub    $0xc,%esp
 868:	ff 75 e4             	pushl  -0x1c(%ebp)
 86b:	e8 fb fb ff ff       	call   46b <sbrk>
  if(p == (char*)-1)
 870:	83 c4 10             	add    $0x10,%esp
 873:	83 f8 ff             	cmp    $0xffffffff,%eax
 876:	74 1b                	je     893 <malloc+0x93>
  hp->s.size = nu;
 878:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 87b:	83 ec 0c             	sub    $0xc,%esp
 87e:	83 c0 08             	add    $0x8,%eax
 881:	50                   	push   %eax
 882:	e8 e9 fe ff ff       	call   770 <free>
  return freep;
 887:	a1 00 10 00 00       	mov    0x1000,%eax
      if((p = morecore(nunits)) == 0)
 88c:	83 c4 10             	add    $0x10,%esp
 88f:	85 c0                	test   %eax,%eax
 891:	75 bd                	jne    850 <malloc+0x50>
        return 0;
  }
}
 893:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 896:	31 c0                	xor    %eax,%eax
}
 898:	5b                   	pop    %ebx
 899:	5e                   	pop    %esi
 89a:	5f                   	pop    %edi
 89b:	5d                   	pop    %ebp
 89c:	c3                   	ret    
    if(p->s.size >= nunits){
 89d:	89 c2                	mov    %eax,%edx
 89f:	89 f8                	mov    %edi,%eax
 8a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8a8:	39 ce                	cmp    %ecx,%esi
 8aa:	74 54                	je     900 <malloc+0x100>
        p->s.size -= nunits;
 8ac:	29 f1                	sub    %esi,%ecx
 8ae:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 8b1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 8b4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 8b7:	a3 00 10 00 00       	mov    %eax,0x1000
}
 8bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8bf:	8d 42 08             	lea    0x8(%edx),%eax
}
 8c2:	5b                   	pop    %ebx
 8c3:	5e                   	pop    %esi
 8c4:	5f                   	pop    %edi
 8c5:	5d                   	pop    %ebp
 8c6:	c3                   	ret    
 8c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ce:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 00 10 00 00 04 	movl   $0x1004,0x1000
 8d7:	10 00 00 
    base.s.size = 0;
 8da:	bf 04 10 00 00       	mov    $0x1004,%edi
    base.s.ptr = freep = prevp = &base;
 8df:	c7 05 04 10 00 00 04 	movl   $0x1004,0x1004
 8e6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8eb:	c7 05 08 10 00 00 00 	movl   $0x0,0x1008
 8f2:	00 00 00 
    if(p->s.size >= nunits){
 8f5:	e9 36 ff ff ff       	jmp    830 <malloc+0x30>
 8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 900:	8b 0a                	mov    (%edx),%ecx
 902:	89 08                	mov    %ecx,(%eax)
 904:	eb b1                	jmp    8b7 <malloc+0xb7>
 906:	66 90                	xchg   %ax,%ax
 908:	66 90                	xchg   %ax,%ax
 90a:	66 90                	xchg   %ax,%ax
 90c:	66 90                	xchg   %ax,%ax
 90e:	66 90                	xchg   %ax,%ax

00000910 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 910:	f3 0f 1e fb          	endbr32 
 914:	55                   	push   %ebp
 915:	89 e5                	mov    %esp,%ebp
 917:	53                   	push   %ebx
 918:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 91b:	68 00 20 00 00       	push   $0x2000
 920:	e8 db fe ff ff       	call   800 <malloc>
    void *stack;

    if (fptr == 0)
 925:	83 c4 10             	add    $0x10,%esp
 928:	85 c0                	test   %eax,%eax
 92a:	74 59                	je     985 <thread_creator+0x75>
 92c:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 92e:	25 ff 0f 00 00       	and    $0xfff,%eax
 933:	75 1b                	jne    950 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 935:	83 ec 0c             	sub    $0xc,%esp
 938:	53                   	push   %ebx
 939:	e8 5d fb ff ff       	call   49b <thread_create>

    if (thread_id < 0)
 93e:	83 c4 10             	add    $0x10,%esp
 941:	85 c0                	test   %eax,%eax
 943:	78 23                	js     968 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 945:	74 45                	je     98c <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 947:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 94a:	c9                   	leave  
 94b:	c3                   	ret    
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 950:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 952:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 955:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 95b:	53                   	push   %ebx
 95c:	e8 3a fb ff ff       	call   49b <thread_create>
    if (thread_id < 0)
 961:	83 c4 10             	add    $0x10,%esp
 964:	85 c0                	test   %eax,%eax
 966:	79 dd                	jns    945 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 968:	83 ec 08             	sub    $0x8,%esp
 96b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96e:	68 f5 0a 00 00       	push   $0xaf5
 973:	6a 01                	push   $0x1
 975:	e8 26 fc ff ff       	call   5a0 <printf>
 97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 97d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 980:	83 c4 10             	add    $0x10,%esp
 983:	c9                   	leave  
 984:	c3                   	ret    
        return -1;
 985:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 98a:	eb bb                	jmp    947 <thread_creator+0x37>
        (fn)(args);
 98c:	83 ec 0c             	sub    $0xc,%esp
 98f:	ff 75 0c             	pushl  0xc(%ebp)
 992:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 995:	89 1c 24             	mov    %ebx,(%esp)
 998:	e8 d3 fd ff ff       	call   770 <free>
        exit();
 99d:	e8 41 fa ff ff       	call   3e3 <exit>
