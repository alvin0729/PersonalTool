import UIKit
//: ### For-In循环
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
//如果不需要区间序列内每一项的值，可以使用下划线_替代变量名来忽略这个值
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna,", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
//: ### While循环
let finalSquare = 25
var board = [Int](repeating:0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;

var square: Int = 0
var diceRoll = 0

/*
while square < finalSquare {
    //抛掷骰子
    diceRoll += 1
    if diceRoll == 7 {diceRoll = 1}
    //根据点数移动
    square += diceRoll
    if square < board.count {
        //如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")
*/
//: - callout(Note): Repeat-While
/*
repeat {
    //顺着梯子爬上去或者顺着蛇滑下去
    square += board[square]
    //抛掷骰子
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll
}while square < finalSquare
print("Game over!")
*/
 
//: ### 条件语句
/*:
>switch\
>不存在隐式的贯穿No Implicit Fallthrough\
>每一个case分支都必须包含至少一条语句
 */
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}

//区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

//: ### 元组(Tuple)
//元组中的元素可以是值，也可以是区间。使用下划线匹配所有可能的值
let somePoint = (1,1)
switch somePoint {
case (0,0):
    print("(0,0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside of the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
//: ### 值绑定Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with an y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
//: ### Where
//case分支的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x==y.")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x==-y.")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point.")
}

//复合匹配Compound Cases
let someCharacter: Character = "e"
switch someCharacter {
case "a","e","i",
    "o","u":
    print("\(someCharacter) is a vowel")
default:
    print("\(someCharacter) is not a vowel")
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
//复合匹配所有的匹配模式，都必须包含相同的值绑定，并且每一个绑定都必须获取到相同类型的值
//: ### 控制转移语句(Control Transfer Statements)
//continue break fallthrough return throw

//continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a","e","i","o","u"," ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

//break
//循环语句中的break
//switch语句中的break

let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
case "1","?","一","?":
    possibleIntegerValue = 1
case "2","?","二","?":
    possibleIntegerValue = 2
case "3","?","三","?":
    possibleIntegerValue = 3
case "4","?","四","?":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue{
    print("The integer value of \(numberSymbol) is \(integerValue).")
}else{
    print("An integer value could not be found \(numberSymbol).")
}

//贯穿Fallthrough
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 3,2,5,7,11,13,17,19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
/*:
>带标签的语句statement label\
>对于一个条件语句，可以使用break加标签的方式来结束这个被标记的语句\
>对于一个循环语句，使用break或continue加标签来结束或继续这条被标记语句的执行
*/
//继续前面的游戏
gameLoop: while square != finalSquare{
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    switch square + diceRoll {
    case finalSquare:
        //diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        //diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        //this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
/*:
>提前退出
>一个guard语句总是有一个else语句，如果条件不为真则执行else从句中的代码*/
func greet(person: [String : String]){
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

//检测API可用性
if #available(iOS 10,macOS 10.12, *){
    //在iOS使用iOS 10的API，在macOS使用macOS 10.12的API
    print("在iOS使用iOS 10的API，在macOS使用macOS 10.12的API")
}else{
    print("使用先去版本的iOS和MacOS的API")
}
