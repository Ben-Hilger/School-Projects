/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Lab2Part1_hilgerbj.cpp
 * Author: hilgerbj
 *
 * Created on February 18, 2020, 10:06 AM
 */

#include <cstdlib>
#include <iostream>

using namespace std;

/*
 * 
 */
int main(int argc, char** argv) {
    cout << "Hello" << endl << endl;
    
    int num;
    num = stoi(argv[1]);
    
    while(num > 0) {
        int digit = num % 10;
        cout << digit << " ";
        num /= 10;
    }
    cout << endl;
    
    return 0;
}

