#!/bin/bash

city=$1
Quality=$2

path=../data_files


if [[ ${Quality} == "highQuality" ]]; then
	if [[ -f ${path}/coldestday_highQuality_$city.txt ]]; then
		rm ${path}/coldestday_highQuality_$city.txt
	fi
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' ${path}/oneDayTemp_highQuality_$city.txt`
	NR=`awk 'END{print NR}' ${path}/oneDayTemp_highQuality_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' ${path}/oneDayTemp_highQuality_$city.txt`
	echo "Creating hottestday_highQuality_$city.txt data file, this takes a few seconds"
	touch ${path}/hottestday_highQuality_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		stop_date=$(date +%Y-%m-%d -d "$next_date -1 day")
		awk -v start="${Date}" -v stop="${stop_date}" 'BEGIN{a=-100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2>a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' ${path}/oneDayTemp_highQuality_$city.txt >> ${path}/hottestday_highQuality_$city.txt
		Date=${next_date}
	done
else
	if [[ -f ${path}/hottestday_allEntries_$city.txt ]]; then
		rm ${path}/hottestday_allEntries_$city.txt
	fi
	
	Date=`awk '$1~/-01-01/ {print $1; exit 1}' ${path}/oneDayTemp_allEntries_$city.txt`
	NR=`awk 'END{print NR}' ${path}/oneDayTemp_allEntries_$city.txt`
	next_date=$(date +%Y-%m-%d -d "$Date +$i year")
	final_date=`awk 'END {print $1}' ${path}/oneDayTemp_allEntries_$city.txt`
	echo "Creating hottestday_$city.txt data file, this takes a few seconds"
	touch ${path}/hottestday_allEntries_$city.txt
	while [[ "${Date}" < "${final_date}" ]]
	do
		next_date=$(date +%Y-%m-%d -d "$Date +$i year")
		stop_date=$(date +%Y-%m-%d -d "$next_date -1 day")
		awk -v start="${Date}" -v stop="${stop_date}" 'BEGIN{a=-100; b=substr($1,1,4)} $1 == start,$1 == stop {if ($2>a) {a=$2; b=substr($1,1,4)} fi} END{print b" "a}' ${path}/oneDayTemp_allEntries_$city.txt >> ${path}/hottestday_allEntries_$city.txt
		Date=${next_date}
	done	
fi
