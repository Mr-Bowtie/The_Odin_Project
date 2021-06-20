# input : a string, an array of substrings 
# output : a hash with the substings as keys and the number of times they appear in the main string as values

# given STRING, DICTIONARY 
#     downcase STRING to take out case as a factor
#     iterate through dictionary 
#     if STRING includes dic_item 
#        check if HASH.has_key?(dic_item) ? HASH[dic_item] += 1 : HASH[dic_item] = 1 
#     end 
#     print out HASH
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]


def substrings(string, substrings)
    substring_count = {}        
    string.downcase!
    string_arr = string.split(" ")
    for word in string_arr
        for i in substrings do
            if word.include?(i)
                substring_count.has_key?(i) ? substring_count[i] += 1 : substring_count[i] = 1
            end 
        end 
    end 
p substring_count    
end 

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
