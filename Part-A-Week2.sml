(*
1. Write a function alternate : int list -> int that takes a list of numbers and adds them with 
alternating sign. For example alternate [1,2,3,4] = 1 - 2 + 3 - 4 = -2.
*)
fun alternate(numbers : int list) =
    let
        fun alternate_with_sum_and_sign(numbers : int list, sum : int, sign : int) =
            if null numbers
            then sum
            else alternate_with_sum_and_sign(tl numbers, sum + sign * (hd numbers), sign * ~1)
    in
        alternate_with_sum_and_sign(numbers, 0, 1)
    end

(*
2. Write a function min_max : int list -> int * int that takes a non-empty list of numbers, and 
returns a pair (min, max) of the minimum and maximum of the numbers in the list.
*)
fun min_max(numbers : int list) =
    let
        val current_number = hd numbers
        val rest_numbers = tl numbers
    in
        if null rest_numbers
        then (current_number, current_number)
        else
            let
                val rest_pair = min_max(rest_numbers)
                val rest_min = #1 rest_pair
                val rest_max = #2 rest_pair
                val current_min = if current_number > rest_min then rest_min else current_number
                val current_max = if current_number > rest_max then current_number else rest_max
            in
                (current_min, current_max)
            end
    end

(*
3. Write a function cumsum : int list -> int list that takes a list of numbers and returns a list
of the partial sums of those numbers. For example cumsum [1,4,20] = [1,5,25].
*)
fun cumsum(numbers : int list) =
    let
        fun cumsum_with_presum(numbers : int list, presum : int) =
            if null numbers
            then []
            else (presum + hd numbers) :: cumsum_with_presum(tl numbers, presum + hd numbers)
    in
        cumsum_with_presum(numbers, 0)
    end

(*
4. Write a function greeting : string option -> string that given a string option SOME name returns 
the string "Hello there, ...!" where the dots would be replaced by name. Note that the name is given
as an option, so if it is NONE then replace the dots with "you".
*)
fun greeting(name : string option) =
    "Hello there, " ^ (if isSome name then valOf name else "you") ^ "!"

(*
5. Write a function repeat : int list * int list -> int list that given a list of integers and another
list of nonnegative integers, repeats the integers in the first list according to the numbers indicated 
by the second list. For example: repeat ([1,2,3], [4,0,3]) = [1,1,1,1,3,3,3].
*)
fun repeat(numbers : int list, repeat_times : int list) =
    let
        fun repeat_number_add_to(number : int, repeat_time : int, lst : int list) =
            if repeat_time = 0
            then lst
            else repeat_number_add_to(number, repeat_time - 1, number :: lst) 
    in
        if null numbers
        then []
        else
            let
                val rest_repeat_numbers = repeat(tl numbers, tl repeat_times)
            in
                repeat_number_add_to(hd numbers, hd repeat_times, rest_repeat_numbers)
            end
    end

(*
6. Write a function addOpt : int option * int option -> int option that given two "optional" integers, 
adds them if they are both present (returning SOME of their sum), or returns NONE if at least one of 
the two arguments is NONE.
*)
fun addOpt(first : int option, second : int option) =
    if isSome first andalso isSome second
    then SOME ((valOf first) + (valOf second))
    else NONE

(*
7. Write a function addAllOpt : int option list -> int option that given a list of "optional" integers,
adds those integers that are there (i.e. adds all the SOME i). For example: 
addAllOpt ([SOME 1, NONE, SOME 3]) = SOME 4. If the list does not contain any SOME i s in it, i.e. they 
are all NONE or the list is empty, the function should return NONE.
*)
fun addAllOpt(options : int option list) =
    if null options
    then NONE
    else
        let 
            val rest_sum_option = addAllOpt(tl options)
            (* add to int option s, if both are NONE, then NONE. If both are SOME, then SOME sum.
               Otherwise, return the only SOME *)
            fun addOpt(first : int option, second : int option) =
                if isSome first andalso isSome second
                then SOME (valOf first + valOf second)
                else
                    if isSome first
                    then first
                    else
                        if isSome second
                        then second
                        else NONE
        in
            addOpt(hd options, rest_sum_option)
        end

