#include <vector>
#include <unordered_map>
#include <iostream>

int main() {
    std::vector<int> s;
    s.push_back(1);
    s.push_back(4);
    s.push_back(3);
    s.push_back(2);
    s.push_back(3);
    s.push_back(1);
    
    int val = 8; 
    std::unordered_map<int, bool> map;
    for (int i = 0; i < s.size(); i++) {
        int reman = 8 - s.at(i);
        if (map[reman]) {
            std::cout << "Found";
            return 0;
        } else {
            map[s.at(i)] = true;
        }
    }
    std::cout << "Not found";
    return 0;
}