#!/bin/bash

#decide which file to clenaup
echo "The file of which city do you want to cleanup?(Please enter just the city name: [City])"
read file

if [ $file != "Karlstad" ]; then
	datafile=smhi-opendata_$file.csv
	echo "Your are working with" $datafile
else datafile=smhi-openda_$file.csv
	echo "Your are working with" $datafile
fi

if [[ ! $datafile ]]; then
	echo "Couldnt find file"
	exit 1
fi

########making temporary file to work with##################
#temporary working files
touch temporary_file.csv
tmpFile=temporary_file.csv
#selecting only lines which start with YYYY-MM-DD followed by a semicolon
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\; $datafile > ${tmpFile}

#########making file containing the average temperature of each day, all temperatures included####
# Get the earliest date with a measured temperature
earliestDate=`awk -F ";" 'NR==1{print $1}' ${tmpFile}`
#echo $earliestDate
date1=`date -d "$earliestDate" "+%s"`
#echo $date1
#Get the latest date with a measured temp
latestDate=`awk -F ";" 'END{print $1}' ${tmpFile}`
date2=`date -d "$latestDate" "+%s"`
#echo "date 2" $date2
#Get the difference between the eraliest and latest entry in seconds
diff=$(($date2-$date1))
#echo $diff
#Get the days between the earliest and latest dates (+1 to include also the last day)
days=$(($diff/(60*60*24)+1))
#echo $days

# temporary working files
touch oneDay.txt
oneDay=oneDay.txt
#Make a file containing the average tmeperature of a day, Format: date averageTemperature
if [[ -f oneDayTemp_allEntries_${file}.txt ]]; then
	rm oneDayTemp_allEntries_${file}.txt
fi

touch oneDayTemp_allEntries_${file}.txt
oneDayTemp_allEntries=oneDayTemp_allEntries_${file}.txt
echo "generating file, this can take a few minutes..."

#increase starting date by one day for each i
Date=`awk -F ";" 'NR==1 {print $1}' ${tmpFile}`
last_date=`awk -F ";" 'END {print $1}' ${tmpFile}`
end_date=$(date +%Y-%m-%d -d "$last_date +$i day")
while [[ "${Date}" < "${end_date}" ]]
do 
	next_date=$(date +%Y-%m-%d -d "$Date +$i day")
	#grep only the lines with the same date
	egrep ^${next_date} ${tmpFile}>${oneDay}
	#get the number of entries per day
	lines=`cat $oneDay | wc -l`
	#make a file with the date and the average of the temperature of thaht day
	awk -F ";" -v date="$Date" -v line="$lines" '{sum += $3} END {print date" "sum/line}' ${oneDay}>>${oneDayTemp_allEntries}
	rm ${oneDay}
	Date=${next_date}
done
echo "Created file" $oneDayTemp_allEntries "with average temperature results of each day, containing low and high quality results."

####making a file that contains the average temp per day using only high quality results#####

#temporary working files
touch tmpFile_highQuality.txt
tmpFile_highQuality=tmpFile_highQuality.txt
touch oneDay_highQuality.txt
oneDay_highQuality=oneDay_highQuality.txt

#Get only good quality results
grep "G" ${tmpFile} >> ${tmpFile_highQuality}

# Get the earliest date with a measured temperature
earliestDate_highQuality=`awk -F ";" 'NR==1{print $1}' ${tmpFile_highQuality}`
#echo $earliestDate
date1_highQuality=`date -d "$earliestDate_highQuality" "+%s"`
#echo $date1
#Get the latest date with a measured temp
latestDate_highQuality=`awk -F ";" 'END{print $1}' ${tmpFile_highQuality}`
date2_highQuality=`date -d "$latestDate_highQuality" "+%s"`
#echo "date 2" $date2
#Get the difference between the eraliest and latest entry in seconds
diff_highQuality=$(($date2_highQuality-$date1_highQuality))
#echo $diff
#Get the days between the earliest and latest dates (+1 to include also the last day)
days_highQuality=$(($diff_highQuality/(60*60*24)+1))
#echo $days
#Make a file containing the average tmeperature of a day, Format: date averageTemperature
if [[ -f oneDayTemp_highQuality_${file}.txt ]]; then
	rm oneDayTemp_highQuality_${file}.txt
fi

touch oneDayTemp_highQuality_${file}.txt
oneDayTemp_highQuality=oneDayTemp_highQuality_${file}.txt

echo "generating next file, this can take a few minutes..."

#increase starting date by one day for each i
for i in $(seq 0 $days_highQuality)
do 
	next_date_highQuality=$(date +%Y-%m-%d -d "$earliestDate_highQuality +$i day")
	#grep only the lines with the same date
	egrep ^${next_date_highQuality} ${tmpFile_highQuality}>${oneDay_highQuality}
	#get the number of entries per day
	lines_highQuality=`cat $oneDay_highQuality | wc -l`
	#make a file with the date and the average of the temperature of thaht day
	awk -F ";" -v date="$next_date_highQuality" -v line="$lines_highQuality" '{sum += $3} END {print date" "sum/line}' ${oneDay_highQuality}>>${oneDayTemp_highQuality}
	rm ${oneDay_highQuality}
done

echo "Created file" $oneDayTemp_highQuality "with average temperature results of each day, containig only high quality results."

rm ${tmpFile}
rm ${tmpFile_highQuality}
