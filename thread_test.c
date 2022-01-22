#include "types.h"
#include "stat.h"
#include "user.h"
//#include "mmu.h"
int stack[4096] __attribute__ ((aligned (4096)));

int x = 0;
int main(int argc, char * argv[]){
    /*void *fptr = malloc((uint)2 * 4096);
    void * stack;
    int mod = (uint)fptr % 4096;
    if (mod == 0)
     stack = fptr;
    else
     stack = fptr + (4096 - mod);  */

    int tid = threadCreate(stack, 1);
    printf(1, "tid = %d\n", tid);
    if (tid < 0){
        printf(2, "kir\n");
    }
    else if (tid == 0){
        
        for (;;){
            x++;
            //printf(1, "x = %d\n", x);
            sleep(100);
        }
    }
    else{
        for (;;){
            printf(1, "x= %d\n", x);
            sleep(100);
        }
    }
    exit();
}