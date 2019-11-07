#!/bin/bash

city=$@

echo "Creating header for coldestday_$city.csv data file"
echo "\"Year\",\"Temperatur\"" > coldestday_$city.txt
Date=`awk '$1~/-01-01/ {print $1; exit 1}' oneDayTemp_allEntries_$city.txt`
echo ${Date}
NR=`awk 'END{print NR}' oneDayTemp_allEntries_$city.txt`
echo ${NR}
next_date=$(date +%Y-%m-%d -d "$Date +$i year")
final_date=`awk 'END {print $1}' oneDayTemp_allEntries_$city.txt` 
echo ${final_date}
while [[ "${Date}" < "${final_date}" ]]
do
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	echo ${Date}
	echo ${next_date}
	awk -v start="${Date}" -v stop="${next_date}" 'BEGIN{a=100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2<a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' oneDayTemp_allEntries_$city.txt >> coldestday_$city.csv
	Date=${next_date}
done	
	




