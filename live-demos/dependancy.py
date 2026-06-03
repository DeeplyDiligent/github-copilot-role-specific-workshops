# define a function that takes a number and returns where in pi it is
def find_in_pi(number):
    # import the pi number from the math module
    from math import pi
    # convert pi to a string and remove the decimal point
    pi_str = str(pi).replace('.', '')
    # find the index of the number in pi
    index = pi_str.find(str(number))
    # if the number is not found, return -1
    if index == -1:
        return -1
    # return the index of the number in pi
    return index + 1  # +1 to account for 0 indexing