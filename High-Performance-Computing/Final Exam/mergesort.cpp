#include <vector>
#include <iostream>

std::vector<int> merge(std::vector<int> list1, std::vector<int> list2) {
    std::vector<int> merged;
    int list1Index = 0, list2Index = 0;
    while (list1Index < list1.size() || list2Index < list2.size()) {
        if (list1Index < list1.size() && list1.at(list1Index) <= list2.at(list2Index)) {
            merged.push_back(list1.at(list1Index));
            list1Index += 1;
        } else if (list2Index < list2.size()) {
            merged.push_back(list2.at(list2Index));
            list2Index += 1;
        }
    }
    return merged;
}

int main() {
    std::vector<int> list1{1, 5, 6, 8};
    std::vector<int> list2{4, 6, 8, 9, 12, 15, 16}; 

    std::vector<int> merged = merge(list1, list2);
    for(int i = 0; i < merged.size(); i++) {
        std::cout << merged.at(i) << " ";
    }
}