//: ## 下标(Subscripts)
//:下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。
/*:
 ```
 subscript(index: Int) -> Int {
     get {
     // 返回一个适当的 Int 类型的值 }
     set(newValue) {
     // 执行适当的赋值操作
     } 
 }
 
 
 subscript(index: Int) -> Int {
 // 返回一个适当的 Int 类型的值
 }
 ```
 */
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
//:下标用法
var numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 4]
numberOfLegs["bird"] = 2
/*:
 >**注意**
 >Swift 的 Dictionary 类型的下标接受并返回可选类型的值。上例中的 numberOfLegs 字典通过下标返回的是一个
 Int? 或者说“可选的int”。 Dictionary 类型之所以如此实现下标，是因为不是每个键都有个对应的值，同时这也提供了一种通过键删除对应值的方式，只需将键对应的值赋值为 nil 即可。
*/
//:下标选项\
//:`下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。`\
//:下标的重载
struct Matrix {
    let rows:Int, columns:Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValidForRow(row: Int , column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int ,column: Int) -> Double{
        get{
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,0] = 3.2
//let someValue = matrix[2,2]
//// 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
//: # 继承(Inheritance)
//:在 Swift 中，继承是区分「类」与其它类型的一个基本特征。\
//:可以为类中继承来的属性添加属性观察器(property observers)\
//:**定义一个基类(Defining a Base Class)**
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //nothing to do
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
//:**子类生成(Subclassing)**
/*
 class SomeClass: SomeSuperclass { // 这里是子类的定义
 }
 */
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentSpeed = 22.0
tandem.currentNumberOfPassengers = 2
print("Tandem: \(tandem.description)")
//:**重写(Overriding)**\
//:子类可以为继承来的实例方法(instance method)，类方法(class method)，实例属性(instance propert y)，或下标(subscript)提供自己定制的实现(implementation)。我们把这种行为叫重写(overriding)。任何缺少override关键字的重写都会在编译时被诊断为错误。\
//:访问超类的方法，属性及下标\
//:在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。\
//:[重写方法](license)
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()
//:[重写属性](license)\
//:你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
//: - callout(注意):如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改 继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属性的名字。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
//:**重写属性观察器(Property Observer)**
//: - callout(注意):你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现是不恰当。\
//:此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已 经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
class AutomaticCar: Car {
    override var currentSpeed: Double{
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
//:**防止重写**\
//:你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可(例如: final var，final func，final class func，以及final subscript)。\
//:在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。\
//:你可以通过在关键字class前添加final修饰符(final  class)来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。

//: ## 构造过程(Initialization)
//:构造过程是使用类、结构体或枚举类型的实例之前的准备过程。\
//:存储属性的初始赋值(类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。)
//: - callout(注意): 当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者( property observers )。

//:构造器
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit") //华氏温度
//:默认属性值
//它也能让你充分利用默认构造器、构造器继承等特性
struct Fahrenheit1 {
    var temperature = 32.0
}
//:自定义构造过程
//构造参数
struct Celsius0 {
    var temperatureInCelsius: Double
    init(fromFahreheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius0(fromFahreheit: 212.0)
let freezingPointOfWater = Celsius0(fromKelvin: 273.15)
//:参数的内部名称和外部名称
//如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
struct Color {
    let red, green, blue: Double
    init(red:Double, green: Double, blue:Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
//注意，如果不通过参数标签传值，你是没法调用这个构造器的。只要构造器定义了某个参数标签，你就必须使用它，忽略它将导致编译错误：
//let veryGreen = Color(0.0, 1.0, 0.0)  //error
// 报编译时错误，需要外部名称
//:不带外部名的构造器参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
    init() {
        temperatureInCelsius = 0
        print("The default temperatureInCelsius is \(temperatureInCelsius)")
    }
}
let bodyTemperature = Celsius(37.0)
//:可选属性类型
//如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为 可选类型。可选类型的属性将自动初始化为 nil，表示这个属性是有意在初始化时设置为空的。
class SurveyQuestion0 {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion0(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
//:构造过程中常量属性的修改
//: - callout(注意): 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I do like beets. (But not with cheese.)"
//: #### 默认构造器
//:如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器(default initializers)
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
//: #### 结构体的逐一成员构造器
//:如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
//: #### 值类型的构造器代理
//:构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
/*:
>注意:
>假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展( extension )中，而不是写在值类型的原始定义中。
*/
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
//: ### 类的继承和构造过程
//:类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。\
//:`指定构造器和便利构造器`\
//:指定构造器(designated initializers)是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。\
//:每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。
//:`便利构造器(convenience initializers)`\
//:[指定构造器和便利构造器的语法](license)
/*:
 ```
 init(parameters) {
     statements
 }
 convenience init(parameters) {
     statements
 }
 ```*/

//: ### 类的构造器代理规则
/*:
 > 规则 1 指定构造器必须调用其直接父类的的指定构造器。\
 > 规则 2 便利构造器必须调用同一类中定义的其它构造器。\
 > 规则 3 便利构造器必须最终导致一个指定构造器被调用。\
 > 指定构造器必须总是向上代理 • 便利构造器必须总是横向代理*/
var sayHello: String? = "Say hello!"
//: **两段式构造过程**\
//: 第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
/*:
 > 安全检查 1 指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。\
 > 安全检查 2 指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。\
 > 安全检查 3 便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。\
 > 安全检查 4 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。
 */
//:**构造器的继承和重写**\
//:父类的构造器仅会在安全和适当的情况下被继承。跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。\
//:当你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上 override 修饰符。\
//:由于子类不能直接调用父类的便利构造器,你在子类中“重写”一个父类便利构造器时，不需要加 override 前缀。
//相反，如果你编写了一个和父类便利构造器相匹配的子类构造器，由于子类不能直接调用父类的便利构造器（每个规则都在上文类的构造器代理规则有所描述），因此，严格意义上来讲，你的子类并未对一个父类构造器提供重写。最后的结果就是，你在子类中“重写”一个父类便利构造器时，不需要加 override 修饰符。

class Vehicle1 {
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) wheel(s)"
    }
}
//:自动获得的默认构造器总会是类中的指定构造器
let vehicle = Vehicle()
print("Vehicle1: \(vehicle.description)")
class Bicycle1: Vehicle1 {
    override init() {  //自定义指定构造器init()
        super.init()
        numberOfWheels = 2   //子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
    }
}
let bicycle1 = Bicycle1()
print("Bicycle1: \(bicycle.description)")
//: ### 构造器的自动继承
/*:
 > 规则 1 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。\
 > 规则 2 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。\
 > 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。\
 注意:\
 对于规则 2，子类可以将父类的指定构造器实现为便利构造器。
 */
//指定构造器和便利构造器实践
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    //注意， RecipeIngredient的便利构造器 init(name: String)使用了跟 Food 中指定构造器init(name: String)相同的参数。由于这个便利构造器重写了父类的指定构造器，因此必须在前面使用override
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    //尽管RecipeIngredient将父类的指定构造器重写为了便利构造器，它依然提供了父类的所有指定构造器的实现.RecipeIngredient会自动继承父类的所有便利构造器。
    //这个继承版本的init()在功能上跟Food提供的版本是一样的，只是它会代理到RecipeIngredient版本的init(name: String) 而不是Food提供的版本
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
//由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器， ShoppingListItem 将自动继承所有父类中的指定构造器和便利构造器。
var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6),]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
//: ### 可失败构造器
//:可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//: - callout(注意): 严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用 return nil 表明可失败构造器构造失败，而不要用关键字 return 来表明构造成功。
print("=====================================")
//例如，实现针对数字类型转换的可失败构造器。确保数字类型之间的转换能保持精确的值，使用这个 init(exactly:) 构造器。如果类型转换不能保持值不变，则这个构造器构造失败。
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}
// Prints "3.14159 conversion to Int does not maintain value"

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal?, 而不是 Animal
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
//空字符串(如 "" ，而不是 "Giraffe" )和一个值为 nil 的可选类型的字符串是两个完全不同的概念。上例中的空字符串( "" )其实是一个有效的，非可选类型的字符串。
//: **枚举类型的可失败构造器**
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
//:带原始值的枚举类型的可失败构造器\
//:带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
//:**构造失败的传递**\
//:类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
//: - callout(注意): 可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name:String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}


if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
//:**重写一个可失败构造器**
/*:
 如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。\
 注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。\
 注意:
 你可以用非可失败构造器重写可失败构造器，但反过来却不行。
 */
class Document {
    var name: String?
    init(){}
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

class AutuomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name:String){
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init(){
        //你可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器。
        super.init(name: "[Untitled]")!
    }
}
//: **可失败构造器 init!**
/*:
 也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器( init! )，该可失败构造器将会构建一个对应类型的隐式解 包可选类型的对象。
 你可以在 init? 中代理到 init! ，反之亦然。你也可以用 init? 重写 init! ，反之亦然。你还可以用 init 代理 到 init! ，不过，一旦 init! 构造失败，则会触发一个断言。
 */
//:**必要构造器**
/*:
 ```
 class SomeClass {
     required init() {
     // 构造器的实现代码 }
 }
 //在重写父类中必要的指定构造器时，不需要添加 override 修饰符:
 class SomeSubclass: SomeClass {
     required init() {
     // 构造器的实现代码 }
 }
 //注意
 如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
 ```*/
//: #### 通过闭包或函数设置属性的默认值
/*:
 ```
 class SomeClass {
     let someProperty: SomeType = {
         // 在这个闭包中给 someProperty 创建一个默认值 
         // someValue 必须和 SomeType 类型相同
         return someValue
     }()
 }
 ```*/
//: - 注意 闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包
//: - 注意 如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包 里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
struct Checkerboard {
    let boardColors:[Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8{
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
        }
        isBlack = !isBlack
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(row: 0, column: 1))
print(board.squareIsBlackAtRow(row: 7, column: 6))

