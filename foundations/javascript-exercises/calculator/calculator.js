function add (a, b) {
	
	return a + b;
}

function subtract (a, b) {
	return a - b;
}

function sum (arr) {
	 return arr.reduce((acc, cur) => {
		 return acc + cur;
	 }, 0);
	 
}

function multiply (arr) {
	return arr.reduce((acc, cur) => {
		return acc * cur;
	}, 1);
	
   
}

function power(number, exponent) {
	return number ** exponent;
}

function factorial(number) {
	if (number === 0 ) { return 1};
	let accumulator = 1
	for (let i = number; i > 0; i--) {
		accumulator *= i; 
	}
	return accumulator;
}
// let array = [1,2,3,4]
// console.log(add(0,0));
// console.log(sum(array));

module.exports = {
	add,
	subtract,
	sum,
	multiply,
    power,
	factorial
}