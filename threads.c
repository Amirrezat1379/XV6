#include "types.h"
#include "stat.h"
#include "user.h"

int stack[4096] __attribute__ ((aligned (4096)));
int x = 0;

int main(int argc, char *argv[]) {
    int tid = thread_create(stack);
    // int tid = fork();

    if (tid < 0) {
        printf(2, "error world :| !!!!");
    }
    else if (tid == 0) {
        for(;;) {
            x++;
            sleep(100);
            if (x == 15)
                break;
        }
    }
    else {
        for(;;) {
            printf(1, "x = %d\n", x);
            sleep(100);
            if (x == 15)
                break;
        }
    }

    exit();
}