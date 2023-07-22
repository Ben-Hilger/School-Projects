# Author: Ben Hilger
# Date: 9/11/19
# This python program converts a decimal number to the binary, octal and hexadecimal number system
# Gets the users input
dec = int(input("Enter any decimal number:"))
# Outputs the information to the user
print("The input decimal value is:", dec)
print(bin(dec), "in binary.")
print(oct(dec), "in octal.")
print(hex(dec), "in hexadecimal.")

