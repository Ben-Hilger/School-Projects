#include <vector>
#include <iostream>
#include <unordered_map>
#include <string>

std::unordered_map<std::string, std::string> mergeMap(std::unordered_map<std::string, std::string> map1,
    std::unordered_map<std::string, std::string> map2) {
    std::unordered_map<std::string, std::string> map3;
    for (auto str : map1) {
        if (map2.find(str.first) != map2.end()) {
            map3[str.first] = map1[str.first] + "-" + map2[str.first];
        }
    }
    return map3;
}

int main() {
    std::unordered_map<std::string, std::string> map1{{"one", "1"}, {"two", "b"}, {"three", "c"}};
    std::unordered_map<std::string, std::string> map2{{"two", "1"}};
    std::unordered_map<std::string, std::string> map3 = mergeMap(map1, map2);
    for (auto str: map3) {
        std::cout << str.first << " " << str.second << std::endl;
    }
    return 0;
}