//include C++ STL headers
#include <iostream>
#include <fstream>

#include "TMath.h"

//own files
#include "tempTrender.h"

//ROOT library objects
#include "TH1.h"
#include "TCanvas.h"

tempTrender::tempTrender(string filePath) {
	cout << "The user supplied " << filePath << " as the path to the data file." << endl;
	fileToPath=filePath;
}

//make function to give hist with temp on given day for each year
void tempTrender::tempOnDay (int monthToCalculate, int dayToCalculate){

	cout<<"Month "<<monthToCalculate<<endl;
	cout<<"Day "<<dayToCalculate<<endl;
	cout<<fileToPath<<endl;
	//make hist
	TH1I* hist = new TH1I("temperature", "Temperature;Temperature[#circC];Entries", 300, -35, 30);
	hist->SetFillColor(4);
	hist->SetTitle("Average temperature on the given day during more than 50 years");

	//get city by getting substring of path variable
	string city_long = fileToPath.substr(fileToPath.find_last_of("_")+1);
	//cout<<city_long<<endl;
	string city = city_long.substr(0,city_long.size()-4);
	//cout<<city<<endl;
	
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
		int year, month, day;
		//array for the temperature
		double_t temp[numLines];
		//loop over the number of lines
		for(Int_t nt = 0; nt<numLines; nt++ ){
		file2>>year>>month>>day>>temp[numLines];
		//cout<<year<<" "<<month<<" "<<day<<" "<<temp[numLines]<<endl;
		
		int month_abs, day_abs;
		month_abs = TMath::Abs(month);
		day_abs = TMath::Abs(day);
		//cout<<month_abs<<day_abs<<endl;
		
		//just store the temperatures for the given month and day 
		if(month_abs == monthToCalculate && day_abs == dayToCalculate){
				//cout<<year<<" "<<month<<" "<<day<<" "<<temp[numLines]<<endl;
				temp[nt]=temp[numLines];
				//cout<<temp[nt]<<endl;
				//make hist
				hist->Fill(temp[nt]); 
			}
		}
	}
	double mean = hist->GetMean(); //The mean of the distribution
	double stdev = hist->GetRMS(); //The standard deviation
	TCanvas* can = new TCanvas();
	hist->Draw();
	
//save the graph as a picture called by the name of the city
	if (city=="Lund"){
		can->SaveAs("Lund.jpg");
	}
	if (city=="Lulea"){
		can->SaveAs("Lulea.jpg");
	}
	if (city=="Karlstad"){
		can->SaveAs("Karlstad.jpg");
	}
		
}

