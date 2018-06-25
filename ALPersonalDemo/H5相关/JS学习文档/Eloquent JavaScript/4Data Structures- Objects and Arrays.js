//数据集
var listOfNumbers = [2, 3, 5, 7, 11];
console.log(listOfNumbers[1]);
//  3
console.log(listOfNumbers[1 - 1]);
//  2


//属性访问方法（使用点和方括号）
//属性名可以是任意字符串value[0]、value["John Doe"]、array["length"]同array.length
//null.length;
//  TypeError: Cannot read property 'length' of null


//方法
var doh = "Doh";
console.log(typeof doh.toUpperCase);
//  function
console.log(doh.toUpperCase());
//  DOH


var mack = [];
mack.push("Mack");
mack.push("the", "Knife");
console.log(mack);
//  ["Mack", "the", "Knife"]
console.log(mack.join(" "));
//  Mack the Knife
console.log(mack.pop());
//  Knife
console.log(mack);
//  ["Mack", "the"]


//对象
var day1 = {
  squirrel: false,
  events: ["work", "touched tree", "pizza", "running",
           "television"]
};
console.log(day1.squirrel);
//  false
console.log(day1.wolf);
//  undefined
day1.wolf = false;
console.log(day1.wolf);                 //可以使用=运算符来给一个属性表达式赋值，若属性不存在，则会在目标对象中新建一个属性
//  false


var descriptions = {
  work: "Went to work",
  "touched tree": "Touched a tree"      //属性名可以是不是有效的变量名或者数字
};


var anObject = {left: 1, right: 2};
console.log(anObject.left);
//  1
delete anObject.left;                   //从对象中移除指定的属性
console.log(anObject.left);
//  undefined
console.log("left" in anObject);        //二元运算符，第一个操作数是一个表示属性名的字符串，第二个操作数是一个对象，返回布尔值
//  false
console.log("right" in anObject);
//  true


var journal = [
  {events: ["work", "touched tree", "pizza",
            "running", "television"],
   squirrel: false},
  {events: ["work", "ice cream", "cauliflower",
            "lasagna", "touched tree", "brushed teeth"],
   squirrel: false},
  {events: ["weekend", "cycling", "break",
            "peanuts", "beer"],
   squirrel: true},
  /* and so on... */
];


//可变性
//==（非内置深度比较运算符）
var object1 = {value: 10};
var object2 = object1;
var object3 = {value: 10};
console.log(object1 == object2);
//  true
console.log(object1 == object3);
//  false
object1.value = 15;
console.log(object2.value);
//  15
console.log(object3.value);
//  10



                /*松鼠人的记录*/
var journal = [];
function addEntry(events, didITurnIntoASquirrel) {
  journal.push({
    events: events,
    squirrel: didITurnIntoASquirrel
  });
}
addEntry(["work", "touched tree", "pizza", "running",
          "television"], false);
addEntry(["work", "ice cream", "cauliflower", "lasagna",
          "touched tree", "brushed teeth"], false);
addEntry(["weekend", "cycling", "break", "peanuts",
          "beer"], true);



                /*计算关联性*/
function phi(table) {             //P65
  return (table[3] * table[0] - table[2] * table[1]) /
    Math.sqrt((table[2] + table[3]) *
              (table[0] + table[1]) *
              (table[1] + table[3]) *
              (table[0] + table[2]));
}

console.log(phi([76, 9, 4, 1]));
//  0.068599434



//循环遍历整个记录提取出某个特定事件的2乘2表格
//测试某个记录中是否包含某个特定的事件
function hasEvent(event, entry) {
  return entry.events.indexOf(event) != -1;        //indexOf方法，可以用于查找特定的值，找到了特定的值则返回当前索引
}
//检查记录中是否包含某个特定事件、并检查发生的事件是否伴随变身成松鼠一起发生、然后计算出表格中相应格子中的数字
function tableFor(event, journal) {
  var table = [0, 0, 0, 0];
  for (var i = 0; i < journal.length; i++) {
    var entry = journal[i], index = 0;
    if (hasEvent(event, entry)) index += 1;
    if (entry.squirrel) index += 2;
    table[index] += 1;
  }
  return table;
}
console.log(tableFor("pizza", JOURNAL));
//  [76, 9, 4, 1]



                /*对象映射*/
var map = {};
function storePhi(event, phi) {
  map[event] = phi;
}

storePhi("pizza", 0.069);
storePhi("touched tree", -0.081);
console.log("pizza" in map);
//  true
console.log(map["touched tree"]);
//  -0.081



