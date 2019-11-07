#!/bin/bash

city="Lund"

echo "creating moonTemp_${city}.txt file"
if [[ -f moonTemp_${city}.txt ]]; then
	rm moonTemp_${city}.txt
fi
for i in {0..11}
do
if [[ -f new_${i} ]]; then
	rm new_${i}
fi
if [[ -f full_${i} ]]; then
	rm full_${i}
fi
done
touch moonTemp_${city}.txt
output=moonTemp_${city}.txt
Date=`awk 'NR==2 {print $1}' moonphases_2014.txt`
final_date=`awk 'END {print $1}' moonphases_2014.txt`
#next_date="2014-01-16"
#NR=`awk 'END{print NR}' moonphases_2014.txt`
for i in $(seq 0 11)
do
	echo "i= "${i}
	next_date=`awk -v pattern="${Date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
	echo ${Date}
	#echo ${next_date}
	new_moon=`awk -v pattern="${next_date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
	#test1=$(date +%Y-%m-%d -d "$Date +1 year")
	test2=$(date +%Y-%m-%d -d "$new_moon -1 day")
	#echo ${test1}
	echo ${test2}
	#get the min and max temp of the time span between Date and next_date
	#minimum=`awk -v start="${Date}" -v stop="${test2}" 'BEGIN{a=100} $1 == start,$1 == stop {if ($2<a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_${city}.txt`
	#maximum=`awk -v start="${Date}" -v stop="${test2}" 'BEGIN{a=-100} $1 == start,$1 == stop {if ($2>a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_${city}.txt`
	#echo ${minimum}
	#echo ${maximum}
	for j in $(seq 0 28)
	do 
		following_day=$(date +%Y-%m-%d -d "$Date +$j day")
		egrep ^${following_day} oneDayTemp_allEntries_${city}.txt>>testfile_$i.txt	
	done
	#awk '{print>"testfile_$i.txt"(NR>(n/2)?2:1)}' n="$(wc -l <"testfile_$i.txt")" testfile_$i.txt>>xyz.txt
	#total_lines=`cat testfile_$i.txt | wc -l`
	#echo "lines "$total_lines
	
	awk -v u="${i}" -v len=$(wc -l < testfile_$i.txt) '
	BEGIN {outfile="new_"u}
	NR>len/2 {outfile="full_"u}
		{print $0 > outfile } 
	' testfile_$i.txt
	minimum=`awk 'BEGIN{a=100}  {if ($2<a) {a=$2} fi} END{print a}' testfile_$i.txt`
	maximum=`awk 'BEGIN{a=-100} {if ($2>a) {a=$2} fi} END{print a}' testfile_$i.txt`
	echo ${minimum}
	echo ${maximum}
	#moon=0
	for k in $(seq 0 28)
	do 
		following_day=$(date +%Y-%m-%d -d "$Date +$k day")
		#egrep ^${following_day} oneDayTemp_allEntries_${city}.txt>>testfile_$i.txt
		awk -v min="${minimum}" -v max="${maximum}" -v day="${following_day}" '$0 ~ day {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_temp_${city}.txt	
	done
	#grep "${Date}" oneDayTemp_allEntries_${city}.txt>>testfile.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' oneDayTemp_allEntries_${city}.txt >> moonTemp_${city}.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_${city}.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_${city}.txt
	#awk -v start="${Date}" -v stop="${next_date}" 
	#awk 'NR == 1 {print $0" "$0}' moonphases_2014.txt >> moonTemp_${city}.txt
	rm testfile_$i.txt
	
	Date=${new_moon}
	
done
#rm moonTemp_temp_${city}.txt
#exit 1
Date=`awk 'NR==2 {print $1}' moonphases_2014.txt`
echo $Date
for i in {0..11}
do
	moon=0
	for j in {1..15}
	do
		next_tag=$(date +%Y-%m-%d -d "$Date +$j day")
		#moon=$((moon+7))
		#echo $moon
		awk -v mond="${moon}" -v day="${next_tag}" '$0 ~ day {print $1" "$2" "((mond+(100/15)))}' moonTemp_temp_${city}.txt>>moonTemp_${city}.txt
		moon=`awk 'END{print $NF}' moonTemp_${city}.txt` 
		echo $moon
		
	done
	Date=$(date +%Y-%m-%d -d "$Date +15 day")
	echo $Date
	moon2=100
	for k in {0..14}
	do
		next_tag=$(date +%Y-%m-%d -d "$Date +$k day")
		#moon=$((moon+7))
		#echo $moon
		awk -v mond="${moon2}" -v day="${next_tag}" '$0 ~ day {print $1" "$2" "((mond-(100/15)))}' moonTemp_temp_${city}.txt>>moonTemp_${city}.txt
		moon2=`awk 'END{print $NF}' moonTemp_${city}.txt` 
		echo $moon2
	done
	Date=$(date +%Y-%m-%d -d "$Date +15 day")
done
rm moonTemp_temp_${city}.txt
##Edit: changed the code a little bit, now it works to make the 
#moonTemp_$city.txt file containnid the date 
#and the percentage of the temp


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
