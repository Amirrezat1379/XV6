
_smlTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define NUM 10

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
    changePolicy(2);
    int main_pid = getpid();
    // int times[3] = {0, 0, 0};

    //make NUM child process
    for (int i = 0; i < NUM; i++)
  14:	31 db                	xor    %ebx,%ebx
{
  16:	51                   	push   %ecx
  17:	83 ec 24             	sub    $0x24,%esp
    changePolicy(2);
  1a:	6a 02                	push   $0x2
  1c:	e8 ca 04 00 00       	call   4eb <changePolicy>
    int main_pid = getpid();
  21:	e8 5d 04 00 00       	call   483 <getpid>
  26:	83 c4 10             	add    $0x10,%esp
  29:	89 c6                	mov    %eax,%esi
    for (int i = 0; i < NUM; i++)
  2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop
    {
        int pid = fork();
  30:	e8 c6 03 00 00       	call   3fb <fork>
  35:	89 c1                	mov    %eax,%ecx
        if (pid > 0) {
  37:	85 c0                	test   %eax,%eax
  39:	0f 8f ea 00 00 00    	jg     129 <main+0x129>
    for (int i = 0; i < NUM; i++)
  3f:	83 c3 01             	add    $0x1,%ebx
  42:	83 fb 0a             	cmp    $0xa,%ebx
  45:	75 e9                	jne    30 <main+0x30>
            setPriority(pid, (i / 5) + 1);
            break;
        }
    }
    
    if (main_pid != getpid())
  47:	e8 37 04 00 00       	call   483 <getpid>
  4c:	39 f0                	cmp    %esi,%eax
  4e:	0f 84 f3 00 00 00    	je     147 <main+0x147>
    {
        //print pid with i
        for (int i = 0; i < NUM; i++){
  54:	31 db                	xor    %ebx,%ebx
  56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5d:	8d 76 00             	lea    0x0(%esi),%esi
            int pid = getpid();
  60:	e8 1e 04 00 00       	call   483 <getpid>
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  65:	53                   	push   %ebx
        for (int i = 0; i < NUM; i++){
  66:	83 c3 01             	add    $0x1,%ebx
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
  69:	50                   	push   %eax
  6a:	68 c4 09 00 00       	push   $0x9c4
  6f:	6a 01                	push   $0x1
  71:	e8 4a 05 00 00       	call   5c0 <printf>
        for (int i = 0; i < NUM; i++){
  76:	83 c4 10             	add    $0x10,%esp
  79:	83 fb 0a             	cmp    $0xa,%ebx
  7c:	75 e2                	jne    60 <main+0x60>
        }

        
        int thisPid = getpid(); 
  7e:	e8 00 04 00 00       	call   483 <getpid>
        int turnAroundTime = getTurnaroundTime(thisPid);
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	50                   	push   %eax
        int thisPid = getpid(); 
  87:	89 c3                	mov    %eax,%ebx
        int turnAroundTime = getTurnaroundTime(thisPid);
  89:	e8 3d 04 00 00       	call   4cb <getTurnaroundTime>
        int waitingTime = getWaitingTime(thisPid);
  8e:	89 1c 24             	mov    %ebx,(%esp)
        int turnAroundTime = getTurnaroundTime(thisPid);
  91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        int waitingTime = getWaitingTime(thisPid);
  94:	e8 3a 04 00 00       	call   4d3 <getWaitingTime>
        int cbpTime = getCpuBurstTime(thisPid);
  99:	89 1c 24             	mov    %ebx,(%esp)
        int waitingTime = getWaitingTime(thisPid);
  9c:	89 c7                	mov    %eax,%edi
        int cbpTime = getCpuBurstTime(thisPid);
  9e:	e8 38 04 00 00       	call   4db <getCpuBurstTime>
        // s[0] += sum;

        // printf(1,"cccccccccccppppptttttttttt suuummmm %d\n",sum);


        printf(1, " Process ID : %d\n", thisPid);
  a3:	83 c4 0c             	add    $0xc,%esp
  a6:	53                   	push   %ebx
        int cbpTime = getCpuBurstTime(thisPid);
  a7:	89 c6                	mov    %eax,%esi
        printf(1, " Process ID : %d\n", thisPid);
  a9:	68 d7 09 00 00       	push   $0x9d7
  ae:	6a 01                	push   $0x1
  b0:	e8 0b 05 00 00       	call   5c0 <printf>
        printf(1,"--------------------------\n");
  b5:	59                   	pop    %ecx
  b6:	5b                   	pop    %ebx
  b7:	68 e9 09 00 00       	push   $0x9e9
  bc:	6a 01                	push   $0x1
  be:	e8 fd 04 00 00       	call   5c0 <printf>
        printf(1, "| TurnAround Time = %d  | \n", turnAroundTime);
  c3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  c6:	83 c4 0c             	add    $0xc,%esp
  c9:	52                   	push   %edx
  ca:	68 05 0a 00 00       	push   $0xa05
  cf:	6a 01                	push   $0x1
  d1:	e8 ea 04 00 00       	call   5c0 <printf>
        printf(1, "| Waiting Time = %d     | \n", waitingTime);
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	57                   	push   %edi
  da:	68 21 0a 00 00       	push   $0xa21
  df:	6a 01                	push   $0x1
  e1:	e8 da 04 00 00       	call   5c0 <printf>
        printf(1, "| CPU Burst Time = %d    | \n", cbpTime);
  e6:	83 c4 0c             	add    $0xc,%esp
  e9:	56                   	push   %esi
  ea:	68 3d 0a 00 00       	push   $0xa3d
  ef:	6a 01                	push   $0x1
  f1:	e8 ca 04 00 00       	call   5c0 <printf>
        printf(1, "\n\n");
  f6:	5e                   	pop    %esi
  f7:	5f                   	pop    %edi
  f8:	68 5a 0a 00 00       	push   $0xa5a
  fd:	6a 01                	push   $0x1
  ff:	e8 bc 04 00 00       	call   5c0 <printf>
 104:	83 c4 10             	add    $0x10,%esp
 107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10e:	66 90                	xchg   %ax,%ax
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
    }

    while(wait() != -1);
 110:	e8 f6 02 00 00       	call   40b <wait>
 115:	83 f8 ff             	cmp    $0xffffffff,%eax
 118:	75 f6                	jne    110 <main+0x110>

    changePolicy(0);    
 11a:	83 ec 0c             	sub    $0xc,%esp
 11d:	6a 00                	push   $0x0
 11f:	e8 c7 03 00 00       	call   4eb <changePolicy>
    exit();
 124:	e8 da 02 00 00       	call   403 <exit>
            setPriority(pid, (i / 5) + 1);
 129:	50                   	push   %eax
 12a:	bf 05 00 00 00       	mov    $0x5,%edi
 12f:	50                   	push   %eax
 130:	89 d8                	mov    %ebx,%eax
 132:	99                   	cltd   
 133:	f7 ff                	idiv   %edi
 135:	83 c0 01             	add    $0x1,%eax
 138:	50                   	push   %eax
 139:	51                   	push   %ecx
 13a:	e8 a4 03 00 00       	call   4e3 <setPriority>
            break;
 13f:	83 c4 10             	add    $0x10,%esp
 142:	e9 00 ff ff ff       	jmp    47 <main+0x47>
        wait();
 147:	e8 bf 02 00 00       	call   40b <wait>
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
 14c:	bb 0a 00 00 00       	mov    $0xa,%ebx
 151:	e8 9d 03 00 00       	call   4f3 <getAllTurnTime>
 156:	52                   	push   %edx
 157:	99                   	cltd   
 158:	f7 fb                	idiv   %ebx
 15a:	50                   	push   %eax
 15b:	68 5d 0a 00 00       	push   $0xa5d
 160:	6a 01                	push   $0x1
 162:	e8 59 04 00 00       	call   5c0 <printf>
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
 167:	e8 8f 03 00 00       	call   4fb <getAllWaitingTime>
 16c:	83 c4 0c             	add    $0xc,%esp
 16f:	99                   	cltd   
 170:	f7 fb                	idiv   %ebx
 172:	50                   	push   %eax
 173:	68 7b 0a 00 00       	push   $0xa7b
 178:	6a 01                	push   $0x1
 17a:	e8 41 04 00 00       	call   5c0 <printf>
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
 17f:	e8 7f 03 00 00       	call   503 <getAllRunningTime>
 184:	83 c4 0c             	add    $0xc,%esp
 187:	99                   	cltd   
 188:	f7 fb                	idiv   %ebx
 18a:	50                   	push   %eax
 18b:	68 96 0a 00 00       	push   $0xa96
 190:	6a 01                	push   $0x1
 192:	e8 29 04 00 00       	call   5c0 <printf>
 197:	83 c4 10             	add    $0x10,%esp
 19a:	e9 71 ff ff ff       	jmp    110 <main+0x110>
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a5:	31 c0                	xor    %eax,%eax
{
 1a7:	89 e5                	mov    %esp,%ebp
 1a9:	53                   	push   %ebx
 1aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1ad:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 1b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1b7:	83 c0 01             	add    $0x1,%eax
 1ba:	84 d2                	test   %dl,%dl
 1bc:	75 f2                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1be:	89 c8                	mov    %ecx,%eax
 1c0:	5b                   	pop    %ebx
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	53                   	push   %ebx
 1d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1db:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1de:	0f b6 01             	movzbl (%ecx),%eax
 1e1:	0f b6 1a             	movzbl (%edx),%ebx
 1e4:	84 c0                	test   %al,%al
 1e6:	75 19                	jne    201 <strcmp+0x31>
 1e8:	eb 26                	jmp    210 <strcmp+0x40>
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1f4:	83 c1 01             	add    $0x1,%ecx
 1f7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1fa:	0f b6 1a             	movzbl (%edx),%ebx
 1fd:	84 c0                	test   %al,%al
 1ff:	74 0f                	je     210 <strcmp+0x40>
 201:	38 d8                	cmp    %bl,%al
 203:	74 eb                	je     1f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 205:	29 d8                	sub    %ebx,%eax
}
 207:	5b                   	pop    %ebx
 208:	5d                   	pop    %ebp
 209:	c3                   	ret    
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 212:	29 d8                	sub    %ebx,%eax
}
 214:	5b                   	pop    %ebx
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 22a:	80 3a 00             	cmpb   $0x0,(%edx)
 22d:	74 21                	je     250 <strlen+0x30>
 22f:	31 c0                	xor    %eax,%eax
 231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 238:	83 c0 01             	add    $0x1,%eax
 23b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 23f:	89 c1                	mov    %eax,%ecx
 241:	75 f5                	jne    238 <strlen+0x18>
    ;
  return n;
}
 243:	89 c8                	mov    %ecx,%eax
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 250:	31 c9                	xor    %ecx,%ecx
}
 252:	5d                   	pop    %ebp
 253:	89 c8                	mov    %ecx,%eax
 255:	c3                   	ret    
 256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	57                   	push   %edi
 268:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 26b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 26e:	8b 45 0c             	mov    0xc(%ebp),%eax
 271:	89 d7                	mov    %edx,%edi
 273:	fc                   	cld    
 274:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 276:	89 d0                	mov    %edx,%eax
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 27f:	90                   	nop

