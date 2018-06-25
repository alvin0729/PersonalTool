//定义函数
var square = function(x) {
  return x * x;
};
console.log(square(12));
//  144


var makeNoise = function() {
  console.log("Pling!");
};
makeNoise();
//  Pling!


var power = function(base, exponent) {
  var result = 1;
  for (var count = 0; count < exponent; count++)
    result *= base;
  return result;
};
console.log(power(2, 10));
//  1024


//参数和作用域
var x = "outside";
var f1 = function() {
  var x = "inside f1";
};
f1();
console.log(x);
//  outside


var f2 = function() {
  x = "inside f2";
};
f2();
console.log(x);
//  inside f2


//词法作用域
var landscape = function() {
  var result = "";
  var flat = function(size) {
    for (var count = 0; count < size; count++)
      result += "_";
  };
  var mountain = function(size) {
    result += "/";
    for (var count = 0; count < size; count++)
      result += "'";
    result += "\\";
  };
  flat(3);
  mountain(4);
  flat(6);
  mountain(1);
  flat(1);
  return result;
};
console.log(landscape());
//  ___/''''\______/'\_


var something = 1;
{
  var something = 2;
  // Do stuff with variable something...
}
// Outside of the block again...
//P47  代码块中的变量something其实引用的是代码块外部的那个同名变量。与其他语言不同


/*

var launchMissiles = function(value) {
  missileSystem.launch("now");
};
if (safeMode)
  launchMissiles = function(value) {/ do nothing /};
*/


function square(x) {
  return x * x;
}


console.log("The future says:", future());
function future() {
  return "We STILL have no flying cars.";
}


/*
function example() {
  function a() {} // Okay
  if (something) {
    function b() {} // Danger!
  }
}
P48禁止这么做，不同浏览器JavaScript平台处理该问题的行为不尽相同
*/


//调用栈
function greet(who) {
  console.log("Hello " + who);
}
greet("Harry");
console.log("Bye");


/*
function chicken() {
  return egg();
}
function egg() {
  return chicken();
}
console.log(chicken() + " came first.");
//  ??
*/


//可选参数
//alert("Hello", "Good Evening", "How do you do?");


//接收可选参数
function power(base, exponent) {
  if (exponent == undefined)
    exponent = 2;
  var result = 1;
  for (var count = 0; count < exponent; count++)
    result *= base;
  return result;
}
console.log(power(4));
//  16
console.log(power(4, 3));
//  64


console.log("R", 2, "D", 2);
//  R 2 D 2


//闭包
function wrapValue(n) {
  var localVariable = n;
  return function() { return localVariable; };
}


//同一变量的多个实例可以同时存在
var wrap1 = wrapValue(1);
var wrap2 = wrapValue(2);
console.log(wrap1());
//  1
console.log(wrap2());
//  2


function multiplier(factor) {
  return function(number) {
    return number * factor;
  };
}
var twice = multiplier(2);
console.log(twice(5));
//  10


//递归
function power(base, exponent) {
  if (exponent == 0)
    return 1;
  else
    return base * power(base, exponent - 1);
}
console.log(power(2, 3));
//  8


function findSolution(target) {
  function find(start, history) {
    if (start == target)
      return history;
    else if (start > target)
      return null;
    else
      return find(start + 5, "(" + history + " + 5)") ||
             find(start * 3, "(" + history + " * 3)");
  }
  return find(1, "1");
}
console.log(findSolution(24));
//  (((1 * 3) + 5) * 3)


function printFarmInventory(cows, chickens) {
  var cowString = String(cows);
  while (cowString.length < 3)
    cowString = "0" + cowString;
  console.log(cowString + " Cows");
  var chickenString = String(chickens);
  while (chickenString.length < 3)
    chickenString = "0" + chickenString;
  console.log(chickenString + " Chickens");
}
printFarmInventory(7, 11);
//  007 Cows
//  011 Chickens


function printZeroPaddedWithLabel(number, label) {
  var numberString = String(number);
  while (numberString.length < 3)
    numberString = "0" + numberString;
  console.log(numberString + " " + label);
}
function printFarmInventory(cows, chickens, pigs) {
  printZeroPaddedWithLabel(cows, "Cows");
  printZeroPaddedWithLabel(chickens, "Chickens");
  printZeroPaddedWithLabel(pigs, "Pigs");
}
printFarmInventory(7, 11, 3);
//  undefined Pigs
//  007 Cows
//  011 Chickens
//  003 Pigs


console.log("==================划分线===================");
function zeroPad(number, width) {
  var string = String(number);
  while (string.length < width)
    string = "0" + string;
  return string;
}
function printFarmInventory(cows, chickens, pigs) {
  console.log(zeroPad(cows, 3) + " Cows");
  console.log(zeroPad(chickens, 3) + " Chickens");
  console.log(zeroPad(pigs, 3) + " Pigs");
}
printFarmInventory(7, 16, 3);
//  007 Cows
//  011 Chickens
//  003 Pigs


//函数及其副作用
//纯函数


// Create a function value f
var f = function(a) {
  console.log(a + 2);
};
// Declare g to be a function
function g(a, b) {
  return a * b * 3.5;
}


function min(a, b) {  
   if (a < b)    
   	return a;  
   else    
   	return b;
}
console.log(min(0, 10));
//  0
console.log(min(0, -10));
//  -10


function isEven(n) {  
    if (n == 0)    
        return true;  
    else if (n == 1)    
        return false;  
    else if (n < 0)   
        return isEven(-n);  
    else    
        return isEven(n - 2);
 }
console.log(isEven(50));
//  true
console.log(isEven(75));
//  false
console.log(isEven(-1)); 
//  false


//字符计数
function countChar(string, ch) {
  var counted = 0;  
  for (var i = 0; i < string.length; i++)
      if (string.charAt(i) == ch)
            counted += 1;
              return counted;
}
function countBs(string) {
  return countChar(string, "B");
}
console.log(countBs("BBC"));
//  2
console.log(countChar("kakkerlak", "k"));
//  4



//http://eloquentjavascript.net/code/#3.3
//http://eloquentjavascript.net/


