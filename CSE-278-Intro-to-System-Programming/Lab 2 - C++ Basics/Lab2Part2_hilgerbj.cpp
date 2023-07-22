/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: benjaminhilger
 *
 * Created on February 18, 2020, 10:23 AM
 */

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cmath>

using namespace std;

/*
 * 
 */
int main(int argc, char** argv) {
    cout << "Hello" << endl << endl;
    
    ifstream inFile;
    ofstream outFile;
    
    inFile.open("inData.txt");
    outFile.open("outData.txt");
    
    if(!inFile.good()) {
        cerr << "Unable to read file";
        return 1;
    }
    
    double sideA, sideB, sideC;
    inFile >> sideA  >> sideB >> sideC;
    
    double perimeter = sideA+sideB+sideC;
    double s = perimeter/2;
    double area = sqrt(s*(s-sideA)*(s-sideB)*(s-sideC));
    
    outFile << "Triangle:" << endl;
    outFile << "Side A = " << sideA << ", Side B = " << sideB << ", Side C = " << sideC << ", area = " << area << ", perimeter = " << perimeter << endl;
    
    
    outFile << endl;
    
    double radius;
    double pi = 3.1416;
    inFile >> radius;
    
    double circleArea = pi * radius * radius;
    double circumference = 2 * pi * radius;
    
    outFile << "Circle: " << endl;
    outFile << fixed << setprecision(2) << "Radius = " << radius << ", area = " << circleArea << ", circumference = " << circumference << endl;
    
    outFile << endl;
    
    string first, last;
    int age;
    inFile >> quoted(first) >> quoted(last) >> age;
    
    outFile << "Name: " << first << " " << last << ", age: " << age << endl;
 
    outFile << endl;
    
    double beginBal, interestRate;
    inFile >> beginBal >> interestRate;

    double endingBal = beginBal * (1+interestRate/100.0/12);
    
    outFile << "Beginning Balance = $" << fixed << setprecision(2) << beginBal << ", interest rate = " << setprecision(2) << interestRate << endl;
    outFile << "Balance at the end of the month = $" << endingBal << endl;
    outFile << endl;
    
    char c;
    inFile >> c;
    outFile << "The character that comes after " << c << " in the ASCII set is " << (char)(c+1) << endl;
    
    outFile.close();
    inFile.close();
    
    
    return 0;
}

