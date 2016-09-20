## Introduction

What is the Capacity trend of the Cluster NetApp storage in Fort Lauderdale Laboratory?

We implemented the NetApp Perfstat tool to run on a schedule for 16 days and capture 48 iterations of 15 minutes each day using the following command to determine capacity:

df -x -m (pre and prostats); df -A -m (pre and prostats); sysstat_x_1sec ; sysstat_x_5sec

## Clean Data

The data is composed of 32 files, 16 files per NetApp controller. Each files are plain text output from the iterations in time for a day.

## Descriptive Analysis
