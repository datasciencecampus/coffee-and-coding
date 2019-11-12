#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 11 10:23:43 2019

@author: pughd
"""



class TestClass:
    # test when x <= y
    def test_x_less_eq_y(self):
        assert example_function(2,4) == -4
        
    # test when x > y
    def test_x_gtr_y(self):
        assert example_function(5,4) == 9  
        
    


def example_function(x,y):
    if x > y:
        return 0
    else:
        return (x*x) - (2*y)
