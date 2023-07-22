/* 
 * File:   main.cpp
 * Author: dmadhava
 *
 * Copyright (C) 2019 raodm@miamioh.edu
 */

#include <boost/asio.hpp>
#include <string>
#include <iostream>

using namespace std;
using namespace boost::asio;
using namespace boost::asio::ip;

const std::string host = "www.miamioh.edu";

void process(std::istream& is, std::ostream& os) {
    // Read line-by-line from client and return a response back.
    std::string line;
    do {
        // Send a prompt to the client
        os << "Yeah, what do you want to know?\r\n";
        // Read a line of input from the client. Remember that
        // get line method removes trailing "\n" in inputs.
        std::getline(is, line);
        // Remove trailing "\r" that may be sent by Windows clients
        if (!line.empty() && line.back() == '\r') {
            line.pop_back();  // Remove last character.
        }
        // Send a sassy response back to the client.
        if (line != "bye") {
            os << "Really? Ask www.google.com about '" << line << "'\r\n";
        }
    } while (line != "bye");
    // Send a final message to the client
    os << "What! did you just hangup on me?\r\n";
}

/*
 * Simple main method to have this program run as a server 
 */
int main(int argc, char** argv) {
    // Generic object used by Boost
    io_service service;
    // Setup an end point. The parameter 0 implies pick any free port.
    // Of course, you may specify a fixed port number.
    tcp::endpoint serverEndPoint(tcp::v4(), 0);
    // Create & bind server socket to given end point. If port is already 
    // in use, an exception will be thrown
    tcp::acceptor server(service, serverEndPoint);
    // Print port number so we know the port the server is listening on
    std::cout << "Listening on port " << server.local_endpoint().port()
              << std::endl;
    // Next wait for a client to connect on the port
    tcp::iostream client;  // The client socket stream
    // Listen and accept connection from client
    server.accept(*client.rdbuf());
    // Now do some processing for the client
    process(client, client);
    // All done.
    return 0;
}
