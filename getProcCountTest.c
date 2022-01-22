#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
    int number_of_processes = getProcCount();
    printf(1, "number of processes is: %d\nsuccesful\n", number_of_processes);
    exit();
}