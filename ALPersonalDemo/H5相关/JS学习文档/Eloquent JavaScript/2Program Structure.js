var caught = 5 * 5;
var ten = 10;
console.log(ten * ten);
//  100
var mood = "light";
console.log(mood);
//  light
mood = "dark";
console.log(mood);
//  dark
var luigisDebt = 140;
luigisDebt = luigisDebt - 35;
console.log(luigisDebt);
//  105
var one = 1, two = 2;
console.log(one + two);
//  3

//关键字和保留字
/*
break case catch class const continue debugger
default delete do else enum export extends false
finally for function if implements import in
instanceof interface let new null package private
protected public return static super switch this
throw true try typeof var void while with yield
*/

//alert("Good morning!");

var x = 30;
console.log("the value of x is", x);
//  the value of x is 30
console.log(Math.max(2, 4));
//  4
console.log(Math.min(2, 4) + 100);
//  102
//confirm("Shall we, then?");                                              //弹窗
//var theNumber = Number(prompt("Pick a number", ""));
//alert("Your number is the square root of " + theNumber * theNumber);

/*var theNumber = Number(prompt("Pick a number", ""));
if (!isNaN(theNumber))
  alert("Your number is the square root of " +
        theNumber * theNumber);*/

/*
var theNumber = Number(prompt("Pick a number", ""));
if (!isNaN(theNumber))
  alert("Your number is the square root of " +
        theNumber * theNumber);
else
  alert("Hey. Why didn't you give me a number?");
 */
 
 /*
 var num = Number(prompt("Pick a number", "0"));

if (num < 10)
  alert("Small");
else if (num < 100)
  alert("Medium");
else
  alert("Large");
 */  
console.log(0);
console.log(2);
console.log(4);
console.log(6);
console.log(8);
console.log(10);
console.log(12);

var number = 0;
while (number <= 12) {
  console.log(number);
  number = number + 2;
}
//  0
//  2
//   … etcetera


var result = 1;
var counter = 0;
while (counter < 10) {
  result = result * 2;
  counter = counter + 1;
}
console.log(result);
//  1024

/*
do {
  var yourName = prompt("Who are you?");
} while (!yourName);
console.log(yourName);
*/

for (var number = 0; number <= 12; number = number + 2)
  console.log(number);
//  0
//  2
//   … etcetera
var result = 1;
for (var counter = 0; counter < 10; counter = counter + 1)
  result = result * 2;
console.log(result);
//  1024
for (var current = 20; ; current++) {
  if (current % 7 == 0)
    break;
}
console.log(current);
//  21

/*
switch (prompt("What is the weather like?")) {
  case "rainy":
    console.log("Remember to bring an umbrella.");
    break;
  case "sunny":
    console.log("Dress lightly.");
  case "cloudy":
    console.log("Go outside.");
    break;
  default:
    console.log("Unknown weather type!");
    break;
}
*/

//骆驼峰命名

/*
var accountBalance = calculateBalance(account);
// It's a green hollow where a river sings
accountBalance.adjust();
// Madly catching white tatters in the grass.
var report = new Report();
// Where the sun on the proud mountain rings:
addToReport(accountBalance, report);
// It's a little valley, foaming like light in a glass.
*/

for (var line = "#"; line.length < 8; line += "#")  
	console.log(line);
console.log('===========划分线===========')
for (var n = 1; n <= 100; n++) {  
	var output = "";  
	if (n % 3 == 0)    
		output += "Fizz";  
	if (n % 5 == 0)    
		output += "Buzz";  
	console.log(output || n);
}

var size = 8;
var board = "";
for (var y = 0; y < size; y++) {  
	for (var x = 0; x < size; x++) {  
	  if ((x + y) % 2 == 0)     
	   board += " ";    
	  else      board += "#"; 
	}  
	board += "\n";
}
console.log(board);
