// Copyright (C) 2020 hilgerbj@miamioh.edu

#define MYSQLPP_MYSQL_HEADERS_BURIED
#include <mysql++/mysql++.h>
#include <string>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
    // Connect to database with: database, server, userID, password
    mysqlpp::Connection myDB("cse278s19", "os1.csi.miamioh.edu", "cse278s19",
            "rbHkqL64VpcJ2ezj");
    // Create a query
    mysqlpp::Query query = myDB.query();
    query << "SELECT pname, price, category, manufacturer FROM Product "
            "where price <= %0;";
    int price;
    std::string input;
    cin >> input;
    string stringprice = input.substr(input.find("=")+1,
            input.length());
    price = std::stoi(stringprice);
    query.parse();  // check to ensure query is correct
    // Run the query and get stored results
    mysqlpp::StoreQueryResult result = query.store(price);
    cout << "Content-Type: text/html\r\n\r\n";
    // Results is a 2D vector of mysqlpp::String objects.
    // Print the results.
    cout << "<table border=1>\r\n";
    for (const auto& row : result) {
        cout << "<tr>";
        for (const auto& col : row) {
            cout << "<td>"<< col << "<\\td>";
        }
        cout << "</tr>\r\n";
    }
    cout << "</table>\r\n";
    // All done
    return 0;
}

