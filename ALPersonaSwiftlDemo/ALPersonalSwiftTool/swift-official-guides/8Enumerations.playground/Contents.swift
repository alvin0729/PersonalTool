/*:
 >枚举-Enumerations */
//:在 Swift中，枚举类型是一等(first-class)类型。它们采用了很多在传统上只被类(class)所支持的特性，例如计算型属性(computed properties)，用于提供枚举值的附加信息，实例方法(instance methods)，用于提供和枚举值相关联的功能。枚举也可以定义构造函数(initializers)来提供一个初始值;可以在原始实现的基础上扩展它们的功能;还可以遵守协议(protocols)来提供标准的功能。
//http://www.cnblogs.com/machao/p/6474667.html
//枚举语法
enum CompassPoint {
    case North
    case South
    case East
    case West
}
//: - callout(注意):与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint 例子中， North ， South ， East 和 West 不会被隐式地赋值为 0 ， 1 ， 2 和 3 。相反，这些枚举成员本身 就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
var directionToHead = CompassPoint.West
//一旦 directionToHead 被声明为 CompassPoint 类型，你可以使用更简短的点语法将其设置为另一个 CompassPoint 的值
directionToHead = .East

//: ###### 使用Switch语句匹配枚举值
directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//:- ❤️4.2Iterating over Enumeration Cases
/*enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
 */
//: #### Associated Values关联值
//:你可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。枚 举的这种特性跟其他语言中的可识别联合(discriminated unions)，标签联合(tagged unions)，或者变体(variants)相似。
enum BarCode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = BarCode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A:\(numberSystem),\(manufacturer),\(product),\(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

switch productBarcode {
//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}

//: #### 原始值Raw Values
//作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
enum ASCIIControlCharacter: Character{
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
/*:
>原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。\
>原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚 举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值 可以变化。\
>原始值的隐式赋值(Implicitly Assigned Raw Values)\
>在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为 你赋值。
 */
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
//:当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
enum CompassPoint1: String {
    case North, South, East, West
}
let earthsOrder = Planet1.Earth.rawValue
let sunsetDirection = CompassPoint1.West.rawValue
//:使用原始值初始化枚举实例(Initializing from a Raw Value)
let possiblePlanet = Planet1(rawValue: 7)
//并非所有 Int 值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员
// possiblePlanet 类型为 Planet? 值为 Planet.Uranus
//:原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。
let positionToFind = 9
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind).")
}

//:#### 递归枚举Recursive Enumerations
//:递归枚举(recursive enumeration)是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
//下面的例子中，枚举类型存储了简单的算术表达式:
//enum ArithmeticExpression {
//    case Number(Int)
//    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case Multiplication(ArithmeticExpression,ArithmeticExpression)
//}

indirect enum ArithmeticExpression {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))

func evaluate(expression: ArithmeticExpression) -> Int{
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(expression: left) + evaluate(expression: right)
    case .Multiplication(let left, let right):
        return evaluate(expression: left) * evaluate(expression: right)
    }
}
print(evaluate(expression: product))
