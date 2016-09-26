#!/bin/bash
# author: nicolas.genibre@citrix.com
# date: 9/20/2016
# version: 1.0

# Place yourself in the directory containing the raw data
# tidy dataset output
> aggr.data

# Add headers
echo "Time,Filer,Aggregate,Total,Used,Free,UsageRatio" >> aggr.data

# Clean data for netapp-02
# make sure to know the number of aggregate and change the j loop with the right numbering
for i in `ls | grep 54`; do
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/BEGIN Iteration/,/[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]/p' | sed -n -e 's/.*\([[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]\).*/\1/p' > date1.out
	while read line; do for j in {1 2}; do echo "$line,netapp-02"; done; done < date1.out > date.out
	rm -rf date1.out
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/[POSTSTATS][PRESTATS] =-=-=-=-=-= df -A -m/,/df -A -m/p' | sed -n -e '/n[0-9]_aggr[0-9] /p' | sed -n -e 's/[A-Z][A-Z]//gp' | sed -n -e 's/%//gp' > aggr.out
	paste -d"," date.out aggr.out | sed -n -e 's/  */,/gp' >> aggr.data
	rm -rf date.out aggr.out
done

# Clean data for netapp-01
# make sure to know the number of aggregate and change the j loop with the right numbering
for i in `ls | grep 53`; do
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/BEGIN Iteration/,/[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]/p' | sed -n -e 's/.*\([[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]\).*/\1/p' > date1.out
	while read line; do for j in {1 2 3}; do echo "$line,netapp-01"; done; done < date1.out > date.out
	rm -rf date1.out
	sed -n -e '/BEGIN Iteration/,/END Iteration/p' $i | sed -n -e '/[POSTSTATS][PRESTATS] =-=-=-=-=-= df -A -m/,/df -A -m/p' | sed -n -e '/n[0-9]_aggr[0-9] /p' | sed -n -e 's/[A-Z][A-Z]//gp' | sed -n -e 's/%//gp' > aggr.out
	paste -d"," date.out aggr.out | sed -n -e 's/  */,/gp' >> aggr.data
	rm -rf date.out aggr.out
done

# Move out clean data from raw directory 
cat aggr.data | sed  -n -e 's/,.$/ /p' > ../aggr.data
dos2unix ../aggr.data
rm -rf aggr.data
