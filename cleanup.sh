#!/bin/bash

#just temporary files
touch temporary_file.csv
tmpFile=temporary_file.csv

#decide which file to clenaup
echo "The file of which city do you want to cleanup?(Please enter just the city name: [City])"
read file
echo $file

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
if [[ cleaned_${file}.csv ]]; then
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
if input==y; then
if [[ cleaned_${file}_highQuality.csv ]]; then
	echo "Deleting old file"
	rm cleaned_${file}_highQuality.csv
fi
echo "Removed"
fgrep "Y" cleaned_${file}.csv | wc -l
echo "low Quality entries"
grep "G" cleaned_${file}.csv >> cleaned_${file}_highQuality.csv
fi
rm $tmpFile
