/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: benjaminhilger
 *
 * Created on February 21, 2020, 11:26 AM
 */

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <algorithm>
#include <iterator>
#include <sstream>
#include <fstream>
#include <vector>

using namespace std;

void printAllLine(istream& is, ostream& os){
  
  string line;
  while (getline(is, line)) {
    cout << line << endl;
  }
  
}

void printLastLine(istream& is, ostream& os) {
    
    string prevLine;
    string line;
    while(getline(is, line)) {
        if (line.compare("") == 0 && prevLine.compare("") != 0) {
            os << prevLine << endl;;
        }
        
        prevLine = line;
    }
}

int main(int argc, char** argv) {

    ifstream paras(argv[1]);
    ofstream parasOut(argv[2]);

    printAllLine(paras, cout);
    
    // Closing and Reopening the input stream
    paras.close();
    paras.open(argv[1]);
    
    printLastLine(paras, cout);
    
    // Closing and Reopening the input stream
    paras.close();
    paras.open(argv[1]);
    
    printLastLine(paras, parasOut);
    
    return 0;
    
}