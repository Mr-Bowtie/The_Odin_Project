def caeser_cipher(string, shift_factor)
    shift_factor %= 26 
    ordinal_array = string.bytes()
    ordinal_array.map! do |char| 
        if letter?(char)
            new_char = char + shift_factor
            wrap?(char, new_char) ? char = new_char - 26 : char = new_char
            char = char.chr() 
        else 
            char = char.chr()
        end 
    end 
    puts ordinal_array.join("")
end 

def letter?(ordinal)
    ordinal >= 65 && ordinal <= 90 || ordinal >= 97 && ordinal <= 122
end 

def wrap?(start, current)
    if (65..90).include?(start) && current > 90 
        true 
    elsif (97..122).include?(start) && current > 122
        true 
    else
        false
    end 
end 

caeser_cipher("What a string!", 83)

