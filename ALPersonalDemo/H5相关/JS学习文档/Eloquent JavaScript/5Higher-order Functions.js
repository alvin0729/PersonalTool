var total = 0, count = 1;
while (count <= 10) {
  total += count;
  count += 1;
}
console.log(total);
//console.log(sum(range(1, 10)));

                                        /*数组遍历抽象*/
var array = [1, 2, 3];
for (var i = 0; i < array.length; i++) {
  var current = array[i];
  console.log(current);
}


function logEach(array) {
  for (var i = 0; i < array.length; i++)
    console.log(array[i]);
}


//优雅的写法
function forEach(array, action) {
  for (var i = 0; i < array.length; i++)
    action(array[i]);
}

forEach(["Wampeter", "Foma", "Granfalloon"], console.log);
// → Wampeter
// → Foma
// → Granfalloon


var numbers = [1, 2, 3, 4, 5], sum = 0;
forEach(numbers, function(number) {             //为当前元素number指定一个变量名
  sum += number;
});
console.log(sum);
// → 15


function gatherCorrelations(journal) {
  var phis = {};
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


function gatherCorrelations(journal) {       //使用forEach改写上段代码
  var phis = {};
  journal.forEach(function(entry) {
    entry.events.forEach(function(event) {
      if (!(event in phis))
        phis[event] = phi(tableFor(event, journal));
    });
  });
  return phis;
}

/*
var numbers = [1, 2, 3, 4, 5], sum = 0;
numbers.forEach(function(number){sum += number;});        //数组含有forEach标准方法
console.log(sum)
*/


                                        /*高阶函数*/
//使用高阶函数来新建另一些函数
function greaterThan(n) {
  return function(m) { return m > n; };
}
var greaterThan10 = greaterThan(10);
console.log(greaterThan10(11));
// → true


//使用高阶函数来修改其他的函数
function noisy(f) {
  return function(arg) {
    console.log("calling with", arg);
    var val = f(arg);
    console.log("called with", arg, "- got", val);
    return val;
  };
}
noisy(Boolean)(0);
// → calling with 0
// → called with 0 - got false


//使用高阶函数来实现新的控制流
function unless(test, then) {
  if (!test) then();
}
function repeat(times, body) {
  for (var i = 0; i < times; i++) body(i);
}

repeat(3, function(n) {
  unless(n % 2, function() {               //变量n属于外部函数的参数
    console.log(n, "is even");
  });
});
// → 0 is even
// → 2 is even
//内部函数的函数体可以访问其外部环境的变量，这与循环及条件语句中的{}语句块有异曲同工之妙，
//其中内部函数与语句块之间的主要区别在于，在内部函数中声明的变量不会因为外部函数执行结束而丢失，这个特性十分有用


                                        /*参数传递*/
//如果f接受多个参数，那么该函数只能接受第一个参数
//apply方法可以解决这个问题，它接受一个参数数组，并使用这些参数调用其所属的函数                                        
function noisy(f) {
  return function(arg) {
    console.log("calling with", arg);
    var val = f(arg);
    console.log("called with", arg, "- got", val);
    return val;
  };
}


function transparentWrapping(f) {
  return function() {
    return f.apply(null, arguments);     //可以将自身的arguments对象传递给该方法
  };
}


                                        /*JSON*/
//JSON格式
[
  {"name": "Emma de Milliano", "sex": "f",
   "born": 1876, "died": 1956,
   "father": "Petrus de Milliano",
   "mother": "Sophia van Damme"},
  {"name": "Carolus Haverbeke", "sex": "m",
   "born": 1832, "died": 1905,
   "father": "Carel Haverbeke",
   "mother": "Maria van Brussel"},
  //… and so on
]


var string = JSON.stringify({name: "X", born: 1980});   //返回一个JSON编码的字符串
console.log(string);
// → {"name":"X","born":1980}
console.log(JSON.parse(string).born);                   //接受一个字符串，并返回一个解码后的值
// → 1980


//var ancestry = JSON.parse(ANCESTRY_FILE);              //参见ancestry.js
//console.log(ancestry.length);
// → 39


                                        /*数组过滤*/
function filter(array, test) {
  var passed = [];
  for (var i = 0; i < array.length; i++) {
    if (test(array[i]))
      passed.push(array[i]);
  }
  return passed;
}


//console.log(filter(ancestry, function(person) {
  //return person.born > 1900 && person.born < 1925;
//}));
// → [{name: "Philibert Haverbeke", …}, …]


//console.log(ancestry.filter(function(person) {
  //return person.father == "Carel Haverbeke";
//}));
// → [{name: "Carolus Haverbeke", …}]

                                        /*使用map函数转换数组*/
//新建数组的长度与输入的数组一致，但其中的内容却通过对每个元素调用的函数“映射”成新的形式
/*
function map(array, transform) {
  var mapped = [];
  for (var i = 0; i < array.length; i++)
    mapped.push(transform(array[i]));
  return mapped;
}

var overNinety = ancestry.filter(function(person) {
  return person.died - person.born > 90;
});
console.log(map(overNinety, function(person) {
  return person.name;
}));
*/
// → ["Clara Aernoudts", "Emile Haverbeke",
//    "Maria Haverbeke"]


                                        /*使用reduce进行数据汇总*/
//根据整个数组计算出一个值
function reduce(array, combine, start) {
  var current = start;
  for (var i = 0; i < array.length; i++)
    current = combine(current, array[i]);
  return current;
}

console.log(reduce([1, 2, 3, 4], function(a, b) {         //忽略start参数，那么该方法将会使用数组中的第一个元素作为初始值，并从第二个元素开始执行合并操作
  return a + b;
}, 0));
// → 10


/*
console.log(ancestry.reduce(function(min, cur) {
  if (cur.born < min.born) return cur;
  else return min;
}));
*/
// → {name: "Pauwels van Haverbeke", born: 1535, …}


                                       /*可组合性*/
/*
var min = ancestry[0];
for (var i = 1; i < ancestry.length; i++) {
  var cur = ancestry[i];
  if (cur.born < min.born)
    min = cur;
}
console.log(min);
*/
// → {name: "Pauwels van Haverbeke", born: 1535, …}




/*   //找出数据集中男人和女人的平均年龄
function average(array) {
  function plus(a, b) { return a + b; }
  return array.reduce(plus) / array.length;
}
function age(p) { return p.died - p.born; }
function male(p) { return p.sex == "m"; }
function female(p) { return p.sex == "f"; }

console.log(average(ancestry.filter(male).map(age)));
// → 61.67
console.log(average(ancestry.filter(female).map(age)));
// → 54.56
*/


                                       /*5.10性能开销*/
                                       /*5.11曾曾曾曾......祖父*/                                      
/*将祖辈的姓名与表示人的对象关联起来
var byName = {};
ancestry.forEach(function(person) {
  byName[person.name] = person;
});

console.log(byName["Philibert Haverbeke"]);
*/
// → {name: "Philibert Haverbeke", …}


//从家谱树中提炼出一个值，f：用于合并父母基因组成比例的函数以及默认值
function reduceAncestors(person, f, defaultValue) {
  function valueFor(person) {      //valueFor计算一个人的基因组成比例，
    if (person == null)
      return defaultValue;
    else
      return f(person, valueFor(byName[person.mother]),
                       valueFor(byName[person.father]));
  }
  return valueFor(person);
}



/*计算我的祖父遗传了Pauwels van Haverbeke的DNA比例
function sharedDNA(person, fromMother, fromFather) {
  if (person.name == "Pauwels van Haverbeke")
    return 1;
  else
    return (fromMother + fromFather) / 2;
}
var ph = byName["Philibert Haverbeke"];
console.log(reduceAncestors(ph, sharedDNA, 0) / 4);        
// → 0.00049
*/



/*找出满足特定条件的祖先比例（抽象通用方法）
function countAncestors(person, test) {
  function combine(current, fromMother, fromFather) {
    var thisOneCounts = current != person && test(current);
    return fromMother + fromFather + (thisOneCounts ? 1 : 0);
  }
  return reduceAncestors(person, combine, 0);
}
function longLivingPercentage(person) {
  var all = countAncestors(person, function(person) {
    return true;
  });
  var longLiving = countAncestors(person, function(person) {
    return (person.died - person.born) >= 70;
  });
  return longLiving / all;
}
console.log(longLivingPercentage(byName["Emile Haverbeke"]));
// → 0.129
*/


                                       /*5.12绑定*/ 
//每个函数都有一个bind方法，该方法可以用来创建新的函数->绑定函数。
//
/*
var theSet = ["Carel Haverbeke", "Maria van Brussel",
              "Donald Duck"];
function isInSet(set, person) {
  return set.indexOf(person.name) > -1;
}

console.log(ancestry.filter(function(person) {
  return isInSet(theSet, person);
}));
// → [{name: "Maria van Brussel", …},
//    {name: "Carel Haverbeke", …}]
console.log(ancestry.filter(isInSet.bind(null, theSet)));     //调用bind会返回一个新的函数，该函数调用isInSet时会将theSet作为
//第一个参数，并将传递给该函数的剩余参数一起传递给isInSet。
// → … same result
*/


                                       /*习题*/ 
console.log("==============================划分线==============================");
//数组降维
var arrays = [[1, 2, 3], [4, 5], [6]];
console.log(arrays.reduce(function(flat, current) {
  return flat.concat(current);
 }, []));
 // → [1, 2, 3, 4, 5, 6]


//计算母子年龄差
/*
function average(array) {
  function plus(a, b) {
    return a + b; 
  }
return array.reduce(plus) / array.length;
}
var byName = {};
ancestry.forEach(function(person) {
  byName[person.name] = person;
});
var differences = ancestry.filter(function(person) {
  return byName[person.mother] != null;
}).map(function(person) {
  return person.born - byName[person.mother].born;
});
console.log(average(differences));
*/
// → 31.2


//计算平均寿命
/*
function average(array) {
  function plus(a, b) {
   return a + b; 
  }
 return array.reduce(plus) / array.length;
}
function groupBy(array, groupOf) {
  var groups = {};  
  array.forEach(function(element) {
      var groupName = groupOf(element);
          if (groupName in groups)
                groups[groupName].push(element);
          else      
                groups[groupName] = [element];  
          });  
   return groups;
}
var byCentury = groupBy(ancestry, function(person) {
  return Math.ceil(person.died / 100);
});
for (var century in byCentury) {
  var ages = byCentury[century].map(function(person) {
      return person.died - person.born;  
  });  
  console.log(century + ": " + average(ages));
}
*/
 // → 16: 43.5//   17: 51.2//   18: 52.8//   19: 54.8//   20: 84.7//   21: 94


//使用every和some方法
function every(array, predicate) {
  for (var i = 0; i < array.length; i++) {
      if (!predicate(array[i]))      
          return false;  
  }  
return true;
}
function some(array, predicate) {
  for (var i = 0; i < array.length; i++) { 
     if (predicate(array[i]))      
     return true;  
  }  
return false;
}
console.log(every([NaN, NaN, NaN], isNaN));
// → true
console.log(every([NaN, NaN, 4], isNaN));
// → false
console.log(some([NaN, 3, 4], isNaN));
// → true
console.log(some([2, 3, 4], isNaN));
// → false

