#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>
#include <numeric>

int main() {
    std::vector<int> list;
    list.push_back(-5);
    list.push_back(4);
    list.push_back(-3);
    list.push_back(100);
    list.push_back(3);
    list.push_back(-5);
    list.push_back(1);
    int max = list.at(0);
    std::vector<int> maxSequence;
    for (size_t i = 0; i < list.size(); i++) {
        for (size_t j = 0; j < list.size(); j++) {
            std::vector<int> currentSequence;
            currentSequence.push_back(list.at(i));
            for (size_t z = j; z < i; z--) {
                currentSequence.push_back(list.at(i));
            }
            if (std::accumulate(currentSequence.begin(), currentSequence.end(), 0) > std::accumulate(maxSequence.begin(), maxSequence.end(), 0)) {
                maxSequence = currentSequence;
            }
        }
    }

    for (size_t i = 0; i < maxSequence.size(); i++) {
        std::cout << maxSequence.at(i) << " ";
    }
}