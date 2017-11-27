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
struct Stack0<Element>{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}
var stackOfStrings0 = Stack0<String>()
stackOfStrings0.push("uno")
stackOfStrings0.push("dos")
stackOfStrings0.push("tres")
stackOfStrings0.push("cuatro")
let fromTheTop0 = stackOfStrings0.pop()
//: ### 扩展一个泛型类型
extension Stack0{
    var topItem:Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings0.topItem {
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
protocol Container1 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
struct IntStack: Container1 {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
//: - callout(注意): IntStack 在实现 Container 的要求时，指定 ItemType 为 Int 类型，即 typealias ItemType = Int，从而将 Container 协议中抽象的 ItemType 类型转换为具体的 Int 类型。
struct Stack1<Element>: Container1 {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
//: **通过扩展一个存在的类型来指定关联类型-符合一个协议**
extension Array: Container1{}

//:Using Type Annotations to Constrain an Associated Type-4.0
protocol Container2 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
//: ### 泛型where语句
func allItemsMatch<C1: Container1, C2: Container1>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}

var stackOfStrings = Stack1<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
var arrayOfStrings = ["uno", "dos", "tres"]
if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."

//:4.0Extensions with a Generic Where Clause
extension Stack1 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

struct NotEquatable { }
var notEquatableStack = Stack1<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // Error

extension Container1 where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

extension Container1 where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"

//:### Associated Types with a Generic Where Clause
protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}
protocol ComparableContainer: Container3 where Item: Comparable { }


//:### Generic Subscripts
extension Container3 {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}


