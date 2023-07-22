# Author: Ben Hilger
# Email: hilgerbj@miamioh.edu
# Section: B
# Date: 9/18/19

'''
    Purpose: To calculate the amount of change that is due when an item is bought in a store
    Input: The price of the item bought and how much money the cashier was given
    Output: The amount of dollars, quartrs, dimes, nickels and penniees that the cashier should give to the customer
'''
print('Change Calculator') # Description of program

# Requesting input of price from the cashier in cents
price = 100 * float(input("Enter the price of the item bought: "))

# Requesting inout of amount of money given to the cashier in cents
pay = 100 * float(input("Enter the amount of money you give the cashier: "))

change = pay - price

amtDollars = int(change/100) # Calculates the amount of dollars that can fit into the change
change = change%100 # Gets the remaining change after the dollar(s) are removed

amtQuarters = int(change/25)# Calculates the amount of quarters that can fit into the remaining change amount
change = change%25 # Gets the remaining change after the quarter(s), if any are removeed

amtDimes = int(change/10) # Calculates the amount of dimes that can fit into the remaining change amount
change  = change%10 # Gets the remaining change after the dime(s), if any are removed

amtNickels = int(change/5) # Calculates the amount of nickels that can fit into the remaining change amount
change = change%5 # Gets the remaining change after the nickel(s), if any are removed

# Any left over change is pennies

# Prints/Reports the result to the client
print("Your change:")
print("   dollars      ", int(amtDollars))
print("   quarters     ", int(amtQuarters))
print("   dimes        ", int(amtDimes))
print("   nickels      ", int(amtNickels))
print("   pennies      ", int(change))
print("Thank you for yor business")



