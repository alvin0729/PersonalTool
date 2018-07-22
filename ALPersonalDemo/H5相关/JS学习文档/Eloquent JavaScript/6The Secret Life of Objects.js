                                 /*=============方法=============*/
//方法：引用函数值的属性                                 
var rabbit = {};
rabbit.speak = function(line) {
  console.log("The rabbit says '" + line + "'");
};
rabbit.speak("I'm alive.");
// → The rabbit says 'I'm alive.'



//对象中的变量this指向当期方法所属的对象
function speak(line) {
  console.log("The " + this.type + " rabbit says '" +
              line + "'");
}
var whiteRabbit = {type: "white", speak: speak};
var fatRabbit = {type: "fat", speak: speak};

whiteRabbit.speak("Oh my ears and whiskers, " +
                  "how late it's getting!");
// → The white rabbit says 'Oh my ears and whiskers, how late it's getting!'
fatRabbit.speak("I could sure use a carrot right now.");
// → The fat rabbit says 'I could sure use a carrot right now.'



// apply和bind方法，这两个方法接收的第一个参数可以用来模拟对象中方法的调用，它们会把第一个参数复制给this
speak.apply(fatRabbit, ["Burp!"]);
// → The fat rabbit says 'Burp!'
//像普通函数一样接收参数
speak.call({type: "old"}, "Oh my.");
// → The old rabbit says 'Oh my.'



                                 /*=============原型=============*/
//每个对象除了拥有自己的属性外，几乎都包含一个原型prototype
//当访问一个对象不包含的属性时，就会从对象原型中搜索属性，接着是原型的原型，依次类推。
var empty = {};
console.log(empty.toString);
// → function toString(){…}
console.log(empty.toString());
// → [object Object]



//Object.prototype是所有对象中原型的父原型,也是空对象的原型。它提供了一些可以在所有对象中使用的方法，如toString将一个对象转换成其字符串表示形式
console.log(Object.getPrototypeOf({}) == Object.prototype);
// → true
console.log(Object.getPrototypeOf(Object.prototype));
// → null



//函数继承自Function.prototype,而数组继承自Array.prototype
console.log(Object.getPrototypeOf(isNaN) == Function.prototype);
// → true
console.log(Object.getPrototypeOf([]) == Array.prototype);
// → true



//可以利用一个特定的原型来使用Object.create方法创建对象。
//原型对象protoRabbit是一个容器，用于包含所有兔子对象的公有属性，每个独立的兔子对象killerRabbit可以包含其自身属性，也可以派生其原型对象中公有的属性
var protoRabbit = {
  speak: function(line) {
    console.log("The " + this.type + " rabbit says '" +
                line + "'");
  }
};
var killerRabbit = Object.create(protoRabbit);                             //将原型对象作为对象的属性！！！
killerRabbit.type = "killer";
killerRabbit.speak("SKREEEE!");
console.log("=="+Object.getPrototypeOf(protoRabbit)+"==");
// → The killer rabbit says 'SKREEEE!'




                                 /*=============构造函数=============*/
function Rabbit(type) {
  this.type = type;
}
//从公有原型中派生并构造对象，通过new创建的对象称之为构造函数的实例，所有函数都会自动获得一个名为prototype的属性。
//所有使用特定构造函数创建的对象都会将构造函数的prototype属性作为其原型
var killerRabbit = new Rabbit("killer");                                 //用构造函数建立对象与原型之间的关联！！！
var blackRabbit = new Rabbit("black");
console.log(blackRabbit.type);
// → black

Rabbit.prototype.speak = function(line) {
  console.log("The " + this.type + " rabbit says '" +
              line + "'");
};
blackRabbit.speak("Doom...");
// → The black rabbit says 'Doom...'



                                 /*=============覆盖继承的属性=============*/
Rabbit.prototype.teeth = "small";
console.log(killerRabbit.teeth);
// → small
killerRabbit.teeth = "long, sharp, and bloody";                         //覆盖原型中存在的属性
console.log(killerRabbit.teeth);
// → long, sharp, and bloody
console.log(blackRabbit.teeth);
// → small
console.log(Rabbit.prototype.teeth);
// → small



