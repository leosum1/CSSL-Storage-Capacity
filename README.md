# CSSL-Storage-Capacity

We implement the NetApp Perfstat tool to run on a schedule for 16 days and capture 48 iterations of 15 minutes per day using the following command to determine capacity:

df -x -m (pre and prostats); df -A -m (pre and prostats); sysstat_x_1sec ; sysstat_x_5sec

