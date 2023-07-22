// Copyright Ben Hilger 2020
/* 
 * File:   main.cpp
 * Author: benjaminhilger
 *
 * Created on April 20, 2020, 1:19 PM
 */

#include <cstdlib>
#include <iostream>
#include <cmath>
#include <string>
#include <locale>
using namespace std;

int hex2Dec(string input);
int convertLettersToNumber(char letter);
void removeHexNotation(string& input);
/*
 * 
 */
int main(int argc, char** argv) {
// Question 3 Code:
//    int i = 12;
//    int j = 0b1100;
//    int k = 014;
//    int l = 0xb;
//    cout << "Decimal: " << i << endl;
//    cout << "Binary: " << j << endl;
//    cout << "Octal: " << k << endl;
//    cout << "Hexadecimal: " << l << endl;
//  Question 4 Code:
    int num = 0;
    cout << "Enter a hexadecimal number: ";
    cin >> hex >> num;
    // Print the number in various bases
    cout << "Decimal: " << dec << num
        << "\nOctal: " << oct << num
        << "\nHexadecimal: " << hex << num
        << endl;

}
