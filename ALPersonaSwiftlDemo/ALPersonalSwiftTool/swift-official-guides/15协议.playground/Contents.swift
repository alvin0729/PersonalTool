import UIKit
//: ## 协议
//: ### 协议语法
/*:
 ```
 protocol SomeProtocol {
 // 这里是协议的定义部分
 }
 struct SomeStructure: FirstProtocol, AnotherProtocol {
 // 这里是结构体的定义部分
 }
 
 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
 // 这里是类的定义部分
 }
 ```*/
//: ### 属性要求
//: 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的
/*:
```
protocol SomeProtocol{
    var mustBeSettable:Int{ get set }
    var doesNotNeedToBeSettable:Int{get}
}
 ```*/
//: 在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol AnotherProtocol {
    static var someTypeProperty:Int{ get set }
}
protocol FullyNamed{
    var fullName:String {get}
}
struct Person:FullyNamed{
    var fullName:String
}
let john = Person(fullName: "John Appleseed")
class Starship:FullyNamed{
    var prefix:String?
    var name:String
    init(name:String,prefix:String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String{
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
//: ### 方法要求
protocol SomeProtocol{
    static func someTypeMethod()
}
protocol RandomNumberGenerator{
    func random() -> Double
}
class LinearCongruentialGenerator:RandomNumberGenerator{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number:\(generator.random())")
print("And another one:\(generator.random())")
//: ### Mutating方法要求
//: - callout(注意): 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
//有时需要在方法中改变（或异变）方法所属的实例。
protocol Togglable{
    mutating func toggle()
}
enum OnOffSwitch: Togglable{
    case Off,On
    //该方法将会改变遵循协议的类型的实例：
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
//: ### 构造器要求
/*:
 ```
 protocol SomeProtocol {
 init(someParameter: Int)
 }
 ```*/
//: **构造器要求在类中的实现**
//你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
//使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
/*:
 ```
 class SomeClass: SomeProtocol {
      required init(someParameter: Int) {
      // 这里是构造器的实现部分
      }
 }
 ```*/
//: - callout(注意): 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
/*:
 ```
 protocol SomeProtocol {
 init()
 }
  
 class SomeSuperClass {
 init() {
 // 这里是构造器的实现部分”
    }
 }
  
 class SomeSubClass: SomeSuperClass, SomeProtocol {
 // 因为遵循协议，需要加上 required
 // 因为继承自父类，需要加上 override
 required override init() {
 // 这里是构造器的实现部分
 }
 }
 ```*/
//: ### 协议作为类型
/*
 作为函数、方法或构造器中的参数类型或返回值类型
 作为常量、变量或属性的类型
 作为数组、字典或其他容器中的元素类型
 */
class Dice {
    let sides: Int
    let generator:RandomNumberGenerator
    init(sides:Int,generator:RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
//: ### 委托（代理）模式
protocol DiceGame{
    var dice:Dice {get}
    func play()
}
protocol DiceGameDelegate{
    func gameDidStart(_ game:DiceGame)
    func game(_ game:DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game:DiceGame)
}
class SnakesAndLadders:DiceGame{
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board:[Int]
    init(){
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop:while square != finalSquare
        {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
class DiceGameTracker:DiceGameDelegate{
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//在扩展里添加协议遵循
//即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议
//: ### 通过扩展添加协议的一致性
protocol TextRepresentable {
    var textualDescription:String{get}
}
extension Dice: TextRepresentable{
    var textualDescription: String{
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
extension SnakesAndLadders: TextRepresentable{
    var textualDescription: String{
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

//: ❤️4.2
//有条件地遵循协议
//泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。
//下面的扩展让 Array 类型只要在存储遵循 TextRepresentable 协议的元素时就遵循 TextRepresentable 协议。
//extension Array: TextRepresentable where Element: TextRepresentable {
//    var textualDescription: String {
//        let itemsAsText = self.map { $0.textualDescription }
//        return "[" + itemsAsText.joined(separator: ", ") + "]"
//    }
//}
//let myDice = [d6, d12]
//print(myDice.textualDescription)
// 打印 "[A 6-sided dice, A 12-sided dice]"
//: ### 通过扩展遵循协议
//: 当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议
struct Hamster{
    var name:String
    var textualDescription: String{
        return "A hamster named \(name)"
    }
}
//即使满足了协议的所有要求，类型也不会自动遵循协议，必须显式地遵循协议。
extension Hamster: TextRepresentable{}
//从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable:TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
//: ### 协议类型的集合
let things:[TextRepresentable] = [game,d12,simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}
//: ### 协议的继承
/*:
 ```
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
 // 这里是协议的定义部分
 }
 ```*/
protocol PrettyTextRepresentable:TextRepresentable{
    var prettyTextDescription: String{get}
}
extension SnakesAndLadders: PrettyTextRepresentable{
    var prettyTextDescription:String{
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextDescription)
//: ### 类类型专属协议
//: 你可以在协议的继承列表中，通过添加 class 关键字来限制协议只能被类类型遵循，而结构体或枚举不能遵循该协议。class 关键字必须第一个出现在协议的继承列表中，在其他继承的协议之前：
/*:
```
 protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
 // 这里是类类型专属协议的定义部分
 }
 //4.0
 protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
 // class-only protocol definition goes here
 }
```*/
//: ### 协议合成
//: 有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。
//协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号（&）分开。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类。
protocol Named{
    var name: String{get}
}
protocol Aged{
    var age:Int{get}
}
struct Person1:Named,Aged{
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator:Named & Aged){
    print("Happy birthday,\(celebrator.name),you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// Prints "Hello, Seattle!"
//: - callout(注意): 协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
//: ### 检查协议一致性
//: -    is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
//: -    as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
//: -    as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
protocol HasArea{
    var area:Double{get}
}
class Circle:HasArea{
    let pi = 3.1415927
    var radius:Double
    var area: Double { return pi * radius * radius}
    init(radius:Double) {
        self.radius = radius
    }
}
//Circle 类把 area 属性实现为基于存储型属性 radius 的计算型属性。Country 类则把 area 属性实现为存储型属性。
class Country:HasArea{
    var area: Double
    init(area:Double) {
        self.area = area
    }
}
class Animal{
    var legs:Int
    init(legs:Int) {
        self.legs = legs
    }
}
let objects:[AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
//: ### 可选的协议要求
//: 一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
//标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
@objc protocol CounterDataSource{
    @objc optional func incrementForCount(count:Int) -> Int
    @objc optional var fixedIncrement:Int{get}
}
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment(){
        if let amount = dataSource?.incrementForCount?(count: count) {//返回值为Int？类型
            count += amount
        } else if let amount = dataSource?.fixedIncrement{//是一个可选属性，因此属性值是一个 Int? 值
            count += amount
        }
    }
}
class ThreeSource:NSObject,CounterDataSource{
    let fixedIncrement = 3
}
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
@objc class TowardsZeroSource:NSObject,CounterDataSource{
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
//: ### 协议扩展
//: 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。
//扩展 RandomNumberGenerator 协议来提供 randomBool() 方法
extension RandomNumberGenerator{
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
print("And here's a random Boolean: \(generator1.randomBool())")
//: **提供默认实现**
//: 可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
//: - callout(注意): 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。

extension PrettyTextRepresentable{
    var prettyTextualDescription:String{
        return textualDescription
    }
}
//: **为协议扩展添加限制条件**
//你可以扩展 Collection 协议，适用于集合中的元素遵循了 Equatable 协议的情况。通过限制集合元素遵 Equatable 协议， 作为标准库的一部分， 你可以使用 == 和 != 操作符来检查两个元素的等价性和非等价性。
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
print(equalNumbers.allEqual())
// 打印 "true"
print(differentNumbers.allEqual())
// 打印 "false"
extension Collection where Iterator.Element:TextRepresentable{
    var textualDescription:String{
        let itemsAsText = self.map{$0.textualDescription}
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster,morganTheHamster,mauriceTheHamster]
print(hamsters.textualDescription)
//: - callout(注意): 如果多个协议扩展都为同一个协议要求提供了默认实现，而遵循协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。
