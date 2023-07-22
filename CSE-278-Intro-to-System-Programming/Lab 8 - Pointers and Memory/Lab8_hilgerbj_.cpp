// Copyright 2020 Ben Hilger

/* 
 * File:   main.cpp
 * Author: benjaminhilger
 *
 * Created on April 28, 2020, 9:27 PM
 */

#include <cstdlib>
#include <iostream>
#include <array>

using namespace std;

void listFactors(int *num);

/*
 * 
 */
int main(int argc, char** argv) {
    int number = stoi(argv[1]);  // Converts the number to an integer
    // Asks the user to enter the specified number
    cout << "Please enter " << number << " number(s):" << endl;   
    
    int numbers[number];  // Creates an array of the specified size
    int* ptr = &numbers[0];  // Stores a pointer to the first index of the array
    // Puts the numbers the user inputted into the array using the pointer
    for (int i = 0; i < number; i++) {
        cin >> *(ptr+i);
    }
    // Resets the pointer to the end of the array
    ptr = &numbers[number-1];
    // Explores the contents of the array
    for (int i = 0; i < number; i++) {
        listFactors((ptr-i));  // Lists the factors of the number
    }

    return 0;
}

/*
 * Lists all of the factor of the given number
 */
void listFactors(int *num) {
    cout << "The Factors of " << *num << " are:" << endl;
    // Explores the possible factors of the number
    for (int i = *num/2; i > 1; i--) {
        if (*num % i == 0) {  // Checks if the current number is a factor
            cout << i << " ";  // Outputs the factor to the console
        }
    }
    cout << endl;  // Prints an empty line
}
