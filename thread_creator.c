#include "types.h"
#include "stat.h"
#include "user.h"

#define PAGESIZE 4096

int thread_creator (void (*fn) (void *), void *args) {
    void *fptr = malloc(2 * PAGESIZE);
    void *stack;

    if (fptr == 0)
        return -1;
    
    int mod = (uint)fptr % PAGESIZE;

    if (mod == 0)
        stack = fptr;
    else
        stack = fptr + (PAGESIZE - mod);
    
    int thread_id = thread_create((void*)stack);

    if (thread_id < 0)
        printf(1, "Thread create faild :( !\n");
    else if (thread_id == 0) {
        (fn)(args);
        free(stack);
        exit();
    }
    return thread_id;
}
