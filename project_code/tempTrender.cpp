//include C++ STL headers
#include <iostream>
#include <fstream>

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
	system("./preparefile.sh");
	//open file
	ifstream file("/home/courseuser/project_groupD/project_groupD/cleaned_Lund.csv");
	string line;
	string helpstring;
	
	//stuck there 
	while(!file.eof()){
		double_t temp;
		file>>helpstring>>temp;
		//cout<<temp<<endl;
		/*getline(file,line);
		if (line==[0-9][0-9][0-9][0-9]-monthTocalculate-dayToCalculate.*){
			cout<<line<<endl;
		}*/
		
	}
	//iterate over years and fill hist
	for(Double_t i=0.; i<40.; i++){
	hist->Fill(i); //Increment the bin corresponding to -3.2 C
	}
	double mean = hist->GetMean(); //The mean of the distribution
	double stdev = hist->GetRMS(); //The standard deviation
	TCanvas* can = new TCanvas();
	hist->Draw();
}
