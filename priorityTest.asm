
_priorityTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define NUM 30

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
    int main_pid = getpid();
    // int times[3] = {0, 0, 0};


    //make NUM child process
    for (int i = 0; i < NUM; i++)
  14:	31 db                	xor    %ebx,%ebx
{
  16:	51                   	push   %ecx
  17:	83 ec 24             	sub    $0x24,%esp
    changePolicy(1);
  1a:	6a 01                	push   $0x1
  1c:	e8 ba 04 00 00       	call   4db <changePolicy>
    int main_pid = getpid();
  21:	e8 4d 04 00 00       	call   473 <getpid>
  26:	83 c4 10             	add    $0x10,%esp
  29:	89 c6                	mov    %eax,%esi
    for (int i = 0; i < NUM; i++)
  2b:	eb 0b                	jmp    38 <main+0x38>
  2d:	8d 76 00             	lea    0x0(%esi),%esi
  30:	83 c3 01             	add    $0x1,%ebx
  33:	83 fb 1e             	cmp    $0x1e,%ebx
  36:	74 29                	je     61 <main+0x61>
    {
        if (fork() > 0) {
  38:	e8 ae 03 00 00       	call   3eb <fork>
  3d:	85 c0                	test   %eax,%eax
  3f:	7e ef                	jle    30 <main+0x30>
            setPriority(getpid(), (i / 5) + 1);
  41:	e8 2d 04 00 00       	call   473 <getpid>
  46:	bf 05 00 00 00       	mov    $0x5,%edi
  4b:	89 c1                	mov    %eax,%ecx
  4d:	50                   	push   %eax
  4e:	50                   	push   %eax
  4f:	89 d8                	mov    %ebx,%eax
  51:	99                   	cltd   
  52:	f7 ff                	idiv   %edi
  54:	83 c0 01             	add    $0x1,%eax
  57:	50                   	push   %eax
  58:	51                   	push   %ecx
  59:	e8 75 04 00 00       	call   4d3 <setPriority>
            break;
  5e:	83 c4 10             	add    $0x10,%esp
        }
    }

    if (main_pid != getpid())
  61:	e8 0d 04 00 00       	call   473 <getpid>
  66:	39 f0                	cmp    %esi,%eax
  68:	0f 84 cb 00 00 00    	je     139 <main+0x139>
    {
        //print pid with i
        for (int i = 0; i < NUM; i++){
  6e:	31 db                	xor    %ebx,%ebx
            int pid = getpid();
  70:	e8 fe 03 00 00       	call   473 <getpid>
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  75:	53                   	push   %ebx
        for (int i = 0; i < NUM; i++){
  76:	83 c3 01             	add    $0x1,%ebx
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  79:	50                   	push   %eax
  7a:	68 b4 09 00 00       	push   $0x9b4
  7f:	6a 01                	push   $0x1
  81:	e8 2a 05 00 00       	call   5b0 <printf>
        for (int i = 0; i < NUM; i++){
  86:	83 c4 10             	add    $0x10,%esp
  89:	83 fb 1e             	cmp    $0x1e,%ebx
  8c:	75 e2                	jne    70 <main+0x70>
        }

        
        int thisPid = getpid(); 
  8e:	e8 e0 03 00 00       	call   473 <getpid>
        int turnAroundTime = getTurnaroundTime(thisPid);
  93:	83 ec 0c             	sub    $0xc,%esp
  96:	50                   	push   %eax
        int thisPid = getpid(); 
  97:	89 c3                	mov    %eax,%ebx
        int turnAroundTime = getTurnaroundTime(thisPid);
  99:	e8 1d 04 00 00       	call   4bb <getTurnaroundTime>
        int waitingTime = getWaitingTime(thisPid);
  9e:	89 1c 24             	mov    %ebx,(%esp)
        int turnAroundTime = getTurnaroundTime(thisPid);
  a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        int waitingTime = getWaitingTime(thisPid);
  a4:	e8 1a 04 00 00       	call   4c3 <getWaitingTime>
        int cbpTime = getCpuBurstTime(thisPid);
  a9:	89 1c 24             	mov    %ebx,(%esp)
        int waitingTime = getWaitingTime(thisPid);
  ac:	89 c7                	mov    %eax,%edi
        int cbpTime = getCpuBurstTime(thisPid);
  ae:	e8 18 04 00 00       	call   4cb <getCpuBurstTime>
        // s[0] += sum;

        // printf(1,"cccccccccccppppptttttttttt suuummmm %d\n",sum);


        printf(1, " Process ID : %d\n", thisPid);
  b3:	83 c4 0c             	add    $0xc,%esp
  b6:	53                   	push   %ebx
        int cbpTime = getCpuBurstTime(thisPid);
  b7:	89 c6                	mov    %eax,%esi
        printf(1, " Process ID : %d\n", thisPid);
  b9:	68 c7 09 00 00       	push   $0x9c7
  be:	6a 01                	push   $0x1
  c0:	e8 eb 04 00 00       	call   5b0 <printf>
        printf(1,"--------------------------\n");
  c5:	59                   	pop    %ecx
  c6:	5b                   	pop    %ebx
  c7:	68 d9 09 00 00       	push   $0x9d9
  cc:	6a 01                	push   $0x1
  ce:	e8 dd 04 00 00       	call   5b0 <printf>
        printf(1, "| TurnAround Time = %d  | \n", turnAroundTime);
  d3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	52                   	push   %edx
  da:	68 f5 09 00 00       	push   $0x9f5
  df:	6a 01                	push   $0x1
  e1:	e8 ca 04 00 00       	call   5b0 <printf>
        printf(1, "| Waiting Time = %d     | \n", waitingTime);
  e6:	83 c4 0c             	add    $0xc,%esp
  e9:	57                   	push   %edi
  ea:	68 11 0a 00 00       	push   $0xa11
  ef:	6a 01                	push   $0x1
  f1:	e8 ba 04 00 00       	call   5b0 <printf>
        printf(1, "| CPU Burst Time = %d    | \n", cbpTime);
  f6:	83 c4 0c             	add    $0xc,%esp
  f9:	56                   	push   %esi
  fa:	68 2d 0a 00 00       	push   $0xa2d
  ff:	6a 01                	push   $0x1
 101:	e8 aa 04 00 00       	call   5b0 <printf>
        printf(1, "\n\n");
 106:	5e                   	pop    %esi
 107:	5f                   	pop    %edi
 108:	68 4a 0a 00 00       	push   $0xa4a
 10d:	6a 01                	push   $0x1
 10f:	e8 9c 04 00 00       	call   5b0 <printf>
 114:	83 c4 10             	add    $0x10,%esp
 117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11e:	66 90                	xchg   %ax,%ax
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
    }

    while(wait() != -1);
 120:	e8 d6 02 00 00       	call   3fb <wait>
 125:	83 f8 ff             	cmp    $0xffffffff,%eax
 128:	75 f6                	jne    120 <main+0x120>

    changePolicy(0);    
 12a:	83 ec 0c             	sub    $0xc,%esp
 12d:	6a 00                	push   $0x0
 12f:	e8 a7 03 00 00       	call   4db <changePolicy>
    exit();
 134:	e8 ba 02 00 00       	call   3f3 <exit>
        wait();
 139:	e8 bd 02 00 00       	call   3fb <wait>
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
 13e:	bb 1e 00 00 00       	mov    $0x1e,%ebx
 143:	e8 9b 03 00 00       	call   4e3 <getAllTurnTime>
 148:	52                   	push   %edx
 149:	99                   	cltd   
 14a:	f7 fb                	idiv   %ebx
 14c:	50                   	push   %eax
 14d:	68 4d 0a 00 00       	push   $0xa4d
 152:	6a 01                	push   $0x1
 154:	e8 57 04 00 00       	call   5b0 <printf>
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
 159:	e8 8d 03 00 00       	call   4eb <getAllWaitingTime>
 15e:	83 c4 0c             	add    $0xc,%esp
 161:	99                   	cltd   
 162:	f7 fb                	idiv   %ebx
 164:	50                   	push   %eax
 165:	68 6b 0a 00 00       	push   $0xa6b
 16a:	6a 01                	push   $0x1
 16c:	e8 3f 04 00 00       	call   5b0 <printf>
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
 171:	e8 7d 03 00 00       	call   4f3 <getAllRunningTime>
 176:	83 c4 0c             	add    $0xc,%esp
 179:	99                   	cltd   
 17a:	f7 fb                	idiv   %ebx
 17c:	50                   	push   %eax
 17d:	68 86 0a 00 00       	push   $0xa86
 182:	6a 01                	push   $0x1
 184:	e8 27 04 00 00       	call   5b0 <printf>
 189:	83 c4 10             	add    $0x10,%esp
 18c:	eb 92                	jmp    120 <main+0x120>
 18e:	66 90                	xchg   %ax,%ax

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 195:	31 c0                	xor    %eax,%eax
{
 197:	89 e5                	mov    %esp,%ebp
 199:	53                   	push   %ebx
 19a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 19d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 1a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1a7:	83 c0 01             	add    $0x1,%eax
 1aa:	84 d2                	test   %dl,%dl
 1ac:	75 f2                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1ae:	89 c8                	mov    %ecx,%eax
 1b0:	5b                   	pop    %ebx
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	53                   	push   %ebx
 1c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1ce:	0f b6 01             	movzbl (%ecx),%eax
 1d1:	0f b6 1a             	movzbl (%edx),%ebx
 1d4:	84 c0                	test   %al,%al
 1d6:	75 19                	jne    1f1 <strcmp+0x31>
 1d8:	eb 26                	jmp    200 <strcmp+0x40>
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1e4:	83 c1 01             	add    $0x1,%ecx
 1e7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1ea:	0f b6 1a             	movzbl (%edx),%ebx
 1ed:	84 c0                	test   %al,%al
 1ef:	74 0f                	je     200 <strcmp+0x40>
 1f1:	38 d8                	cmp    %bl,%al
 1f3:	74 eb                	je     1e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1f5:	29 d8                	sub    %ebx,%eax
}
 1f7:	5b                   	pop    %ebx
 1f8:	5d                   	pop    %ebp
 1f9:	c3                   	ret    
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 200:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 202:	29 d8                	sub    %ebx,%eax
}
 204:	5b                   	pop    %ebx
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 21a:	80 3a 00             	cmpb   $0x0,(%edx)
 21d:	74 21                	je     240 <strlen+0x30>
 21f:	31 c0                	xor    %eax,%eax
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 228:	83 c0 01             	add    $0x1,%eax
 22b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 22f:	89 c1                	mov    %eax,%ecx
 231:	75 f5                	jne    228 <strlen+0x18>
    ;
  return n;
}
 233:	89 c8                	mov    %ecx,%eax
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 240:	31 c9                	xor    %ecx,%ecx
}
 242:	5d                   	pop    %ebp
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	57                   	push   %edi
 258:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 25b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25e:	8b 45 0c             	mov    0xc(%ebp),%eax
 261:	89 d7                	mov    %edx,%edi
 263:	fc                   	cld    
 264:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27e:	0f b6 10             	movzbl (%eax),%edx
 281:	84 d2                	test   %dl,%dl
 283:	75 16                	jne    29b <strchr+0x2b>
 285:	eb 21                	jmp    2a8 <strchr+0x38>
 287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28e:	66 90                	xchg   %ax,%ax
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	83 c0 01             	add    $0x1,%eax
 297:	84 d2                	test   %dl,%dl
 299:	74 0d                	je     2a8 <strchr+0x38>
    if(*s == c)
 29b:	38 d1                	cmp    %dl,%cl
 29d:	75 f1                	jne    290 <strchr+0x20>
      return (char*)s;
  return 0;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2a8:	31 c0                	xor    %eax,%eax
}
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret    
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	57                   	push   %edi
 2b8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b9:	31 f6                	xor    %esi,%esi
{
 2bb:	53                   	push   %ebx
 2bc:	89 f3                	mov    %esi,%ebx
 2be:	83 ec 1c             	sub    $0x1c,%esp
 2c1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2c4:	eb 33                	jmp    2f9 <gets+0x49>
 2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2d0:	83 ec 04             	sub    $0x4,%esp
 2d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2d6:	6a 01                	push   $0x1
 2d8:	50                   	push   %eax
 2d9:	6a 00                	push   $0x0
 2db:	e8 2b 01 00 00       	call   40b <read>
    if(cc < 1)
 2e0:	83 c4 10             	add    $0x10,%esp
 2e3:	85 c0                	test   %eax,%eax
 2e5:	7e 1c                	jle    303 <gets+0x53>
      break;
    buf[i++] = c;
 2e7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2eb:	83 c7 01             	add    $0x1,%edi
 2ee:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2f1:	3c 0a                	cmp    $0xa,%al
 2f3:	74 23                	je     318 <gets+0x68>
 2f5:	3c 0d                	cmp    $0xd,%al
 2f7:	74 1f                	je     318 <gets+0x68>
  for(i=0; i+1 < max; ){
 2f9:	83 c3 01             	add    $0x1,%ebx
 2fc:	89 fe                	mov    %edi,%esi
 2fe:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 301:	7c cd                	jl     2d0 <gets+0x20>
 303:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 305:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 308:	c6 03 00             	movb   $0x0,(%ebx)
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
 313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 317:	90                   	nop
 318:	8b 75 08             	mov    0x8(%ebp),%esi
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 de                	add    %ebx,%esi
 320:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 322:	c6 03 00             	movb   $0x0,(%ebx)
}
 325:	8d 65 f4             	lea    -0xc(%ebp),%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi

00000330 <stat>:

int
stat(const char *n, struct stat *st)
{
 330:	f3 0f 1e fb          	endbr32 
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	56                   	push   %esi
 338:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	6a 00                	push   $0x0
 33e:	ff 75 08             	pushl  0x8(%ebp)
 341:	e8 ed 00 00 00       	call   433 <open>
  if(fd < 0)
 346:	83 c4 10             	add    $0x10,%esp
 349:	85 c0                	test   %eax,%eax
 34b:	78 2b                	js     378 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 34d:	83 ec 08             	sub    $0x8,%esp
 350:	ff 75 0c             	pushl  0xc(%ebp)
 353:	89 c3                	mov    %eax,%ebx
 355:	50                   	push   %eax
 356:	e8 f0 00 00 00       	call   44b <fstat>
  close(fd);
 35b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 35e:	89 c6                	mov    %eax,%esi
  close(fd);
 360:	e8 b6 00 00 00       	call   41b <close>
  return r;
 365:	83 c4 10             	add    $0x10,%esp
}
 368:	8d 65 f8             	lea    -0x8(%ebp),%esp
 36b:	89 f0                	mov    %esi,%eax
 36d:	5b                   	pop    %ebx
 36e:	5e                   	pop    %esi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
 371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 378:	be ff ff ff ff       	mov    $0xffffffff,%esi
 37d:	eb e9                	jmp    368 <stat+0x38>
 37f:	90                   	nop

00000380 <atoi>:

int
atoi(const char *s)
{
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	53                   	push   %ebx
 388:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 38b:	0f be 02             	movsbl (%edx),%eax
 38e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 391:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 394:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 399:	77 1a                	ja     3b5 <atoi+0x35>
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop
    n = n*10 + *s++ - '0';
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3aa:	0f be 02             	movsbl (%edx),%eax
 3ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
  return n;
}
 3b5:	89 c8                	mov    %ecx,%eax
 3b7:	5b                   	pop    %ebx
 3b8:	5d                   	pop    %ebp
 3b9:	c3                   	ret    
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c0:	f3 0f 1e fb          	endbr32 
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	57                   	push   %edi
 3c8:	8b 45 10             	mov    0x10(%ebp),%eax
 3cb:	8b 55 08             	mov    0x8(%ebp),%edx
 3ce:	56                   	push   %esi
 3cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d2:	85 c0                	test   %eax,%eax
 3d4:	7e 0f                	jle    3e5 <memmove+0x25>
 3d6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3d8:	89 d7                	mov    %edx,%edi
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3e1:	39 f8                	cmp    %edi,%eax
 3e3:	75 fb                	jne    3e0 <memmove+0x20>
  return vdst;
}
 3e5:	5e                   	pop    %esi
 3e6:	89 d0                	mov    %edx,%eax
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    

