//:![Icon](swift.png)  A Swift tour
import UIKit

print("Hello, world!")
//: ## 简单值
var myVariable = 42
myVariable = 50
let myConstant = 42
/*:
 >**变量后面申明类型**
 */
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble : Double = 70
/*:
 >**值显示转换**
 */
let label = "The width is"
let width = 94
let widthLabel = label + String(width)
//: - callout(Exercise):let widthLabel = label + width
/*:
 >**把值转换成字符串**
 */

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit"
//❤️4.0
let quotation = """
Even though there's whitespace to the left
the actual lines aren't indented.
Except for this line.
Double quotes (") can appear without being escaped.
I still have \(apples + oranges) pieces of fruit.
"""
/*:
 >**使用方括号[]来创建数组和字典，最后一个元素后面允许有个逗号**
 */

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
var occupations = [
    "Malcolm" : "Captain",
    "Kaylee" : "Mechanic",]
occupations["Jayne"] = "Public Relations"

/*:
 >**创建空数组或字典**
 */
let emptyArray = [String]()
let emptyDictionary = [String : Float]()
//❤️4.0
shoppingList = []
occupations = [:]
//:  ## 控制流
let individualScores = [75,43,103,87,12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    }else{
        teamScore += 1
    }
}
print("-----",teamScore)
/*:
 >**[在if语句中，条件必须是一个布尔表达式--这意味着像if score{...}这样的代码将报错，而不会隐形地与0做对比]()**\
 >一起使用if和let来处理值缺失的情况。在类型后面加一个`?`来标记这个变量的值是可选的
 */
var optionalString : String? = "Hello"
print(optionalString == nil)
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
/*:
 >**通过使用`？？`来提供一个默认值**
 */
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
/*:
 >**switch支持任意类型的数据以及各种比较操作**
 */
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log")
case "cucumber","watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
/*:
 >**for-in遍历字典**
 */
let interestingNumbers = [
    "Prime" : [2, 3, 5, 7, 11, 13],
    "Fibonacci" : [1, 1, 2, 3, 5, 8],
    "Square" : [1, 4, 9, 16, 25],
]
var largest = 0
var largestKind = String()

for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKind = kind
        }
    }
}
print(largestKind,":",largest)
/*:
 >**使用while循环**
 */
var n = 2
while n < 100{
    n = n * 2
}
print(n)

var m = 2
repeat{
    m = m * 2
}while m < 100
print(m)
/*:
 >**在循环中使用..<来表示范围**
 */
var total = 0
for i in 0..<4 {
    /**0...4**/
    total += i
}
print(total)
/*:   ## 函数和闭包*/
func greet(name: String, day: String) -> String{
    return "Hello \(name), today is \(day)."
}
greet(name: "Bob", day: "Tuesday")

func greet1(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet1("John", on: "Wednesday")
/*:
 >**使用元组来让一个函数返回多个值**
 */
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        }else if score < min{
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.1)
/*:
 >**函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式：**
 */
