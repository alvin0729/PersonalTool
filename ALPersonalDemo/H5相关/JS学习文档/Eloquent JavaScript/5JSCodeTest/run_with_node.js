// load dependencies
require("./code/load")("code/ancestry.js", "code/chapter/05_higher_order.js", "code/intro.js");

var ph = byName["Philibert Haverbeke"];
console.log(reduceAncestors(ph, sharedDNA, 0) / 4);




var ancestry = JSON.parse(ANCESTRY_FILE);              //参见ancestry.js
console.log(ancestry.length);
// → 39




function filter(array, test) {
  var passed = [];
  for (var i = 0; i < array.length; i++) {
    if (test(array[i]))
      passed.push(array[i]);
  }
  return passed;
}
console.log(filter(ancestry, function(person) {
  return person.born > 1900 && person.born < 1925;
}));
// → [{name: "Philibert Haverbeke", …}, …]




console.log(ancestry.filter(function(person) {
  return person.father == "Carel Haverbeke";
}));
// → [{name: "Carolus Haverbeke", …}]




console.log("==============================划分线==============================");
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
// → ["Clara Aernoudts", "Emile Haverbeke",
//    "Maria Haverbeke"]




console.log(ancestry.reduce(function(min, cur) {
  if (cur.born < min.born) return cur;
  else return min;
}));
// → {name: "Pauwels van Haverbeke", born: 1535, …}




var min = ancestry[0];
for (var i = 1; i < ancestry.length; i++) {
  var cur = ancestry[i];
  if (cur.born < min.born)
    min = cur;
}
console.log(min);
// → {name: "Pauwels van Haverbeke", born: 1535, …}




//找出数据集中男人和女人的平均年龄
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




//将祖辈的姓名与表示人的对象关联起来
/*var byName = {};
ancestry.forEach(function(person) {
  byName[person.name] = person;
});*/
console.log(byName["Philibert Haverbeke"]);
// → {name: "Philibert Haverbeke", …}




function sharedDNA(person, fromMother, fromFather) {
  if (person.name == "Pauwels van Haverbeke")
    return 1;
  else
    return (fromMother + fromFather) / 2;
}
var ph = byName["Philibert Haverbeke"];
console.log(reduceAncestors(ph, sharedDNA, 0) / 4);
// → 0.00049




console.log("==============================划分线==============================");
//找出满足特定条件的祖先比例（抽象通用方法）
function countAncestors(person, test) {
  function combine(current, fromMother, fromFather) {
    var thisOneCounts = current != person && test(current);
    //console.log('==',fromMother + fromFather + (thisOneCounts ? 1 : 0));
    return fromMother + fromFather + (thisOneCounts ? 1 : 0);
  }
  return reduceAncestors(person, combine, 0);
}
function longLivingPercentage(person) {
  var all = countAncestors(person, function(person) {
    return true;
  });
  console.log('all:',all);
  var longLiving = countAncestors(person, function(person) {
    return (person.died - person.born) >= 70;
  });
  return longLiving / all;
}
console.log(longLivingPercentage(byName["Emile Haverbeke"]));
// → 0.129




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
console.log(ancestry.filter(isInSet.bind(null, theSet)));
// → … same result




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
*/
var differences = ancestry.filter(function(person) {
  return byName[person.mother] != null;
}).map(function(person) {
  return person.born - byName[person.mother].born;
});
console.log(average(differences));
// → 31.2






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
 // → 16: 43.5//   17: 51.2//   18: 52.8//   19: 54.8//   20: 84.7//   21: 94
