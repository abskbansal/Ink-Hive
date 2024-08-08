from .colors import *
from getpass import getpass

def getInt(s):
    while True:
        try:
            x = int(input(blue(s)))
            return x
        except ValueError:
            print(red("Invalid Input. Please try again..."))
            print()

def getString(s):
    return input(blue(s)).strip()

def getPass(s):
    return getpass(blue(s))