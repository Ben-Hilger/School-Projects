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
    int decimalNum = hex2Dec(argv[1]);  // Calls the method 
    // Reports the final number to the user
    cout << decimalNum << endl;
    return 0;
}

int hex2Dec(string input) {
    removeHexNotation(input);
    int decimalNum = 0;  // Stores the decimal equivalent
    for (unsigned i = 0; i < input.length(); i++) {
        // Stores the current character being evaluated
        char currentValue = toupper(input.at(input.length()-1-i));
        int value;  // Stores the equivalent value of the character
        // Checks the character if it's a number or letter
        switch (currentValue) { 
            case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
                // Calls a method to convert the letter to number equivalent
                value = convertLettersToNumber(currentValue); 
                break;
            default:
                // Converts the value to it's integer equivalent
                string s(1, currentValue);
                value = stoi(s); 
                break;
        }
        // Adds the value to the final number
        decimalNum += value * pow(16, i); 
    }
    return decimalNum;  // Returns the final number to the user
} 

int convertLettersToNumber(char letter) {
    switch (letter) {
        case 'A':
            return 10;  // A = 10
        case 'B':
            return 11;  // B = 11
        case 'C':
            return 12;  // C = 12
        case 'D':
            return 13;  // D = 13
        case 'E':
            return 14;  // E = 14
        case 'F':
            return 15;  // F = 15
        default:
            return 0;  // Unknown Numbers = 0
    }
}

void removeHexNotation(string& input) {
    size_t found = input.find("0x");  // Checks if the user added hex notation
    if (found != string::npos) {
        // Removes the notation if found
        input.replace(found, 2, "");  
    } else if (input.find("0X") != string::npos) {  // Checks for capital X
        // Removes the notation if found
        input.replace(input.find("0X"), 2, "");  
    } 
}

