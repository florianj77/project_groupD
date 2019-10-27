#include <iostream>
#include "tempTrender.h"

tempTrender::tempTrender(string filePath) {
	cout << "The user supplied " << filePath << " as the path to the data file." << endl;
	cout << "You should probably store this information in a member variable of the class. Good luck with the project! :)" << endl;
	filePath = mfilePath;
}

tempTrender::~tempTrender() {}; //Destructor

//TempOnDay function
void tempTrender::tempOnDay (int monthToCalculate, int dayToCalculate){
	cout<<"Month = "<<monthToCalculate<<endl;
	cout<<"Day = "<<dayToCalculate<<endl;
}
