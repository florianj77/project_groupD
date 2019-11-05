#include "tempTrender.h"
#include <string>
#include <iostream>

void project() {
	string pathToFile = "/home/courseuser/project_groupD/project_groupD/oneDayTemp_allEntries_Lund.txt"; //Put the path to your data file here
	//string pathToFile = "/home/courseuser/project_groupD/project_groupD/oneDayTemp_allEntries_Lulea.txt";
	//cout<<"File path = "<<pathToFile<<endl;

	tempTrender t(pathToFile); //Instantiate your analysis object
	
	t.tempOnDay(2, 24); //Call implemented function
	//t.tempOnDay(235);
	//t.tempPerDay();
	//t.hotCold();
	//t.tempPerYear(2050);
}
