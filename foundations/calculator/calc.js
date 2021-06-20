const container = document.querySelectorAll("#container");
const buttons = document.querySelectorAll(".button");
const operators = document.querySelectorAll(".operator");
const numbers = document.querySelectorAll("number");
const tallyZone = document.querySelector('.tallyZone');
const operatorOptions = ["+","-","*","/","+/-",".","="];
const numRegex = /[\d]/;

let firstOperand = "";
let secondOperand = "";
let consecutiveEquals = false;
let consequtiveOperators = false;
let operatorToggle = false;
let operator = ""

document.addEventListener('keydown', buttonActions);
buttons.forEach(button => {
    button.addEventListener("click", buttonActions)
    if (!button.classList.contains("math")) {
        button.addEventListener("transitionend", removeTransition);
    }
});


// Button Functions 

function buttonActions(e) {
    let button = e.type === "click" ? e.target.textContent : e.key;
    if (button === "<-") button = "Backspace";
    if (button === "Enter") button = "=";
    
    let buttonSelect = document.querySelector(`button[data-key="${button}"]`);
    if (button === "Backspace") {
        removeLast();
        buttonSelect.classList.add("pressedClear");
       
    }
    else if (button === "c") {
        clearButtonDo();
        buttonSelect.classList.add("pressedClear");
    }
    else if (operatorOptions.includes(button)) {
        operatorSwitch(button);
        buttonSelect.classList.add("pressedOperator");
    }
    else if (!numRegex.test(button)) {
        return; 
    }
    else {
        numericButtonsDo(button);
        buttonSelect.classList.add("pressedNumber");
    }
}

function operatorSwitch(operand) {
    let currentDisplay = tallyZone.textContent;
    switch (operand) {
        case "+/-":
            tallyZone.textContent = (parseFloat(currentDisplay) * -1).toString();
            break;
        case ".":
            if (operatorToggle === true || currentDisplay === "") {
                tallyZone.textContent = "0.";
                operatorToggle = false;

            }
            else if (![...currentDisplay].includes(".")) {
               if (tallyZone.textContent.length < 13) tallyZone.textContent += operand;
            }
            break;
            case "=":
                if (operator === "") {
                    break;
                } 
                equalButtonDo();
                consequtiveOperators = false;
                break;
        default:
            clearMathButtons();
            mathButtonsDo(operand);
            break;
    }
}

function mathButtonsDo(currentOperator) {
    if (consequtiveOperators && operatorToggle === false) {
        secondOperand = +tallyZone.textContent;
        calculateResult();
        firstOperand = +tallyZone.textContent;
        secondOperand = "";
    }
    else {
        firstOperand = +tallyZone.textContent;
        consequtiveOperators = true; 
    }
    operatorToggle = true;
    operator = currentOperator;
    consecutiveEquals = false;
}


function clearButtonDo() {
    tallyZone.textContent = "";
    firstOperand = "";
    secondOperand = "";
    operator = "";
    operatorToggle = false;
    consequtiveOperators = false;
    consecutiveEquals = false;
    clearMathButtons();

}

function equalButtonDo() {
    if (operatorToggle && !consecutiveEquals) return;
    switch(consecutiveEquals){
        case false:
            secondOperand = +tallyZone.textContent;
            consecutiveEquals = true;
            operatorToggle = true;
            break

        default:
            firstOperand = +tallyZone.textContent;
            break;
    }
   calculateResult();         
   clearMathButtons();         
}
        
function numericButtonsDo(number) {
    if (operatorToggle === false) {
        return displayNumbers(number);
    }
    else if (operatorToggle || consecutiveEquals === true) {
        tallyZone.textContent = ""
        operatorToggle = false;
        displayNumbers(number);
    }
}

// Helper functions 

function displayNumbers(number) {
    if (tallyZone.textContent.length < 13) tallyZone.textContent += number;
}

function removeTransition() {
    this.classList.remove("pressedClear", "pressedNumber", "pressedOperator");
}

function clearMathButtons() {
    operators.forEach(operator => operator.classList.remove("pressedOperator"));   
}

function removeLast() {
    currentDisplay = [...tallyZone.textContent]; 
    currentDisplay.pop();
    tallyZone.textContent = currentDisplay.join("");
}

// parseFloat removes trailing zeros, slice prevents overflow before
// and after the decimal. 
function calculateResult() {
    result = operate(operator,firstOperand, secondOperand);
    tallyZone.textContent = parseFloat(result.toString().slice(0, 14));
}


// Math operations

function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b){
    return a * b;
}

function divide(a, b){
   if (b === 0) return "ERROR";
   return a / b;
}

function operate(sign, a, b){
    switch (sign) {
        case "+":
            return add(a ,b);
            break;
        case "-":
            return subtract(a, b);
            break;
        case "*":
            return multiply(a, b);
            break;
        case "/":
            return divide(a, b);
            break;
        default:
            break;
    }
}

