import UIKit
//: ## 嵌套类型
//: ### 嵌套类型实践
struct BlackjackCard {
    //嵌套的Suit枚举
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    //嵌套的Rank枚举
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack,.Queen,.King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //BlackjackCard 的属性和方法
    let rank:Rank,suit:Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
//: ### 引用嵌套类型
//在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
let rankSymbol = BlackjackCard.Rank.Ace.rawValue
let valuesSymbol = BlackjackCard.Rank.Two.values.first

//扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
//: ## 拓展（Extensions）
//: - 添加计算型属性和计算型类型属性
//: - 定义实例方法和类型方法
//: - Provide new initializers
//: - 定义下标
//: - 定义和使用新的嵌套类型
//: - 使一个已有类型符合某个协议\
//: 在 Swift 中，你甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些功能。
//: - callout(注意): 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
//: ### 扩展语法
/*:
```
 extension SomeType {
 // 为 SomeType 添加的新功能写到这里
 }
 extension SomeType: SomeProtocol, AnotherProctocol {
 // 协议实现写到这里
 }
 ```
 */
//: ### 计算型属性

//扩展可以为已有类型添加计算型实例属性和计算型类型属性。
extension Double{
    var km:Double {return self * 1_000.0}
    var m: Double {return self}
    var cm: Double { return self / 100.0}
    var mm: Double {return self / 1_0000.0}
    var ft: Double {return self / 3.28084}
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meter long")

/**扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。*/
//: - callout(注意): 如果你通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有已有实例都是可用的，即使它们是在这个扩展定义之前创建的。
//: ### 构造器

/*:
 >-扩展可以为已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项。
 >-扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
 */

//: - callout(注意): 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。

struct Size{
    var width = 0.0,height = 0.0
}
struct Point{
    var x = 0.0,y=0.0
}
struct Rect{
    var origin = Point()
    var size = Size()
}
//因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x:2.0,y:2.0), size: Size(width: 5.0, height: 5.0))
extension Rect{
    init(center: Point,size:Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:Point(x: originX, y: originY),size:size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
//如果你使用扩展提供了一个新的构造器，你依旧有责任确保构造过程能够让实例完全初始化。
//: ### 方法
extension Int {
    func repetitions(task:() -> Void){
        for _ in 0..<self {
            task()
        }
    }
}
//: 这个 repetitions(task:) 方法接受一个 () -> Void 类型的单参数，表示没有参数且没有返回值的函数。
3.repetitions{
    print("Hello!")
}
//: **可变实例方法**
//通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating，正如来自原始实现的可变方法一样。
extension Int{
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
//: ### 下标
extension Int{
    subscript(digitIndex: Int) -> Int{
        var decimalBase = 1
        for _ in 0..<digitIndex{
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[8]
746381295[9]
// returns 0, as if you had requested:
//如果该 Int 值没有足够的位数，即下标越界，那么上述下标实现会返回 0，犹如在数字左边自动补 0
0746381295[9]

//: ### 嵌套类型
//扩展可以为已有的类、结构体和枚举添加新的嵌套类型：
extension Int{
    enum Kind {
        case Negative,Zero,Positive
    }
    var kind: Kind{
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func printIntegerKinds(_ numbers:[Int]){
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ",terminator:"")
        case .Zero:
            print("0 ",terminator:"")
        case .Positive:
            print("+ ",terminator:"")
        }
    }
    print("")
}
printIntegerKinds([3,19,-27,0,-6,0,7])





