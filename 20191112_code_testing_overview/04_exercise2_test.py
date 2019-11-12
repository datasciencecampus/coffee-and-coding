#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 11 10:23:43 2019

@author: pughd

Updated after spec changes
"""


# Test class to hold our tests
class TestClass:

        
    # test when x > y and x + y < 10
    def test_x_gtr_y_x_add_y_lt_10(self):
        assert example_function(5,1, 9) == 0  
        
   
    # test when x > y and x + y > = 10
    def test_x_gtr_y_x_add_y_gte_10(self):
        assert example_function(10,9, 9) == 10
    
    #test that x<=y
    def test_x_lte_y(self):
        assert example_function(2,9,2) == -14


    #test string integers
    def test_str_ints(self):
        assert example_function("2","9", 2) == -14 
    # test neg string integers   
    def test_neg_str_ints(self):
        assert example_function("-2","-1", 2) == 6

    #test str inputs
    def test_str_word_entries(self):
        assert example_function("test","6", 4) == -24 

def example_function(x,y,m):
    #isdigit only detects positive so use cast and catch
   x = is_int(x)
   y = is_int(y)
   m = is_int(m)
          
    
   if x > y and x + y < 10:
        return 0
   elif x > y and x + y >=10 :
        return 10
   else:
        return (x*x) - (m*y)
    
    
def is_int(s):
   try:
        x = int(s)
        return x
   except ValueError:
        return 0  
