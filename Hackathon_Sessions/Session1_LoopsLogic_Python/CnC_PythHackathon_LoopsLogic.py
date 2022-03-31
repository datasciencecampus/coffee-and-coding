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
    # Write your function here (DONT forget to remove pass)
    
    pass

# test integer_sum using the following tests

begin_val = 4
end_val = 4
step_val = 4

integer_sum(begin_val, end_val, step_val)
# should return 4

integer_sum(3,11,2)
# should return 35 (3 + 5 + 7 + 9 + 11)

integer_sum(1,15,5)
# should return 18 (1+6+11)

integer_sum(9,7,2)
# should return 0 (begin_val is larger than end_val)


#%%
# Exercise 2

def odd_int_count(int_array):
    # Write your function here
    pass 

# test odd_int_count using the following tests

odd_int_count([2,2,2,5,5,5,5])
# should return 2 

odd_int_count([1,2,2,2,3,3,1,1,1])
# should return 2 

odd_int_count([10,10,10,10,10,3,4,5,4,2,1,1,5,5,3,5])
# should return 10 


#%%
# Exercise 3

def move_zeros(int_array):
    # Write your function here
    pass 
    
move_zeros([3,4,0,5,6])
# should return [3,4,5,6,0]

move_zeros([11,25,0,0,1,3,4,5,11,10,29,0,3])
# Should return [11,25,1,3,4,5,11,1,29,3,0,0,0]

move_zeros([0,5,0,8,9,0,4,9,0])
# should return [5,8,9,4,9,0,0,0,0]