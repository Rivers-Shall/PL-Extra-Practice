(*
1. test strategy:
  - empty list
  - odd number of elements
  - even number of elements
*)
(* covers empty list *)
val test1_1 = alternate([]) = 0
(* covers odd number of elements list *)
val test1_2 = alternate([1, 2, 3]) = 2
(* covers even number of elements list *)
val test1_3 = alternate([1, 2]) = ~1

(*
2. test strategy:
  - one-element list
  - a list of same elements
  - a list of distinct elements
  - distinct min and max value with duplicate elements in the list

  - sorted list
  - unsorted list
*)
(* covers one-element list *)
val test2_1 = min_max([1]) = (1, 1)
(* covers a list of same elements *)
val test2_2 = min_max([2, 2, 2, 2]) = (2, 2)
(* covers a list of distinct elements and unsorted list *)
val test2_3 = min_max([3, 2, 4, 7]) = (2, 7)
(* covers a list of distinct elements and sorted list *)
val test2_4 = min_max([2, 3, 4, 5]) = (2, 5)

(*
3. test strategy:
  - empty list
  - all positive number list
  - all negative number list
  - all zero list
  - mixed list
*)
(* covers empty list *)
val test3_1 = cumsum [] = []
(* covers all positive number list *)
val test3_2 = cumsum [1, 2, 3] = [1, 3, 6]
(* covers all negative number list *)
val test3_3 = cumsum [~1, ~2, ~3] = [~1, ~3, ~6]
(* covers all zero list *)
val test3_4 = cumsum [0, 0, 0] = [0, 0, 0]
(* covers mixed list *)
val test3_5 = cumsum [1, ~2, 0, 4, ~3] = [1, ~1, ~1, 3, 0]

(*
4. test strategy:
  - NONE
  - SOME empty string
  - SOME nonempty string
*)
(* covers NONE *)
val test4_1 = greeting(NONE) = "Hello there, you!"
(* covers SOME empty string *)
val test4_2 = greeting(SOME "") = "Hello there, !"
(* covers SOME nonempty string *)
val test4_3 = greeting(SOME "Rivers") = "Hello there, Rivers!"

(*
5. test strategy:
  - both empty lists
  - nonempty
    - all zero times
    - all single times
    - all multiple times
    - mixed
*)
(* covers both empty list *)
val test5_1 = repeat([], []) = []
(* covers all zero times *)
val test5_2 = repeat([1, 2, 3], [0, 0, 0]) = []
(* covers all single times *)
val test5_3 = repeat([1, 2, 3], [1, 1, 1]) = [1, 2, 3]
(* covers all multiple times *)
val test5_4 = repeat([1, 2, 3], [2, 4, 3]) = [1, 1, 2, 2, 2, 2, 3, 3, 3]
(* covers mixed times *)
val test5_5 = repeat([1, 2, 3], [1, 4, 0]) = [1, 2, 2, 2, 2]

(*
6. test strategy:
  - both NONE
  - both SOME
  - first SOME, second NONE
  - first NONE, second SOME
*)
(* covers both NONE *)
val test6_1 = addOpt(NONE, NONE) = NONE
(* covers both SOME *)
val test6_2 = addOpt(SOME 1, SOME 2) = SOME 3
(* covers first SOME, second NONE *)
val test6_3 = addOpt(SOME 1, NONE) = NONE
(* covers first NONE, second SOME *)
val test6_4 = addOpt(NONE, SOME 1) = NONE

(*
7. test strategy:
  - empty list

  - nonempty list
    - all NONE
    - all SOME
    - mixed
*)
(* covers empty list *)
val test7_1 = addAllOpt [] = NONE
(* covers nonempty list, all NONE *)
val test7_2 = addAllOpt [NONE, NONE, NONE] = NONE
(* covers nonempty list, all SOME *)
val test7_3 = addAllOpt [SOME 1, SOME ~2, SOME 9] = SOME 8
(* covers nonempty list, mixed *)
val test7_4 = addAllOpt [NONE, SOME ~2, SOME 9, NONE] = SOME 7

(*
8. test strategy:
  - empty list
  - nonempty list
    - all false
    - one true with some false
    - multiple true with some false
    - all true
*)
(* covers empty list *)
val test8_1 = any [] = false
(* covers nonempty list, all false *)
val test8_2 = any [false, false, false] = false
(* covers nonempty list, one true with some false *)
val test8_3 = any [true, false, false] = true
(* covers nonempty list, multiple true with some false *)
val test8_4 = any [false, true, false, true] = true
(* covers nonempty list, all true *)
val test8_5 = any [true, true, true] = true