000003eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <exit>:
SYSCALL(exit)
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <wait>:
SYSCALL(wait)
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <pipe>:
SYSCALL(pipe)
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <read>:
SYSCALL(read)
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <write>:
SYSCALL(write)
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <close>:
SYSCALL(close)
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <kill>:
SYSCALL(kill)
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <exec>:
SYSCALL(exec)
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <open>:
SYSCALL(open)
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mknod>:
SYSCALL(mknod)
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <unlink>:
SYSCALL(unlink)
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <fstat>:
SYSCALL(fstat)
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <link>:
SYSCALL(link)
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <mkdir>:
SYSCALL(mkdir)
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <chdir>:
SYSCALL(chdir)
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <dup>:
SYSCALL(dup)
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <getpid>:
SYSCALL(getpid)
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <sbrk>:
SYSCALL(sbrk)
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <sleep>:
SYSCALL(sleep)
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <uptime>:
SYSCALL(uptime)
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <getHelloWorld>:
SYSCALL(getHelloWorld)
 493:	b8 16 00 00 00       	mov    $0x16,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <getProcCount>:
SYSCALL(getProcCount)
 49b:	b8 17 00 00 00       	mov    $0x17,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <getReadCount>:
SYSCALL(getReadCount)
 4a3:	b8 18 00 00 00       	mov    $0x18,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <thread_create>:
