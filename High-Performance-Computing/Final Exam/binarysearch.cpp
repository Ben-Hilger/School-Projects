#include <vector>
#include <iostream>

int binarySearch(std::vector<int> vec, int start, int end, int find) {
    int index = (start + end) / 2;

    if (start == end && find != vec.at(index)) {
        return -1;
    } if (find == vec.at(index)) {
        return index;
    } else if(find > vec.at(index)) {
        return binarySearch(vec, index+1, end, find);
    } else {
        return binarySearch(vec, start, index-1, find);
    }
}

int main() {
    std::vector<int> sorted{1, 5, 8, 9, 10};
    std::cout << binarySearch(sorted, 0, sorted.size(), 10);
}