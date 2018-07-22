                 /*=============严格模式=============*/
function canYouSpotTheProblem() {
 //"use strict";                       //严格模式
  for (counter = 0; counter < 1; counter++)
    console.log("Happy happy")
}
canYouSpotTheProblem();
// → ReferenceError: counter is not defined
//严格模式中，如果我们没有将函数作为方法调用，函数中的this会绑定undefined
//而如果没有在严格模式中，函数的this会引用一个全局对象。



//调用构造函数未使用new，this不会引用新创建的对象
function Person(name) { this.name = name; }        
var ferdinand = Person("Ferdinand"); // oops创建名为name的全局变量
console.log(name);
// → Ferdinand



"use strict";
function Person(name) { this.name = name; }
// Oops, forgot 'new'
var ferdinand = Person("Ferdinand");
// → TypeError: Cannot set property 'name' of undefined




function Vector(x, y) {
  this.x = x;
  this.y = y;
}
Vector.prototype.plus = function(other) {
  return new Vector(this.x + other.x, this.y + other.y);
};




function testVector() {
  var p1 = new Vector(10, 20);
  var p2 = new Vector(-10, 5);
  var p3 = p1.plus(p2);

  if (p1.x !== 10) return "fail: x property";
  if (p1.y !== 20) return "fail: y property";
  if (p2.x !== -10) return "fail: negative x property";
  if (p3.x !== 0) return "fail: x from plus";
  if (p3.y !== 25) return "fail: y from plus";
  return "everything ok";
}
console.log(testVector());
// → everything ok




function numberToString(n, base) {
  var result = "", sign = "";
  if (n < 0) {
    sign = "-";
    n = -n;
  }
  do {
    result = String(n % base) + result;
    n /= base;
  } while (n > 0);
  return sign + result;
}
//console.log(numberToString(13, 10));
// → 1.5e-3231.3e-3221.3e-3211.3e-3201.3e-3191.3e-3181.3…


/*
function promptNumber(question) {
  var result = Number(prompt(question, ""));
  if (isNaN(result)) return null;
  else return result;
}

console.log(promptNumber("How many trees do you see?"));
*/




function promptDirection(question) {
  var result = prompt(question, "");
  if (result.toLowerCase() == "left") return "L";
  if (result.toLowerCase() == "right") return "R";
  throw new Error("Invalid direction: " + result);
}

function look() {
  if (promptDirection("Which way?") == "L")
    return "a house";
  else
    return "two angry bears";
}

try {
  console.log("You see", look());
} catch (error) {
  console.log("Something went wrong: " + error);
}



var context = null;

function withContext(newContext, body) {
  var oldContext = context;
  context = newContext;
  var result = body();
  context = oldContext;
  return result;
}





function withContext(newContext, body) {
  var oldContext = context;
  context = newContext;
  try {
    return body();
  } finally {
    context = oldContext;
  }
}




try {
  withContext(5, function() {
    if (context < 10)
      throw new Error("Not enough context!");
  });
} catch (e) {
  console.log("Ignoring: " + e);
}
// → Ignoring: Error: Not enough context!

console.log(context);
// → null





for (;;) {
  try {
    var dir = promtDirection("Where?"); // ← typo!
    console.log("You chose ", dir);
    break;
  } catch (e) {
    console.log("Not a valid direction. Try again.");
  }
}




function InputError(message) {
  this.message = message;
  this.stack = (new Error()).stack;
}
InputError.prototype = Object.create(Error.prototype);
InputError.prototype.name = "InputError";




function promptDirection(question) {
  var result = prompt(question, "");
  if (result.toLowerCase() == "left") return "L";
  if (result.toLowerCase() == "right") return "R";
  throw new InputError("Invalid direction: " + result);
}




for (;;) {
  try {
    var dir = promptDirection("Where?");
    console.log("You chose ", dir);
    break;
  } catch (e) {
    if (e instanceof InputError)
      console.log("Not a valid direction. Try again.");
    else
      throw e;
  }
}




function AssertionFailed(message) {
  this.message = message;
}
AssertionFailed.prototype = Object.create(Error.prototype);

function assert(test, message) {
  if (!test)
    throw new AssertionFailed(message);
}

function lastElement(array) {
  assert(array.length > 0, "empty array in lastElement");
  return array[array.length - 1];
}



function MultiplicatorUnitFailure() {}function primitiveMultiply(a, b) {  if (Math.random() < 0.5)    return a * b;  else    throw new MultiplicatorUnitFailure();}function reliableMultiply(a, b) {  for (;;) {    try {      return primitiveMultiply(a, b);    } catch (e) {      if (!(e instanceof MultiplicatorUnitFailure))        throw e;    }  }}console.log(reliableMultiply(8, 8));// → 64


function withBoxUnlocked(body) {  var locked = box.locked;  if (!locked)    return body();  box.unlock();  try {    return body();  } finally {    box.lock();  }}withBoxUnlocked(function() {  box.content.push("gold piece");});try {  withBoxUnlocked(function() {    throw new Error("Pirates on the horizon! Abort!");  });} catch (e) {  console.log("Error raised:", e);}console.log(box.locked);// → true



























































