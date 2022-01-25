#include "types.h"
#include "stat.h"
#include "user.h"

// number of children created
#define NUM 6
// int stack[4096] __attribute__ ((aligned (4096)));
int stack[4096] __attribute__ ((aligned (4096)));

int main(int argc, char *argv[])
{
    // changePolicy(1);
    int main_pid = getpid();
    int sum = 0;
    int s[1];
    s[0] = 0;


    //make NUM child process
    for (int i = 0; i < NUM; i++)
    {
        if (fork() > 0)
            break;
    }

    if (main_pid != getpid())
    {
        //print pid with i
        for (int i = 0; i < 8; i++){
            int pid = getpid();
            printf(1, "PID=/%d/ : i=/%d/\n",pid , i);
        }

        int thisPid = getpid(); 
        int turnAroundTime = getTurnaroundTime(thisPid);
        wait();
        int waitingTime = getWaitingTime(thisPid);
        int cbpTime = getCpuBurstTime(thisPid);
        printf(1,"cccccccccccppppptttttttttt %d\n",cbpTime);
        sum=cbpTime;
        s[0] += sum;

        printf(1,"cccccccccccppppptttttttttt suuummmm %d\n",sum);


        printf(1, " Process ID : %d\n", thisPid);
        printf(1,"--------------------------\n");
        printf(1, "| TurnAround Time = %d  | \n", turnAroundTime);
        printf(1, "| Waiting Time = %d     | \n", waitingTime);
        printf(1, "| CPU Burst Time = %d    | \n", cbpTime);
        printf(1, "\n\n");


    } else {
        wait();
        int t = s[0];
        printf(1,"assqwqwqwqwqdewwdweaw %d",t);

        // int turnarounds[NUM] = {0}; // turnaround times for each child
        // int waitings[NUM] = {0};    // waiting times for each child
        // int CBTs[NUM] = {0};        // CBTs for each child

        // int i = 0;
        // int turnAroundtime, waitingtime,  cbttime , pario;
        // while (wait2(&turnAroundtime, &waitingtime,  &cbttime , &pario) > 0)
        // {
        //     int childTurnaround = turnAroundtime;
        //     int childWaiting = waitingtime;
        //     int childCBT = cbttime;

        //     turnarounds[i] = childTurnaround;
        //     waitings[i] = childWaiting;
        //     CBTs[i] = childCBT;
        //     i++;
        // }


        // printf(1, "\n\n\n*****AVG Times in total*****\n");
        // int turnaroundsSum = 0;
        // int waitingsSum = 0;
        // int CBTsSum = 0;
        // for (int j = 0; j < NUM; j++)
        // {
        //     turnaroundsSum += turnarounds[j];
        //     waitingsSum += waitings[j];
        //     CBTsSum += CBTs[j];
        // }
        // printf(1, "Total -> AVG Turnaround: %d, AVG Waiting: %d, AVG CBT: %d\n",
        //        turnaroundsSum / NUM,
        //        waitingsSum / NUM,
        //        CBTsSum / NUM);
    }
    //print average

    //wait to finish
    // wait();

    
    exit();
}