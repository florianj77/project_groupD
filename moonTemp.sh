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
lines=`awk 'END{print NR}' moonphases_2014.txt`
range=`awk -v lines=${lines} 'BEGIN{print ((lines-2)/2)-1}'`
echo $range
for i in $(seq 0 $range)
do
	next_date=`awk -v pattern="${Date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
	#echo ${Date}
	#echo ${next_date}
	new_moon=`awk -v pattern="${next_date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
	#test1=$(date +%Y-%m-%d -d "$Date +1 year")
	test2=$(date +%Y-%m-%d -d "$new_moon -1 day")
	#echo "new_moon" $new_moon
	#echo "test2" $test2
	#echo ${test1}
	#echo ${test2}
	#get the min and max temp of the time span between Date and next_date
	#minimum=`awk -v start="${Date}" -v stop="${test2}" 'BEGIN{a=100} $1 == start,$1 == stop {if ($2<a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_${city}.txt`
	#maximum=`awk -v start="${Date}" -v stop="${test2}" 'BEGIN{a=-100} $1 == start,$1 == stop {if ($2>a) {a=$2} fi} END{print a}' oneDayTemp_allEntries_${city}.txt`
	#echo ${minimum}
	#echo ${maximum}
	count=0
	#for j in $(seq 0 28) ##while
	following_day=$(date +%Y-%m-%d -d "$Date +$count day")
	while [[ "${following_day}" < "${test2}" ]]
	do 
		following_day=$(date +%Y-%m-%d -d "$Date +$count day")
		egrep ^${following_day} oneDayTemp_allEntries_${city}.txt>>testfile_$i.txt	
		count=$((count+1))
	done
	#length=`wc -l <testfile_$i.txt`
	#actual_length=$length+1
	awk -v u="${i}" -v len=$(wc -l <testfile_$i.txt) ' 
	BEGIN {outfile="new_"u}
	(NR-1)>len/2 {outfile="full_"u}
		{print $0 > outfile } 
	' testfile_$i.txt
	minimum=`awk 'BEGIN{a=100}  {if ($2<a) {a=$2} fi} END{print a}' testfile_$i.txt`
	maximum=`awk 'BEGIN{a=-100} {if ($2>a) {a=$2} fi} END{print a}' testfile_$i.txt`
	#echo ${minimum}
	#echo ${maximum}
	#for k in $(seq 0 28)
	count=0
	following_day=$(date +%Y-%m-%d -d "$Date +$count day")
	while [[ "${following_day}" < "${new_moon}" ]] 
	do 
		following_day=$(date +%Y-%m-%d -d "$Date +$count day")
		#egrep ^${following_day} oneDayTemp_allEntries_${city}.txt>>testfile_$i.txt
		awk -v min="${minimum}" -v max="${maximum}" -v day="${following_day}" '$0 ~ day {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_temp_${city}.txt
		count=$((count+1))	
	done
	rm testfile_${i}.txt
	#grep "${Date}" oneDayTemp_allEntries_${city}.txt>>testfile.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' oneDayTemp_allEntries_${city}.txt >> moonTemp_${city}.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_${city}.txt
	#awk -v min="${minimum}" -v max="${maximum}" -v start="${Date}" -v stop="${test2}" '$1 == start,$1 == stop {print $1" "(($2-min)/(max-min))}' testfile_${i}.txt >> moonTemp_${city}.txt
	#awk -v start="${Date}" -v stop="${next_date}" 
	#awk 'NR == 1 {print $0" "$0}' moonphases_2014.txt >> moonTemp_${city}.txt
	
	Date=${new_moon}
	
done
#Date=`awk 'NR==2 {print $1}' moonphases_2014.txt`
#echo $Date
#for i in $(seq 0 $range)
#do
#	next_date=`awk -v pattern="${Date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
#	moon=0
#	j=0
#	next_tag=$(date +%Y-%m-%d -d "$Date +$j day")
#	while [[ "${next_tag}" < "${next_date}" ]]
#	do
#
#		awk -v mond="${moon}" -v day="${next_tag}" '$0 ~ day {print $1" "$2" "((mond+(100/15)))}' moonTemp_temp_${city}.txt>>moonTemp_${city}.txt
#		moon=`awk 'END{print $NF}' moonTemp_${city}.txt` 
#		j=$((j+1))
#		next_tag=$(date +%Y-%m-%d -d "$Date +$j day")
#		
#	done
#	Date=${next_date}
#	next_date=`awk -v pattern="${Date}" '$0 ~ pattern {getline; print}' moonphases_2014.txt`
#	one_cycle=$(date +%Y-%m-%d -d "$next_date -1 day")
#	moon2=100
#	k=0
#	next_tag=$(date +%Y-%m-%d -d "$Date +$k day")
#	while [[ "${next_tag}" < "${one_cycle}" ]]
#	do
#		next_tag=$(date +%Y-%m-%d -d "$Date +$k day")
#		awk -v mond="${moon2}" -v day="${next_tag}" '$0 ~ day {print $1" "$2" "((mond-(100/15)))}' moonTemp_temp_${city}.txt>>moonTemp_${city}.txt
#		moon2=`awk 'END{print $NF}' moonTemp_${city}.txt` 
#		k=$((k+1))
#
#	done
#	Date=${next_date}
#done
#rm moonTemp_temp_${city}.txt


for i in {0..11}
do
lines=`wc -l <new_$i`
awk -v lin="${lines}" '{if(NR==1) print $3=0; else  print $3=(NR-1)/(lin)}' new_$i >>tempfile1_$i
lines=`wc -l <full_$i`
awk -v lin="${lines}" '{if(NR==14) print ($1" "$2" "1); else  print $1" "$2" "(NR)/(lin)}' full_$i >>outfile_$i
awk '{a[i++]=$3} END {while(i--) print a[i]}' outfile_$i >> tempfile_$i

cat tempfile1_$i >> gesamt
cat tempfile_$i >> gesamt
rm tempfile_$i
rm tempfile1_$i
rm outfile_$i
done

paste -d ' ' moonTemp_temp_${city}.txt gesamt >> moonTemp1_${city}.txt
rm gesamt
rm moonTemp_temp_${city}.txt

awk '{print $0, (sqrt(($2-$3)*($2-$3))*100)}' moonTemp1_${city}.txt >> moonTemp_${city}.txt

rm moonTemp1_${city}.txt

for i in {0..11}
do
	if [[ -f new_${i} ]]; then
		rm new_${i}
	fi
	if [[ -f full_${i} ]]; then
		rm full_${i}
	fi
done
