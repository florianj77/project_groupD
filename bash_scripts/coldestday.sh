#!/bin/bash

city=$@

echo "Do you want to include only high quality results? [y/n]"
read choice
path=../data_files
if [[ ${choice} == "y" ]]; then
	if [[ -f ${path}/coldestday_HQ_$city.txt ]]; then
		rm ${path}/coldestday_HQ_$city.txt
		echo "1"
	fi
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' ${path}/oneDayTemp_highQuality_$city.txt`
	NR=`awk 'END{print NR}' ${path}/oneDayTemp_highQuality_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' ${path}/oneDayTemp_highQuality_$city.txt`
	echo "Creating coldestday_HQ_$city.txt data file, this takes a few seconds"
	touch ${path}/coldestday_HQ_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		stop_date=$(date +%Y-%m-%d -d "$next_date -1 day")
		awk -v start="${Date}" -v stop="${stop_date}" 'BEGIN{a=100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2<a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' ${path}/oneDayTemp_highQuality_$city.txt >> ${path}/coldestday_HQ_$city.txt
		Date=${next_date}
	done
else
	if [[ -f ${path}/coldestday_$city.txt ]]; then
		rm ${path}/coldestday_$city.txt
	fi
	
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' ${path}/oneDayTemp_allEntries_$city.txt`
	NR=`awk 'END{print NR}' ${path}/oneDayTemp_allEntries_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' ${path}/oneDayTemp_allEntries_$city.txt`
	echo "Creating coldestday_$city.txt data file, this takes a few seconds"
	touch ${path}/coldestday_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		stop_date=$(date +%Y-%m-%d -d "$next_date -1 day")
		awk -v start="${Date}" -v stop="${stop_date}" 'BEGIN{a=100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2<a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' ${path}/oneDayTemp_allEntries_$city.txt >> ${path}/coldestday_$city.txt
		Date=${next_date}
	done	
fi