//循环遍历（针对无法预先了解所有的属性名称）
for (var event in map)
  console.log("The correlation for '" + event +
              "' is " + map[event]);
// → The correlation for 'pizza' is 0.069
// → The correlation for 'touched tree' is -0.081



                /*分析结果*/
//每当phis对象中找不到当前遍历的事件类型，就计算其相关系数，然后把计算结果添加到对象中             
function gatherCorrelations(journal) {
  var phis = {};        //存储所有遍历事件的相关系数
  for (var entry = 0; entry < journal.length; entry++) {
    var events = journal[entry].events;
    for (var i = 0; i < events.length; i++) {
      var event = events[i];
      if (!(event in phis))
        phis[event] = phi(tableFor(event, journal));
    }
  }
  return phis;
}
var correlations = gatherCorrelations(JOURNAL);
console.log(correlations.pizza);
// → 0.068599434
for (var event in correlations)
  console.log(event + ": " + correlations[event]);
// → carrot:   0.0140970969
// → exercise: 0.0685994341
// → weekend:  0.1371988681
// → bread:   -0.0757554019
// → pudding: -0.0648203724
// and so on...


//过滤
for (var event in correlations) {
  var correlation = correlations[event];
  if (correlation > 0.1 || correlation < -0.1)
    console.log(event + ": " + correlation);
}
// → weekend:        0.1371988681
// → brushed teeth: -0.3805211953
// → candy:          0.1296407447
// → work:          -0.1371988681
// → spaghetti:      0.2425356250
// → reading:        0.1106828054
// → peanuts:        0.5902679812


for (var i = 0; i < JOURNAL.length; i++) {
  var entry = JOURNAL[i];
  if (hasEvent("peanuts", entry) &&
     !hasEvent("brushed teeth", entry))
    entry.events.push("peanut teeth");
}
console.log(phi(tableFor("peanut teeth", JOURNAL)));
// → 1


                /*详解数组*/
//在数组的开头添加或删除元素的方法分别是unshift和shift                
var todoList = [];
function rememberTo(task) {
  todoList.push(task);
}
function whatIsNext() {
  return todoList.shift();     //获取并删除列表中的第一项任务
}
function urgentlyRememberTo(task) {
  todoList.unshift(task);      //将任务添加到列表的开头
}


console.log([1, 2, 3, 2, 1].indexOf(2));
// → 1
console.log([1, 2, 3, 2, 1].lastIndexOf(2));      //从最后一个元素向前搜索
// → 3


//字符串也有一个具有相同功能的slice方法
console.log([0, 1, 2, 3, 4].slice(2, 4));         //接收一个起始和结束索引，返回索引范围内的元素，但结束索引元素不会包含在返回结果中
// → [2, 3]
console.log([0, 1, 2, 3, 4].slice(2));
// → [2, 3, 4]


//移除指定索引处的那个元素，返回副本
function remove(array, index) {
  return array.slice(0, index)
    .concat(array.slice(index + 1));
}
console.log(remove(["a", "b", "c", "d", "e"], 2));
// → ["a", "b", "d", "e"]


                /*字符串及其属性*/
var myString = "Fido";
myString.myProperty = "value";       //不能向字符串中添加任何新的属性
console.log(myString.myProperty);
// → undefined


//非对象类型的值包含一些内置属性
console.log("coconuts".slice(4, 7));
// → nut
console.log("coconut".indexOf("u"));
// → 5


console.log("one two three".indexOf("ee"));    //字符串中的indexOf方法可以使用多个字符作为搜索条件，而数组中的indexOf则只能搜索单个元素
// → 11

 
console.log("  okay \n ".trim());             //删除字符串中开头和结尾的空白符号（空格、换行符和制表符等）
// → okay


var string = "abc";
console.log(string.length);
// → 3
console.log(string.charAt(0));                //获取字符串当中某个特定的字符
// → a
console.log(string[1]);
// → b


                /*arguments对象*/
//每当函数被调用时，就会在函数体的运行环境当中添加一个特殊的变量arguments
//arguments对象有一个length属性，该对象不包含任何数组方法                
function noArguments() {}
noArguments(1, 2, 3); // This is okay
function threeArguments(a, b, c) {}
threeArguments();     // And so is this


function argumentCounter() {
  console.log("You gave me", arguments.length, "arguments.");
}
argumentCounter("Straw man", "Tautology", "Ad hominem");
// → You gave me 3 arguments.


addEntry(["work", "touched tree", "pizza", "running",
          "television"], false);


