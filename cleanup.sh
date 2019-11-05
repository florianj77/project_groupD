#!/bin/bash

#just a temporary file
touch temporary_file.csv
tmpFile=temporary_file.csv

#decide which file to clenaup
echo "The file of which city do you want to cleanup?(Please enter just the city name: [City])"
read file

if [ $file != "Karlstad" ]; then
	datafile=smhi-opendata_$file.csv
	echo "Your are working with" $datafile
else datafile=smhi-openda_$file.csv
	echo "Your are working with" $datafile
fi

if [[ ! $file ]]; then
	echo "Couldnt find file"
	exit 1
fi

#remove old file if it exists
if [[ -f cleaned_${file}.csv ]]; then
	echo "Deleting old file csx"
	rm cleaned_$file.csv
fi

#creating header for cleaned file
echo "Creating header for cleaned_$file.csv data file"
echo "\"Date\",\"Time\",\"Temperatur\",\"Quality\"" > cleaned_$file.csv

#selecting only lines which start with YYYY-MM-DD followed by a semicolon
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\; $datafile > ${tmpFile}

#printing only the date, time, temperatur and quality seperated by a ; to the file
awk -F ";" '{print $1";"$2";"$3";"$4}' ${tmpFile}>>cleaned_$file.csv

#ask if one wants to make a file with only high quality results
echo "Do you want to make a file with only high Quality results?[y/n]"
read input
if [ $input == "y" ]; then
	if [[ -f cleaned_${file}_highQuality.csv ]]; then
	echo "Deleting old file"
	rm cleaned_${file}_highQuality.csv
	fi
echo "Removed"
fgrep "Y" cleaned_${file}.csv | wc -l
echo "low Quality entries"
grep "G" cleaned_${file}.csv >> cleaned_${file}_highQuality.csv
fi
 
#date=`awk -F ";" 'NR==1{print $1}' ${tmpFile}`
#echo $date

#Make a file containing the average tmeperature of a day, Format: date averageTemperature
Date=`awk -F ";" 'NR==1 {print $1}' ${tmpFile}`
echo ${Date}
last_date=`awk -F ";" 'END {print $1}' ${tmpFile}`
echo ${last_date}
rm oneDayTemp.txt
touch oneDay.txt
touch oneDayTemp_${file}.txt
oneDay=oneDay.txt
oneDayTemp=oneDayTemp_${file}.txt
#increase starting date by one day for each i
echo "Calculating the average Temperature per day, this can take a while"
while [[ "${Date}" < "${last_date}" ]]
do 
	next_date=$(date +%Y-%m-%d -d "$Date +$i day")
	#grep only the lines with the same date
	egrep ^${next_date} ${tmpFile}>${oneDay}
	#get the number of entries per day
	lines=`cat $oneDay | wc -l`
	#make a file with the date and the average of the temperature of thaht day
	awk -F ";" -v date="$next_date" -v line="$lines" '{sum += $3} END {print date" "sum/line}' ${oneDay}>>${oneDayTemp}
	rm ${oneDay}
	Date=${next_date}
done
 
# store in easy readable format for c++
if [[ -f easyToRead0600_${file}.txt ]]; then
	rm easyToRead0600_${file}.txt
fi
if [[ -f easyToRead1200_${file}.txt ]]; then
	rm easyToRead1200_${file}.txt
fi
if [[ -f easyToRead1800_${file}.txt ]]; then
	rm easyToRead1800_${file}.txt
fi

#all data at 06:00
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\;06 $datafile > ${tmpFile}
awk -F ";" '{print $1" "$3}' ${tmpFile}>>easyToRead0600_${file}.txt

#all data at 12:00
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\;12 $datafile > ${tmpFile}
awk -F ";" '{print $1" "$3}' ${tmpFile}>>easyToRead1200_${file}.txt

#all data at 18:00
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\;18 $datafile > ${tmpFile}
awk -F ";" '{print $1" "$3}' ${tmpFile}>>easyToRead1800_${file}.txt





#rm $tmpFile

