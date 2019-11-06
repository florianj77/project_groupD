#!/bin/bash

city="Lund"

echo "creating moonTemp_${city}.txt file"
rm moonTemp_${city}.txt
touch moonTemp_${city}.txt
output=moonTemp_${city}.txt
Date=`awk 'NR==2 {print $1}' moonphases_2014.txt`
final_date=`awk 'END {print $1}' moonphases_2014.txt`
#next_date="2014-01-16"
NR=`awk 'END{print NR}' moonphases_2014.txt`
for i in $(seq 0 26)
do
	echo ${i}
	next_date=`awk -v pattern="${Date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
	echo ${Date}
	echo ${next_date}
	test1=$(date +%Y-%m-%d -d "$Date +1 year")
	test2=$(date +%Y-%m-%d -d "$next_date +1 year")
	echo${test1}
	echo${test2}
	minimum=`awk -v start="${Date}" -v stop="${next_date}" 'BEGIN{a=100} $1 == start,$1 == stop {if ($2<a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_Lund.txt`
	maximum=`awk -v start="${Date}" -v stop="${next_date}" 'BEGIN{a=-100} $1 == start,$1 == stop {if ($2>a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_Lund.txt`
	echo ${minimum}
	echo ${maximum}
	awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${next_date}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' oneDayTemp_allEntries_Lund.txt >> moonTemp_${city}.txt
	#awk -v start="${Date}" -v stop="${next_date}" 
	awk 'NR == 1 {print $0" "$0}' moonphases_2014.txt >> moonTemp_${city}.txt
	Date=${next_date}
done
#Ok ich werde ab hier mal aufhören. Dieser erro ist das schlimmste
#was ich jeh in meinem Leben gesehen habe.
#Also offensichtlich scheint es so zu sein, dass er die Daten nicht
#als richtige marker erkennt. Z.b. kann man nicht wie sonst das Datum
#mit dem Ueblichen befehl ändern
#ich habe diesen ersten satz aus moonphases genutzt
#damit kann man sehen wann eine loop angefangen hat und endet
#bin ab morgen wieder dran.
#aber komischer weise funktioniert es dann wieder fuer manche blöcke 
#so wie es sollte arghhhhhhh
