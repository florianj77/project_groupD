#include "tempTrender.h"
#include <string>
#include <iostream>

void project() {
	string pathToFile = "/home/courseuser/project_groupD/project_groupD/easyToRead1200_Lund.txt"; //Put the path to your data file here
	//cout<<"File path = "<<pathToFile<<endl;
	tempTrender t(pathToFile); //Instantiate your analysis object
	
	t.tempOnDay(8, 23); //Call implemented function
	//t.tempOnDay(235);
	//t.tempPerDay();
	//t.hotCold();
	//t.tempPerYear(2050);
}
