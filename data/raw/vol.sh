#!/bin/bash
# author nicolas.genibre@citrix.com
# date 9/20/2016
# version 1.0

# Place yourself in the directory containing the raw data
# tidy dataset output
> vol.data

# Add headers
echo "Time,Filer,Volume,Total,Used,Free,UsageRatio" >> vol.data

# Clean data for netapp-02
# make sure to know the number of volume (not coun ting vol0) and change the j loop with the right number
for i in `ls | grep 54`; do
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/BEGIN Iteration/,/[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]/p' | sed -n -e 's/.*\([[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]\).*/\1/p' > date1.out
	while read line; do for j in {1 2 3 4 5 6 7 8 9 10 11}; do echo "$line,netapp-02"; done; done < date1.out > date.out
	rm -rf date1.out
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/POSTSTATS =-=-=-=-=-= df -x -m/,/--- EXE-TIME of /p' | sed -n -e '/vs1_/p' | sed -n -e 's/[A-Z][A-Z]//gp' | sed -n -e 's/%//gp' | sed -n -e 's/\/vol\///gp' | sed -n -e 's/\///gp' | awk '{print $1","$2","$3","$4","$5}' > vol.out
	paste -d"," date.out vol.out >> vol.data
	rm -rf date.out vol.out
done

# Clean data for netapp-01
# make sure to know the number of aggregate and change the j loop with the right number
for i in `ls | grep 53`; do
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/BEGIN Iteration/,/[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]/p' | sed -n -e 's/.*\([[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]\).*/\1/p' > date1.out
	while read line; do for j in {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24}; do echo "$line,netapp-01"; done; done < date1.out > date.out
	rm -rf date1.out
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/POSTSTATS =-=-=-=-=-= df -x -m/,/--- EXE-TIME of /p' | sed -n -e '/vs1_/p' | sed -n -e 's/[A-Z][A-Z]//gp' | sed -n -e 's/%//gp' | sed -n -e 's/\/vol\///gp' | sed -n -e 's/\///gp' | awk '{print $1","$2","$3","$4","$5}' > vol.out
	paste -d"," date.out vol.out >> vol.data
	rm -rf date.out vol.out
done

# Move out clean data from raw directory 
cat vol.data > ../vol.csv
dos2unix ../vol.csv
rm -rf vol.data
