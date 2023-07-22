/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   lab3_hilgerbj.cpp
 * Author: benjaminhilger
 *
 * Created on February 24, 2020, 12:29 AM
 */

#include <cstdlib>
#include <vector>
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>


using namespace std;

void processLines(std::istream& is, std::ostream& os) {
    
    std::string line;
    while (std::getline(is, line)) {
        os << line << std::endl;
    }
    
}

using IntVec = std::vector<int>;

IntVec evens(const IntVec& src) {
	 

       vector<int> evens = {};

       for(int i = 0; i < src.size(); i++) {
              
              if(src[i] % 2 == 0) {
                     evens.push_back (src[i]);
              }
       }

       return evens;
}

using StrVec = std::vector<std::string>;

StrVec reverse(const StrVec& src) {
     

       StrVec reversed = {};

       for(int i = src.size()-1; i >= 0; i--) {
              reversed.push_back (src[i]);
       }

       return reversed;
}


IntVec getPrimes(int n) {
 
    IntVec primes = {};
    
    int count = 1;
    while(primes.size() < n) {
        
        // Checking if prime
        bool isPrime = true;
        for(int i = 2; i <= count/2; i++)  {
            
            // If there is no remainder and it's not the same number, then the number isn't prime
            if(count % i == 0 && count != i) {
                isPrime = false;
            }
            
        }
        
        // If it is prime then add it to the list
        if(isPrime)  {
            primes.push_back(count);
        }
        
        count++;
    }


    return primes;


}


/*
 * 
 */
int main(int argc, char** argv) {
    cout << "Hello" << endl << endl;
    vector<int> test = {2, -4, 7, 9, 3, 8};
    
    vector<int> even = evens(test);
    
    cout << "Evens: ";
    for(const int i : even) {
        std::cout << i << " ";
    }
    
    cout << endl;
    
    StrVec t = {"one", "two", "three"};
    
    StrVec rev = reverse(t);
    
    cout << "Reversed: ";
    for(const string str : rev) {
        std::cout << str << " ";
    } 
    
    cout << endl;
    
    IntVec primes = getPrimes(7);
    
    cout << "Primes: ";
    for(int i = 0; i < primes.size(); i++) {
        cout << primes[i] << " ";
    }
    
    cout << endl << endl;
    
    string lines = "Line #1\nSecond Line\nLast line";
    std::istringstream stream;
    stream.str(lines);
    
    processLines(stream, cout);
    
    return 0;
}

