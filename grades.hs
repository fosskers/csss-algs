module Grades where

import Data.Maybe (fromJust)

---

data Grade = Grade Float Float Float deriving (Eq,Show)

data Letter = F | D | Cm | C | Cp | Bm | B | Bp | Am | A | Ap
            deriving (Eq,Show,Enum)

data Course = Course { letterOf :: Letter
                     , unitsOf  :: Units } deriving (Eq,Show)

type Units = Float

letterNumMap :: [(Letter,Units)]
letterNumMap = [ (Ap,4.33), (A,4), (Am,3.67), (Bp,3.33), (B,3)
               , (Bm,2.67), (Cp,2.33), (C,2), (Cm,1.67), (D,1), (F,0) ]

------------
-- USE THESE
------------
-- | Your percent grade so far.
final :: [Grade] -> Float
final gs = 100 * sum (map grade gs) / highest gs

gpa :: [Course] -> Float
gpa = uncurry (/) . foldl (\(ps,us) c -> (ps + points c, us + unitsOf c)) (0,0)

------------
-- PLUMBING 
------------
-- | The maximum percentage grade for a course. Should be 100
-- for a full set of Grades.
highest :: [Grade] -> Float
highest = foldl (\acc (Grade _ _ x) -> acc + x) 0

-- | A grade, weighted.
-- Got 75/100 on something worth 4%? Then you got 3%.
grade :: Grade -> Float
grade (Grade g m w) = (g / m) * w

points :: Course -> Float
points (Course l u) = letterToNum l * u

letterToNum :: Letter -> Float
letterToNum = fromJust . flip lookup letterNumMap

------------------------
-- COURSES AND SEMESTERS
------------------------
-- Pass this to `gpa`
sem01 :: [Course]
sem01 = [ Course A  3  -- GERM 102
        , Course Am 3  -- CMPT 150
        , Course Am 3  -- MATH 232
        , Course Bp 3  -- MACM 101
        ]

-- Pass this to `final`
macm101 :: [Grade]
macm101 = [ Grade 90.75 100 5
          , Grade 75 90 5
          , Grade 98 100 5
          , Grade 89 100 5
          , Grade 91 97 5
          , Grade 80 100 15  -- Midterm 1
          , Grade 59 100 15  -- Midterm 2
          , Grade 10 10 10   -- Tutorials
          , Grade 95 130 35  -- Final
          ]
