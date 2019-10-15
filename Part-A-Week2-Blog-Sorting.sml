fun partition(numbers : int list, pivot : int) =
    if null numbers
    then ([], [])
    else
        let
            val current_number = hd numbers
            val rest_of_numbers = tl numbers
            val (less_than_or_equal_to_pivot, larger_than_pivot) = partition(rest_of_numbers, pivot)
        in
            if current_number > pivot
            then (less_than_or_equal_to_pivot, current_number :: larger_than_pivot)
            else (current_number :: less_than_or_equal_to_pivot, larger_than_pivot)
        end

(* 1st version of quick sort, first element as pivot *)
fun sort(numbers : int list) =
    if null numbers
    then []
    else
        let
            val pivot = hd numbers
            val to_partition = tl numbers
            val (less_than_or_equal_to_pivot, larger_than_pivot) = partition(to_partition, pivot)
        in
            sort(less_than_or_equal_to_pivot) @ (pivot :: sort(larger_than_pivot))
        end

(* find the *nth* element of *numbers* and partition *numbers* with it being pivot *)
fun extract_and_partition(nth : int, numbers : int list) =
    let
        val current_number = hd numbers
        val rest_numbers = tl numbers
    in
        if nth = 1
        then
            let
                val (less_than_or_equal_to_pivot, larger_than_pivot) = partition(rest_numbers, current_number)
            in
                (current_number, less_than_or_equal_to_pivot, larger_than_pivot)
            end
        else
            let
                val (pivot, less_than_or_equal_to_pivot, larger_than_pivot) = extract_and_partition(nth - 1, rest_numbers)
            in
                if current_number <= pivot
                then (pivot, (current_number :: less_than_or_equal_to_pivot), larger_than_pivot)
                else (pivot, less_than_or_equal_to_pivot, (current_number :: larger_than_pivot))
            end
    end

val rand_seed = Random.rand(1, 100)

(* 2nd version of quick sort, random element as pivot *)
fun qsort(numbers : int list) =
    if null numbers
    then []
    else
        let
            val rand_index = Random.randInt(rand_seed) mod (List.length numbers) + 1
            val (pivot, less_than_or_equal_to_pivot , greater_than_pivot) = extract_and_partition(rand_index, numbers)
        in
            qsort(less_than_or_equal_to_pivot) @ (pivot :: qsort(greater_than_pivot))
        end

(*
20. Write a function divide : int list -> int list * int list that takes a list of integers and produces two 
lists by alternating elements between the two lists. For example: divide ([1,2,3,4,5,6,7]) = ([1,3,5,7], [2,4,6])
*)
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
                
fun merge_sort(numbers : int list) =
    if null numbers orelse null (tl numbers)
    then numbers
    else
        let
            val divided_pairs = divide numbers
        in
            sortedMerge(merge_sort(#1 divided_pairs), merge_sort(#2 divided_pairs))
        end