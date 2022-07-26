# -*- coding: utf-8 -*-
"""
Coffee and Coding Python Exercises

Session Focus:
For Loops and If Statements 

@authors: Craig Scott, Ian Banda
"""

#%%
# Exercise 1

def interger_sum(begin_val, end_val, step_val):
    '''
    Sums integers between specified values. 

    Parameters
    ----------
    begin_val : int
        value to begin sequence.
    end_val : int
        value to end sequence.
    step_val : int
        step_val the integers steps between numbers.

    Returns
    -------
    int
        A sum of the integers

    '''
    # Check whether the begin value is greater than end value - return 0 if True
    if begin_val > end_val:
        
        return 0
    
    else:
        # Return sum of integers 
        return sum(range(begin_val,end_val+1,step_val))
    

# test integer_sum using the following tests

begin_val = 4
end_val = 4
step_val = 4

interger_sum(begin_val, end_val, step_val)
# should return 4

interger_sum(3,11,2)
# should return 35 (3 + 5 + 7 + 9 + 11)

interger_sum(1,15,5)
# should return 18 (1+6+11)

interger_sum(9,7,2)
# should return 0 (begin_val is larger than end_val)


#%%
# Exercise 2

def odd_int_count(int_array):
    '''
    Returns the integer that appears an odd number of time. 

    Parameters
    ----------
    int_array : list
        list of integers.

    Returns
    -------
    i : int
        The integer that appears an odd number of times.

    '''
    
    # Use set to only get the unique values in the array
    unique_int_array = set(int_array)
    
    # cycle through the unique set of integers 
    for i in unique_int_array:
        
        # use modulo to get the remainder of the division of the number of times it appears divided by 2
        # If this is 1 - the number is 1 and we return this number
        if int_array.count(i) % 2:
            
            return i
        

# test odd_int_count using the following tests

odd_int_count([2,2,2,5,5,5,5])
# should return 2 (it appears an odd number of times)

odd_int_count([1,2,2,2,3,3,1,1,1])
# should return 2 (it appears an odd number of times)

odd_int_count([10,10,10,10,3,4,5,4,2,1,1,5,5,3,2,10,5])
# should return 10 (it appears an odd number of times)


#%%
# Exercise 3

def move_zeros(int_array):
    '''
    Moves zeros in an array to the end of the list. 

    Parameters
    ----------
    int_array : list
        list of ints.

    Returns
    -------
    int_array : list
        A reordered list with zeros at the end.


    '''
    
    # create some values to control the while loop
    still_zeros = 1
    number_of_zeros = 0
    
    # While the variable still_zeros is still true 
    while still_zeros:
        
        # catch an error when there are no more zeros
        try:
            
            # get the index of he next zero
            zero_index = int_array.index(0)
            # increase the number zeros counter
            number_of_zeros += 1
            # use the pop function to remove that zero value 
            int_array.pop(zero_index)number.pop
        
        except ValueError:
            # if there are no more zeros break the while loop by changing still zeros 
            # to be 0
            still_zeros = 0
    
    # for the number of times there was a zero in the list 
    for i in range(number_of_zeros):
        # use append to add a zero at the end 
        int_array.append(0)
        
    return int_array
            
    
move_zeros([3,4,0,5,6])
# should return [3,4,5,6,0]

move_zeros([11,25,0,0,1,3,4,5,11,10,29,0,3])
# Should return [11,25,1,3,4,5,11,1,29,3,0,0,0]

move_zeros([0,5,0,8,9,0,4,9,0])
# should return [5,8,9,4,9,0,0,0,0]