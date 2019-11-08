#include "tempTrender_moon.h"
#include <string>
#include <iostream>

void project() {
	string pathToFile = "/home/courseuser/project_groupD/project_groupD/moonTemp_Lund.txt"; //Put the path to data file, Southern Sweden
	//string pathToFile = "/home/courseuser/project_groupD-master/oneDayTemp_allEntries_Lulea.txt"; //Northern Sweden
	//string pathToFile = "/home/courseuser/project_groupD-master/oneDayTemp_allEntries_Karlstad.txt"; //Center of Sweden
	//cout<<"File path = "<<pathToFile<<endl;

	tempTrender t(pathToFile); //Instantiate your analysis object
	
	//t.tempOnDay(12, 24); //Call implemented function
	t.moonTemp();
	//t.tempOnDay(235);
	//t.tempPerDay();
	//t.hotCold();
	//t.tempPerYear(2050);
}
