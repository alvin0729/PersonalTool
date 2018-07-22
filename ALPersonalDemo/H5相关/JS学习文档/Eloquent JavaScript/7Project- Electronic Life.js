


var plan = ["############################",
            "#      #    #      o      ##",
            "#                          #",
            "#          #####           #",
            "##         #   #    ##     #",
            "###           ##     #     #",
            "#           ###      #     #",
            "#   ####                   #",
            "#   ##       o             #",
            "# o  #         o       ### #",
            "#    #                     #",
            "############################"];


function Vector(x, y) {
  this.x = x;
  this.y = y;
}
Vector.prototype.plus = function(other) {
  return new Vector(this.x + other.x, this.y + other.y);
};


var grid = [["top left",    "top middle",    "top right"],
            ["bottom left", "bottom middle", "bottom right"]];
console.log(grid[1][2]);
// → bottom right


var grid = ["top left",    "top middle",    "top right",
            "bottom left", "bottom middle", "bottom right"];
console.log(grid[2 + (1 * 3)]);
// → bottom right



function Grid(width, height) {
  this.space = new Array(width * height);
  this.width = width;
  this.height = height;
}
Grid.prototype.isInside = function(vector) {
  return vector.x >= 0 && vector.x < this.width &&
         vector.y >= 0 && vector.y < this.height;
};
Grid.prototype.get = function(vector) {
  return this.space[vector.x + this.width * vector.y];
};
Grid.prototype.set = function(vector, value) {
  this.space[vector.x + this.width * vector.y] = value;
};



var grid = new Grid(5, 5);
console.log(grid.get(new Vector(1, 1)));
// → undefined
grid.set(new Vector(1, 1), "X");
console.log(grid.get(new Vector(1, 1)));
// → X


                         /*=================动物的编程接口===============*/
var directions = {
  "n":  new Vector( 0, -1),
  "ne": new Vector( 1, -1),
  "e":  new Vector( 1,  0),
  "se": new Vector( 1,  1),
  "s":  new Vector( 0,  1),
  "sw": new Vector(-1,  1),
  "w":  new Vector(-1,  0),
  "nw": new Vector(-1, -1)
};



function randomElement(array) {
  return array[Math.floor(Math.random() * array.length)];
}

var directionNames = "n ne e se s sw w nw".split(" ");

//可以使用Object.keys从directions对象中获取的数组无法确保属性列表的排列顺序
function BouncingCritter() {
  this.direction = randomElement(directionNames);
};

BouncingCritter.prototype.act = function(view) {
  if (view.look(this.direction) != " ")
    this.direction = view.find(" ") || "s";
  return {type: "move", direction: this.direction};
};


                         /*=================World对象===============*/
function elementFromChar(legend, ch) {       //参数：平面图、图例
  if (ch == " ")
    return null;
  var element = new legend[ch]();            //每个字符对应一个构造函数，空格表示空闲空间
  element.originChar = ch;                   //找出创建元素时使用的字符
  return element;
}

function World(map, legend) {
  console.log(map.length);
  var grid = new Grid(map[0].length, map.length);
  this.grid = grid;
  this.legend = legend;

  map.forEach(function(line, y) {           //this作用域
    //对于传递给forEach方法的函数来说，其作用域已经超出了构造函数作用域的范围
    //函数内部的this与外部函数（构造函数）的this不同，不会指向新创建的对象。
    //如果没有以方法的形式来调用某个函数，该函数内部的this会指向全局对象
    //因此无法在循环中使用this.grid来访问网格对象
    for (var x = 0; x < line.length; x++)
      grid.set(new Vector(x, y),elementFromChar(legend, line[x]));
  });
}


function charFromElement(element) {
  if (element == null)
    return " ";
  else
    return element.originChar;
}

World.prototype.toString = function() {
  var output = "";
  for (var y = 0; y < this.grid.height; y++) {
    for (var x = 0; x < this.grid.width; x++) {
      var element = this.grid.get(new Vector(x, y));
      output += charFromElement(element);
    }
    output += "\n";
  }
  return output;
};


function Wall() {}


