#include "types.h"
#include "stat.h"
#include "user.h"
#include "mmu.h"

int main(){
    int pid = fork();
    if (pid < 0)
        printf(1, "Error in fork\n");
    else{
        if (pid == 0){
            //child
            //printf(1, "child: ", getpid());
            cps();
        }
        else{
            //printf(1, "parent: ", getpid());
            wait();
            cps();
        }
    }    
    //cps();
    exit();
}