func sumOf(numbers: Int...) -> Int{
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(numbers: 42, 597, 12)
/*:
 >**函数可以嵌套**
 */
func returnFifteen() -> Int{
    var y = 10
    func add(){
        y += 5
    }
    add()
    return y
}
returnFifteen()
/*:
 >**函数是第一等类型，函数可以作为另一个函数的返回值**
 */
func makeIncrementer() -> ((Int) -> Int){
    func addOne(number: Int) -> Int{
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
/*:
 >**函数也可以当做参数传入另一个函数**
 */
func hasAnyMatch(list: [Int], condition: (Int) -> Bool) ->Bool{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool{
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatch(list: numbers, condition: lessThanTen)
/*:
 >**使用{}来创建匿名闭包，使用in将参数和返回值类型申明与闭包函数体进行分离**
 */
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
let mappedNumbers = numbers.map({number in 3 * number })
print(mappedNumbers)
/*:
 >**当一个闭包是传给函数的唯一参数，可以完全忽略括号**
 */
let sortedNumbers = numbers.sorted{ $0 > $1 }
print(sortedNumbers)
//:   ## 对象和类
class Shape{
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
/*:
 >**添加构造函数**
 >deinit创建一个析构函数
 */
class NamedShape{
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
/*:
 >**子类重写父类的方法override**
 */
class Square: NamedShape{
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
print(test.simpleDescription())
/*:
 >**getter和setter**
 */
class EquilateralTriangle: NamedShape{
    var sideLength: Double = 0.0
    init(sideLength: Double, name: String) {
        //1.设置子类申明的属性值
        self.sideLength = sideLength
        //2.调用父类的构造器
        super.init(name: name)
        //3.改变父类定义的属性值
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        //可以在set之后显示地设置一个名字
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)
/*:
 >**如果不需要计算属性，但是任然需要在设置一个新值之前或者之后运行代码，使用willSet和didSet**\
 >下面的类确保三角形的边长和正方形的边长相同
 */
class TriangleAndSquare{
    var triangle: EquilateralTriangle {
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square{
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
/*:
 >**处理变量的可选值时，你可以在操作（方法、属性和子脚本）之前加`？`。如果`？`之前的值是nil，`？`后面的东西都会被忽略，并且整个表达式返回nil。否则`？`之后的东西都会被运行**
 */
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
/*:  ## 枚举和结构体*/
enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            //使用rawValue属性来访问一个枚举成员的原始值
            return String(self.rawValue)
        }
    }
}
let ace = Rank.Ace
let aceRawValue = ace.rawValue
/*:
 >**使用init?(rawValue:)初始化构造器在原始值和枚举值之间进行转换**
 */
if let convertedRank = Rank(rawValue: 3){
    let threeDescription = convertedRank.simpleDescription()
}
/*:
 >**枚举的成员值是实际值，并不是原始值的另一种表达方法**
 */
enum Suit{
    case Spades, Herts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Herts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Herts
let heartsDescription = hearts.simpleDescription()
/*:
 >**使用struct来创建一个结构体**
 >结构体是传值，类是传引用
 */
struct Card{
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
/*:
 >**从服务器获取🌅和日落时间**
 */
enum ServerResponse{
    case Result(String, String)
    case Failure(String)
}

let success = ServerResponse.Result("6:00 am", "8:09 pm")
let failure = ServerResponse.Failure("Out of cheese.")

switch success {
case let .Result(sunrise, sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Failure(message):
    print("Failure...\(message)")
}

/*:  ## 协议和扩展*/
protocol ExampleProtocol{
    var simpleDescription: String{get}
    mutating func adjust()
}
/*:
 >**类、枚举和结构体都可以实现协议**
 */
class SimpleClass: ExampleProtocol{
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol{
    var simpleDescription: String = "A simple structure"
    //mutating关键字用来标记一个会修改结构体的方法
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
/*:
 >**使用extension来为现有的类型添加功能**
 */
extension Int: ExampleProtocol{
    var simpleDescription: String{
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)
/*:
 >**编译器会把它的类型当做ExampleProtocol。这表示不能调用SimpleClass在它实现的协议之外实现的方法或者属性**\
 >print(protocolValue.anotherProperty)   //Uncomment to see the error\
 >即使protocolValue变量运行时的类型是simpleClass，编译器会把它的类型当做ExampleProtocol。这表示你不能调用类在它实现的协议之外实现的方法或者属性。
 */
/*:   ## 错误处理*/
/*:
 >**采用Errortype协议的类型来表示错误**
 */
enum PrinterError: Error{
    case OutOfPaper
    case NoToner
    case OnFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.NoToner
    }
    return "Job sent"
}

func sendToPrinter(printerName: String) throws -> String{
    if printerName == "Never Has Toner"{
        throw PrinterError.NoToner
    }
    return "Job sent"
}
do{
    let printerResponse = try sendToPrinter(printerName: "Bi Sheng")
    print(printerResponse)
} catch{
    print(error)
}

do{
    let printerResponse = try sendToPrinter(printerName: "Gutenberg")
    print(printerResponse)
} catch PrinterError.OnFire{
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch{
    print(error)
}
/*:
 >**使用try`？`将结果转换为可选的。如果函数抛出错误，该错误会被抛弃并且结果为nil，否则，结果会是一个函数返回值的可选值**
 */
let printerSuccess = try? sendToPrinter(printerName: "Mergenthaler")
let printerFailure = try? sendToPrinter(printerName: "Never Has Toner")
/*:
>**使用defer代码块来表示在函数返回前，函数中最后执行的代码**
 */
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "lefttovers"]
func fridgeContains(itemName: String) ->Bool{
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    let result = fridgeContent.contains(itemName)
    return result
}
fridgeContains(itemName: "banana")
print(fridgeIsOpen)
/*:   ## 泛型*/
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item]{
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
repeatItem(item: "knock", numberOfTimes: 4)
/*:
 >可以创建泛型函数、方法、类、枚举和结构体
 >Reimplement the Swift standard library's optional type
 */
enum OptionalValue<Wrapped>{
    case None
    case Some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)
/*:
 >在类型名后面使用where来指定对类型的需求，比如，限定类型实现某一个协议，限定两个类型是相同的，或者限定某个类必须有一个特定的父类
 */
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem{
                return true
            }
        }
    }
    return false
}
anyCommonElements([1,2,3],[3])
/*:
 ><T: Equatable>和<T where T: Equatable>是等价的
 */
//: - callout(Exercise):Exercise
//:* Change the `question`
/*:
 ```
 print(botheration)
 ```
 */
//: - experiment:
//: 2017.04.23
/*:
 _Copyright (C) 2016 [alvin](license).
 All Rights Reserved._
 */

