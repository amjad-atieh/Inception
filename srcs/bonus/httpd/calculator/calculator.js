function add(firstNum, secondNum)
{
    let result = Number(firstNum) + Number(secondNum);
    return String(result);
}

function substract(firstNum, secondNum)
{
    return String(Number(firstNum) - Number(secondNum));
}

function multiply(firstNum, secondNum)
{
    return String(Number(firstNum) * Number(secondNum));
}

function divide(firstNum, secondNum)
{
    return String(Number(firstNum) / Number(secondNum));
}

function mod(firstNum, secondNum)
{
    return String(Number(firstNum) % Number(secondNum));
}

function removeLastChar(secondNum)
{
    if (secondNum.value[secondNum.value.length - 1] == '.')
    {
        secondNum.isInteger = true;
    }
    return (secondNum.value.slice(0, secondNum.value.length - 1) + secondNum.value.slice(secondNum.value.length));
}

function handleNumberInput(id, operator, secondNum, resultDisplay)
{
    if (id == '.')
    {
        if (secondNum.isInteger == true)
            secondNum.isInteger = false;
        else
            return;
    }
    if (secondNum.value == "0" && id != '.')
    {
        secondNum.value = id;
    }
    else
    {
        secondNum.value += id;
    }
    resultDisplay.textContent = secondNum.value;
    operator.latest = false;
}

function handleFunctionInput(id, operator, firstNum, secondNum, resultDisplay)
{
    if (id == "AC")
    {
        firstNum.value = "0";
        secondNum.value = "0";
        operator.latest = false;
        secondNum.isInteger = true;
        operator.value = '=';
    }
    else if (id == "C")
    {
        if (operator.latest == true)
        {
            operator.latest = false;
            operator.value = '=';
            secondNum.value = firstNum.value;
        }
        else
        {
            if (secondNum.value.length == 1)
                secondNum.value = '0';
            else
                secondNum.value = removeLastChar(secondNum);
        }
    }
    resultDisplay.textContent = secondNum.value;
}

function handleOperatorInput(id, operator, firstNum, secondNum, resultDisplay)
{
    if ((operator.value == '=' || operator.latest == true) && id == '=')
        return;
    if (operator.latest == true)
    {
        resultDisplay.textContent = firstNum.value + id;
        operator.value = id;
        return;
    }
    if (operator.value == '+')
        firstNum.value = add(firstNum.value, secondNum.value)
    else if (operator.value == '-')
        firstNum.value = substract(firstNum.value, secondNum.value)
    else if (operator.value == '*')
        firstNum.value = multiply(firstNum.value, secondNum.value)
    else if (operator.value == '/')
    {
        if (secondNum.value != "0")
            firstNum.value = divide(firstNum.value, secondNum.value)
        else
        {
            resultDisplay.textContent = "You cannot devide by zero!";
            firstNum.value = '0';
            secondNum.value = '0';
            operator.value = '=';
            secondNum.isInteger = true;
            operator.latest = false;
            return;
        }
    }
    else if (operator.value == '%')
        firstNum.value = mod(firstNum.value, secondNum.value)
    else if (operator.value == '=')
    {
        firstNum.value = secondNum.value;
    }
    if (id != '=')
    {
        resultDisplay.textContent = firstNum.value + id;
    }
    else
        resultDisplay.textContent = firstNum.value;
    secondNum.value = '0';
    secondNum.isInteger = true;
    operator.latest = true;
    operator.value = id;
}

function handleKeyboardInput(key, operator, firstNum, secondNum, resultDisplay)
{
    if (!isNaN(Number(key)) || key == '.')
        handleNumberInput(key, operator, secondNum, resultDisplay);
    else if (key == '-' || key == '+' || key == '/' || key == '%' || key == '*' || key == '=')
        handleOperatorInput(key, operator, firstNum, secondNum, resultDisplay);
    else if (key == "Enter")
        handleOperatorInput("=", operator, firstNum, secondNum, resultDisplay);
    else if (key == 'Backspace' || key == 'c')
        handleFunctionInput("C", operator, firstNum, secondNum, resultDisplay);
    else if (key == 'Delete' || key == 'a')
        handleFunctionInput("AC", operator, firstNum, secondNum, resultDisplay);
}

const resultDisplay = document.getElementById("result");
const operatorElements = document.querySelectorAll(".operator");
const numberElements = document.querySelectorAll(".number");
const functionElements = document.querySelectorAll(".function");

let operator = {value: "=", latest: false};
let firstNum = {value: "0"}, secondNum = {isInteger: true, value: "0"};

numberElements.forEach(element => {
    element.addEventListener("click", function() {handleNumberInput(element.id, operator, secondNum, resultDisplay)});    
});

functionElements.forEach(element => {
    element.addEventListener("click", function() {handleFunctionInput(element.id, operator, firstNum, secondNum, resultDisplay)});    
});

operatorElements.forEach(element => {
    element.addEventListener("click", function() {handleOperatorInput(element.id, operator, firstNum, secondNum, resultDisplay)});    
});

document.addEventListener('keydown', function(event) {
    handleKeyboardInput(event.key, operator, firstNum, secondNum, resultDisplay);
});