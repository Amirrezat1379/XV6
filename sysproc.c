#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int sys_thread_create(void) {
  int stackptr = 0;
  if (argint(0, &stackptr) < 0) {
    return -1;
  }
  return thread_create((void*) stackptr);
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int sys_join(void) {
  return join();
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
sys_getHelloWorld(void) {
  return getHelloWorld();
}

int
sys_getProcCount(void) {
  return getProcCount();
}

extern int readCount;

int sys_getReadCount(void) {
  cprintf("%d", readCount);
  return readCount;
}

int sys_getTurnaroundTime(void) {
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return getTurnaroundTime(pid);
}

int sys_getWaitingTime(void) {
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return getWaitingTime(pid);
}

int sys_getCpuBurstTime(void) {
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return getCpuBurstTime(pid);
}

int sys_setPriority(void) {
  int pid;
  int priority;

  if(argint(0, &pid) < 0)
    return -1;
  if(argint(0, &priority) < 0)
    return -1;
  return setPriority(pid, priority);
}

int sys_changePolicy(void) {
  int myPolicy;

  if(argint(0, &myPolicy) < 0)
    return -1;

  return changePolicy(myPolicy);
}

int sys_getAllTurnTime(void) {
  return getAllTurnTime();
}

int sys_getAllWaitingTime(void) {
  return getAllWaitingTime();
}

int sys_getAllRunningTime(void) {
  return getAllRunningTime();
}