(*
8. Write a function any : bool list -> bool that given a list of booleans returns true if there is at 
least one of them that is true, otherwise returns false. (If the list is empty it should return false 
because there is no true.)
*)
fun any(bools : bool list) =
    if null bools
    then false
    else
        if hd bools
        then true
        else any(tl bools)

(*
9. Write a function all : bool list -> bool that given a list of booleans returns true if all of them 
true, otherwise returns false. (If the list is empty it should return true because there is no false.)
*)
fun all(bools : bool list) =
    if null bools
    then true
    else
        if hd bools
        then all(tl bools)
        else false

(*
10. Write a function zip : int list * int list -> int * int list that given two lists of integers creates 
consecutive pairs, and stops when one of the lists is empty. For example: zip ([1,2,3], [4, 6]) = [(1,4), (2,6)]
*)
fun zip(first_ints : int list, second_ints : int list) =
    if null first_ints orelse null second_ints
    then []
    else
        (hd first_ints, hd second_ints) :: zip(tl first_ints, tl second_ints)

(*
11. Challenge: Write a version zipRecycle of zip, where when one list is empty it starts recycling from its 
start until the other list completes. For example: 
zipRecycle ([1,2,3], [1, 2, 3, 4, 5, 6, 7]) = [(1,1), (2,2), (3, 3), (1,4), (2,5), (3,6), (1,7)].
*)
fun zipRecycle(first_ints : int list, second_ints : int list) =
    if null first_ints orelse null second_ints
    then []
    else
        let
            fun zipRecycle_until_first_empty(first_lst : int list, second_lst : int list) =
                if null first_lst
                then []
                else
                    if null second_lst
                    then zipRecycle_until_first_empty(first_lst, second_ints)
                    else (hd first_lst, hd second_lst) :: zipRecycle_until_first_empty(tl first_lst, tl second_lst)
            fun zipRecycle_until_second_empty(first_lst : int list, second_lst : int list) =
                if null second_lst
                then []
                else
                    if null first_lst
                    then zipRecycle_until_second_empty(first_ints, second_lst)
                    else (hd first_lst, hd second_lst) :: zipRecycle_until_second_empty(tl first_lst, tl second_lst)
            (* 
               the first call to this function should have two nonempty argument

               This function first deals with those part for original zip function.
               After one of the list turned into empty list after calls to this function, we call corresponding helper function
               to enter the recycling 
            *)
            fun zipRecycle_first_call_not_both_empty(first_lst : int list, second_lst : int list) =
                if null first_lst
                then zipRecycle_until_second_empty(first_ints, second_lst)
                else
                    if null second_lst
                    then zipRecycle_until_first_empty(first_lst, second_ints)
                    else (hd first_lst, hd second_lst) :: zipRecycle_first_call_not_both_empty(tl first_lst, tl second_lst)
        in
            zipRecycle_first_call_not_both_empty(first_ints, second_ints)
        end

fun zipRecycle(first_ints : int list, second_ints : int list) =
    if null first_ints orelse null second_ints
    then []
    else
        let
            fun zipRecycle_until_first_empty(first_lst : int list, second_lst : int list) =
                if null first_lst
                then []
                else
                    if null second_lst
                    then zipRecycle_until_first_empty(first_lst, second_ints)
                    else (hd first_lst, hd second_lst) :: zipRecycle_until_first_empty(tl first_lst, tl second_lst)
            fun zipRecycle_until_second_empty(first_lst : int list, second_lst : int list) =
                if null second_lst
                then []
                else
                    if null first_lst
                    then zipRecycle_until_second_empty(first_ints, second_lst)
                    else (hd first_lst, hd second_lst) :: zipRecycle_until_second_empty(tl first_lst, tl second_lst)
        in
            if List.length first_ints > List.length second_ints
            then zipRecycle_until_first_empty(first_ints, second_ints)
            else zipRecycle_until_second_empty(first_ints, second_ints)
        end

