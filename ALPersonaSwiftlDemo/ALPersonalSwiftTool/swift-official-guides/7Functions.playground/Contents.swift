import UIKit
//: # 函数
//: #### 函数的定义与调用（Defining and Calling Functions）
func greet(person: String) -> String{
    //let greeting = "Hello, " + person + "!"
    //return greeting
    return "Hello, " + person + "!"
}
print(greet(person: "Anna"))

//:#### 函数参数与返回值(Function Parameters and Return Values)
//: 无参数函数(Functions Without Parameters)
func  sayHelloWorld() -> String{
    return "Hello, world!"
}
print(sayHelloWorld())
//:多参数函数(Functions With Multiple Parameters)
func greet(person: String, alreadyGreeted: Bool) ->String{
    if alreadyGreeted {
        //return greetAgain(person: person)
        return sayHelloWorld()
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
//:无返回值函数(Functions Without Return Values)
//: - callout(Note):默认返回一个特殊的void值，它其实是一个空的元组tuple，没有任何元素
func greet1(person: String){
    print("Hello, \(person)!")
}
greet1(person: "Dave")
//: - callout(Note):被调用时，一个函数的返回值可以被忽略
func printAndCount(string: String) -> Int{
    print(string)
    return string.count
    //return string.characters.count
}
func printWithoutCounting(string: String){
    //若定义了有返回值的函数必须返回一个值，若没有。。。。
    let _ =  printAndCount(string: string)
}
printAndCount(string: "hello, world1")
printWithoutCounting(string: "hello, world2")
//:多重返回值函数（Functions with Multiple Return Values)
func minMax(array: [Int]) -> (min: Int, max: Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax{
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
//:可选元组返回类型optional tuple return types
//: - callout(注意):可选元组类型如（Int，Int）`？`与元组包含可选类型如（Int`？`，Int`？`）是不同的。可选的元组类型，整个元组都是可选的，而不只是元组中的每个元素值
func minMax1(array: [Int]) -> (min: Int, max: Int)?{
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax{
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = minMax1(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
//:函数参数标签和参数名称(Function Argument Labels and Parameter Names)
func greet(person: String, from hometown: String) ->String{
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
//:忽略参数标签Omitting Argument Labels
func someFuntion(_ firstParameterName: Int, secondParameterName: Int){
    //如果一个参数有一个标签，那么在调用的时候必须使用标签来标记这个参数
}
someFuntion(1, secondParameterName: 2)
//:默认参数值default parameter values
func someFunction1(parameterWithoutDefault: Int, parameterWithDefault: Int = 12){
    //
}
someFunction1(parameterWithoutDefault: 4)
someFunction1(parameterWithoutDefault: 3,parameterWithDefault: 6)
//:可变参数Variadic Parameters  
//一个函数最多只能拥有一个可变参数
func arithmeticMean(_ numbers: Double...) -> Double{
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1,2,3,4,5)
arithmeticMean(3,8.25,18.75)
//:#### 输入输出参数In-Out Parameters  
//: - callout(Note):输入输出参数不能有默认值，而且可变参数不能有inout标记
//函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。

func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
    
}
var someInt = 3
var anotherInt = 107
//当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
//:#### 函数类型Function Types
func addTwoInts(_ a: Int, _ b: Int) -> Int{
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int{
    return a * b
}
func printHelloWorld(){
    print("hello, world")
}
//:Using Function Types
//: - 定义一个类型为函数的常量或变量，并将适当的函数赋值给它
var mathFunction: (Int,Int) -> Int = addTwoInts
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2,3))")
let anotherMathFuciton = addTwoInts
// anotherMathFunction 被推断为 (Int, Int) -> Int 类型

//: - 函数类型作为参数类型Function types as parameter types
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a : Int,_ b: Int){
    print("Result: \(mathFunction(a,b))")
}
printMathResult(mathFunction, 3, 5)
//: - 函数类型作为返回类型function types as return types
func stepForward(_ input: Int) -> Int{
    return input + 1
}
func stepBackward(_ input: Int) -> Int{
    return input - 1
}
//它的返回类型是 (Int) -> Int 类型的函数。
func chooseStepFunction(backward: Bool) -> (Int) -> Int{
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
//:### 嵌套函数Nested Functions  外围函数enclosing function
func chooseStepFunction1(backward: Bool) -> (Int) -> Int{
    func stepForward(_ input: Int) -> Int{
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int{
        return input - 1
    }
    return backward ? stepBackward : stepForward
}
var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(backward: currentValue > 0)
print("Counting to zero:")
while currentValue1 != 0 {
    print("\(currentValue1)...")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("zero!")


//: # 闭包（Closures)
//:闭包是自包含的函数代码块\
//:闭包可以捕获和存储其所在上下文中任意常量和变量的引用。Swift会为你管理在捕获过程中涉及到的所有内存操作。\
//:全局函数是一个有名字但不会捕获任何值的闭包。\
//:嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包\
//:闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
//: ### 闭包表达式closure expressions
/*
 利用上下文推断参数和返回值类型
 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
 参数名称缩写
 尾随闭包语法
 */


//sorted方法（The Sorted Method）返回正确排序的新数组，原数组不会被该方法修改
let names = ["Chris","Alex","Ewa","Barry","Daniella"]
//sorted(by:)方法接受一个闭包
func backward(_ s1: String, _ s2 : String) -> Bool{
    return s1 > s2
}
var reversedNames = names.sorted(by:backward)
//:### 闭包表达式语法closure expression syntax
/*:
>{(parameters) -> returnType in\
>             statements\
>}\
>元组可以作为参数和返回值，闭包表达式的参数可以是inout参数，亦可以使用同名的可变参数（需放在参数列表的最后一位）*/
reversedNames = names.sorted(by:{(_ s1: String, _ s2 : String) -> Bool in
    return s1 > s2
})
//:根据上下文推断类型Inferring type from context
reversedNames = names.sorted(by:{ s1 , s2 in return s1 > s2 })
//Shorthand Argument Names
//reversedNames = names.sorted(by: { $0 > $1 } )
//Here, $0 and $1 refer to the closure’s first and second String arguments.

//Operator Methods
//reversedNames = names.sorted(by: >)
//: - 单表达式闭包隐式返回（Implicit returns from single-expression closures
reversedNames = names.sorted(by:{ s1 , s2 in s1 > s2 })
//: - 参数名称缩写shorthand argument names
//: - swift自动为内联闭包提供了参数名称缩写功能，可以直接通过$0,$1,...来顺序调用闭包的参数
reversedNames = names.sorted(by:{$0 > $1})
//: - 运算符方法Operator Methods
reversedNames = names.sorted(by:>)
//: ### 尾随闭包trailing closures
//:书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。
/*:
 ```
func someFunctionThatTakesAClosure(closure:()->void){
    function body
}
```
 */
//:以下是不使用尾随闭包进行函数调用
/*:
 ```
someFunctionThatTakesAClosure(closure:{
    闭包主体部分
})
 ```*/
//:以下是使用尾随闭包进行函数调用
/*:
 ```
someFunctionThatTakesAClosure(){
闭包主体部分
}
 ```*/
//:sorted(by:)方法参数的字符串排序闭包可以改写为
reversedNames = names.sorted(){
    $0 > $1
}
//若闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，可以省略（）
reversedNames = names.sorted{ $0 > $1 }

//在map（_：）方法中使用尾随闭包将Int类型数组转换为包含对于String类型值的数组
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map{
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
//: - callout(注意):字典digitNames下标后跟着一个！，因为字典下标返回一个可选值，可以确定number % 10总是字典的有效下标，因此！可以用于强制解包fore-unwrap存储在下标的可选类型的返回值中的String类型的值
//: ### Capturing Values值捕获
//:闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包任然可以在闭包函数体内引用和修改这些值
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {//从外围函数捕获amount、amount引用，保证了amount、amount在调用完makeIncrementer后不会消失，并且保证在下一次执行incrementer函数时，runningTotal依旧存在
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
//: - callout(注意):为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift可能会捕获并保存了一份对值的拷贝。Swift会负责被捕获变量的所有内存管理工作
let incremenByTen = makeIncrementer(forIncrement: 10)
incremenByTen()
incremenByTen()
incremenByTen()
//如果你创建了另一个incrementor，它会有属于自己的引用，指向一个全新、独立的runningTotal变量
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incremenByTen()
//:如果你将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，你将在闭包和该实例间创建一个循环强引用。Swift 使用捕获列表来打破这种循环强引用。\
//:闭包是引用类型Closures are reference types\
//:函数和闭包都是引用类型。\
//:如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包:
let alsoIncrementByTen = incremenByTen
alsoIncrementByTen()
//:### 逃逸闭包escaping closures
//:当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。\
//:一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。
var completionHandlers:[() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler : @escaping () -> Void){
    completionHandlers.append(completionHandler)
}
//:将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用self\
//:相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用self
func someFunctionWithNonescapingClosure(closure: () -> Void){
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)
//:### 自动闭包Autoclosures
//:自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。\
//:举个例子来说，assert(condition:message:file:line:) 函数接受自动闭包作为它的 condition 参数和 message 参数;它的 condition 参数仅会在 debug 模式下被求值，它的 message 参数仅当 condition 参数为 false 时被计算求值。\
//:自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
let customerProvider = {customersInLine.remove(at: 0)}
print(customersInLine.count)
print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: {customersInLine.remove(at: 0)})
//:通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数(而非闭包)的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性
func serve(customer customerProvider: @autoclosure () -> String){
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//: - callout(注意):过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟 执行的。
//:如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性.
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String){
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
