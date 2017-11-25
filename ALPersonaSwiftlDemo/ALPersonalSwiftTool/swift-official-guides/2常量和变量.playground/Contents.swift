import UIKit
//: ### 申明常量和变量
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
var x = 0.0, y = 0.0, z = 0.0

//: - callout(Note):类型标注type annotation
var welcomeMessage: String
welcomeMessage = "Hello"
var red, green, blue: Double

//: - callout(Note):常量和变量的命名
let π = 3.14159
let 你好 = "你好世界"
let  🐶🐮 = "dogcow"
//: - callout(注意):常量一旦申明为确定的类型，就不能改变其存储值的类型，也不能将常量和变量进行互转

var friendlyWelcome = "Hello"
friendlyWelcome = "Bonjour!"

let languageName = "Swift"
//languageName = "Swift++"

//: - callout(Note):常量输出常量和变量
print(friendlyWelcome)
print(friendlyWelcome, terminator: "")
print(friendlyWelcome, terminator: "\n")

//Swift用字符串插值(string interpolation)
print("The current value of friendlyWelocme is \(friendlyWelcome)")
//:### 注释
//: - callout(Note):\
//:  /`*`这是一个多行注释\
//:  /`*` 可以嵌套多行注释`*`/\
//:  `*`/
//:### 分号
let cat = "🐱"; print(cat)
//:### 整数
let minValue = UInt8.min
let maxValue = UInt8.max
//: - callout(Note):尽量不要使用UInt，最好使用Int。统一使用Int可以提高代码的可复用性，避免不同类型数字之间的转换，并且匹配数字的类型推断

//:### 浮点数
//:### 类型安全和类型推断
let meaningOfLife = 42
let pi = 3.14159
let anotherPi = 3 + 0.14159
//:### 数值型字面量
let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11
//:- callout(Note):
/*:
 >0xFp2  相当于15 * 2 ^2\
 >0xFp-2 相当于15 * 2 ^ -2
 */
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//:### 数值型类型转换
//: - callout(Note):整数转换
//let cannotBeNegative: UInt8 = -1
//let tooBig: Int8 = Int8.max + 1

let twoThousand: UInt16 = 2_000
let one: UInt16 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
//调用UInt16(one)来创建一个新的UInt16数字并用one的值来初始化

//: - callout(Note):整数和浮点数转换
let three = 3
let pointOneFourOneFiveNine = 0.14159
let dPi = Double(three) + pointOneFourOneFiveNine
//结合数字类常量和变量不同于结合数字类字面量
let integerPi = Int(dPi)

//:### 类型别名 type aliases
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

//:### 布尔值
let orangesAreOrange = true
let trunipsAreDelicious = false
if trunipsAreDelicious {
    print("Mmm, tasty turnips!")
}else{
    print("Eww, turnips are horrible.")
}
/*:
>let i = 1\
>if i {\
>      “这个例子不会通过编译，会报错”\
>}
*/
let i = 1
if i == 1 {
    //
}
//:### 元组tuples
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")
//: - callout(Note):只需元组的一部分，分解的时候可以把要忽略的部分用下划线_标记
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")
//给定义元组的单个元素命名
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

//:### 可选类型
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// nil不能用于非可选的常量和变量,nil不是指针，它是一个确定的值
var serverResponseCode: Int? = 404
//serverResponseCode包含一个可选的Int值404
serverResponseCode = nil
//serverResponseCode现在不包含值
var surveyAnswer: String?
//: - callout(Note):if语句以及强制解析(当你知道可选类型确实包含值之后)
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
/*: - callout(Note):可选绑定optional binding来判断可选类型是否包含值\
>if let constantName = someOptional{\
    //statements\
>}
 */
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
}else{
    print("\'\(possibleNumber)\' could not be an integer")
}

if let firstNumber = Int("4"),let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100{
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

/*:
 >隐式解析可选类型implicitly unwrapped optionals\
>把想要用作可选的类型的后面的问号改成感叹号来申明一个隐式解析可选类型
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString

if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}


//:### 错误处理error handling
func canThrowAnError() throws{
    //statement
}
do {
    try canThrowAnError()
} catch{
    //
}

func makeASandwich() throws{
    //...
}

do {
    try makeASandwich()
    //eateASandwich()
} catch{
    //...
}

//:### 断言
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")
