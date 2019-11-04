//include C++ STL headers
#include <iostream>
#include <fstream>

#include "TMath.h"

//own files
#include "tempTrender.h"

//ROOT library objects
#include "TH1.h"
#include "TCanvas.h"
//using namespace std;
tempTrender::tempTrender(string filePath) {
	//cout << "The user supplied " << filePath << " as the path to the data file." << endl;
	//cout << "You should probably store this information in a member variable of the class. Good luck with the project! :)" << endl;
	fileToPath=filePath;
}

//make function to give hist with temp for each year
void tempTrender::hotCold(){
	
	//make hist
	TH1I* hist = new TH1I("temperature", "Year;Year;Temperature[#circC]", 300, -20, 40);
	hist->SetFillColor(4);
	hist->SetTitle("Temperature per year");

	//open file (file path missing to be implemented correctly)
	ifstream file(fileToPath.c_str());
	
	//count number of lines to know array size
	int numLines=0;
	while( file.good() ){
		string line;
		getline(file, line);
		++numLines;
	}
	file.close();

	//read file to get temperature data
	ifstream file2(fileToPath.c_str());
	while( file2.good()){
		//help variables
		int year;
		double temperature;
		int a[70], int b[70];
		while (!infile.
		
		
		
		
		
		
		
		int year;
		//array for the temperature
		double_t temp[numLines];
		//loop over the number of lines
		for(Int_t nt = 0; nt<numLines; nt++ ){
		file2>>year>>temp[numLines];
		cout<<year<<""<<temp[numLines]<<endl;
		
	
				//make hist
				hist->Fill(temp[nt]); 
			}
		}
	
	double mean = hist->GetMean(); //The mean of the distribution
	double stdev = hist->GetRMS(); //The standard deviation
	TCanvas* can = new TCanvas();
	hist->Draw();
}