var world = new World(plan, {"#": Wall,"o": BouncingCritter});
console.log(world.toString());
// → ############################
//   #      #    #      o      ##
//   #                          #
//   #          #####           #
//   ##         #   #    ##     #
//   ###           ##     #     #
//   #           ###      #     #
//   #   ####                   #
//   #   ##       o             #
//   # o  #         o       ### #
//   #    #                     #
//   ############################



                         /*=================this及其作用域================*/
//var self = this,创建普通变量self，内部函数可以直接访问
var test = {
  prop: 10,
  addPropTo: function(array) {
    return array.map(function(elt) {
      return this.prop + elt;
    }.bind(this));                   //调用bind会返回一个新函数
  }
};
//bind的第一个参数会绑定到这个新函数的this上，this指向test对象
console.log(test.addPropTo([5]));
// → [15]


var test = {
  prop: 10,
  addPropTo: function(array) {
    return array.map(function(elt) {
      return this.prop + elt;
    }, this); // ← no bind
    //该方法只适用于支持context参数的高阶函数
  }
};
console.log(test.addPropTo([5]));
// → [15]


//自定义高阶函数，可以调用函数的call方法来支持context参数
Grid.prototype.forEach = function(f, context) {
  for (var y = 0; y < this.height; y++) {
    for (var x = 0; x < this.width; x++) {
      var value = this.space[x + y * this.width];
      if (value != null)
        f.call(context, value, new Vector(x, y));
    }
  }
};

                         /*=================赋予生命================*/

World.prototype.turn = function() {
  var acted = [];
  //使用上面定义的forEach遍历网格并查找所有包含act方法的对象
  this.grid.forEach(function(critter, vector) {
    //调用act方法以获取一个动作对象
    if (critter.act && acted.indexOf(critter) == -1) {
      acted.push(critter);
      this.letAct(critter, vector);
    }
  }, this);
};



World.prototype.letAct = function(critter, vector) {
  //防御式编程
  var action = critter.act(new View(this, vector));
  if (action && action.type == "move") {
    var dest = this.checkDestination(action, vector);
    if (dest && this.grid.get(dest) == null) {
      this.grid.set(vector, null);
      this.grid.set(dest, critter);
    }
  }
};

World.prototype.checkDestination = function(action, vector) {
  if (directions.hasOwnProperty(action.direction)) {
    var dest = vector.plus(directions[action.direction]);
    if (this.grid.isInside(dest))
      return dest;
  }
};
//调用act方法获取动物的动作，可以通过view对象获取世界对象的信息以及动物在当前世界中的位置



function View(world, vector) {
  this.world = world;
  this.vector = vector;
}

View.prototype.look = function(dir) {
  var target = this.vector.plus(directions[dir]);
  if (this.world.grid.isInside(target))
    return charFromElement(this.world.grid.get(target));
  else
    return "#";
};
View.prototype.findAll = function(ch) {
  var found = [];
  for (var dir in directions)
    if (this.look(dir) == ch)
      found.push(dir);
  return found;
};
View.prototype.find = function(ch) {
  var found = this.findAll(ch);
  if (found.length == 0) return null;
  return randomElement(found);
};


                 /*=================动物的爬行动作================*/
for (var i = 0; i < 5; i++) {
  world.turn();
  //console.log(world.toString());
}
// → … five turns of moving critters



                /*=================更多动物================*/

//animateWorld(world);
// → … life!


//dirPlus("n",1)代表从正北方向开始顺时针旋转45°
function dirPlus(dir, n) {
  var index = directionNames.indexOf(dir);
  //console.log("++++2",dir,directionNames[(index + n + 8) % 8]);
  return directionNames[(index + n + 8) % 8];
}


function WallFollower() {
  this.dir = "s";
}

//从自己的左侧开始，顺时针寻找空的方格
WallFollower.prototype.act = function(view) {
  var start = this.dir;
  if (view.look(dirPlus(this.dir, -3)) != " ")      //左侧方向，逆时针旋转270°
    start = this.dir = dirPlus(this.dir, -2);
  while (view.look(this.dir) != " ") {
    this.dir = dirPlus(this.dir, 1);        //正前方
    if (this.dir == start) break;
  }
  return {type: "move", direction: this.dir};
};



                /*=================更逼真的生态系统仿真================*/
/*
animateWorld(new World(
  ["############",
   "#     #    #",
   "#   ~    ~ #",
   "#  ##      #",
   "#  ##  o####",
   "#          #",
   "############"],
  {"#": Wall,
   "~": WallFollower,
   "o": BouncingCritter}
));
*/


