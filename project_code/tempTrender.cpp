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
	cout << "You should probably store this information in a member variable of the class. Good luck with the project! :)" << endl;
}

//make function to give hst with temp on given day for each year
void tempTrender::tempOnDay (int monthToCalculate, int dayToCalculate){
	cout<<"Month "<<monthToCalculate<<endl;
	cout<<"Day "<<dayToCalculate<<endl;
	
	//make hist
	TH1I* hist = new TH1I("temperature", "Temperature;Temperature[#circC];Entries", 300, -20, 40);
	hist->SetFillColor(kRed + 1);
	//system("./preparefile.sh");
	//open file (file path missing to be implemented correctly)
	ifstream file("/home/courseuser/project_groupD/project_groupD/easyToRead1200_Lund.txt");
	
	
	//count number of lines to know array size
	int numLines=0;
	while( file.good()){
		string line;
		getline(file, line);
		++numLines;
	}
	file.close();

	//read file to get temperature data
	ifstream file2("/home/courseuser/project_groupD/project_groupD/easyToRead1200_Lund.txt");
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
		//hist->Fill(3.2);//Increment the bin corresponding to -3.2 C
		}
	}
	double mean = hist->GetMean(); //The mean of the distribution
	double stdev = hist->GetRMS(); //The standard deviation
	TCanvas* can = new TCanvas();
	hist->Draw();
}