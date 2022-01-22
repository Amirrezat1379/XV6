#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
    int number_of_readSystemCalls = getReadCount();
    printf(1, "number of read System calls is: %d\nsuccesful\n", number_of_readSystemCalls);
    exit();
}