SYSCALL(thread_create)
 4ab:	b8 19 00 00 00       	mov    $0x19,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <join>:
SYSCALL(join)
 4b3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 4bb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <getWaitingTime>:
SYSCALL(getWaitingTime)
 4c3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 4cb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <setPriority>:
SYSCALL(setPriority)
 4d3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <changePolicy>:
SYSCALL(changePolicy)
 4db:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 4e3:	b8 20 00 00 00       	mov    $0x20,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 4eb:	b8 21 00 00 00       	mov    $0x21,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 4f3:	b8 22 00 00 00       	mov    $0x22,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    
 4fb:	66 90                	xchg   %ax,%ax
 4fd:	66 90                	xchg   %ax,%ax
 4ff:	90                   	nop

00000500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 3c             	sub    $0x3c,%esp
 509:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 50c:	89 d1                	mov    %edx,%ecx
{
 50e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 511:	85 d2                	test   %edx,%edx
 513:	0f 89 7f 00 00 00    	jns    598 <printint+0x98>
 519:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 51d:	74 79                	je     598 <printint+0x98>
    neg = 1;
 51f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 526:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 528:	31 db                	xor    %ebx,%ebx
 52a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 52d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 530:	89 c8                	mov    %ecx,%eax
 532:	31 d2                	xor    %edx,%edx
 534:	89 cf                	mov    %ecx,%edi
 536:	f7 75 c4             	divl   -0x3c(%ebp)
 539:	0f b6 92 a8 0a 00 00 	movzbl 0xaa8(%edx),%edx
 540:	89 45 c0             	mov    %eax,-0x40(%ebp)
 543:	89 d8                	mov    %ebx,%eax
 545:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 548:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 54b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 54e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 551:	76 dd                	jbe    530 <printint+0x30>
  if(neg)
 553:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 556:	85 c9                	test   %ecx,%ecx
 558:	74 0c                	je     566 <printint+0x66>
    buf[i++] = '-';
 55a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 55f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 561:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 566:	8b 7d b8             	mov    -0x48(%ebp),%edi
 569:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 56d:	eb 07                	jmp    576 <printint+0x76>
 56f:	90                   	nop
 570:	0f b6 13             	movzbl (%ebx),%edx
 573:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 576:	83 ec 04             	sub    $0x4,%esp
 579:	88 55 d7             	mov    %dl,-0x29(%ebp)
 57c:	6a 01                	push   $0x1
 57e:	56                   	push   %esi
 57f:	57                   	push   %edi
 580:	e8 8e fe ff ff       	call   413 <write>
  while(--i >= 0)
 585:	83 c4 10             	add    $0x10,%esp
 588:	39 de                	cmp    %ebx,%esi
 58a:	75 e4                	jne    570 <printint+0x70>
    putc(fd, buf[i]);
}
 58c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58f:	5b                   	pop    %ebx
 590:	5e                   	pop    %esi
 591:	5f                   	pop    %edi
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 598:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 59f:	eb 87                	jmp    528 <printint+0x28>
 5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5b0:	f3 0f 1e fb          	endbr32 
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	56                   	push   %esi
 5b9:	53                   	push   %ebx
 5ba:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 5c0:	0f b6 1e             	movzbl (%esi),%ebx
 5c3:	84 db                	test   %bl,%bl
 5c5:	0f 84 b4 00 00 00    	je     67f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 5cb:	8d 45 10             	lea    0x10(%ebp),%eax
 5ce:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5d4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5d9:	eb 33                	jmp    60e <printf+0x5e>
 5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop
 5e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5e3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5e8:	83 f8 25             	cmp    $0x25,%eax
 5eb:	74 17                	je     604 <printf+0x54>
  write(fd, &c, 1);
 5ed:	83 ec 04             	sub    $0x4,%esp
 5f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5f3:	6a 01                	push   $0x1
 5f5:	57                   	push   %edi
 5f6:	ff 75 08             	pushl  0x8(%ebp)
 5f9:	e8 15 fe ff ff       	call   413 <write>
 5fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 601:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 604:	0f b6 1e             	movzbl (%esi),%ebx
 607:	83 c6 01             	add    $0x1,%esi
 60a:	84 db                	test   %bl,%bl
 60c:	74 71                	je     67f <printf+0xcf>
    c = fmt[i] & 0xff;
 60e:	0f be cb             	movsbl %bl,%ecx
 611:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 614:	85 d2                	test   %edx,%edx
 616:	74 c8                	je     5e0 <printf+0x30>
      }
    } else if(state == '%'){
 618:	83 fa 25             	cmp    $0x25,%edx
 61b:	75 e7                	jne    604 <printf+0x54>
      if(c == 'd'){
 61d:	83 f8 64             	cmp    $0x64,%eax
 620:	0f 84 9a 00 00 00    	je     6c0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 626:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 62c:	83 f9 70             	cmp    $0x70,%ecx
 62f:	74 5f                	je     690 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 631:	83 f8 73             	cmp    $0x73,%eax
 634:	0f 84 d6 00 00 00    	je     710 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63a:	83 f8 63             	cmp    $0x63,%eax
 63d:	0f 84 8d 00 00 00    	je     6d0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 643:	83 f8 25             	cmp    $0x25,%eax
 646:	0f 84 b4 00 00 00    	je     700 <printf+0x150>
  write(fd, &c, 1);
 64c:	83 ec 04             	sub    $0x4,%esp
 64f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 653:	6a 01                	push   $0x1
 655:	57                   	push   %edi
 656:	ff 75 08             	pushl  0x8(%ebp)
 659:	e8 b5 fd ff ff       	call   413 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 65e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 661:	83 c4 0c             	add    $0xc,%esp
 664:	6a 01                	push   $0x1
 666:	83 c6 01             	add    $0x1,%esi
 669:	57                   	push   %edi
 66a:	ff 75 08             	pushl  0x8(%ebp)
 66d:	e8 a1 fd ff ff       	call   413 <write>
  for(i = 0; fmt[i]; i++){
 672:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 676:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 679:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 67b:	84 db                	test   %bl,%bl
 67d:	75 8f                	jne    60e <printf+0x5e>
    }
  }
}
 67f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 682:	5b                   	pop    %ebx
 683:	5e                   	pop    %esi
 684:	5f                   	pop    %edi
 685:	5d                   	pop    %ebp
 686:	c3                   	ret    
 687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 10 00 00 00       	mov    $0x10,%ecx
 698:	6a 00                	push   $0x0
 69a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 69d:	8b 45 08             	mov    0x8(%ebp),%eax
 6a0:	8b 13                	mov    (%ebx),%edx
 6a2:	e8 59 fe ff ff       	call   500 <printint>
        ap++;
 6a7:	89 d8                	mov    %ebx,%eax
 6a9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ac:	31 d2                	xor    %edx,%edx
        ap++;
 6ae:	83 c0 04             	add    $0x4,%eax
 6b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6b4:	e9 4b ff ff ff       	jmp    604 <printf+0x54>
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6c0:	83 ec 0c             	sub    $0xc,%esp
 6c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c8:	6a 01                	push   $0x1
 6ca:	eb ce                	jmp    69a <printf+0xea>
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6d6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6d8:	6a 01                	push   $0x1
        ap++;
 6da:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6dd:	57                   	push   %edi
 6de:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6e1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e4:	e8 2a fd ff ff       	call   413 <write>
        ap++;
 6e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ef:	31 d2                	xor    %edx,%edx
 6f1:	e9 0e ff ff ff       	jmp    604 <printf+0x54>
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 700:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 703:	83 ec 04             	sub    $0x4,%esp
 706:	e9 59 ff ff ff       	jmp    664 <printf+0xb4>
 70b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop
        s = (char*)*ap;
 710:	8b 45 d0             	mov    -0x30(%ebp),%eax
 713:	8b 18                	mov    (%eax),%ebx
        ap++;
 715:	83 c0 04             	add    $0x4,%eax
 718:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 71b:	85 db                	test   %ebx,%ebx
 71d:	74 17                	je     736 <printf+0x186>
        while(*s != 0){
 71f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 722:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 724:	84 c0                	test   %al,%al
 726:	0f 84 d8 fe ff ff    	je     604 <printf+0x54>
 72c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 72f:	89 de                	mov    %ebx,%esi
 731:	8b 5d 08             	mov    0x8(%ebp),%ebx
 734:	eb 1a                	jmp    750 <printf+0x1a0>
          s = "(null)";
 736:	bb a1 0a 00 00       	mov    $0xaa1,%ebx
        while(*s != 0){
 73b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 73e:	b8 28 00 00 00       	mov    $0x28,%eax
 743:	89 de                	mov    %ebx,%esi
 745:	8b 5d 08             	mov    0x8(%ebp),%ebx
 748:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
          s++;
 753:	83 c6 01             	add    $0x1,%esi
 756:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 759:	6a 01                	push   $0x1
 75b:	57                   	push   %edi
 75c:	53                   	push   %ebx
 75d:	e8 b1 fc ff ff       	call   413 <write>
        while(*s != 0){
 762:	0f b6 06             	movzbl (%esi),%eax
 765:	83 c4 10             	add    $0x10,%esp
 768:	84 c0                	test   %al,%al
 76a:	75 e4                	jne    750 <printf+0x1a0>
 76c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 76f:	31 d2                	xor    %edx,%edx
 771:	e9 8e fe ff ff       	jmp    604 <printf+0x54>
 776:	66 90                	xchg   %ax,%ax
 778:	66 90                	xchg   %ax,%ax
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	f3 0f 1e fb          	endbr32 
 784:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 785:	a1 a8 0d 00 00       	mov    0xda8,%eax
{
 78a:	89 e5                	mov    %esp,%ebp
 78c:	57                   	push   %edi
 78d:	56                   	push   %esi
 78e:	53                   	push   %ebx
 78f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 792:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 794:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 797:	39 c8                	cmp    %ecx,%eax
 799:	73 15                	jae    7b0 <free+0x30>
 79b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
 7a0:	39 d1                	cmp    %edx,%ecx
 7a2:	72 14                	jb     7b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	39 d0                	cmp    %edx,%eax
 7a6:	73 10                	jae    7b8 <free+0x38>
{
 7a8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7aa:	8b 10                	mov    (%eax),%edx
 7ac:	39 c8                	cmp    %ecx,%eax
 7ae:	72 f0                	jb     7a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	72 f4                	jb     7a8 <free+0x28>
 7b4:	39 d1                	cmp    %edx,%ecx
 7b6:	73 f0                	jae    7a8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7be:	39 fa                	cmp    %edi,%edx
 7c0:	74 1e                	je     7e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7c5:	8b 50 04             	mov    0x4(%eax),%edx
 7c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7cb:	39 f1                	cmp    %esi,%ecx
 7cd:	74 28                	je     7f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7d1:	5b                   	pop    %ebx
  freep = p;
 7d2:	a3 a8 0d 00 00       	mov    %eax,0xda8
}
 7d7:	5e                   	pop    %esi
 7d8:	5f                   	pop    %edi
 7d9:	5d                   	pop    %ebp
 7da:	c3                   	ret    
 7db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7df:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7e0:	03 72 04             	add    0x4(%edx),%esi
 7e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 12                	mov    (%edx),%edx
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	75 d8                	jne    7cf <free+0x4f>
    p->s.size += bp->s.size;
 7f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7fa:	a3 a8 0d 00 00       	mov    %eax,0xda8
    p->s.size += bp->s.size;
 7ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 802:	8b 53 f8             	mov    -0x8(%ebx),%edx
 805:	89 10                	mov    %edx,(%eax)
}
 807:	5b                   	pop    %ebx
 808:	5e                   	pop    %esi
 809:	5f                   	pop    %edi
 80a:	5d                   	pop    %ebp
 80b:	c3                   	ret    
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	f3 0f 1e fb          	endbr32 
 814:	55                   	push   %ebp
 815:	89 e5                	mov    %esp,%ebp
 817:	57                   	push   %edi
 818:	56                   	push   %esi
 819:	53                   	push   %ebx
 81a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 81d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 820:	8b 3d a8 0d 00 00    	mov    0xda8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 826:	8d 70 07             	lea    0x7(%eax),%esi
 829:	c1 ee 03             	shr    $0x3,%esi
 82c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 82f:	85 ff                	test   %edi,%edi
 831:	0f 84 a9 00 00 00    	je     8e0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 837:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 839:	8b 48 04             	mov    0x4(%eax),%ecx
 83c:	39 f1                	cmp    %esi,%ecx
 83e:	73 6d                	jae    8ad <malloc+0x9d>
 840:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 846:	bb 00 10 00 00       	mov    $0x1000,%ebx
 84b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 84e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 855:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 858:	eb 17                	jmp    871 <malloc+0x61>
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 862:	8b 4a 04             	mov    0x4(%edx),%ecx
 865:	39 f1                	cmp    %esi,%ecx
 867:	73 4f                	jae    8b8 <malloc+0xa8>
 869:	8b 3d a8 0d 00 00    	mov    0xda8,%edi
 86f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 871:	39 c7                	cmp    %eax,%edi
 873:	75 eb                	jne    860 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 875:	83 ec 0c             	sub    $0xc,%esp
 878:	ff 75 e4             	pushl  -0x1c(%ebp)
 87b:	e8 fb fb ff ff       	call   47b <sbrk>
  if(p == (char*)-1)
 880:	83 c4 10             	add    $0x10,%esp
 883:	83 f8 ff             	cmp    $0xffffffff,%eax
 886:	74 1b                	je     8a3 <malloc+0x93>
  hp->s.size = nu;
 888:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 88b:	83 ec 0c             	sub    $0xc,%esp
 88e:	83 c0 08             	add    $0x8,%eax
 891:	50                   	push   %eax
 892:	e8 e9 fe ff ff       	call   780 <free>
  return freep;
 897:	a1 a8 0d 00 00       	mov    0xda8,%eax
      if((p = morecore(nunits)) == 0)
 89c:	83 c4 10             	add    $0x10,%esp
 89f:	85 c0                	test   %eax,%eax
 8a1:	75 bd                	jne    860 <malloc+0x50>
        return 0;
  }
}
 8a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8a6:	31 c0                	xor    %eax,%eax
}
 8a8:	5b                   	pop    %ebx
 8a9:	5e                   	pop    %esi
 8aa:	5f                   	pop    %edi
 8ab:	5d                   	pop    %ebp
 8ac:	c3                   	ret    
    if(p->s.size >= nunits){
 8ad:	89 c2                	mov    %eax,%edx
 8af:	89 f8                	mov    %edi,%eax
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8b8:	39 ce                	cmp    %ecx,%esi
 8ba:	74 54                	je     910 <malloc+0x100>
        p->s.size -= nunits;
 8bc:	29 f1                	sub    %esi,%ecx
 8be:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 8c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 8c4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 8c7:	a3 a8 0d 00 00       	mov    %eax,0xda8
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8cf:	8d 42 08             	lea    0x8(%edx),%eax
}
 8d2:	5b                   	pop    %ebx
 8d3:	5e                   	pop    %esi
 8d4:	5f                   	pop    %edi
 8d5:	5d                   	pop    %ebp
 8d6:	c3                   	ret    
 8d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8de:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 8e0:	c7 05 a8 0d 00 00 ac 	movl   $0xdac,0xda8
 8e7:	0d 00 00 
    base.s.size = 0;
 8ea:	bf ac 0d 00 00       	mov    $0xdac,%edi
    base.s.ptr = freep = prevp = &base;
 8ef:	c7 05 ac 0d 00 00 ac 	movl   $0xdac,0xdac
 8f6:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8fb:	c7 05 b0 0d 00 00 00 	movl   $0x0,0xdb0
 902:	00 00 00 
    if(p->s.size >= nunits){
 905:	e9 36 ff ff ff       	jmp    840 <malloc+0x30>
 90a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 910:	8b 0a                	mov    (%edx),%ecx
 912:	89 08                	mov    %ecx,(%eax)
 914:	eb b1                	jmp    8c7 <malloc+0xb7>
 916:	66 90                	xchg   %ax,%ax
 918:	66 90                	xchg   %ax,%ax
 91a:	66 90                	xchg   %ax,%ax
 91c:	66 90                	xchg   %ax,%ax
 91e:	66 90                	xchg   %ax,%ax

00000920 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 920:	f3 0f 1e fb          	endbr32 
 924:	55                   	push   %ebp
 925:	89 e5                	mov    %esp,%ebp
 927:	53                   	push   %ebx
 928:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 92b:	68 00 20 00 00       	push   $0x2000
 930:	e8 db fe ff ff       	call   810 <malloc>
    void *stack;

    if (fptr == 0)
 935:	83 c4 10             	add    $0x10,%esp
 938:	85 c0                	test   %eax,%eax
 93a:	74 59                	je     995 <thread_creator+0x75>
 93c:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 93e:	25 ff 0f 00 00       	and    $0xfff,%eax
 943:	75 1b                	jne    960 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 945:	83 ec 0c             	sub    $0xc,%esp
 948:	53                   	push   %ebx
 949:	e8 5d fb ff ff       	call   4ab <thread_create>

    if (thread_id < 0)
 94e:	83 c4 10             	add    $0x10,%esp
 951:	85 c0                	test   %eax,%eax
 953:	78 23                	js     978 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 955:	74 45                	je     99c <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 957:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 95a:	c9                   	leave  
 95b:	c3                   	ret    
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 960:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 962:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 965:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 96b:	53                   	push   %ebx
 96c:	e8 3a fb ff ff       	call   4ab <thread_create>
    if (thread_id < 0)
 971:	83 c4 10             	add    $0x10,%esp
 974:	85 c0                	test   %eax,%eax
 976:	79 dd                	jns    955 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 978:	83 ec 08             	sub    $0x8,%esp
 97b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 97e:	68 b9 0a 00 00       	push   $0xab9
 983:	6a 01                	push   $0x1
 985:	e8 26 fc ff ff       	call   5b0 <printf>
 98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 98d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 990:	83 c4 10             	add    $0x10,%esp
 993:	c9                   	leave  
 994:	c3                   	ret    
        return -1;
 995:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 99a:	eb bb                	jmp    957 <thread_creator+0x37>
        (fn)(args);
 99c:	83 ec 0c             	sub    $0xc,%esp
 99f:	ff 75 0c             	pushl  0xc(%ebp)
 9a2:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 9a5:	89 1c 24             	mov    %ebx,(%esp)
 9a8:	e8 d3 fd ff ff       	call   780 <free>
        exit();
 9ad:	e8 41 fa ff ff       	call   3f3 <exit>
