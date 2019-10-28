
	//include C++ STL headers
	#include <iostream>
	#include <fstream>
	
	#include "TMath.h"
	
	//own files
	#include "tempTrender2.h"
	
	//ROOT library objects
	#include <TH1.h>
	#include <TGraph.h>
	#include <TCanvas.h>
	#include <TMultiGraph.h>
	//using namespace std;
	tempTrender::tempTrender(string filePath) {
		//cout << "The user supplied " << filePath << " as the path to the data file." << endl;
		fileToPath=filePath;
	}
	
	//make function to give hist with temp for each year
	void tempTrender::hotCold(){
		
		
		TCanvas *c1 = new TCanvas("c1","Extreme temperatures per year");
		
		//TGraph* graph = new TGraph("../../data_files/coldestday_Lund.txt");
		//TGraph* graph1 = new TGraph("../../data_files/hottestday_Lund.txt");
		TGraph* graph = new TGraph("../../data_files/coldestday_highQuality_Lund.txt");
		TGraph* graph1 = new TGraph("../../data_files/hottestday_highQuality_Lund.txt");
		TMultiGraph *mg = new TMultiGraph(); 
		
		graph->SetFillColor(4); //blue
		graph->SetTitle("Coldest days");
		
		graph1->SetFillColor(2); //red
		graph1->SetTitle("Hottest days");
	
		mg -> Add(graph);
		mg -> Add(graph1);
		mg->Draw("AB");
		mg->GetXaxis()->SetTitle("Years");
		mg->GetYaxis()->SetTitle("Temperature [#circC]");
		c1->BuildLegend();
		c1->SaveAs("../../pictures/newpicture.jpg");
		
	}
