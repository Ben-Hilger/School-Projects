#include <vector>
#include <iostream>

int main() {
    std::vector<int> values;
    values.push_back(1);
    values.push_back(2);
    values.push_back(3);
    values.push_back(2);
    values.push_back(2);
    values.push_back(1);
    std::cout << values.size();
    values.erase(std::remove(values.begin(), values.end(), 2));
    std::cout << values.size();

}