function addEntry(squirrel) {
  var entry = {events: [], squirrel: squirrel};
  for (var i = 1; i < arguments.length; i++)
    entry.events.push(arguments[i]);
  journal.push(entry);
}
addEntry(true, "work", "touched tree", "pizza",
         "running", "television");

                /*Math对象*/
//Math对象其实提供了一个“命名空间”，封装了所有的数学运算函数和值
//当你去定义一个已经被使用的变量名的时候，对于很多编程语言来说，都会阻止你这么做，但是JavaScript不会，因此要小心这些陷阱                
function randomPointOnCircle(radius) {
  var angle = Math.random() * 2 * Math.PI;
  return {x: radius * Math.cos(angle),
          y: radius * Math.sin(angle)};
}
console.log(randomPointOnCircle(2));
// → {x: 0.3667, y: 1.966}


console.log(Math.random());
// → 0.36993729369714856
console.log(Math.random());
// → 0.727367032552138
console.log(Math.random());
// → 0.40180766698904335


//Math.floor、Math.cel（向上取整）、Math.round（四舍五入）
console.log(Math.floor(Math.random() * 10));            //向下取整到与当前数字最接近的整数
// → 2


                /*全局对象*/
//在浏览器中，全局对象存储在window变量当中                
var myVar = 10;
console.log("myVar" in window);
// → true
console.log(window.myVar);
// → 10

                /*习题*/
//特定范围数字求和                
function range(start, end, step) {
  if (step == null) step = 1;
    var array = [];  if (step > 0) {
        for (var i = start; i <= end; i += step)
              array.push(i);  
   } else {
        for (var i = start; i >= end; i += step)
             array.push(i);
   }
   return array;
}
function sum(array) {
   var total = 0;
     for (var i = 0; i < array.length; i++)
         total += array[i];
   return total;
}
console.log(range(1, 10))
// → [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
console.log(range(5, 2, -1));
// → [5, 4, 3, 2]
console.log(sum(range(1, 10)));
// → 55


//逆转数组
function reverseArray(array) {
  var output = [];
    for (var i = array.length - 1; i >= 0; i--)
        output.push(array[i]);
  return output;
}
function reverseArrayInPlace(array) {
  for (var i = 0; i < Math.floor(array.length / 2); i++) {
      var old = array[i];
      array[i] = array[array.length - 1 - i];
      array[array.length - 1 - i] = old;  
  }
  return array;
}
console.log(reverseArray(["A", "B", "C"]));
// → ["C", "B", "A"];
var arrayValue = [1, 2, 3, 4, 5];
reverseArrayInPlace(arrayValue);console.log(arrayValue);
// → [5, 4, 3, 2, 1]



//实现列表
function arrayToList(array) {
  var list = null;
  for (var i = array.length - 1; i >= 0; i--)
      list = {value: array[i], rest: list};
  return list;
}

function listToArray(list) {
  var array = [];
  for (var node = list; node; node = node.rest)
      array.push(node.value);
  return array;
}

function prepend(value, list) {
  return {value: value, rest: list};
}

function nth(list, n) {
  if (!list)
    return undefined;
  else if (n == 0)
    return list.value;
  else    
    return nth(list.rest, n - 1);
}
console.log(arrayToList([10, 20]));
// → {value: 10, rest: {value: 20, rest: null}}
console.log(listToArray(arrayToList([10, 20, 30])));      //console.log(listToArray({value:10,rest:{value:20, rest:{value:30,rest:null}}})) 
// → [10, 20, 30]
console.log(prepend(10, prepend(20, null)));
// → {value: 10, rest: {value: 20, rest: null}}
console.log(nth(arrayToList([10, 20, 30]), 1));           //console.log(nth({value:10,rest:{value:20, rest:{value:30,rest:null}}}, 1));
// → 20


//深度比较
function deepEqual(a, b) {
  if (a === b) return true;
  if (a == null || typeof a != "object" || b == null || typeof b != "object")
    return false;
  var propsInA = 0, propsInB = 0;
  for (var prop in a)
    propsInA += 1;
  for (var prop in b) {
    propsInB += 1;
    if (!(prop in a) || !deepEqual(a[prop], b[prop]))
       return false;  
  } 
  return propsInA == propsInB;
}
var obj = {here: {is: "an"}, object: 2};
console.log(deepEqual(obj, obj));
// → true
console.log(deepEqual(obj, {here: 1, object: 2}));
// → false
console.log(deepEqual(obj, {here: {is: "an"}, object: 2}));
// → true