(*
9. test strategy:
  - empty list
  - nonempty list
    - all false
    - one true with some false
    - multiple true with some false
    - all true
*)
(* covers empty list *)
val test9_1 = all [] = true
(* covers nonempty list, all false *)
val test9_2 = all [false, false, false] = false
(* covers nonempty list, one true with some false *)
val test9_3 = all [true, false, false] = false
(* covers nonempty list, multiple true with some false *)
val test9_4 = all [false, true, false, true] = false
(* covers nonempty list, all true *)
val test9_5 = all [true, true, true] = true

(*
10. test strategy:
  - equal length
  - first longer than second
  - second longer than first
  
  - both empty
  - first empty, second nonempty
  - first nonempty, second empty
  - both nonempty
*)
(* covers equal length, both nonempty *)
val test10_1 = zip ([1, 2, 3], [~4, ~9, 0]) = [(1, ~4), (2, ~9), (3, 0)]
(* covers equal length, both empty *)
val test10_2 = zip ([], []) = []
(* covers first longer than second, both nonempty *)
val test10_3 = zip ([1, 2, 3, 5, 6], [~4, ~9, 0]) = [(1, ~4), (2, ~9), (3, 0)]
(* covers first longer than second, first nonempty, second empty *)
val test10_4 = zip ([1, 2, 3], []) = []
(* covers second longer than first, both nonempty *)
val test10_5 = zip ([1, 2, 3], [~4, ~9, 0, 10, 2]) = [(1, ~4), (2, ~9), (3, 0)]
(* covers second longer than first, first empty, second nonempty *)
val test10_6 = zip ([], [~4, ~9, 0, 10, 2]) = []

(*
11. test strategy:
  - equal length
  - first longer than second
  - second longer than first
  
  - both empty
  - first empty, second nonempty
  - first nonempty, second empty
  - both nonempty
*)
(* covers equal length, both nonempty *)
val test11_1 = zipRecycle ([1, 2, 3], [~4, ~9, 0]) = [(1, ~4), (2, ~9), (3, 0)]
(* covers equal length, both empty *)
val test11_2 = zipRecycle ([], []) = []
(* covers first longer than second, both nonempty *)
val test11_3 = zipRecycle ([1, 2, 3, 5, 6], [~4, ~9, 0]) = [(1, ~4), (2, ~9), (3, 0), (5, ~4), (6, ~9)]
(* covers first longer than second, first nonempty, second empty *)
val test11_4 = zipRecycle ([1, 2, 3], []) = []
(* covers second longer than first, both nonempty *)
val test11_5 = zipRecycle ([1, 2, 3], [~4, ~9, 0, 10, 2]) = [(1, ~4), (2, ~9), (3, 0), (1, 10), (2, 2)]
(* covers second longer than first, first empty, second nonempty *)
val test11_6 = zipRecycle ([], [~4, ~9, 0, 10, 2]) = []

(*
12. test strategy:
  - equal length
  - first longer than second
  - second longer than first
  
  - both empty
  - first empty, second nonempty
  - first nonempty, second empty
  - both nonempty
*)
(* covers equal length, both nonempty *)
val test12_1 = zipOpt ([1, 2, 3], [~4, ~9, 0]) = SOME [(1, ~4), (2, ~9), (3, 0)]
(* covers equal length, both empty *)
val test12_2 = zipOpt ([], []) = SOME []
(* covers first longer than second, both nonempty *)
val test12_3 = zipOpt ([1, 2, 3, 5, 6], [~4, ~9, 0]) = NONE
(* covers first longer than second, first nonempty, second empty *)
val test12_4 = zipOpt ([1, 2, 3], []) = NONE
(* covers second longer than first, both nonempty *)
val test12_5 = zipOpt ([1, 2, 3], [~4, ~9, 0, 10, 2]) = NONE
(* covers second longer than first, first empty, second nonempty *)
val test12_6 = zipOpt ([], [~4, ~9, 0, 10, 2]) = NONE

(*
13. testing strategy:
  - empty list, one-element list, multiple-element list
  - not found, found at the start, found in the middle, found at the end
*)
(* covers empty list *)
val test13_1 = lookup([], "test") = NONE
(* covers one-element list, not found *)
val test13_2 = lookup([("test", 1)], "tes") = NONE
(* covers one-element list, found *)
val test13_3 = lookup([("test", 1)], "test") = SOME 1
(* covers multiple-element list, not found *)
val test13_4 = lookup([("test", 1), ("rivers", 2), ("david", 4)], "tes") = NONE
(* covers multiple-element list, found at the start *)
val test13_5 = lookup([("test", 1), ("rivers", 2), ("david", 4)], "test") = SOME 1
(* covers multiple-element list, found in the middle *)
val test13_6 = lookup([("test", 1), ("rivers", 2), ("david", 4)], "rivers") = SOME 2
(* covers multiple-element list, found at the end *)
val test13_7 = lookup([("test", 1), ("rivers", 2), ("david", 4)], "david") = SOME 4

