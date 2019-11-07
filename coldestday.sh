#!/bin/bash

city=$@

echo "Do you want to include only high quality results? [y/n]"
read choice
if [[ ${choice} == "y" ]]; then
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' oneDayTemp_highQuality_$city.txt`
	NR=`awk 'END{print NR}' oneDayTemp_highQuality_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' oneDayTemp_highQuality_$city.txt`
	echo "Creating coldestday_HQ_$city.txt data file, this takes a few seconds"
	echo "\"Date\",\"Temperatur\"" > coldestday_HQ_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		awk -v start="${Date}" -v stop="${next_date}" 'BEGIN{a=100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2<a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' oneDayTemp_highQuality_$city.txt >> coldestday_HQ_$city.txt
		Date=${next_date}
	done
else
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' oneDayTemp_allEntries_$city.txt`
	NR=`awk 'END{print NR}' oneDayTemp_allEntries_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' oneDayTemp_allEntries_$city.txt`
	echo "Creating coldestday_$city.txt data file, this takes a few seconds"
	echo "\"Date\",\"Temperatur\"" > coldestday_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		awk -v start="${Date}" -v stop="${next_date}" 'BEGIN{a=100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2<a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' oneDayTemp_allEntries_$city.txt >> coldestday_$city.txt
		Date=${next_date}
	done	
fi