00000280 <strchr>:

char*
strchr(const char *s, char c)
{
 280:	f3 0f 1e fb          	endbr32 
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 28e:	0f b6 10             	movzbl (%eax),%edx
 291:	84 d2                	test   %dl,%dl
 293:	75 16                	jne    2ab <strchr+0x2b>
 295:	eb 21                	jmp    2b8 <strchr+0x38>
 297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29e:	66 90                	xchg   %ax,%ax
 2a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2a4:	83 c0 01             	add    $0x1,%eax
 2a7:	84 d2                	test   %dl,%dl
 2a9:	74 0d                	je     2b8 <strchr+0x38>
    if(*s == c)
 2ab:	38 d1                	cmp    %dl,%cl
 2ad:	75 f1                	jne    2a0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 2af:	5d                   	pop    %ebp
 2b0:	c3                   	ret    
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2b8:	31 c0                	xor    %eax,%eax
}
 2ba:	5d                   	pop    %ebp
 2bb:	c3                   	ret    
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002c0 <gets>:

char*
gets(char *buf, int max)
{
 2c0:	f3 0f 1e fb          	endbr32 
 2c4:	55                   	push   %ebp
 2c5:	89 e5                	mov    %esp,%ebp
 2c7:	57                   	push   %edi
 2c8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c9:	31 f6                	xor    %esi,%esi
{
 2cb:	53                   	push   %ebx
 2cc:	89 f3                	mov    %esi,%ebx
 2ce:	83 ec 1c             	sub    $0x1c,%esp
 2d1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2d4:	eb 33                	jmp    309 <gets+0x49>
 2d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2e6:	6a 01                	push   $0x1
 2e8:	50                   	push   %eax
 2e9:	6a 00                	push   $0x0
 2eb:	e8 2b 01 00 00       	call   41b <read>
    if(cc < 1)
 2f0:	83 c4 10             	add    $0x10,%esp
 2f3:	85 c0                	test   %eax,%eax
 2f5:	7e 1c                	jle    313 <gets+0x53>
      break;
    buf[i++] = c;
 2f7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2fb:	83 c7 01             	add    $0x1,%edi
 2fe:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 301:	3c 0a                	cmp    $0xa,%al
 303:	74 23                	je     328 <gets+0x68>
 305:	3c 0d                	cmp    $0xd,%al
 307:	74 1f                	je     328 <gets+0x68>
  for(i=0; i+1 < max; ){
 309:	83 c3 01             	add    $0x1,%ebx
 30c:	89 fe                	mov    %edi,%esi
 30e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 311:	7c cd                	jl     2e0 <gets+0x20>
 313:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 315:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 318:	c6 03 00             	movb   $0x0,(%ebx)
}
 31b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 31e:	5b                   	pop    %ebx
 31f:	5e                   	pop    %esi
 320:	5f                   	pop    %edi
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 327:	90                   	nop
 328:	8b 75 08             	mov    0x8(%ebp),%esi
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	01 de                	add    %ebx,%esi
 330:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 332:	c6 03 00             	movb   $0x0,(%ebx)
}
 335:	8d 65 f4             	lea    -0xc(%ebp),%esp
 338:	5b                   	pop    %ebx
 339:	5e                   	pop    %esi
 33a:	5f                   	pop    %edi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
 33d:	8d 76 00             	lea    0x0(%esi),%esi

00000340 <stat>:

int
stat(const char *n, struct stat *st)
{
 340:	f3 0f 1e fb          	endbr32 
 344:	55                   	push   %ebp
 345:	89 e5                	mov    %esp,%ebp
 347:	56                   	push   %esi
 348:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	6a 00                	push   $0x0
 34e:	ff 75 08             	pushl  0x8(%ebp)
 351:	e8 ed 00 00 00       	call   443 <open>
  if(fd < 0)
 356:	83 c4 10             	add    $0x10,%esp
 359:	85 c0                	test   %eax,%eax
 35b:	78 2b                	js     388 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 35d:	83 ec 08             	sub    $0x8,%esp
 360:	ff 75 0c             	pushl  0xc(%ebp)
 363:	89 c3                	mov    %eax,%ebx
 365:	50                   	push   %eax
 366:	e8 f0 00 00 00       	call   45b <fstat>
  close(fd);
 36b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 36e:	89 c6                	mov    %eax,%esi
  close(fd);
 370:	e8 b6 00 00 00       	call   42b <close>
  return r;
 375:	83 c4 10             	add    $0x10,%esp
}
 378:	8d 65 f8             	lea    -0x8(%ebp),%esp
 37b:	89 f0                	mov    %esi,%eax
 37d:	5b                   	pop    %ebx
 37e:	5e                   	pop    %esi
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret    
 381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 388:	be ff ff ff ff       	mov    $0xffffffff,%esi
 38d:	eb e9                	jmp    378 <stat+0x38>
 38f:	90                   	nop

00000390 <atoi>:

int
atoi(const char *s)
{
 390:	f3 0f 1e fb          	endbr32 
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
 397:	53                   	push   %ebx
 398:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 39b:	0f be 02             	movsbl (%edx),%eax
 39e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3a1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3a4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3a9:	77 1a                	ja     3c5 <atoi+0x35>
 3ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3af:	90                   	nop
    n = n*10 + *s++ - '0';
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3b6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3ba:	0f be 02             	movsbl (%edx),%eax
 3bd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3c0:	80 fb 09             	cmp    $0x9,%bl
 3c3:	76 eb                	jbe    3b0 <atoi+0x20>
  return n;
}
 3c5:	89 c8                	mov    %ecx,%eax
 3c7:	5b                   	pop    %ebx
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	f3 0f 1e fb          	endbr32 
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	57                   	push   %edi
 3d8:	8b 45 10             	mov    0x10(%ebp),%eax
 3db:	8b 55 08             	mov    0x8(%ebp),%edx
 3de:	56                   	push   %esi
 3df:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3e2:	85 c0                	test   %eax,%eax
 3e4:	7e 0f                	jle    3f5 <memmove+0x25>
 3e6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3e8:	89 d7                	mov    %edx,%edi
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3f1:	39 f8                	cmp    %edi,%eax
 3f3:	75 fb                	jne    3f0 <memmove+0x20>
  return vdst;
}
 3f5:	5e                   	pop    %esi
 3f6:	89 d0                	mov    %edx,%eax
 3f8:	5f                   	pop    %edi
 3f9:	5d                   	pop    %ebp
 3fa:	c3                   	ret    