//为标准函数和数组原型提供一个不同于Object原型的toString方法。
console.log(Array.prototype.toString == Object.prototype.toString);
// → false
console.log([1, 2].toString());
// → 1,2


//Object原型提供的toString方法并不了解数组结构
console.log(Object.prototype.toString.call([1, 2]));
// → [object Array]



                                 /*=============原型污染=============*/
//为原型对象添加新的属性和方法                                 
Rabbit.prototype.dance = function() {
  console.log("The " + this.type + " rabbit dances a jig.");
};
killerRabbit.dance();
// → The killer rabbit dances a jig.



var map = {};
function storePhi(event, phi) {
  map[event] = phi;
}
storePhi("pizza", 0.069);
storePhi("touched tree", -0.081);


Object.prototype.nonsense = "hi";
for (var name in map)                                   //使用for/in循环遍历phi时，会到对象的原型中寻找属性
  console.log(name);
// → pizza
// → touched tree
// → nonsense
console.log("nonsense" in map);
// → true
console.log("toString" in map);
// → true
//Object.prototype同意中的标准属性都不可枚举，因此这些标准属性不会出现在for/in循环中
//我们创建并赋予对象的所有属性都是可枚举的
// Delete the problematic property again
delete Object.prototype.nonsense;



//使用Object.defineProperty函数定义自己的不可枚举属性，该函数允许我们在创建属性时控制属性类型
Object.defineProperty(Object.prototype, "hiddenNonsense",
                      {enumerable: false, value: "hi"});
for (var name in map)
  console.log(name);
// → pizza
// → touched tree
console.log(map.hiddenNonsense);
// → hi

//告知我们对象自身是否包含某个属性，而不会搜索其原型
console.log(map.hasOwnProperty("toString"));
// → false


//以防其他代码干扰基础对象的原型
for (var name in map) {
  if (map.hasOwnProperty(name)) {
    // ... this is an own property
  }
}



                                 /*=============无原型对象=============*/
//使用Object.create函数并根据特定原则来创建对象，传递null将创建一个无原型对象
var map = Object.create(null);
map["pizza"] = 0.069;
console.log("toString" in map);
// → false
console.log("pizza" in map);
// → true



                                 /*=============多态=============*/
                               /*=============绘制表格=============*/
// 计算每列的最小宽度和每行的最大高度，rows是一个二维数组，每个数组元素用来表示一个单元格组成的行                              
function rowHeights(rows) {
  return rows.map(function(row) {                      //逐行处理rows数组
    return row.reduce(function(max, cell) {
      return Math.max(max, cell.minHeight());
    }, 0);
  });
}
//rows的数组元素表示一行，而非一列
//map函数的第二个参数表示当前元素的索引编号
//rows[0]第一行单元格数组
function colWidths(rows) { 
  //i表示列索引编号
  return rows[0].map(function(_, i) {                    //下划线_开头或只包含单个下划线的变量名表示代码中不会使用该参数
    return rows.reduce(function(max, row) {
      //reduce逐行遍历，计算当前这一列单元格的最大宽度
      return Math.max(max, row[i].minWidth());
    }, 0);
  });
}



function drawTable(rows) {
  var heights = rowHeights(rows);
  var widths = colWidths(rows);

  function drawLine(blocks, lineNo) {
    return blocks.map(function(block) {                     //每次从所有块中提取出属于同一行的文本
      return block[lineNo];
    }).join(" ");
  }
  //将行中的单元格转换成block，每个block是一个字符串数组
  function drawRow(row, rowNum) {
    var blocks = row.map(function(cell, colNum) {
      return cell.draw(widths[colNum], heights[rowNum]);
    });
    return blocks[0].map(function(_, lineNo) {               //对最左侧的块进行映射，lineNo获得每一行的索引
      return drawLine(blocks, lineNo);
    }).join("\n");
  }
  return rows.map(drawRow).join("\n");
}



function repeat(string, times) {
  var result = "";
  for (var i = 0; i < times; i++)
    result += string;
  return result;
}