(*
14. testing strategy:
  - empty list
  - only nonnegative entries
  - only negative entries
  - mixed
*)
(* covers empty list *)
val test14_1 = splitup [] = ([], [])
(* covers only nonnegative entries *)
val test14_2 = splitup [0, 1, 2, 3] = ([0, 1, 2, 3], [])
(* covers only negative entries *)
val test14_3 = splitup [~1, ~2, ~3] = ([], [~1, ~2, ~3])
(* covers mixed entries *)
val test14_4 = splitup [0, ~1, 2, ~3] = ([0, 2], [~1, ~3])

(*
15. testing strategy:
  - empty list
  - only greater-than-or-equal-to-threshold entries
  - only less-than-threshold entries
  - mixed
*)
(* covers empty list *)
val test15_1 = splitAt ([], 1)= ([], [])
(* covers only greater-than-or-equal-to-threshold entries *)
val test15_2 = splitAt ([0, 1, 2, 3], ~1) = ([0, 1, 2, 3], [])
(* covers only less-than-threshold entries *)
val test15_3 = splitAt ([~1, ~2, ~3], 2) = ([], [~1, ~2, ~3])
(* covers mixed entries *)
val test15_4 = splitAt ([0, ~1, 2, ~3], 1) = ([2], [0, ~1, ~3])

(*
16. testing strategy:
  - empty list
  - one element list
  - multiple-element list
  
  - sorted list
  - out-of-order list
  - reversely sorted list
*)
(* covers empty list *)
val test16_1 = isSorted [] = true
(* covers one-element list *)
val test16_2 = isSorted [2] = true
(* covers multiple-element list, sorted list *)
val test16_3 = isSorted [2, 3, 4, 5] = true
(* covers multiple-element list, out-of-order list *)
val test16_4 = isSorted [2, 4, 3, 5] = false
(* covers multiple-element list, reversely sorted list *)
val test16_5 = isSorted [5, 4, 3, 2] = false

(*
17. testing strategy:
  - empty list
  - one element list
  - two element list
  - multiple-element list
  
  - sorted list
  - out-of-order list
  - reversely sorted list
*)
(* covers empty list *)
val test17_1 = isAnySorted [] = true
(* covers one-element list *)
val test17_2 = isAnySorted [2] = true
(* covers multiple-element list, sorted list *)
val test17_3 = isAnySorted [2, 3, 4, 5] = true
(* covers multiple-element list, out-of-order list *)
val test17_4 = isAnySorted [2, 4, 3, 5] = false
(* covers multiple-element list, reversely sorted list *)
val test17_5 = isAnySorted [5, 4, 3, 2] = true
(* covers two-element list *)
val test17_6 = isAnySorted [12, 2] = true

(*
18. testing strategy:
  - both empty lists
  - first empty list, second nonempty list
  - first nonempty list, second empty list
  - both nonempty lists
  
  - same length
  - first longer than second
  - second longer than first

  - first all smaller than second
  - first all greater than second
  - mixed
*)
(* covers both empty lists *)
val test18_1 = sortedMerge ([], []) = []
(* covers first empty list, second nonempty list *)
val test18_2 = sortedMerge ([], [1, 2, 3]) = [1, 2, 3]
(* covers first nonempty list, second empty list *)
val test18_3 = sortedMerge ([1, 2, 3], []) = [1, 2, 3]
(* covers both nonempty lists , same length, mixed *)
val test18_4 = sortedMerge ([1, 2, 3], [~1, 4, 8]) = [~1, 1, 2, 3, 4, 8]
(* covers both nonempty lists , same length, first all smaller than second *)
val test18_5 = sortedMerge ([1, 2, 3], [5, 6, 8]) = [1, 2, 3, 5, 6, 8]
(* covers both nonempty lists , same length, first all greater than second *)
val test18_6 = sortedMerge ([1, 2, 3], [~6, ~4, 0]) = [~6, ~4, 0, 1, 2, 3]
(* covers both nonempty lists , first longer than second, mixed *)
val test18_7 = sortedMerge ([1, 2, 3, 9], [~1, 4, 8]) = [~1, 1, 2, 3, 4, 8, 9]
(* covers both nonempty lists , second longer than first, mixed *)
val test18_8 = sortedMerge ([1, 2, 7], [~1, 4, 6, 8]) = [~1, 1, 2, 4, 6, 7, 8]

