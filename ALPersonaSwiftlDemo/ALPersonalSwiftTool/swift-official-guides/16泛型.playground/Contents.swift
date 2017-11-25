import UIKit
//: ## 泛型
//: ### 泛型所解决的问题
func swapTwoInts(_ a: inout Int,_ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and another is now \(anotherInt)")
//: ### 泛型函数
//与库中已存在的函数swap功能类似
func swapTwoValues<T>(_ a:inout T, _ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}
var someString = "Hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
//: ### 命名类型参数
//: - callout(注意): 请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。
//: ### 泛型类型
struct Stack<Element>{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()
//: ### 扩展一个泛型类型
extension Stack{
    var topItem:Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
//: ### 类型约束
//: **类型约束语法**
/*:
 ```
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
 // 这里是泛型函数的函数体部分
 }
 ```*/
//: **类型约束实践**
func findIndex(ofString valueToFind: String, in array:[String]) ->Int?{
    for (index,value) in array.enumerated(){
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat","dog","llama","parakeet","terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
func findIndexT<T: Equatable>(of valueToFind: T, in array:[T]) ->Int?{
    for (index,value) in array.enumerated(){
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndexT(of: 9.3, in: [3.1415,0.1,0.25])
let stringIndex = findIndexT(of: "Andrea", in: ["Mike","Malcolm","Andrea"])
//: ### 关联类型
//: **关联类型实践**
protocol Container{
    associatedtype ItemType
    mutating func append(item:ItemType)
    var count: Int{get}
    subscript(i:Int) -> ItemType{get}
}
struct IntStack:Container{
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
    //Container协议的实现部分
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int{
        return items.count
    }
    subscript(i:Int)->Int{
        return items[i]
    }
}
//: - callout(注意): IntStack 在实现 Container 的要求时，指定 ItemType 为 Int 类型，即 typealias ItemType = Int，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
struct Stack1<Element>:Container{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
    //Container协议的实现部分
    mutating func append(item:Element) {
        self.push(item)
    }
    var count: Int{
        return items.count
    }
    subscript(i: Int) -> Element{
        return items[i]
    }
}
//: **通过扩展一个存在的类型来指定关联类型-符合一个协议**
extension Array: Container{}
//: ### 泛型where语句
func allItemsMatch<C1:Container,C2:Container>(_ someContainer:C1, _ anotherContainer:C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType:Equatable{
    //检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count{
        return false
    }
    //检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}
var stackOStrings = Stack1<String>()
stackOStrings.push("uno")
stackOStrings.push("dos")
stackOStrings.push("tres")
var arrayOfStrings = ["uno","dos","tres"]
if allItemsMatch(stackOStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
