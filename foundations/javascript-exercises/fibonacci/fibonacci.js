const fibonacci = function(num) {
    if(num < 0){
        return "OOPS";
    }
    let first = 0;
    let second = 1
    for (let i = 1; i < Number(num) ; i++) {
        i % 2 != 0 ? first += second : second += first;
    }
    return (first > second) ? first : second;

}

module.exports = fibonacci
