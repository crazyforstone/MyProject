//在这里定义一些简单的函数
function add(x, y) {
    return x + y;
}

function subtract(x, y) {
    return x - y;
}

function multiply(x, y) {
    return x * y;
}

function divide(x, y) {
    return x / y;
}

//这里的函数以上上面的某个函数作为参数
//并给它传入两个操作数然后调用它
function operate(operator, operand1, operand2) {
    return operator(operand1, operand2);
}

//这行代码所示的函数调用实际上计算了（2+3）+（4*5）的值
var i = operate(add, operate(add, 2, 3), operate(multiply, 4, 5));

//我们为这个例子重复实现一个简单的函数
//这次实现使用函数直接量，这些函数直接量定义在一个对象直接量中
var operators = {
    add: function (x, y) {
        return x + y;
    },
    subtract: function (x, y) {
        return x - y;
    },
    multiply: function (x, y) {
        return x * y;
    },
    divide: function (x, y) {
        return x / y;
    },
    pow: Math.pow//使用预定义的函数
};

//这个函数接收一个名字作为运算符，在对象中查找这个运算符
//然后将它作用于所提供的操作数
//注意这里调用运算符函数的语法
function operate2(operation, operand1, operand2) {
    if (typeof operators[operation] === "function")
        return operators[operation](operand1, operand2);
    else throw "unknown operator";
}

//这样用来计算（“hello”+“ ”+“world”）的值
var j = operate2("add", "hello", operate2("add", "", "world"));
//使用预定义的函数Math.pow()
var k = operate2("pow", 10, 2);