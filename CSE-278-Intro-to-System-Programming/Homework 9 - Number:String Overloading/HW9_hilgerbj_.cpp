// Copyright 2020 hilgerbj

#include <iostream>
#include <string>

char password[15];
bool valid = false;

int main() {
    // Stores the sum and debit variables
    //int sum =0, debit = 0;
    //do {

        // Asks the user to enter the loan amount
        //std::cout << "Enter loan amount (0 to quit): ";
        // Gets the input from the user
        //std::cin >> debit;
        // Checks if the input is valid (> 0)
        //if (debit > 0) {
            // Adds the debt to the sum
            //sum += debit;
        //}
    //} while (debit > 0); // Continues until the debit <= 0
    // Outpts the total amount to the user
    //std::cout << "Total loan amount you own to bank: " << sum << std::endl;
    
    // Prompts the user to enter the secret code
	std::cout << "Enter secret code: ";
    // Gets the input from the user
	std::cin >> password;
    // Stores the correct password
	const std::string Secret = "R0Ot!23$5";
    
    // Checks to see if the user entered the correct password
	if(Secret == password) {
		valid = true; // If true, it marks the user as valid
	}

    // Checks if the user is valid
	if (valid) {
        // Reports success to the user
		std::cout << "Success. You are root!\n";
	}
	else {
        // Reports a faliure to the user
		std::cout << "Authentication faliure\n";
	}
	return 0;
}
