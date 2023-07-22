#include <string>
#include <iostream>
#include <algorithm>

bool isPalindrome(std::string& str) {
    std::string str2(str);
    std::reverse(str2.begin(), str2.end());
    return str == str2;
}

int main() {
    std::string str("madam");
    std::cout << isPalindrome(str);
}