000003fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fb:	b8 01 00 00 00       	mov    $0x1,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <exit>:
SYSCALL(exit)
 403:	b8 02 00 00 00       	mov    $0x2,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <wait>:
SYSCALL(wait)
 40b:	b8 03 00 00 00       	mov    $0x3,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <pipe>:
SYSCALL(pipe)
 413:	b8 04 00 00 00       	mov    $0x4,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <read>:
SYSCALL(read)
 41b:	b8 05 00 00 00       	mov    $0x5,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <write>:
SYSCALL(write)
 423:	b8 10 00 00 00       	mov    $0x10,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <close>:
SYSCALL(close)
 42b:	b8 15 00 00 00       	mov    $0x15,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <kill>:
SYSCALL(kill)
 433:	b8 06 00 00 00       	mov    $0x6,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <exec>:
SYSCALL(exec)
 43b:	b8 07 00 00 00       	mov    $0x7,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <open>:
SYSCALL(open)
 443:	b8 0f 00 00 00       	mov    $0xf,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mknod>:
SYSCALL(mknod)
 44b:	b8 11 00 00 00       	mov    $0x11,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <unlink>:
SYSCALL(unlink)
 453:	b8 12 00 00 00       	mov    $0x12,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <fstat>:
SYSCALL(fstat)
 45b:	b8 08 00 00 00       	mov    $0x8,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <link>:
