/*: # 类和结构体*/
//: ## 定义语法
/*:
 ```
 class SomeClass {
 // class definition goes here
 }
 struct SomeStructure {
 // structure definition goes here
 }
 ```*/
//: - callout(注意):在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。因此请使用UpperCamelCase 这种方式来命名(如 SomeClass 和 SomeStructure 等)，以便符合标准 Swift 类型的大写命名风格(如 String ， Int 和 Bool )。相反的，请使用 lowerCamelCase 这种方式为属性和方法命名(如 framerate 和 incrementCount )，以便和类型名区分。
struct Resolution{
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
//:存储属性是被捆绑和存储在类或结构体中的常量或变量。当这两个属性被初始化为整数 0 的时候，它们会被推断为 Int 类型。
//类和结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()
//:属性访问
//:通过使用点语法(dot syntax)，你可以访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者通过点号( . )连接:
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
//:与 Objective-C 语言不同的是，Swift 允许直接设置结构体属性的子属性。
//:结构体类型的成员逐一构造器(Memberwise Initializers for Structure Types)
let vga = Resolution(width: 640, height: 480)
//:与结构体不同，类实例没有默认的成员逐一构造器。
//:结构体和枚举是值类型
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
//:类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//:改变的是被引用的 VideoMode 的 frameRate 属 性，而不是引用 VideoMode 的常量的值。
//: #### 恒等运算符
//:运用这两个运算符(=== !==)检测两个常量或者变量是否引用同一个实例:
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
//指针
//:类和结构体的选择
//:结构体实例总是通过值传递，类实例总是通过引用传递。
//字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
/*: ## 属性Properties*/
//:计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。\
//:存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属性。
//存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//常量结构体的存储属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6
//:如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行!\
//:这种行为是由于结构体(struct)属于值类型。\
//:延迟存储属性:是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存 储属性。
//: - callout(注意):必须将延迟存储属性声明成变量(使用 var 关键字)，因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//DataImporter 实例的 importer 属性还没有被创建
print(manager.importer.fileName)
//:如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
//: #### 存储属性和实例变量
//:计算属性
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect{
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
        //便捷的setter
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//:只读计算属性
//必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明 常量属性，表示初始化后再也无法修改的值。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
//: #### 属性观察器
//:属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。\
//:可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性(包括存储属性和计算属性)添加属性观察器。\
//:[父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。](license)
class StepCounter {
    var totalSteps: Int = 0{
        willSet(newTotalSteps){
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
//:如果将属性通过 in-out 方式传入函数，willSet 和 didSet 也会调用。这是因为 in-out 参数采用了拷入拷出模式:即在函数内部使用的是参数的 copy，函数结束后，又对参数重新赋值
//: ### 全局变量和局部变量
//:在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器\
//:全局的常量或变量都是延迟计算的，局部范围的常量或变量从不延迟计算。\
//:[类型属性-类型属性用于定义某个类型所有实例共享的数据](license)
//: - callout( ):必须给存储型类型属性指定默认值，存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
//: #### 类型属性语法
//:使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
//获取和设置类型属性的值
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
                //在第一个检查过程中，didSet 属性观察器将 currentLevel 设置成了不同的值，但这不会造成属性观察器被再次调用。
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
/*: ## 方法methods*/
//: #### 实例方法 (Instance Methods)
//:实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.incrementBy(amount: 5)
counter.reset()
//:方法的局部参数名称和外部参数名称 (Local and External Parameter Names for Methods)\
//:Swift默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称局部参数名称和外部参数名称。
class Counter1 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counter1 = Counter1()
counter1.incrementBy(amount: 5, numberOfTimes: 3)
//:修改方法的外部参数名称(Modifying External Parameter Name Behavior for Methods)\
//:[self 属性(The self Property)](license)
/*
 上面例子中的 increment 方法还可以这样写:
 func increment() {
 self.count += 1
 }
 */
//:使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候
//下面的例子中， self 消除方法参数 x 和实例属性 x 之间的歧义
struct Point1 {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool{
        return self.x > x
        //如果不使用 self 前缀，Swift 就认为两次使用的 x 都指的是名称为 x 的函数参数。
    }
}
let somePoint = Point1(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
//:[在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)](license)\
//:_默认情况下，值类型的属性不能在它的实例方法中被修改。_\
//:_如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating) 行为，然后就可以从其方法内部改变它的属性;并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。_
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
//该方法被调用时修改了这个点，而不是返回一个新的点。
//: - callout(注意):不能在结构体类型的常量(a constant of structure type)上调用可变方法，因为其属性不能被改变，即使属性是变量属性
let fixedPoint = Point(x: 3.0, y: 3.0)
//: - experiment:fixedPoint.moveByX(2.0, y: 3.0)\
//:这里将会报告一个错误

//:**[在可变方法中给 self 赋值(Assigning to self Within a Mutating Method)](license)**
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double){
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}
//枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员
enum TriStateSwitch{
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()
//: #### 类型方法 (Type Methods)
//:在 Objective-C 中，你只能为 Objective-C 的类类型(classes)定义类型方法(type-level methods)。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
class SomeClass1{
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass1.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(level: Int) ->Bool{
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool{
        if LevelTracker.levelIsUnlocked(level: level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level: level + 1)
        tracker.advanceToLevel(level: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
var player = Player(name: "Argyrios")
player.completedLevel(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(level: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
