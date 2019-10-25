#include "tempTrender.h"
#include <string>
#include <iostream>

void project() {
	string pathToFile = "/home/courseuser/project_groupD/project_groupD/cleaned_Lund.csv"; //Put the path to your data file here
	//cout<<"File path = "<<pathToFile<<endl;
	tempTrender t(pathToFile); //Instantiate your analysis object
	
	t.tempOnDay(8, 23); //Call some functions that you've implemented
	//t.tempOnDay(235);
	//t.tempPerDay();
	//t.hotCold();
	//t.tempPerYear(2050);
}
