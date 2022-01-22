#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
//#include "umalloc.c"
//#include <stdlib.h>

//extern int readCount;

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


int
sys_getProcCount(void)
{
  return getProcCount();
} 

int
sys_getReadCount(void)
{
  return getReadCount();
}

// threadCreator as a systemcall and gets
// function pointer, void* arg and status as parameter
int
sys_threadCreate(void){
  /*void *arg, *fn;
  void * stack;
  int status;
  void * fptr = (void *)malloc(2 * PGSIZE);
  struct proc * curproc = myproc();
	
	if(argint(0, &fn) < 0
		|| argint(1, &arg) < 0
		|| argint(2, &status, 4) < 0)
		return -1;*/
	
  //cprintf("inside sys_clone %d\n", (uint)stack);

	// check the stack is page aligned
  //int mod = (uint)fptr % PGSIZE;
  //if (mod == 0)
    //stack = fptr;
  //else
    //stack = fptr + (PGSIZE - mod);  
	//if ((uint)stack % PGSIZE != 0)
		//return -1;
	
	/*//check if the address space is less than one page 
	if (curproc->sz - (uint)stack < PGSIZE)
		return -1;*/
	// call the create method in proc.c
  // and save the child's threadID
  //int child_tid = threadCreate((void *) stack);
	//int child_tid = threadCreate(fn, arg1, arg2, stack);
  // thread creation failed 
  //if (child_tid < 0)
    //cprintf("clone failed\n");
  //else if (child_tid == 0){
    // when the work is done with threads,
    // stack should be emptied
    //cprintf("salap");
    //kfree(stack);
    //kfree(curproc->kstack);
    //curproc->kstack = 0;
    //exit();
  //}  
   /*void *fptr = malloc((uint)2 * 4096);
    void * stack;
    int mod = (uint)fptr % 4096;
    if (mod == 0)
     stack = fptr;
    else
     stack = fptr + (4096 - mod); 

  return threadCreate(stack);*/
  int stack, status;
  cprintf("salap\n");
  if (argint(0, &stack) < 0 || argint(1, &status) < 0){
    return -1;
  }
  return threadCreate((void *) stack, (int) status);
  //return child_tid;

}

//This system call waits for a child thread that shares the address space with the 
//calling process.  It returns the PID of waited-for child or -1 if none. 
int
sys_threadWait(void) {
  //cprintf("inside sys_join %d\n", (uint)(*(char**)stack));
	return threadWait();
}

int
sys_cps(void){
  return cps();
}

int
sys_changePriorityOfProcess(void)
{
  int pid, priority;
  if(argint(0, &pid) < 0)
    return -1;
  if(argint(1, &priority) < 0)
    return -1;

  return changePriorityOfProcess(pid, priority);
}