(*
19. testing strategy:
  - empty list
  - one-element list
  - multiple element list
  
  - sorted list
  - reversely sorted list
  - out-of-order list
*)
(* covers empty list *)
val test19_1 = qsort [] = []
(* covers one-element list *)
val test19_2 = qsort [1] = [1]
(* covers multiple-element list, sorted list *)
val test19_3 = qsort [1, 2, 3, 4] = [1, 2, 3, 4]
(* covers multiple-element list, reversely sorted list *)
val test19_4 = qsort [4, 3, 2, 1] = [1, 2, 3, 4]
(* covers multiple-element list, out-of-order list *)
val test19_5 = qsort [2, 1, 4, 3] = [1, 2, 3, 4]

(*
20. testing strategy:
  - empty list
  - one-element list
  - multiple(odd-number)element list
  - multiple(even-number)element list
*)
(* covers empty list *)
val test20_1 = divide [] = ([], [])
(* covers one-element list *)
val test20_2 = divide [1] = ([1], [])
(* covers multiple(odd-number)element list *)
val test20_3 = divide [1, 2, 3] = ([1, 3], [2])
(* covers multiple(even-number)element list *)
val test20_4 = divide [1, 2, 3, 4] = ([1, 3], [2, 4])

(*
21 testing strategy:
  - empty list
  - one-element list
  - multiple , odd-number-element list
  - multiple , even-number-element list
  
  - sorted list
  - reversely sorted list
  - out-of-order list
*)
(* covers empty list *)
val test21_1 = not_so_quick_sort [] = []
(* covers one-element list *)
val test21_2 = not_so_quick_sort [1] = [1]
(* covers multiple, even-number-element list, sorted list *)
val test21_3 = not_so_quick_sort [1, 2, 3, 4] = [1, 2, 3, 4]
(* covers multiple, even-number-element list, reversely sorted list *)
val test21_4 = not_so_quick_sort [4, 3, 2, 1] = [1, 2, 3, 4]
(* covers multiple, even-number-element list, out-of-order list *)
val test21_5 = not_so_quick_sort [2, 1, 4, 3] = [1, 2, 3, 4]
(* covers multiple, odd-number-element list, sorted list *)
val test21_6 = not_so_quick_sort [1, 2, 3, 4, 5] = [1, 2, 3, 4, 5]
(* covers multiple, odd-number-element list, reversely sorted list *)
val test21_7 = not_so_quick_sort [5, 4, 3, 2, 1] = [1, 2, 3, 4, 5]
(* covers multiple, odd-number-element list, out-of-order list *)
val test21_8 = not_so_quick_sort [2, 1, 4, 3, 5] = [1, 2, 3, 4, 5]

(*
22. testing strategy:
  - k = n
  - n = k ^ d (d > 1)
  - k does not divide n
  - n = k ^ d * n2 (n2 > 1)
  - n = 1
*)
(* covers k = n *)
val test22_1 = fullDivide (3, 3) = (1, 1)
(* covers n = k ^ d *)
val test22_2 = fullDivide (27, 3) = (3, 1)
(* covers k does not divide n *)
val test22_3 = fullDivide (27, 6) = (0, 27)
(* covers n = k ^ d * n2 (n2 > 1) *)
val test22_4 = fullDivide (54, 3) = (3, 2)
(* covers n = 1 *)
val test22_5 = fullDivide (1, 2) = (0, 1)

(*
23. testing strategy:
  - n = 1
  - n is prime
  - n is composite and has only one prime factor
  - n has multiple prime factors
*)
(* covers n = 1 *)
val test23_1 = factorize 1 = []
(* covers n has only one prime factor *)
val test23_2 = factorize 8 = [(2, 3)]
(* covers n has multiple prime factors *)
val test23_3 = factorize 120 = [(2, 3), (3, 1), (5, 1)]
(* covers n is prime *)
val test23_4 = factorize 7 = [(7, 1)]

(*
24. testing strategy:
  - empty list
  - one-factor list
  - multiple-factor list
*)
(* covers empty list *)
val test24_1 = multiply [] = 1
(* covers one-factor list *)
val test24_2 = multiply [(2, 3)] = 8
(* covers multiple-factor list *)
val test24_3 = multiply [(2, 3), (3, 1), (5, 2)] = 600

(*
25. testing strategy
  - empty list
  - one factor with power 1 list
  - one factor with power greater than 1 list
  - multiple factor with power greater than 1 list
*)
(* covers empty list *)
val test25_1 = all_products [] = [1]
(* covers one factor with power 1 list *)
val test25_2 = all_products [(7, 1)] = [1, 7]
(* covers one factor with power greater than 1 list *)
val test25_3 = all_products [(2, 3)] = [1, 2, 4, 8]
(* covers multiple factor with power greater than 1 list *)
val test25_4 = all_products [(2, 3), (3, 2), (5, 1)] = [1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 18, 20, 24, 30, 36, 40, 45, 60, 72, 90, 120, 180, 360]