function TextCell(text) {
  this.text = text.split("\n");
}
TextCell.prototype.minWidth = function() {
  return this.text.reduce(function(width, line) {
    return Math.max(width, line.length);
  }, 0);
};
TextCell.prototype.minHeight = function() {
  return this.text.length;
};
TextCell.prototype.draw = function(width, height) {
  var result = [];
  for (var i = 0; i < height; i++) {
    var line = this.text[i] || "";
    result.push(line + repeat(" ", width - line.length));
  }
  return result;
};


var rows = [];
for (var i = 0; i < 5; i++) {
   var row = [];
   for (var j = 0; j < 5; j++) {
     if ((j + i) % 2 == 0)
       row.push(new TextCell("##"+i+j+"##"));
     else
       row.push(new TextCell("   "));
   }
   rows.push(row);
}
console.log(drawTable(rows));
// → ##    ##    ##
//      ##    ##
//   ##    ##    ##
//      ##    ##
//   ##    ##    ##



//山脉
function UnderlinedCell(inner) {
  this.inner = inner;
}
UnderlinedCell.prototype.minWidth = function() {
  return this.inner.minWidth();
};
UnderlinedCell.prototype.minHeight = function() {
  return this.inner.minHeight() + 1;
};
UnderlinedCell.prototype.draw = function(width, height) {
  return this.inner.draw(width, height - 1)
    .concat([repeat("-", width)]);
};



//标准Object.keys函数会返回一个数组，该数组中存储了对象中的所有属性名称
/*
function dataTable(data) {
  var keys = Object.keys(data[0]);
  var headers = keys.map(function(name) {
    return new UnderlinedCell(new TextCell(name));
  });
  var body = data.map(function(row) {
    return keys.map(function(name) {
      return new TextCell(String(row[name]));
    });
  });
  return [headers].concat(body);
}

console.log(drawTable(dataTable(MOUNTAINS)));
*/
// → name         height country
//   ------------ ------ -------------
//   Kilimanjaro  5895   Tanzania
//   … etcetera



                               /*=============Getter与Setter=============*/
var pile = {
  elements: ["eggshell", "orange peel", "worm"],
  get height() {
    return this.elements.length;
  },
  set height(value) {
    console.log("Ignoring attempt to set height to", value);
  }
};

console.log(pile.height);
// → 3
pile.height = 100;
// → Ignoring attempt to set height to 100


Object.defineProperty(TextCell.prototype, "heightProp", {
  get: function() { return this.text.length; }
});

var cell = new TextCell("no\nway");
console.log(cell.heightProp);
// → 2
cell.heightProp = 100;
console.log(cell.heightProp);
// → 2



                               /*=============继承=============*/
function RTextCell(text) {
  TextCell.call(this, text);     //使用call方法将对象作为旧构造函数的this值
}
RTextCell.prototype = Object.create(TextCell.prototype);
RTextCell.prototype.draw = function(width, height) {
  var result = [];
  for (var i = 0; i < height; i++) {
    var line = this.text[i] || "";
    result.push(repeat(" ", width - line.length) + line);
  }
  return result;
};


/*
function dataTable(data) {
  var keys = Object.keys(data[0]);
  var headers = keys.map(function(name) {
    return new UnderlinedCell(new TextCell(name));
  });
  var body = data.map(function(row) {
    return keys.map(function(name) {
      var value = row[name];
      // This was changed:
      if (typeof value == "number")
        return new RTextCell(String(value));
      else
        return new TextCell(String(value));
    });
  });
  return [headers].concat(body);
}

console.log(drawTable(dataTable(MOUNTAINS)));
*/
// → … beautifully aligned table


                               /*=============instanceof运算符=============*/
console.log(new RTextCell("A") instanceof RTextCell);
// → true
console.log(new RTextCell("A") instanceof TextCell);
// → true
console.log(new TextCell("A") instanceof RTextCell);
// → false
console.log([1] instanceof Array);
// → true

//多态：不同的对象可以实现相同的接口，只不过不同的对象提供了不同的内部实现细节


                               /*=============习题=============*/
                              console.log("=========习题=========");
