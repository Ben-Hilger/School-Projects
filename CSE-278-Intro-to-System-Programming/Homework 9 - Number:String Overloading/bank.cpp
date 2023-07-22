#include <iostream>

using namespace std;

int main() {
	int sum =0, debit = 0;
	
	do {
		std::cout << "Enter loan amount (0 to quit): ";
		std::cin >> debit;
		if (debit > 0) {
			sum += debit;
		}
	} while (debit > 0);
	std::cout << "Total loan amount you own to bank: " << sum << std::endl;
	return 0;
}
