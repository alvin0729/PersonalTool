import UIKit

//:### 赋值运算符
let b = 10
var a = 5
a = b

let (x, y) = (1, 2)
//if x = y {
    //此句错误，因为x = y并不返回任何值
//}
//:### 算术运算符
1 + 2
5 - 3
2 * 3
10.0 / 2.5
//溢出运算符（如 a &+ b）

"hello," + "world"

//求余运算符
9 % 4
-9 % 4
//浮点数求余计算
//8.0 % 2.5

//一元负号运算符
let three = 3
let minusThree = -three
let plusThree = -minusThree

//一元正号运算符
let minusSix = -6
let alsoMinusSix = +minusSix

//:### 组合赋值运算符
var a1 = 1
a1 += 2

//:### 比较运算符(Comparison Operators)
let name = "world"
if name == "world" {
    print("hello, world")
}else{
    print("I'm sorry \(name), but I don't recognize you")
}

//: - callout(注意):Bool不能被比较，比较元组大小会按照从左到右，逐值比较的方式，直到发现两个值不等时停止
(1, "zebra") < (2, "apple")
(3, "apple") < (3, "bird")
(4, "dog") == (4, "dog")
//: ### 三目运算符ternary conditional operator
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
//:### 空合运算符nil coalescing operator
/*:
>(a `??` b)表达式a必须是optional类型，b与a的类型保持一致。如果a包含一个值就进行解封，否则返回一个默认值b\
>a `!`= nil `?` a`!` : b
*/
let defaultColorName = "red"
var userDefinedColorName: String?    //默认值为nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
//:### 区间运算符Range Operators
//闭区间运算符
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}
//半开区间运算符
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第\(i + 1)个人叫\(names[i])")
}
//:### 逻辑运算 logical operators
//逻辑非!a
let allowedEntry = false
if !allowedEntry {
    print("Access denied")
}
//逻辑与 - 短路计算short-circuit evaluation
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
}else{
    print("Access denied")
}
//逻辑或 - 短路计算
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else{
    print("Access denied")
}
//左结合，优先计算最左边的表达式
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else{
    print("Access denied")
}
//使用括号来明确优先级
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else{
    print("Access denied")
}
