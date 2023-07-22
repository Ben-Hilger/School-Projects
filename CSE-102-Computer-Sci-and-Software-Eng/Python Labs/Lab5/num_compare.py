# Author: Ben Hilger
# Email: hilgerbj@miaioh.edu
# Section: B
# Date: 9/25/19

'''
    Purpose: To use if statements to compare two numbers to see if they are equal or one is greater than the number
    Inputs: The two numbers to compare
    Outputs: Weither the first number is equal to, greater than or less than the second number

'''

# Gets the two numbers to compare from the user
firstNum = int(input("Enter the first number: "))
secondNum = int(input("Enter the second number: "))

# Prints a blank space
print("")

# Compares the number to see if they are equal or one number is greater than the other
if firstNum == secondNum:
    print("The number", firstNum, "is equal to", secondNum) # Reports to the user the numbers are equal
elif firstNum > secondNum:
    print("The number", firstNum , "is greater than", secondNum) # Reports to the user that the first number is greater than the second number
elif firstNum < secondNum:
    print("The number", firstNum, "is less than", secondNum) # Reports to the user that the first number is less than the second number

# Prints a blank space
print("")
