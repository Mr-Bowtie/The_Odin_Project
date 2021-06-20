# given an array of integers

# loop over the array n - 1 times (n = number of elements in array)
# in each pass, starting at index 0, determine if the first element is greater than the second element
# if so, swap the two elements. 
#     move one element to the right and repeat until the end of the array. 
# if there are no swaps done on a pass, the sort is done. 

def bubble_sort(array)
    loop_length = array.length - 1
    loop_length.times do |pass|
        k = loop_length - pass 
        swap_toggle = false
        k.times do |i|
            el1 = array[i]
            el2 = array[i + 1]
            if el1 > el2
                array[i] = el2
                array[i + 1] = el1
                swap_toggle = true 
            end 
        end
        if swap_toggle 
            swap_toggle = false
        else 
            puts "it took #{pass} passes to sort "
            break 
        end 
        if pass == loop_length -1
            puts "it took #{pass + 1} passes to sort"
        end
    end 
    p array 
end 

bubble_sort([4,2,3,1])
bubble_sort([4,3,78,2,0,2])
bubble_sort([5,4,3,2,1])
bubble_sort([1,2,3,4,6,5])
bubble_sort([88,19,2,33,102,4,6,7])