SYSCALL(link)
 463:	b8 13 00 00 00       	mov    $0x13,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <mkdir>:
SYSCALL(mkdir)
 46b:	b8 14 00 00 00       	mov    $0x14,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <chdir>:
SYSCALL(chdir)
 473:	b8 09 00 00 00       	mov    $0x9,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <dup>:
SYSCALL(dup)
 47b:	b8 0a 00 00 00       	mov    $0xa,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <getpid>:
SYSCALL(getpid)
 483:	b8 0b 00 00 00       	mov    $0xb,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <sbrk>:
SYSCALL(sbrk)
 48b:	b8 0c 00 00 00       	mov    $0xc,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <sleep>:
SYSCALL(sleep)
 493:	b8 0d 00 00 00       	mov    $0xd,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <uptime>:
SYSCALL(uptime)
 49b:	b8 0e 00 00 00       	mov    $0xe,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <getHelloWorld>:
SYSCALL(getHelloWorld)
 4a3:	b8 16 00 00 00       	mov    $0x16,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <getProcCount>:
SYSCALL(getProcCount)
 4ab:	b8 17 00 00 00       	mov    $0x17,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getReadCount>:
SYSCALL(getReadCount)
 4b3:	b8 18 00 00 00       	mov    $0x18,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <thread_create>:
SYSCALL(thread_create)
 4bb:	b8 19 00 00 00       	mov    $0x19,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <join>:
SYSCALL(join)
 4c3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <getTurnaroundTime>:
SYSCALL(getTurnaroundTime)
 4cb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <getWaitingTime>:
SYSCALL(getWaitingTime)
 4d3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <getCpuBurstTime>:
SYSCALL(getCpuBurstTime)
 4db:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <setPriority>:
SYSCALL(setPriority)
 4e3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <changePolicy>:
SYSCALL(changePolicy)
 4eb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <getAllTurnTime>:
SYSCALL(getAllTurnTime)
 4f3:	b8 20 00 00 00       	mov    $0x20,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <getAllWaitingTime>:
SYSCALL(getAllWaitingTime)
 4fb:	b8 21 00 00 00       	mov    $0x21,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <getAllRunningTime>:
SYSCALL(getAllRunningTime)
 503:	b8 22 00 00 00       	mov    $0x22,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    
 50b:	66 90                	xchg   %ax,%ax
 50d:	66 90                	xchg   %ax,%ax
 50f:	90                   	nop

00000510 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 3c             	sub    $0x3c,%esp
 519:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 51c:	89 d1                	mov    %edx,%ecx
{
 51e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 521:	85 d2                	test   %edx,%edx
 523:	0f 89 7f 00 00 00    	jns    5a8 <printint+0x98>
 529:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 52d:	74 79                	je     5a8 <printint+0x98>
    neg = 1;
 52f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 536:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 538:	31 db                	xor    %ebx,%ebx
 53a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 53d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 540:	89 c8                	mov    %ecx,%eax
 542:	31 d2                	xor    %edx,%edx
 544:	89 cf                	mov    %ecx,%edi
 546:	f7 75 c4             	divl   -0x3c(%ebp)
 549:	0f b6 92 b8 0a 00 00 	movzbl 0xab8(%edx),%edx
 550:	89 45 c0             	mov    %eax,-0x40(%ebp)
 553:	89 d8                	mov    %ebx,%eax
 555:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 558:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 55b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 55e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 561:	76 dd                	jbe    540 <printint+0x30>
  if(neg)
 563:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 566:	85 c9                	test   %ecx,%ecx
 568:	74 0c                	je     576 <printint+0x66>
    buf[i++] = '-';
 56a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 56f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 571:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 576:	8b 7d b8             	mov    -0x48(%ebp),%edi
 579:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 57d:	eb 07                	jmp    586 <printint+0x76>
 57f:	90                   	nop
 580:	0f b6 13             	movzbl (%ebx),%edx
 583:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 586:	83 ec 04             	sub    $0x4,%esp
 589:	88 55 d7             	mov    %dl,-0x29(%ebp)
 58c:	6a 01                	push   $0x1
 58e:	56                   	push   %esi
 58f:	57                   	push   %edi
 590:	e8 8e fe ff ff       	call   423 <write>
  while(--i >= 0)
 595:	83 c4 10             	add    $0x10,%esp
 598:	39 de                	cmp    %ebx,%esi
 59a:	75 e4                	jne    580 <printint+0x70>
    putc(fd, buf[i]);
}
 59c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 59f:	5b                   	pop    %ebx
 5a0:	5e                   	pop    %esi
 5a1:	5f                   	pop    %edi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret    
 5a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 5af:	eb 87                	jmp    538 <printint+0x28>
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop

000005c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5c0:	f3 0f 1e fb          	endbr32 
 5c4:	55                   	push   %ebp
 5c5:	89 e5                	mov    %esp,%ebp
 5c7:	57                   	push   %edi
 5c8:	56                   	push   %esi
 5c9:	53                   	push   %ebx
 5ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 5d0:	0f b6 1e             	movzbl (%esi),%ebx
 5d3:	84 db                	test   %bl,%bl
 5d5:	0f 84 b4 00 00 00    	je     68f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 5db:	8d 45 10             	lea    0x10(%ebp),%eax
 5de:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5e4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 5e6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e9:	eb 33                	jmp    61e <printf+0x5e>
 5eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
 5f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5f8:	83 f8 25             	cmp    $0x25,%eax
 5fb:	74 17                	je     614 <printf+0x54>
  write(fd, &c, 1);
 5fd:	83 ec 04             	sub    $0x4,%esp
 600:	88 5d e7             	mov    %bl,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	57                   	push   %edi
 606:	ff 75 08             	pushl  0x8(%ebp)
 609:	e8 15 fe ff ff       	call   423 <write>
 60e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 611:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 614:	0f b6 1e             	movzbl (%esi),%ebx
 617:	83 c6 01             	add    $0x1,%esi
 61a:	84 db                	test   %bl,%bl
 61c:	74 71                	je     68f <printf+0xcf>
    c = fmt[i] & 0xff;
 61e:	0f be cb             	movsbl %bl,%ecx
 621:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 624:	85 d2                	test   %edx,%edx
 626:	74 c8                	je     5f0 <printf+0x30>
      }
    } else if(state == '%'){
 628:	83 fa 25             	cmp    $0x25,%edx
 62b:	75 e7                	jne    614 <printf+0x54>
      if(c == 'd'){
 62d:	83 f8 64             	cmp    $0x64,%eax
 630:	0f 84 9a 00 00 00    	je     6d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 636:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 63c:	83 f9 70             	cmp    $0x70,%ecx
 63f:	74 5f                	je     6a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 641:	83 f8 73             	cmp    $0x73,%eax
 644:	0f 84 d6 00 00 00    	je     720 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64a:	83 f8 63             	cmp    $0x63,%eax
 64d:	0f 84 8d 00 00 00    	je     6e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 653:	83 f8 25             	cmp    $0x25,%eax
 656:	0f 84 b4 00 00 00    	je     710 <printf+0x150>
  write(fd, &c, 1);
 65c:	83 ec 04             	sub    $0x4,%esp
 65f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 663:	6a 01                	push   $0x1
 665:	57                   	push   %edi
 666:	ff 75 08             	pushl  0x8(%ebp)
 669:	e8 b5 fd ff ff       	call   423 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 66e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 671:	83 c4 0c             	add    $0xc,%esp
 674:	6a 01                	push   $0x1
 676:	83 c6 01             	add    $0x1,%esi
 679:	57                   	push   %edi
 67a:	ff 75 08             	pushl  0x8(%ebp)
 67d:	e8 a1 fd ff ff       	call   423 <write>
  for(i = 0; fmt[i]; i++){
 682:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 686:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 689:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 68b:	84 db                	test   %bl,%bl
 68d:	75 8f                	jne    61e <printf+0x5e>
    }
  }
}
 68f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 692:	5b                   	pop    %ebx
 693:	5e                   	pop    %esi
 694:	5f                   	pop    %edi
 695:	5d                   	pop    %ebp
 696:	c3                   	ret    
 697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 6a0:	83 ec 0c             	sub    $0xc,%esp
 6a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6a8:	6a 00                	push   $0x0
 6aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6ad:	8b 45 08             	mov    0x8(%ebp),%eax
 6b0:	8b 13                	mov    (%ebx),%edx
 6b2:	e8 59 fe ff ff       	call   510 <printint>
        ap++;
 6b7:	89 d8                	mov    %ebx,%eax
 6b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6bc:	31 d2                	xor    %edx,%edx
        ap++;
 6be:	83 c0 04             	add    $0x4,%eax
 6c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c4:	e9 4b ff ff ff       	jmp    614 <printf+0x54>
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6d0:	83 ec 0c             	sub    $0xc,%esp
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	6a 01                	push   $0x1
 6da:	eb ce                	jmp    6aa <printf+0xea>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 6e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 6e8:	6a 01                	push   $0x1
        ap++;
 6ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6ed:	57                   	push   %edi
 6ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6f4:	e8 2a fd ff ff       	call   423 <write>
        ap++;
 6f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 0e ff ff ff       	jmp    614 <printf+0x54>
 706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 710:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 713:	83 ec 04             	sub    $0x4,%esp
 716:	e9 59 ff ff ff       	jmp    674 <printf+0xb4>
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
        s = (char*)*ap;
 720:	8b 45 d0             	mov    -0x30(%ebp),%eax
 723:	8b 18                	mov    (%eax),%ebx
        ap++;
 725:	83 c0 04             	add    $0x4,%eax
 728:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 72b:	85 db                	test   %ebx,%ebx
 72d:	74 17                	je     746 <printf+0x186>
        while(*s != 0){
 72f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 732:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 734:	84 c0                	test   %al,%al
 736:	0f 84 d8 fe ff ff    	je     614 <printf+0x54>
 73c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 73f:	89 de                	mov    %ebx,%esi
 741:	8b 5d 08             	mov    0x8(%ebp),%ebx
 744:	eb 1a                	jmp    760 <printf+0x1a0>
          s = "(null)";
 746:	bb b1 0a 00 00       	mov    $0xab1,%ebx
        while(*s != 0){
 74b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 74e:	b8 28 00 00 00       	mov    $0x28,%eax
 753:	89 de                	mov    %ebx,%esi
 755:	8b 5d 08             	mov    0x8(%ebp),%ebx
 758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
          s++;
 763:	83 c6 01             	add    $0x1,%esi
 766:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 769:	6a 01                	push   $0x1
 76b:	57                   	push   %edi
 76c:	53                   	push   %ebx
 76d:	e8 b1 fc ff ff       	call   423 <write>
        while(*s != 0){
 772:	0f b6 06             	movzbl (%esi),%eax
 775:	83 c4 10             	add    $0x10,%esp
 778:	84 c0                	test   %al,%al
 77a:	75 e4                	jne    760 <printf+0x1a0>
 77c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 77f:	31 d2                	xor    %edx,%edx
 781:	e9 8e fe ff ff       	jmp    614 <printf+0x54>
 786:	66 90                	xchg   %ax,%ax
 788:	66 90                	xchg   %ax,%ax
 78a:	66 90                	xchg   %ax,%ax
 78c:	66 90                	xchg   %ax,%ax
 78e:	66 90                	xchg   %ax,%ax

00000790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	f3 0f 1e fb          	endbr32 
 794:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 795:	a1 b8 0d 00 00       	mov    0xdb8,%eax
{
 79a:	89 e5                	mov    %esp,%ebp
 79c:	57                   	push   %edi
 79d:	56                   	push   %esi
 79e:	53                   	push   %ebx
 79f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7a2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 7a4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a7:	39 c8                	cmp    %ecx,%eax
 7a9:	73 15                	jae    7c0 <free+0x30>
 7ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7af:	90                   	nop
 7b0:	39 d1                	cmp    %edx,%ecx
 7b2:	72 14                	jb     7c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b4:	39 d0                	cmp    %edx,%eax
 7b6:	73 10                	jae    7c8 <free+0x38>
{
 7b8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ba:	8b 10                	mov    (%eax),%edx
 7bc:	39 c8                	cmp    %ecx,%eax
 7be:	72 f0                	jb     7b0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c0:	39 d0                	cmp    %edx,%eax
 7c2:	72 f4                	jb     7b8 <free+0x28>
 7c4:	39 d1                	cmp    %edx,%ecx
 7c6:	73 f0                	jae    7b8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ce:	39 fa                	cmp    %edi,%edx
 7d0:	74 1e                	je     7f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7d5:	8b 50 04             	mov    0x4(%eax),%edx
 7d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7db:	39 f1                	cmp    %esi,%ecx
 7dd:	74 28                	je     807 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7df:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7e1:	5b                   	pop    %ebx
  freep = p;
 7e2:	a3 b8 0d 00 00       	mov    %eax,0xdb8
}
 7e7:	5e                   	pop    %esi
 7e8:	5f                   	pop    %edi
 7e9:	5d                   	pop    %ebp
 7ea:	c3                   	ret    
 7eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7ef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7f0:	03 72 04             	add    0x4(%edx),%esi
 7f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	8b 10                	mov    (%eax),%edx
 7f8:	8b 12                	mov    (%edx),%edx
 7fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7fd:	8b 50 04             	mov    0x4(%eax),%edx
 800:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 803:	39 f1                	cmp    %esi,%ecx
 805:	75 d8                	jne    7df <free+0x4f>
    p->s.size += bp->s.size;
 807:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 80a:	a3 b8 0d 00 00       	mov    %eax,0xdb8
    p->s.size += bp->s.size;
 80f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 812:	8b 53 f8             	mov    -0x8(%ebx),%edx
 815:	89 10                	mov    %edx,(%eax)
}
 817:	5b                   	pop    %ebx
 818:	5e                   	pop    %esi
 819:	5f                   	pop    %edi
 81a:	5d                   	pop    %ebp
 81b:	c3                   	ret    
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 820:	f3 0f 1e fb          	endbr32 
 824:	55                   	push   %ebp
 825:	89 e5                	mov    %esp,%ebp
 827:	57                   	push   %edi
 828:	56                   	push   %esi
 829:	53                   	push   %ebx
 82a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 830:	8b 3d b8 0d 00 00    	mov    0xdb8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 836:	8d 70 07             	lea    0x7(%eax),%esi
 839:	c1 ee 03             	shr    $0x3,%esi
 83c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 83f:	85 ff                	test   %edi,%edi
 841:	0f 84 a9 00 00 00    	je     8f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 847:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 849:	8b 48 04             	mov    0x4(%eax),%ecx
 84c:	39 f1                	cmp    %esi,%ecx
 84e:	73 6d                	jae    8bd <malloc+0x9d>
 850:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 856:	bb 00 10 00 00       	mov    $0x1000,%ebx
 85b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 85e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 865:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 868:	eb 17                	jmp    881 <malloc+0x61>
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 870:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 872:	8b 4a 04             	mov    0x4(%edx),%ecx
 875:	39 f1                	cmp    %esi,%ecx
 877:	73 4f                	jae    8c8 <malloc+0xa8>
 879:	8b 3d b8 0d 00 00    	mov    0xdb8,%edi
 87f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 881:	39 c7                	cmp    %eax,%edi
 883:	75 eb                	jne    870 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 885:	83 ec 0c             	sub    $0xc,%esp
 888:	ff 75 e4             	pushl  -0x1c(%ebp)
 88b:	e8 fb fb ff ff       	call   48b <sbrk>
  if(p == (char*)-1)
 890:	83 c4 10             	add    $0x10,%esp
 893:	83 f8 ff             	cmp    $0xffffffff,%eax
 896:	74 1b                	je     8b3 <malloc+0x93>
  hp->s.size = nu;
 898:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 89b:	83 ec 0c             	sub    $0xc,%esp
 89e:	83 c0 08             	add    $0x8,%eax
 8a1:	50                   	push   %eax
 8a2:	e8 e9 fe ff ff       	call   790 <free>
  return freep;
 8a7:	a1 b8 0d 00 00       	mov    0xdb8,%eax
      if((p = morecore(nunits)) == 0)
 8ac:	83 c4 10             	add    $0x10,%esp
 8af:	85 c0                	test   %eax,%eax
 8b1:	75 bd                	jne    870 <malloc+0x50>
        return 0;
  }
}
 8b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8b6:	31 c0                	xor    %eax,%eax
}
 8b8:	5b                   	pop    %ebx
 8b9:	5e                   	pop    %esi
 8ba:	5f                   	pop    %edi
 8bb:	5d                   	pop    %ebp
 8bc:	c3                   	ret    
    if(p->s.size >= nunits){
 8bd:	89 c2                	mov    %eax,%edx
 8bf:	89 f8                	mov    %edi,%eax
 8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8c8:	39 ce                	cmp    %ecx,%esi
 8ca:	74 54                	je     920 <malloc+0x100>
        p->s.size -= nunits;
 8cc:	29 f1                	sub    %esi,%ecx
 8ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 8d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 8d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 8d7:	a3 b8 0d 00 00       	mov    %eax,0xdb8
}
 8dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8df:	8d 42 08             	lea    0x8(%edx),%eax
}
 8e2:	5b                   	pop    %ebx
 8e3:	5e                   	pop    %esi
 8e4:	5f                   	pop    %edi
 8e5:	5d                   	pop    %ebp
 8e6:	c3                   	ret    
 8e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 8f0:	c7 05 b8 0d 00 00 bc 	movl   $0xdbc,0xdb8
 8f7:	0d 00 00 
    base.s.size = 0;
 8fa:	bf bc 0d 00 00       	mov    $0xdbc,%edi
    base.s.ptr = freep = prevp = &base;
 8ff:	c7 05 bc 0d 00 00 bc 	movl   $0xdbc,0xdbc
 906:	0d 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 909:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 90b:	c7 05 c0 0d 00 00 00 	movl   $0x0,0xdc0
 912:	00 00 00 
    if(p->s.size >= nunits){
 915:	e9 36 ff ff ff       	jmp    850 <malloc+0x30>
 91a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 920:	8b 0a                	mov    (%edx),%ecx
 922:	89 08                	mov    %ecx,(%eax)
 924:	eb b1                	jmp    8d7 <malloc+0xb7>
 926:	66 90                	xchg   %ax,%ax
 928:	66 90                	xchg   %ax,%ax
 92a:	66 90                	xchg   %ax,%ax
 92c:	66 90                	xchg   %ax,%ax
 92e:	66 90                	xchg   %ax,%ax

00000930 <thread_creator>:
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
 930:	f3 0f 1e fb          	endbr32 
 934:	55                   	push   %ebp
 935:	89 e5                	mov    %esp,%ebp
 937:	53                   	push   %ebx
 938:	83 ec 20             	sub    $0x20,%esp
    void *fptr = malloc(2 * PAGESIZE);
 93b:	68 00 20 00 00       	push   $0x2000
 940:	e8 db fe ff ff       	call   820 <malloc>
    void *stack;

    if (fptr == 0)
 945:	83 c4 10             	add    $0x10,%esp
 948:	85 c0                	test   %eax,%eax
 94a:	74 59                	je     9a5 <thread_creator+0x75>
 94c:	89 c3                	mov    %eax,%ebx
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
 94e:	25 ff 0f 00 00       	and    $0xfff,%eax
 953:	75 1b                	jne    970 <thread_creator+0x40>
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);
 955:	83 ec 0c             	sub    $0xc,%esp
 958:	53                   	push   %ebx
 959:	e8 5d fb ff ff       	call   4bb <thread_create>

    if (thread_id < 0)
 95e:	83 c4 10             	add    $0x10,%esp
 961:	85 c0                	test   %eax,%eax
 963:	78 23                	js     988 <thread_creator+0x58>
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
 965:	74 45                	je     9ac <thread_creator+0x7c>
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
 967:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 96a:	c9                   	leave  
 96b:	c3                   	ret    
 96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        stack = fptr + (PAGESIZE - mod);
 970:	29 c3                	sub    %eax,%ebx
    int thread_id = thread_create((void*)stack);
 972:	83 ec 0c             	sub    $0xc,%esp
        stack = fptr + (PAGESIZE - mod);
 975:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    int thread_id = thread_create((void*)stack);
 97b:	53                   	push   %ebx
 97c:	e8 3a fb ff ff       	call   4bb <thread_create>
    if (thread_id < 0)
 981:	83 c4 10             	add    $0x10,%esp
 984:	85 c0                	test   %eax,%eax
 986:	79 dd                	jns    965 <thread_creator+0x35>
        printf(1, "Thread create faild :( !\n");
 988:	83 ec 08             	sub    $0x8,%esp
 98b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 98e:	68 c9 0a 00 00       	push   $0xac9
 993:	6a 01                	push   $0x1
 995:	e8 26 fc ff ff       	call   5c0 <printf>
 99a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 99d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9a0:	83 c4 10             	add    $0x10,%esp
 9a3:	c9                   	leave  
 9a4:	c3                   	ret    
        return -1;
 9a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9aa:	eb bb                	jmp    967 <thread_creator+0x37>
        (fn)(args);
 9ac:	83 ec 0c             	sub    $0xc,%esp
 9af:	ff 75 0c             	pushl  0xc(%ebp)
 9b2:	ff 55 08             	call   *0x8(%ebp)
        free(stack);
 9b5:	89 1c 24             	mov    %ebx,(%esp)
 9b8:	e8 d3 fd ff ff       	call   790 <free>
        exit();
 9bd:	e8 41 fa ff ff       	call   403 <exit>
