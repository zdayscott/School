-- CSci 119, Lab 5
-- Reference: Lecture notes, Sections 4.1, 4.2

import Data.List

-- For this (and most) labs, the alphabet will be {a,b} to keep testing easier,
-- but your code should work just as well for any finite list.
sigma = ['a', 'b']

-- Finite State Machine M = (Q, s, F, d)
type FSM = ([Int], Int, [Int], [(Int,Char,Int)])

-- Check whether a finite state machine (qs, s, fs, ts) is correct/complete:
-- (1) States qs are unique (no duplicates)
-- (2) Start state is a state (s is in qs)
-- (3) Final states are states (fs is a subset of qs)
-- (4) Transition relation is a function from qs and sigma to qs (exactly one
--     output state for each state and letter from sigma)
checkFSM :: FSM -> Bool
checkFSM (qs, s, fs, ts) = let
                            one = qs == (nub qs)
                            two = s `elem` qs
                            three = and [x `elem` qs | x <- fs]
                            four = [d | (q, a, d) <- ts, q 'elem' qs, sig <- sigma, ql <- qs, (q, a) == (ql, sig)]
                                --and [(is `elem` qs) && (ds `elem` qs) && (is /= is2 || s /= s2 || ds == ds2) | (is,s,ds) <- ts, (is2,s2,ds2) <- ts]

                            in one && two && three && four

-- Gives the transition function of the machine as a function
-- i.e., delta m q a = the state machine m goes to when reading a in state q
delta :: FSM -> Int -> Char -> Int
delta (qs, s, fs, ts) q a = undefined

-- Gives the delta* function (recursive in w)
delta_star :: FSM -> Int -> [Char] -> Int
delta_star m q w = undefined

-- Machine acceptance, Definition 1 (via delta*)
accept1 :: FSM -> [Char] -> Bool
accept1 m w = undefined


-- Machine acceptance, Definition 2 (via L_q(M))

-- accept2_aux m q w = whether m, starting in q, accepts w (recursive in w)
accept2_aux :: FSM -> Int -> [Char] -> Bool
accept2_aux m q w = undefined

-- Acceptance, defined (non-recursively) in terms of accept2_aux
accept2 :: FSM -> [Char] -> Bool
accept2 m w = undefined


-- Define a machine that accepts exactly the strings with an odd number of b's
-- and test it adequately


-- Define a machine that accepts exactly the strings that do not contain "aab"
-- as a substring and test it adequately


-- Define a machine that accepts all strings that end in "ab" and test


