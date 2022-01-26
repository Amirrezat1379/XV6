#include "types.h"
#include "stat.h"
#include "user.h"

#define NUM 10

int main(int argc, char *argv[])
{
    changePolicy(2);
    int main_pid = getpid();
    // int times[3] = {0, 0, 0};

    //make NUM child process
    for (int i = 0; i < NUM; i++)
    {
        int pid = fork();
        if (pid > 0) {
            setPriority(pid, (i / 5) + 1);
            break;
        }
    }
    
    if (main_pid != getpid())
    {
        //print pid with i
        for (int i = 0; i < NUM; i++){
            int pid = getpid();
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
        }

        
        int thisPid = getpid(); 
        int turnAroundTime = getTurnaroundTime(thisPid);
        int waitingTime = getWaitingTime(thisPid);
        int cbpTime = getCpuBurstTime(thisPid);
        // int thisPid = getpid(); 
        // int turnAroundTime = 0;
        // int waitingTime = 0;
        // int cbpTime = 0;
        // printf(1, "\n\n\nmikham wait konam\n\n\n");
    // changePolicy(0);   
        // wait();
        // sleep(10);
        // sum=cbpTime;
        // s[0] += sum;

        // printf(1,"cccccccccccppppptttttttttt suuummmm %d\n",sum);


        printf(1, " Process ID : %d\n", thisPid);
        printf(1,"--------------------------\n");
        printf(1, "| TurnAround Time = %d  | \n", turnAroundTime);
        printf(1, "| Waiting Time = %d     | \n", waitingTime);
        printf(1, "| CPU Burst Time = %d    | \n", cbpTime);
        printf(1, "\n\n");


    } else {
        wait();
        printf(1,"average Turnaround time = %d\n",getAllTurnTime() / NUM);
        printf(1,"average waiting time = %d\n",getAllWaitingTime() / NUM);
        printf(1,"average running time = %d\n",getAllRunningTime() / NUM);
    }

    while(wait() != -1);

    changePolicy(0);    
    exit();
}