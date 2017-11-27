import UIKit
//: ## Memory Safety - 4.0

//: #### Understanding Conflicting Access to Memory
// A write access to the memory where one is stored.
var one = 1
// A read access from the memory where one is stored.
print("We're number \(one)!")
//: Characteristics of Memory Access
func oneMore(than number: Int) -> Int {
    return number + 1
}
var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
//: ### Conflicting Access to In-Out Parameters
var stepSize = 1
func incrementInPlace(_ number: inout Int) {
    number += stepSize
}
incrementInPlace(&stepSize)
// Error: conflicting accesses to stepSize
//One way to solve this conflict is to make an explicit copy of stepSize:
//: - callout(注意): Make an explicit copy.
var copyOfStepSize = stepSize
incrementInPlace(&copyOfStepSize)
// Update the original.
stepSize = copyOfStepSize
// stepSize is now 2

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)  // OK
//balance(&playerOneScore, &playerOneScore)
// Error: Conflicting accesses to playerOneScore
//: ### Conflicting Access to self in Methods
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}
var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
////oscar.shareHealth(with: &oscar)
// Error: conflicting accesses to oscar
//: ### Conflicting Access to Properties
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// Error: conflicting access to properties of playerInformation

var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)  // Error

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}
//: ## 访问控制
//: ### 模块和源文件
//: 模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
//: ### 访问级别
//: **访问级别基本原则**
//: Swift 中的访问级别遵循一个基本原则：不可以在某个实体中定义访问级别更低（更严格）的实体。
//: - 一个公开访问级别的变量，其类型的访问级别不能是内部，文件私有或是私有类型的。因为无法保证变量的类型在使用变量的地方也具有“访问权限。
//: - 函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
//: **默认访问级别**
//: 如果你不为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。
//: ### 访问控制语句
/*:
 ```
 public class SomePublicClass {}
 internal class SomeInternalClass {}
 fileprivate class SomeFilePrivateClass {}
 private class SomePrivateClass {}
  
 public var somePublicVariable = 0
 internal let someInternalConstant = 0
 fileprivate func someFilePrivateFunction() {}
 private func somePrivateFunction() {}
 ```*/
//: ### 自定义类型
/*:
 ```
 public class SomePublicClass {                  // 显式公开类
 public var somePublicProperty = 0            // 显式公开类成员
 var someInternalProperty = 0                 // 隐式内部类成员
 fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
 private func somePrivateMethod() {}          // 显式私有类成员
 }
  
 class SomeInternalClass {                       // 隐式内部类
 var someInternalProperty = 0                 // 隐式内部类成员
 fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
 private func somePrivateMethod() {}          // 显式私有类成员
 }
  
 fileprivate class SomeFilePrivateClass {        // 显式文件私有类
 func someFilePrivateMethod() {}              // 隐式文件私有类成员
 private func somePrivateMethod() {}          // 显式私有类成员
 }
  
 private class SomePrivateClass {                // 显式私有类
 func somePrivateMethod() {}                  // 隐式私有类成员
 }
 ```*/
//: **元组类型**\
//: 元组的访问级别将由元组中访问级别最严格的类型来决定。
//: - callout(注意): 元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。

//: **函数类型**
//: 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
/*: 
 ```
 private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
 // 此处是函数实现部分
 }
 ```*/
//: - callout(注意): 将该函数指定为 public 或 internal，或者使用默认的访问级别 internal 都是错误的，因为如果把该函数当做 public 或 internal 级别来使用的话，可能会无法访问 private 级别的返回值。

//: **枚举类型**\
//: 枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
public enum CompassPoint{
    case North,South,East,West
}
//: **原始值和关联值**\
//: 枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 访问级别的枚举中定义 private 级别的原始值类型。
//: **嵌套类型** \
//: 如果在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
//: ### 子类
public class A{
    fileprivate func someMethod(){}
}
internal class B: A{
    override internal func someMethod(){
        super.someMethod()
    }
}
internal class C: A {
    override internal func someMethod() {
        super.someMethod()
    }
}
//Because superclass A and subclass C are defined in the same source file, it’s valid for the C implementation of someMethod() to call super.someMethod().

//: 可以在子类中，用子类成员去访问访问级别更低的父类成员，只要这一操作在相应访问级别的限制范围内（也就是说，在同一源文件中访问父类 fileprivate 级别的成员，在同一模块内访问父类 internal 级别的成员）
//: ### 常量、变量、属性、下标
//: 常量、变量、属性不能拥有比它们的类型更高的访问级别。
//: **Getter 和 Setter**\
//: 常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。\
//: Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限。在 var 或 subscript 关键字之前，你可以通过 fileprivate(set)，private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别。
//private var privateInstance = SomePrivateClass()

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = ""{
        didSet{
            numberOfEdits += 1
        }
    }
}
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
/*:
 ```
 public struct TrackedString {
     public private(set) var numberOfEdits = 0
     public var value: String = "" {
         didSet {
             numberOfEdits += 1
         }
     }
     public init() {}
 }
 ```*/
//: ### 构造器
//: **默认构造器**\
//: 默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器。

//: **结构体默认的成员逐一构造器**\
//: 如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。
//: ### 协议
//: - callout(注意): 协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别

//: **协议继承**\
//: 如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。

//: **协议一致性**\
//: 采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。\
//: 如果你采纳了协议，那么实现了协议的所有要求后，你必须确保这些实现的访问级别不能低于协议的访问级别。例如，一个 public 级别的类型，采纳了 internal 级别的协议，那么协议的实现至少也得是 internal 级别。
//: ### 扩展
//: 扩展成员具有和原始类型成员一致的访问级别。例如，你扩展了一个 public 或者 internal 类型，扩展中的成员具有默认的 internal 访问级别，和原始类型中的成员一致 。如果你扩展了一个 private 类型，扩展成员则拥有默认的 private 访问级别。
protocol SomeProtocol {
    func doSomething()
}
struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}
var structDemo : SomeStruct = SomeStruct();
structDemo.doSomething()

//: **通过扩展添加协议一致性**\
//: 如果你通过扩展来采纳协议，那么你就不能显式指定该扩展的访问级别了。协议拥有相应的访问级别，并会为该扩展中所有协议要求的实现提供默认的访问级别。
//: ### 泛型
//: ### 类型别名
