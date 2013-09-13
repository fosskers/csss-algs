-- Boolean logic!

-- Exclusive `or`
xor :: Bool -> Bool -> Bool
xor = (/=)

-- Implication, in terms of disjunction.
(-->) :: Bool -> Bool -> Bool
p --> q = not p || q

(<->) :: Bool -> Bool -> Bool
(<->) = (==)

---

uncurry3 :: (a -> b -> c -> d) -> (a,b,c) -> d
uncurry3 f (a,b,c) = f a b c

one f = map f [False,True]

two f = map (uncurry f) [(False,False),(False,True),(True,False),(True,True)]

three f = map (uncurry3 f) [ (False,False,False),(False,False,True),(False,True,False)
                           , (False,True,True),(True,False,False),(True,False,True)
                           , (True,True,False),(True,True,True) ]

---

taut1 :: Bool -> Bool -> Bool -> Bool
taut1 p q r = ((q || r) && (not q || p)) --> r || p

taut2 :: Bool -> Bool -> Bool
taut2 p q = (p `xor` q) == not (p <-> q)

taut3 :: Bool -> Bool
taut3 p = p --> p

absorb1 :: Bool -> Bool -> Bool
absorb1 p q = (p && (p || q)) == p

absorb2 :: Bool -> Bool -> Bool
absorb2 p q = (p || (p && q)) == p

demorgan1 :: Bool -> Bool -> Bool
demorgan1 p q = not (p && q) == (not p || not q)

demorgan2 :: Bool -> Bool -> Bool
demorgan2 p q = not (p || q) == (not p && not q)

---

prob6a p q r = a == b
    where a = not $ p && (q || r) && (not p || not q || r)
          b = not p || not r

prob6b p q r = a == b
    where a = not $ (p && q) --> r
          b = p && q && not r

prob14a p q = a == b
    where a = p --> (q --> (p && q))
          b = not q || not p || q
