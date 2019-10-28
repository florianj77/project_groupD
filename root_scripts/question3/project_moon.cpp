
	#include "tempTrender_moon.h"
	#include <string>
	#include <iostream>
	
	void project() {
		string pathToFile = "../../data_files/moonTemp_highQuality_Lund.txt"; //Put the path to data file, Southern Sweden
		
	
		tempTrender t(pathToFile); //Instantiate your analysis object
		
		//t.tempOnDay(12, 24); //Call implemented function
		t.moonTemp();
		
	}
