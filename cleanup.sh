#!/bin/bash
touch temporary_file.csv
tmpFile=temporary_file.csv
#remove old file if it exists
if [[ cleaned_Lund.csv ]]; then
	echo "Deleting old file"
	rm cleaned_Lund.csv
fi

#creating header for cleaned file
echo "Creating header for cleaned_Lund.csv data file"
echo "\"Date\",\"Time\",\"Temperatur\",\"Quality\"" > cleaned_Lund.csv

#selecting only lines which start with YYYY-MM-DD followed by a semicolon
egrep ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\; smhi-opendata_Lund.csv > ${tmpFile}
#printing only the date, time, temperatur and quality seperated by a ; to the file
awk -F ";" '{print $1";"$2";"$3";"$4}' ${tmpFile}>>cleaned_Lund.csv

rm $tmpFile
