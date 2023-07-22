#include <vector>
#include <string>
#include <iostream>

int findClosing(std::string& str, int open) {
    std::vector<char> stack{'('};
    for (int i = open+1; i < str.size(); i++) {
        char current = str.at(i);
        std::cout << current << std::endl;   
        if (current == '(') {
            stack.push_back('(');
        } else if (current == ')') {
            stack.pop_back();
        }
        if (stack.size() == 0) {
            return i;
        }
    }
    return -1;
}

int main() {
    std::string str("(a+sin((b+c))/d+(e+f))");
    std::cout << findClosing(str, 7);
}