function LifelikeWorld(map, legend) {
  World.call(this, map, legend);
}
LifelikeWorld.prototype = Object.create(World.prototype);

var actionTypes = Object.create(null);

LifelikeWorld.prototype.letAct = function(critter, vector) {
  var action = critter.act(new View(this, vector));
  var handled = action &&
    action.type in actionTypes &&
    actionTypes[action.type].call(this, critter,
                                  vector, action);
    //最后判断处理函数是否成功处理了该动作
  if (!handled) {
    critter.energy -= 0.2;
    if (critter.energy <= 0)
      this.grid.set(vector, null);
  }
};



                /*=================动作处理器================*/
actionTypes.grow = function(critter) {
  critter.energy += 0.5;
  return true;
};

actionTypes.move = function(critter, vector, action) {
  var dest = this.checkDestination(action, vector);
  if (dest == null ||
      critter.energy <= 1 ||
      this.grid.get(dest) != null)  //非空闲区域
    return false;
  critter.energy -= 1;
  this.grid.set(vector, null);
  this.grid.set(dest, critter);
  return true;
};



actionTypes.eat = function(critter, vector, action) {
  var dest = this.checkDestination(action, vector);
  var atDest = dest != null && this.grid.get(dest);
  if (!atDest || atDest.energy == null)
    return false;
  critter.energy += atDest.energy;
  this.grid.set(dest, null);
  return true;
};



actionTypes.reproduce = function(critter, vector, action) {
  var baby = elementFromChar(this.legend,
                             critter.originChar);
  var dest = this.checkDestination(action, vector);
  if (dest == null ||
      critter.energy <= 2 * baby.energy ||
      this.grid.get(dest) != null)
    return false;
  critter.energy -= 2 * baby.energy;
  this.grid.set(dest, baby);
  return true;
};



                /*=================充实这个新世界================*/
function Plant() {
  this.energy = 3 + Math.random() * 4;
}
Plant.prototype.act = function(view) {
  if (this.energy > 15) {
    var space = view.find(" ");
    if (space)
      return {type: "reproduce", direction: space};
  }
  if (this.energy < 20)
    return {type: "grow"};
};



function PlantEater() {
  this.energy = 20;
}
PlantEater.prototype.act = function(view) {
  var space = view.find(" ");
  if (this.energy > 60 && space)
    return {type: "reproduce", direction: space};
  var plant = view.find("*");
  if (plant)
    return {type: "eat", direction: plant};
  if (space)
    return {type: "move", direction: space};
};



var valley = new LifelikeWorld(
  ["############################",
   "#####                 ######",
   "##   ***                **##",
   "#   *##**         **  O  *##",
   "#    ***     O    ##**    *#",
   "#       O         ##***    #",
   "#                 ##**     #",
   "#   O       #*             #",
   "#*          #**       O    #",
   "#***        ##**    O    **#",
   "##****     ###***       *###",
   "############################"],
  {"#": Wall,
   "O": PlantEater,
   "*": Plant}
);


//animateWorld(valley);
/*
for (var i = 0; i < 1; i++) {
  valley.turn();
  console.log(valley.toString());
}
*/

/*=================习题================*/
function SmartPlantEater() {
  this.energy = 30;  
  this.direction = "e";
}
SmartPlantEater.prototype.act = function(view) {
  var space = view.find(" ");  
  if (this.energy > 90 && space)
      return {type: "reproduce", direction: space};
  var plants = view.findAll("*");
  if (plants.length > 1)
      return {type: "eat", direction: randomElement(plants)};
  if (view.look(this.direction) != " " && space)
      this.direction = space;  
return {type: "move", direction: this.direction};
};
var valley1 = new LifelikeWorld(
  ["############################",
   "#####                 ######",
   "##   ***                **##",   
   "#   *##**         **  O  *##",   
   "#    ***     O    ##**    *#",   
   "#       O         ##***    #",   
   "#                 ##**     #",   
   "#   O       #*             #",   
   "#*          #**       O    #",   
   "#***        ##**    O    **#",   
   "##****     ###***       *###",   
   "############################"],  
   {"#": Wall,   "O": SmartPlantEater,   "*": Plant});
