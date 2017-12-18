#include "SystemUptime.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>

#define MIB_SIZE 2

extern "C"
{
    int mib[MIB_SIZE];
    size_t size;
    struct timeval boottime;
    struct timeval now;
    struct timezone tz;

    float GetSystemUptime()
    {
        mib[0] = CTL_KERN;
        mib[1] = KERN_BOOTTIME;
        size = sizeof(boottime);

        gettimeofday(&now, &tz);

        float uptime = 0;
        if (sysctl(mib, MIB_SIZE, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
            uptime = now.tv_sec - boottime.tv_sec;
            uptime += (float)(now.tv_usec - boottime.tv_usec) / 1.e6;
        }

        return uptime;
    }
}
