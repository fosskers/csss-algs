# Parametric Logic in Python

# Usage:
# 1. Open up a Python REPL in the folder containing this file.
# 2. Import it by typing:
#    >>> from logic import *
# 3. You can then freely use all the functions below.
#    Test a one-parameter statement using the `one` function like:
#    >>> one(your_statement_function)
#    Likewise, for two and three parameter statements, use `two` and `three`.
# 4. The output will be a list of Booleans. This represents the `output` column
#    of the truth table for your statement. If all values are True, you know
#    your statement is a tautology.
# 5. You can use this to test if your initial and final statements are equal,
#    or even to test whether your mid-steps are still correct when you're stuck.

# Writing a new compound statement (as a function):
# 1. This is easily, as computers are based on logical operations.
#    The operations are:
#      not      - KEYWORD  - Logical `not`
#      and      - KEYWORD  - Logical `and`
#      or       - KEYWORD  - Logical `or`
#      xor()    - FUNCTION - Exclusive `or`
#      imply()  - FUNCTION - Implication
#      bi_con() - FUNCTION - Biconditional
# 2. Note the difference between `keywords` and `functions`.
# 3. Define a function that takes the number of parameters your statement needs.
# 4. Create two variables, one for each statement, and test their equality.
# 4. See the examples below for model functions.

# Exclusive `or`
xor = lambda p, q: p != q

imply = lambda p, q: (not p) or q

bi_con = lambda p, q: p == q

###

# Utility functions
def uncurry(f):
    return lambda ps: f(ps[0],ps[1])

def uncurry_3(f):
    return lambda ps: f(ps[0],ps[1],ps[2])

###

def one(f):
    return list(map(f, [False,True]))

def two(f):
    return list(map(uncurry(f), [[False,False],
                                 [False,True],
                                 [True,False],
                                 [True,True]]))

def three(f):
    return list(map(uncurry_3(f), [[False,False,False],
                                   [False,False,True],
                                   [False,True,False],
                                   [False,True,True],
                                   [True,False,False],
                                   [True,False,True],
                                   [True,True,False],
                                   [True,True,True]]))

### EXAMPLES
# From Page 66
def q_6a(p, q, r):
    a = not (p and (q or r) and (not p or not q or r))
    b = not p or not r
    return a == b

# Example of a simple tautology.
def taut(p):
    return imply(p, p)

# DeMorgan's Laws
def demorgan_1(p, q):
    return (not (p and q)) == (not p or not q)

def demorgan_2(p, q):
    return (not (p or q)) == (not p and not q)

# Not a tautology.
def not_taut(p, q):
    return p and q
