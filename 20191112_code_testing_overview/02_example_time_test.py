#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 11 10:28:55 2019

@author: pughd
"""


from datetime import datetime


class TestClass:
    # Difficult to automate test this as depends on time of day!
    def test_morning1(self):
        assert time_of_day() == "Night"
        
    # Far easier to test    
    def test_morning2(self):
        assert time_of_day_2(9) == "Morning"
        assert time_of_day_2(13) == "Afternoon"
        assert time_of_day_2(0) == "Night"
        assert time_of_day_2(19) == "Evening"


def time_of_day_2(hour):
    
    # Return approproiate description
    if hour >= 0 and hour < 6:
        return 'Night'
    elif hour >= 6 and hour < 12:
        return "Morning"
    elif  hour >= 12 and hour < 18:
        return "Afternoon"     
    else:
        return "Evening" 


def time_of_day():
    # Get the current hour
    hour = datetime.now().hour
    
    # Return approproiate description
    if hour >= 0 and hour < 6:
        return 'Night'
    elif hour >= 6 and hour < 12:
        return "Morning"
    elif  hour >= 12 and hour < 18:
        return "Afternoon"     
    else:
        return "Evening"