(*
12. Lesser challenge: Write a version zipOpt of zip with return type (int * int) list option. This version 
should return SOME of a list when the original lists have the same length, and NONE if they do not.
*)
fun zipOpt(first_ints : int list, second_ints : int list) =
    if null first_ints andalso null second_ints
    then SOME []
    else
        if null first_ints orelse null second_ints
        then NONE
        else
            let
                val rest_zipOpt = zipOpt(tl first_ints, tl second_ints)
            in
                if isSome rest_zipOpt
                then SOME ((hd first_ints, hd second_ints) :: valOf rest_zipOpt)
                else NONE
            end

(*
13. Write a function lookup : (string * int) list * string -> int option that takes a list of pairs (s, i)
and also a string s2 to look up. It then goes through the list of pairs looking for the string s2 in the 
first component. If it finds a match with corresponding number i, then it returns SOME i. If it does not, 
it returns NONE.
(I assume that there is at most one match.)
*)
fun lookup(string_int_pairs : (string * int) list, target_string : string) =
    if null string_int_pairs
    then NONE
    else
        if (#1 (hd string_int_pairs)) = target_string
        then SOME (#2 (hd string_int_pairs))
        else lookup(tl string_int_pairs, target_string)

(*
14. Write a function splitup : int list -> int list * int list that given a list of integers creates two 
lists of integers, one containing the non-negative entries, the other containing the negative entries. 
Relative order must be preserved: All non-negative entries must appear in the same order in which they 
were on the original list, and similarly for the negative entries.
*)
fun splitup(numbers : int list) =
    if null numbers
    then ([], [])
    else
        let
            val rest_splitup = splitup(tl numbers)
            val current_number = hd numbers
        in
            if current_number >= 0
            then (current_number :: (#1 rest_splitup), #2 rest_splitup)
            else (#1 rest_splitup, current_number :: (#2 rest_splitup))
        end

(*
15. Write a version splitAt : int list * int -> int list * int list of the previous function that takes 
an extra "threshold" parameter, and uses that instead of 0 as the separating point for the two resulting lists.
*)
fun splitAt(numbers : int list, threshold : int) =
    if null numbers
    then ([], [])
    else
        let
            val rest_splitup = splitAt(tl numbers, threshold)
            val current_number = hd numbers
        in
            if current_number >= threshold
            then (current_number :: (#1 rest_splitup), #2 rest_splitup)
            else (#1 rest_splitup, current_number :: (#2 rest_splitup))
        end

(*
16. Write a function isSorted : int list -> boolean that given a list of integers determines whether the 
list is sorted in increasing order.
(* I assume the list given is a list of distinct numbers *)
*)
fun isSorted(numbers : int list) =
    if null numbers
    then true
    else
        let
            val rest_numbers = tl numbers
            val current_number = hd numbers
        in
            if null rest_numbers
            then true
            else
                let
                    val rest_sorted = isSorted rest_numbers
                in
                    current_number < hd rest_numbers andalso rest_sorted
                end
        end
            
(*
17. Write a function isAnySorted : int list -> boolean, that given a list of integers determines whether 
the list is sorted in either increasing or decreasing order.
*)
fun isAnySorted(numbers : int list) =
    if null numbers orelse null (tl numbers) orelse null (tl (tl numbers))
    then true
    else
        let
            val rest_numbers = tl numbers
            val current_number = hd numbers
            val rest_isAnySorted = isAnySorted(rest_numbers)
        in
            rest_isAnySorted andalso
            ((current_number < hd rest_numbers andalso hd rest_numbers < hd (tl rest_numbers)) orelse
             (current_number > hd rest_numbers andalso hd rest_numbers > hd (tl rest_numbers))) 
        end

(*
18. Write a function sortedMerge : int list * int list -> int list that takes two lists of integers that 
are each sorted from smallest to largest, and merges them into one sorted list. For example: 
sortedMerge ([1,4,7], [5,8,9]) = [1,4,5,7,8,9]
*)
fun sortedMerge(first_numbers : int list, second_numbers : int list) =
    if null first_numbers andalso null second_numbers
    then []
    else
        if null first_numbers
        then (hd second_numbers) :: sortedMerge(first_numbers, tl second_numbers)
        else
            if null second_numbers
            then (hd first_numbers) :: sortedMerge(tl first_numbers, second_numbers)
            else
                if (hd first_numbers) > (hd second_numbers)
                then (hd second_numbers) :: sortedMerge(first_numbers, tl second_numbers)
                else (hd first_numbers) :: sortedMerge(tl first_numbers, second_numbers)

(*
19. Write a sorting function qsort : int list -> int list that works as follows: Takes the first element out, 
and uses it as the "threshold" for splitAt. It then recursively sorts the two lists produced by splitAt. 
Finally it brings the two lists together. (Don't forget that element you took out, it needs to get back in at 
some point). You could use sortedMerge for the "bring together" part, but you do not need to as all the numbers 
in one list are less than all the numbers in the other.)
*)
fun qsort(numbers : int list) =
    if null numbers
    then []
    else
        let
            val pivot = hd numbers
            val partitioned_pairs = splitAt(tl numbers, pivot)
            val greater_than_or_equal_pivot = #1 partitioned_pairs
            val less_than_pivot = #2 partitioned_pairs
        in
            qsort(less_than_pivot) @ (pivot :: qsort(greater_than_or_equal_pivot))
        end

(*
20. Write a function divide : int list -> int list * int list that takes a list of integers and produces two 
lists by alternating elements between the two lists. For example: divide ([1,2,3,4,5,6,7]) = ([1,3,5,7], [2,4,6])
*)
fun divide(numbers : int list) =
    let
        fun divide_first_element_in_second_list(numbers : int list) =
            if null numbers
            then ([], [])
            else
                let
                    val rest_divided_pairs = divide(tl numbers)
                in
                    (#1 rest_divided_pairs, (hd numbers) :: (#2 rest_divided_pairs))
                end
    in
        if null numbers
        then ([], [])
        else
            let
                val rest_divided_pairs = divide_first_element_in_second_list(tl numbers)
            in
                ((hd numbers) :: (#1 rest_divided_pairs), #2 rest_divided_pairs)
            end
    end

fun divide(numbers : int list) =
    let
        fun divide_first_put_to(numbers : int list, put_to_first : bool) =
            if null numbers
            then ([], [])
            else
                let
                    val rest_divided_pairs = divide_first_put_to(tl numbers, not put_to_first)
                in
                    if put_to_first
                    then ((hd numbers) :: (#1 rest_divided_pairs), #2 rest_divided_pairs)
                    else (#1 rest_divided_pairs, (hd numbers) :: (#2 rest_divided_pairs))
                end
    in
        divide_first_put_to(numbers, true)
    end

(*
21. Write another sorting function not_so_quick_sort : int list -> int list that works as follows: 
Given the initial list of integers, splits it in two lists using divide, then recursively sorts 
those two lists, then merges them together with sortedMerge.
*)
fun not_so_quick_sort(numbers : int list) =
    if null numbers orelse null (tl numbers)
    then numbers
    else
        let
            val divided_pairs = divide numbers
        in
            sortedMerge(not_so_quick_sort(#1 divided_pairs), not_so_quick_sort(#2 divided_pairs))
        end

(*
22. Write a function fullDivide : int * int -> int * int that given two numbers k and n it attempts 
to evenly divide k into n as many times as possible, and returns a pair (d, n2) where d is the number 
of times while n2 is the resulting n after all those divisions. Examples: fullDivide (2, 40) = (3, 5)
because 2*2*2*5 = 40 and fullDivide((3,10)) = (0, 10) because 3 does not divide 10.
*)
fun fullDivide(n : int, k : int) =
    if n mod k <> 0
    then (0, n)
    else
        let
            val rest_divide_pairs = fullDivide(n div k, k)
        in
            (#1 rest_divide_pairs + 1, #2 rest_divide_pairs)
        end

(*
23. Using fullDivide, write a function factorize : int -> (int * int) list that given a number n returns 
a list of pairs (d, k) where d is a prime number dividing n and k is the number of times it fits. The 
pairs should be in increasing order of prime factor, and the process should stop when the divisor considered 
surpasses the square root of n. If you make sure to use the reduced number n2 given by fullDivide for each 
next step, you should not need to test if the divisors are prime: If a number divides into n, it must be 
prime (if it had prime factors, they would have been earlier prime factors of n and thus reduced earlier). 
Examples: factorize(20) = [(2,2), (5,1)]; factorize(36) = [(2,2), (3,2)]; factorize(1) = [].
*)
fun factorize(number : int) =
    let
        fun try_to_factorize_until_checked_prime(n : int, possible_factor : int) =
            if n = 1
            then []
            else if possible_factor * possible_factor > n
                then [(n, 1)]
                else
                    if n mod possible_factor = 0
                    then
                        let
                            val divide_pair = fullDivide(n, possible_factor)
                        in
                            (possible_factor, #1 divide_pair) :: try_to_factorize_until_checked_prime(#2 divide_pair, 2)
                        end
                    else try_to_factorize_until_checked_prime(n, possible_factor + 1)
    in
        try_to_factorize_until_checked_prime(number, 2)
    end

(*
24. Write a function multiply : (int * int) list -> int that given a factorization of a number n as 
described in the previous problem computes back the number n. So this should do the opposite of factorize.
*)
fun multiply(factor_and_powers : (int * int) list) =
    if null factor_and_powers
    then 1
    else 
        let
            fun pow(factor : int, power : int) =
                if power = 0
                then 1
                else factor * pow(factor, power - 1)
        in
            pow(#1 (hd factor_and_powers), #2 (hd factor_and_powers)) * multiply(tl factor_and_powers)
        end

(*
25. Challenge (hard): Write a function all_products : (int * int) list -> int list that given a factorization 
list result from factorize creates a list all of possible products produced from using some or all of those 
prime factors no more than the number of times they are available. This should end up being a list of all the 
divisors of the number n that gave rise to the list. Example: all_products([(2,2), (5,1)]) = [1,2,4,5,10,20]. 
For extra challenge, your recursive process should return the numbers in this order, as opposed to sorting them 
afterwards.
*)
fun all_products (factor_and_powers : (int * int) list) =
    if null factor_and_powers
    then [1]
    else
        let
            val rest_products = all_products(tl factor_and_powers)
            fun add_factor_and_power_to_products(factor_and_power : int * int, prev_products : int list) =
                let
                    val factor = #1 factor_and_power
                    val power = #2 factor_and_power
                in
                    if power = 0
                    then prev_products
                    else
                        let
                            fun all_power(factor_and_power : int * int) =
                                let
                                    val factor = #1 factor_and_power
                                    val power = #2 factor_and_power
                                in
                                    if power = 0
                                    then [1]
                                    else
                                        let
                                            val rest_powers = all_power((factor, power - 1))
                                        in
                                            (factor * (hd rest_powers)) :: rest_powers
                                        end
                                end
                            fun multiply_first_to_second(multipliers : int list, numbers : int list) =
                                let
                                    fun multiply(multiplier : int, numbers : int list) =
                                        if null numbers
                                        then []
                                        else (multiplier * (hd numbers)) :: multiply(multiplier, tl numbers)
                                in
                                    if null multipliers
                                    then []
                                    else multiply(hd multipliers, numbers) @ multiply_first_to_second(tl multipliers, numbers)
                                end
                        in
                            multiply_first_to_second(all_power(factor_and_power), prev_products)
                        end
                end
        in
            qsort (add_factor_and_power_to_products(hd factor_and_powers, rest_products))
        end
            