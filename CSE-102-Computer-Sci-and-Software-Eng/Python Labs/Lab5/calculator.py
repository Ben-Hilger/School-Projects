# Author: Ben Hilger
# Email: hilgerbj@miamioh.edu
# Section: B
# Date: 9/25/19

'''
    Purpose: To add, subtract, multiply and/or divide two numbers such as a simple calculator  
    Input: The type of operation to complete on the calculator and the two numbers to perform the operation on
    Output: The two numbers, the operation selected and the answer in a human-readable format 
'''

# Prints the available operations to the user
print("Select operation.")
print("\t1.Add")
print("\t2.Subtract")
print("\t3.Multiply")
print("\t4.Divide")

# Recieves the desired operation from the user
operation = int(input("Enter your choice (1/2/3/4): "))

# Gets the two numbers from the user
firstNum = int(input("Enter first number: "))
secondNum = int(input("Enter second number: "))

# Performs the selected operation on the numbers and reports the answer to the user
answer = 0
operChar = ''
if operation == 1:
    answer = firstNum+secondNum # Adds the two numbers
    operChar = '+' # Sets the character to print to the plus sign
elif operation == 2:
    answer = firstNum-secondNum # Subtracts the two numbers
    operChar = '-'# Sets the character to print the minus sign 
elif operation == 3:
    answer = firstNum*secondNum # Multiplies the two numbers
    operChar = '*' # Sets the character to print the multiplication sign
elif operation == 4:
    answer = firstNum/secondNum # Divides the two numbers
    operChar = '/' # Sets the character to print the division sign
else:
    print("Invalid operation selected") # The user selected an operation not available
    operChar = "I" # Sets the character to I  (for "Invalid")

# Checks to ensure the user selected a valid operation before printing the output 
if operChar != "I":
    print(firstNum, operChar, secondNum, "=", answer) # Prints the output to the user



