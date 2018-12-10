import UIKit
//: ## 析构过程(Deinitialization)
//:析构器实践
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")
//: ## 自动引用计数(Automatic Reference Counting
//: **自动引用计数的工作机制**\
//:无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。
//:自动引用计数实践
class Person0 {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person0?
var reference2: Person0?
var reference3: Person0?
reference1 = Person0(name: "EN: John Appleseed")
reference2 = reference1
reference3 = reference1
//现在这一个 Person 实例已经有三个强引用了。
reference1 = nil
reference2 = nil
reference3 = nil
//: #### 类实例之间的循环强引用
//:你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题。
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}
/*:
 ```
class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}
 ```*/
/*:
 ```
var john: Person?
var unit4A: Apartment?
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john
john = nil
unit4A = nil
 ```*/
//: #### 解决实例之间的循环强引用
//:**弱引用(weak reference)和无 主引用(unowned reference)**\
//:弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。\
//:对于生命周期中会变为 nil 的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为 nil 的实例，使用无主引用。\
//:声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用
//: - callout(注意):
//:弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。\
//:因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型。\
//:ARC会在引用的实例被销毁后自动将其赋值为nil
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john: Person?
var unit4A: Apartment?
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john
john = nil
unit4A = nil
/*:
 > 注意: 在使用垃圾收集的系统里，弱指针有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃 圾收集时才被销毁。但是在 ARC 中，一旦值的最后一个强引用被移除，就会被立即销毁，这导致弱引用并不适 合上面的用途。\
 > 和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型(non-optional type)。你可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。\
 > ARC无法在实例被销毁后将无主引用设为 nil ，因为非可选类型的变量不允许被赋值为 nil 。*/
//: - callout(注意): 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终 指向一个未销毁的实例。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
var joh: Customer?
joh = Customer(name: "Joh App")
joh!.card = CreditCard(number: 1234_4567_3456, customer: joh!)
//由于再也没有指向 Customer 实例的强引用，该实例被销毁了。其后，再也没有指向 CreditCard 实例的强引 用，该实例也随之被销毁了:
joh = nil
//: #### 无主引用以及隐式解析可选属性
//:存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil 。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
//这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用
class Country {
    let name: String
    var capitalCity:City!   //将 Country的capitalCity 属性声明为隐式解析可选类型的属性
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
//: #### 闭包引起的循环强引用
//: **闭包捕获列表 (closure capture list)**
class HTMLElement {
    let name: String
    let text: String?
    //在默认的闭包中可以使用 self ，因为只有当初始化完成以及 self 确实存在后，才能访问 lazy 属性。
    lazy var asHTML:() ->String = {
        //无主引用
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name)/>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
//可以像实例方法那样去命名、使用 asHTML 属性。然而，由于 asHTML 是闭包而不是实例方法，如果你想改变特定 HTML 元素的处理方式的话，可以用自定义的闭包来取代默认值。
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
//// 打印 "<h1>some default text</h1>"
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil
//: #### 解决闭包引起的循环强引用
//:捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。
//: - callout(注意):
//:Swift有如下要求:只要在闭包内使用self的成员，就要用self.someProperty 或者 self.someMethod()(而不只是someProperty或someMethod())。这提醒你可能会一不小心就捕获了self。

//: **定义捕获列表**\
//:捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用(例如self)或初始化过的变量(如delegate = self.delegate!)。这些项在方括号中用逗号分开。\
//:如果闭包有参数列表和返回类型，把捕获列表放在它们前面:
/*:
 ```
lazy var someClosure:(Int,String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    //这里是闭包的函数体
}
```*/
/*:
 ```
 如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包 最开始的地方:
 lazy var someClosure: () -> String = {
         [unowned self, weak delegate = self.delegate!] in // 这里是闭包的函数体
 }
 ```*/
//:**弱引用和无主引用**\
//:在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。\
//:在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用 。弱引用总是可选类型，并且当引用 的实例被销毁后，弱引用的值会自动置为 nil 
//:如果被捕获的引用绝对不会变为 nil ，应该用无主引用，而不是弱引用。