function Vector(x, y) {
  this.x = x;  this.y = y;
}
Vector.prototype.plus = function(other) {
  return new Vector(this.x + other.x, this.y + other.y);
};
Vector.prototype.minus = function(other) {
  return new Vector(this.x - other.x, this.y - other.y);
};
Object.defineProperty(Vector.prototype, "length", {
  get: function() {
      return Math.sqrt(this.x * this.x + this.y * this.y);  
  }
});
console.log(new Vector(1, 2).plus(new Vector(2, 3)));
// → Vector{x: 3, y: 5}
console.log(new Vector(1, 2).minus(new Vector(2, 3)));
// → Vector{x: -1, y: -1}
console.log(new Vector(3, 4).length);
// → 5



function StretchCell(inner, width, height) {
  this.inner = inner;  this.width = width;  
  this.height = height;
}
StretchCell.prototype.minWidth = function() {
  return Math.max(this.width, this.inner.minWidth());
};
StretchCell.prototype.minHeight = function() {
  return Math.max(this.height, this.inner.minHeight());
};
StretchCell.prototype.draw = function(width, height) {
  return this.inner.draw(width, height);
};
var sc = new StretchCell(new TextCell("abc"), 1, 2);
console.log(sc.minWidth());
// → 3
console.log(sc.minHeight());
// → 2
console.log(sc.draw(3, 2));
// → ["abc", "   "]


//序列接口
//抽象集合的元素迭代过程
// I am going to use a system where a sequence object has two methods:
//
// * next(), which returns a boolean indicating whether there are more
//   elements in the sequence, and moves it forward to the next
//   element when there are.
//
// * current(), which returns the current element, and should only be
//   called after next() has returned true at least once.

function logFive(sequence) {
  for (var i = 0; i < 5; i++) {
      if (!sequence.next())
            break;    
      console.log(sequence.current());
  }
}
function ArraySeq(array) {
  this.pos = -1;  
  this.array = array;
}
ArraySeq.prototype.next = function() {
  if (this.pos >= this.array.length - 1)
      return false;  
  this.pos++;
      return true;
};
ArraySeq.prototype.current = function() {
  return this.array[this.pos];
};

function RangeSeq(from, to) {
  this.pos = from - 1;  
  this.to = to;
}
RangeSeq.prototype.next = function() {
  if (this.pos >= this.to)
      return false;  
  this.pos++;
      return true;
};
RangeSeq.prototype.current = function() {
  return this.pos;
};

logFive(new ArraySeq([1, 2]));
// → 1
// → 2
logFive(new RangeSeq(100, 1000));
// → 100
// → 101
// → 102
// → 103
// → 104
// This alternative approach represents the empty sequence as null,
// and gives non-empty sequences two methods:
//
// * head() returns the element at the start of the sequence.
// 
// * rest() returns the rest of the sequence, or null if there are no
//   elemements left.
//
// Because a JavaScript constructor can not return null, we add a make
// function to constructors of this type of sequence, which constructs
// a sequence, or returns null if the resulting sequence would be empty.


function logFive2(sequence) {
  for (var i = 0; i < 5 && sequence != null; i++) {
      console.log(sequence.head());    
      sequence = sequence.rest();  
  }
}
function ArraySeq2(array, offset) {
  this.array = array;  
  this.offset = offset;
}
ArraySeq2.prototype.rest = function() {
  return ArraySeq2.make(this.array, this.offset + 1);
};
ArraySeq2.prototype.head = function() {
  return this.array[this.offset];
};
ArraySeq2.make = function(array, offset) {
  if (offset == null) offset = 0;
  if (offset >= array.length)
      return null;  
  else
      return new ArraySeq2(array, offset);
};

function RangeSeq2(from, to) {
  this.from = from;
  this.to = to;
}
RangeSeq2.prototype.rest = function() {
  return RangeSeq2.make(this.from + 1, this.to);
};
RangeSeq2.prototype.head = function() {
  return this.from;
};
RangeSeq2.make = function(from, to) {
  if (from > to)
      return null;  
  else
      return new RangeSeq2(from, to);
};
logFive2(ArraySeq2.make([1, 2]));
// → 1
// → 2
logFive2(RangeSeq2.make(100, 1000));
// → 100// → 101// → 102// → 103// → 104



