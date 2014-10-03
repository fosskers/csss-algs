{-
Boolean Logic in Haskell
author:  Colin Woodbury
updated: 2014 September 24 @ 13:38

Haskell functions for testing logical statements.

USAGE:
1. Testing compound logical statements with specific values:
     (False --> True) && not (False `xor` True)

2. Testing compound logical statements for _all_ possible inputs
   (Output is a truth table ordered by base 2 counting).
   Pass a lambda implementing your compound statement to the functions
   `one`, `two`, and `three`.
     one (\p -> p --> p)                -- p implies p
     two (\p q -> p --> q && q --> p)   -- p implies q and q implies p
     three (\p q r -> p `xor` q --> r)  -- p xor'd with q implies r

3. Testing two statements for logical equality (should have same truth table)
     f :: Bool -> Bool -> Bool
     f p q = a == b
       where a = p --> q
             b = q && p || p `xor` p

   Then in a eval loop, just:
     two f
-}

--------------------
-- LOGICAL FUNCTIONS
--------------------
{-| Exclusive `or` -}
xor :: Bool -> Bool -> Bool
xor = (/=)

{-| Implication, in terms of disjunction -}
(-->) :: Bool -> Bool -> Bool
p --> q = not p || q

{-| Bicondition -}
(<->) :: Bool -> Bool -> Bool
(<->) = (==)

{-| Negated `or` -}
nor :: Bool -> Bool -> Bool
nor p q = not $ p && q

------------------------
-- FUNCTIONS FOR TESTING
------------------------
{-| These functions take a function that expects a certain number of
Boolean arguments, and test it with all possible True/False input
combinations.
-}
one :: (Bool -> Bool) -> [Bool]
one f = map f [False,True]

two :: (Bool -> Bool -> Bool) -> [Bool]
two f = map (uncurry f) [(False,False),(False,True),(True,False),(True,True)]

three :: (Bool -> Bool -> Bool -> Bool) -> [Bool]
three f = map (uncurry3 f) [ (False,False,False), (False,False,True)
                           , (False,True,False),  (False,True,True)
                           , (True,False,False),  (True,False,True)
                           , (True,True,False),   (True,True,True) ]

four :: (Bool -> Bool -> Bool -> Bool -> Bool) -> [Bool]
four f = map (uncurry4 f) [ (False,False,False,False), (False,False,False,True)
                          , (False,False,True,False), (False,False,True,True)
                          , (False,True,False,False), (False,True,False,True)
                          , (False,True,True,False),  (False,True,True,True)
                          , (True,False,False,False), (True,False,False,True)
                          , (True,False,True,False),  (True,False,True,True)
                          , (True,True,False,False),  (True,True,False,True)
                          , (True,True,True,False),   (True,True,True,True) ]

------------------
-- TAUTOLOGY TESTS
------------------
taut1 :: Bool -> Bool -> Bool -> Bool
taut1 p q r = ((q || r) && (not q || p)) --> r || p

taut2 :: Bool -> Bool -> Bool
taut2 p q = (p `xor` q) == not (p <-> q)

taut3 :: Bool -> Bool
taut3 p = p --> p

------------
-- LAW TESTS
------------
absorb1 :: Bool -> Bool -> Bool
absorb1 p q = (p && (p || q)) == p

absorb2 :: Bool -> Bool -> Bool
absorb2 p q = (p || (p && q)) == p

demorgan1 :: Bool -> Bool -> Bool
demorgan1 p q = not (p && q) == (not p || not q)

demorgan2 :: Bool -> Bool -> Bool
demorgan2 p q = not (p || q) == (not p && not q)

-----------
-- PLUMBING
-----------
-- Can this be done better with lenes?
uncurry3 :: (a -> b -> c -> d) -> (a,b,c) -> d
uncurry3 f (a,b,c) = f a b c

uncurry4 :: (a -> b -> c -> d -> e) -> (a,b,c,d) -> e
uncurry4 f (a,b,c,d) = f a b c d
