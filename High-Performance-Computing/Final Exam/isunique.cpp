#include <string>
#include <unordered_map>
#include <iostream>

bool isUnique(std::string& str) {
    std::unordered_map<char, bool> map;
    for (size_t i = 0; i < str.size(); i++) {
        if (map[str.at(i)]) {
            return false;
        } else {
            map[str.at(i)] = true;
        }
    }
    return true;
}

int main() {
    std::string str("adcd");
    std::cout << isUnique(str);
}