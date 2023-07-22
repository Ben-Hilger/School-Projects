#include <iostream>
#include <vector>
#include <unordered_map>

int main() {
    std::vector<int> list;
    std::vector<int> removed;
    
    list.push_back(1);
    list.push_back(2);
    list.push_back(3);
    list.push_back(4);
    list.push_back(2);
    list.push_back(3);
    list.push_back(1);
    list.push_back(1);
    std::unordered_map<int, bool> inList(list.size());

    std::cout << list.size() << std::endl;

    for (size_t i = 0; i < list.size(); i++) {
        int val = list.at(i);
        if (!inList[val]) {
            removed.push_back(val);
            inList[val] = true;
        }
    }

    std::cout << removed.size() << std::endl;

    for (size_t i = 0; i < removed.size(); i++) {
        std::cout << removed.at(i) << " ";
    }
   
}