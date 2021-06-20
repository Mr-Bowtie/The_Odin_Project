const palindromes = function(string) {
    // string = string.toLowerCase
    const lettersRegex = /[a-z]/;
    let splitString = [...string.toLowerCase()];
    let strippedString = splitString.filter(letter => 
        lettersRegex.test(letter)).join("");
    let reverseStrippedString = splitString.reverse().filter(letter => 
        lettersRegex.test(letter)).join("");
    return ((strippedString === reverseStrippedString) ? true : false);    
}

module.exports = palindromes
