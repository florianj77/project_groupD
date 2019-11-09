#!/bin/bash

echo "###########################################################
Welcome to The Project work of Group D for MNXB01 2019

What would you like to do?

EX1: Average Temperature for a given day from 1961-2014 [1]

EX2: Hottest and coldest Temperature from 1961-2014 [2]

EX2: Compare the Weather with the moon cycle in Lund from 1961-2014 [3]

Exit: Exit the program [4]"


read Option

base=`pwd`
echo ${base}
if [ ${Option} == "1" ]; then

###Exercise 1

	#decide which city
	echo "For what city should this exercise be done?(Please enter just the city name: [City])
	OPTIONS:
	Boras Falsterbo Falun Lulea Lund Karlstad Soderarm Umea Visby"
	read city
	if [[ ${city} != "Lund" && ${city} != "Boras" && ${city} != "Falsterbo" && ${city} != "Falun" && ${city} != "Lulea"
		&& ${city} != "Karlstad" && ${city} != "Soderarm"	&& ${city} != "Umea" && ${city} != "Visby" ]];
	then
		echo "Invalid input"
		exit 1
	fi
	echo "Continuing with ${city}"
	
	#decide Quality

	echo "Do you want to only inculde high Quality data?[y/n]"
	read qualitychoice
	if [[ ${qualitychoice} == "y" ]];
	then 
		Quality="highQuality"
	elif [[ ${qualitychoice} == "n" ]];
	then
		Quality="allEntries"
	else 
		echo "Invalid Input"
		exit 1
	fi
	
	output=Q${1}_${city}_${Quality}.jpg
	
	#cleanup/prepare data
	
	if [[ -f ${base}/data_files/oneDayTemp_${Quality}_${city}.txt ]];
	then
		echo "Prepare the date for ${city}: (this can take a up to 5 minutes):"
		cd ${base}/bash_scripts
		./cleanup.sh ${city} ${Quality}
		cd ${base}
	
	else
		echo "Data file exist already"
	fi
	
	#run corresponding root script
	
	cd ${base}/root_scripts/question${Option}
	root 
	ech
	cd ${base}/pictures
	mv newpicture.jpg ${output}
	xdg-open ${output}
	
else
	
	exit 1
fi
elif (( ${Option} -eq "2" ));
then

####Exercise 2

	#decide which city
	echo "For what city should this exercise be done?(Please enter just the city name: [City])
	OPTIONS:
	Boras Falsterbo Falun Lulea Lund Karlstad Soderarm Umea Visby\n"
	read city
	
	if [[ ${city} != "Lund" && ${city} != "Boras" && ${city} != "Falsterbo" && ${city} != "Falun" && ${city} != "Lulea"
		&& ${city} != "Karlstad" && ${city} != "Soderarm"	&& ${city} != "Umea" && ${city} != "Visby" ]];
	then
		echo "Invalid input"
		exit 1
	fi
	echo "Continuing with ${city}"
	
	#decide Quality
	
	echo "Do you want to only include high Quality data?[y/n]"
	read qualitychoice
	if [[ ${qualitychoice} == "y" ]];
	then 
		Quality="highQuality"
	else if [[ ${qualitychoice} == "n" ]];
	then
		Quality="allEntries"
	else 
		echo "Invalid Input"
		exit 1
	fi

	output=Q${1}_${city}_${Quality}.jpg
	
	#cleanup/prepare data
	
	if [[ -f ${base}/data_files/oneDayTemp_${Quality}_${city}.txt ]]; then
		echo "Prepare the date for ${city}: (this can take a up to 5 minutes):"
		cd ${base}/bash_scripts
		./cleanup.sh ${city} ${Quality}
		cd ${base}
	else
		echo "Data file exist already"
	fi
	cd ${base}/bash_scripts
	./coldestday.sh ${city} ${Quality}
	./hottestday.sh ${city} ${Quality}
	cd ${base}
	#run corresponding root script
	
	cd ${base}/root_scripts/root_q${Option}
	#root
	#project()
	#.q
	cd ${base}/pictures
	mv newpicture.jpg ${output}
	xdg-open ${output} 

elif (( ${Option} == "3" ));
then 

	###Exercise 3
	city="Lund"
	
	#decide Quality
	
	echo "Do you want to only include high Quality data?[y/n]"
	read qualitychoice
	if [[ ${qualitychoice} == "y" ]];
	then 
		Quality="highQuality"
	else if [[ ${qualitychoice} == "n" ]];
	then
		Quality="allEntries"
	else 
		echo "Invalid Input"
		exit 1
	fi
	
	output=Q${1}_${city}_${Quality}.jpg
	
	#cleanup/prepare data
	
	if [[ -f ${base}/data_files/oneDayTemp_${Quality}_${city}.txt ]]
		echo "Prepare the date for ${city}: (this can take a up to 5 minutes):"
		cd ${base}/bash_scripts
		./cleanup.sh ${city} ${Quality}
		cd ${base}
	else
		echo "Data file exist already"
	fi
	
	#run corresponding root script
	
	moonTemp_final ${city} ${Quality}
	cd ${base}/root_scripts/root_q${Option}
	#root
	#project()
	#.q
	mv newpicture.jpg ${output}
	xdg-open ${output} 
else 
	echo "Invalid Option"
	exit 1
fi