/*
animateWorld(new LifelikeWorld(
  ["############################",
   "#####                 ######",
   "##   ***                **##",   
   "#   *##**         **  O  *##",   
   "#    ***     O    ##**    *#",   
   "#       O         ##***    #",   
   "#                 ##**     #",   
   "#   O       #*             #",   
   "#*          #**       O    #",   
   "#***        ##**    O    **#",   
   "##****     ###***       *###",   
   "############################"],  
   {"#": Wall,   "O": SmartPlantEater,   "*": Plant}));
*/
for (var i = 0; i < 0; i++) {
  valley1.turn();
  console.log(valley1.toString());
}



function SmartPlantEater() {
  this.energy = 30;  
  this.direction = "e";
}
SmartPlantEater.prototype.act = function(view) {
  var space = view.find(" ");  
  if (this.energy > 90 && space)
      return {type: "reproduce", direction: space};  
  var plants = view.findAll("*");  
  if (plants.length > 1)
      return {type: "eat", direction: randomElement(plants)};  
  if (view.look(this.direction) != " " && space)
      this.direction = space;  
  return {type: "move", direction: this.direction};
};
function Tiger() {
  this.energy = 100;  
  this.direction = "w";  
  // Used to track the amount of prey seen per turn in the last six turns  
  this.preySeen = [];
}
Tiger.prototype.act = function(view) {
  // Average number of prey seen per turn  
  var seenPerTurn = this.preySeen.reduce(function(a, b) {
      return a + b;  }, 0) / this.preySeen.length;  
  var prey = view.findAll("O");  
  this.preySeen.push(prey.length);  
  // Drop the first element from the array when it is longer than 6  
  if (this.preySeen.length > 6)
      this.preySeen.shift();  
  // Only eat if the predator saw more than ¼ prey animal per turn  
  if (prey.length && seenPerTurn > 0.25)
      return {type: "eat", direction: randomElement(prey)};      
  var space = view.find(" ");  
  if (this.energy > 400 && space)
      return {type: "reproduce", direction: space};  
  if (view.look(this.direction) != " " && space)
      this.direction = space;  
  return {type: "move", direction: this.direction};
};

//animateWorld(new LifelikeWorld(  ["####################################################",   "#                 ####         ****              ###",   "#   *  @  ##                 ########       OO    ##",   "#   *    ##        O O                 ****       *#",   "#       ##*                        ##########     *#",   "#      ##***  *         ****                     **#",   "#* **  #  *  ***      #########                  **#",   "#* **  #      *               #   *              **#",   "#     ##              #   O   #  ***          ######",   "#*            @       #       #   *        O  #    #",   "#*                    #  ######                 ** #",   "###          ****          ***                  ** #",   "#       O                        @         O       #",   "#   *     ##  ##  ##  ##               ###      *  #",   "#   **         #              *       #####  O     #",   "##  **  O   O  #  #    ***  ***        ###      ** #",   "###               #   *****                    ****#",   "####################################################"],  {"#": Wall,   "@": Tiger,   "O": SmartPlantEater, // from previous exercise   "*": Plant}));


var valley2 = new LifelikeWorld(
  ["####################################################",
   "#                 ####         ****              ###",   
   "#   *  @  ##                 ########       OO    ##",   
   "#   *    ##        O O                 ****       *#",   
   "#       ##*                        ##########     *#",   
   "#      ##***  *         ****                     **#",   
   "#* **  #  *  ***      #########                  **#",   
   "#* **  #      *               #   *              **#",   
   "#     ##              #   O   #  ***          ######",   
   "#*            @       #       #   *        O  #    #",   
   "#*                    #  ######                 ** #",   
   "###          ****          ***                  ** #",   
   "#       O                        @         O       #",   
   "#   *     ##  ##  ##  ##               ###      *  #",   
   "#   **         #              *       #####  O     #",   
   "##  **  O   O  #  #    ***  ***        ###      ** #",   
   "###               #   *****                    ****#",   
   "####################################################"],  
   {"#": Wall,   "@": Tiger,   "O": SmartPlantEater, 
   // from previous exercise   
   "*": Plant});
for (var i = 0; i < 0; i++) {
  valley2.turn();
  console.log(valley2.toString());
}


