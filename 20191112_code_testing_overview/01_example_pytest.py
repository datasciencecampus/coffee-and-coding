#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 11 09:38:59 2019

@author: pughd
"""

# Create a class to hold our tests
# These should be testing the edge cases
class TestClass:

    def test_eq_100(self):
        assert small_function(100,5) == 100
    
    def test_gtr_100(self):
        assert small_function(102,6) == 100
        
    def test_lt_100(self):
        assert small_function(2,89) == 91
        
               
# Define our function
def small_function(x,y):
    if x< 100:
        return x + y
    else:
        return 100
