#include "types.h"
#include "stat.h"
#include "user.h"
#include "mmu.h"

int stack[4096] __attribute__ ((aligned (4096)));
int thread_creator(void (*fn) (void *), void *arg, int status){
    //void *arg, *fn;

    // last comment
    //void * stack = malloc(2 * PGSIZE);

    //int status;
    //void * fptr = (void *)malloc(2 * PGSIZE);
    //struct proc * curproc = myproc();

    // check the stack is page aligned
    /*int mod = (uint)fptr % PGSIZE;
    if (mod == 0)
        stack = fptr;
    else
        stack = fptr + (PGSIZE - mod); */
    // last comment   
    //stack = (void *) PGROUNDUP((uint)stack);
    printf(1, "stack is %d\n", stack);
    // call the create method in proc.c
    // and save the child's threadID
    int child_tid = threadCreate(stack, status);   
    // thread creation failed 
    if (child_tid < 0)
        printf(1, "clone failed\n");
    else if (child_tid == 0){
        // when the work is done with threads,
        // stack should be emptied
        printf(1, "salap\n");
        (fn)(arg);
        free(stack);
        //kfree(curproc->kstack);
        //curproc->kstack = 0;
        exit();
    }  
    return child_tid;
}
int x = 0;
void salap(void * arg){
    printf(1, "arg is %d\n", arg);
    while (x < 8){
        x++;
        sleep(100);
    }
}

int main(){
    int salam = 3;
    thread_creator(salap, (void *)salam, 1);
    while (x < 7){
        printf(1, "x = %d\n", x);
        sleep(100);
    }
    threadWait();
    exit();
}