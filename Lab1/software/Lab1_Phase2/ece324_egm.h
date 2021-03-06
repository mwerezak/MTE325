
//#include "alt_types.h"
#include <stdio.h>
#include <unistd.h>
#include "system.h"
//#include "sys/alt_irq.h"
#include <io.h>

typedef struct TestStatistics {
	int period, duty_cycle, latency_res;
	int grain_size, tasks_compelete;
	int events_missed, latency, rel_latency;
} TestStatistics;


//header for lab 1 phase 2 support file
void init(int, int, TestStatistics*);
void finalize(TestStatistics*);
int background(int);
