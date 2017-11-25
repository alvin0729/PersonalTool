import UIKit
/*: ## 可选链式调用(Optional Chaining)*/
//: #### 使用可选链式调用代替强制展开
//willRotateToInterfaceOrientation
class Person{
    var residence: Residence?
}
class Residence{
    var numberOfRooms = 1
}
let john = Person()
//let roomCount = john.residence!.numberOfRooms
//“这会引发运行时错误”
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Uable to retrieve the number of rooms.")
}

john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Uable to retrieve the number of rooms.")
}
//: #### 为可选链式调用定义模型类
class Person1{
    var residence: Residence1?
}

class Residence1{
    var rooms = [Room]()
    var numberOfRooms: Int{
        return rooms.count
    }
    subscript(i:Int) -> Room{
        get{
            return rooms[i]
        }
        set{
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room{
    let name: String
    init(name: String){ self.name = name}
}

class Address{
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil{
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}
//: #### 通过可选链式调用访问属性
let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Uable to retrieve the number of rooms.")
}
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john1.residence?.address = someAddress

func createAddress()-> Address{
    print("Function was called.")
    
    let someAddress1 = Address()
    someAddress1.buildingNumber = "29"
    someAddress1.street = "Acacia Road"
    
    return someAddress1
}
john1.residence?.address = createAddress()
//: #### 通过可选链式调用调用方法
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john1.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
//: #### 通过可选链式调用访问下标
//: - callout(注意): 通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
if let firstRoomName = john1.residence?[0].name{
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
john1.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john1.residence = johnsHouse
if let firstRoomName = john1.residence?[0].name{
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
//: **访问可选类型的下标**
var testScores = ["Dave":[86,82,84], "Bev": [79,94,81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
//: #### 连接多层可选链式调用
if let johnsStreet = john1.residence?.address?.street{
    print("John's street name is  \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is  \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
//: #### 在方法的可选返回值上进行可选链式调用
if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
if let beginsWithThe = john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"THe\".")
    } else {
        print("John's building identifier does not begin with \"THe\".")
    }
}
//: - callout(注意): 在上面的例子中，在方法的圆括号后面加上问号是因为你要在buildingIdentifier()方法的可选返回值上进行可选链式调用，而不是方法本身。

//: ## 错误处理
//: #### 表示并抛出错误
 enum VendingMachineError: Error {
 case invalidSelection                     //选择无效
 case insufficientFunds(coinsNeeded: Int)   //金额不足
 case outOfStock                           //缺货
 }
 throw VendingMachineError.insufficientFunds(coinsNeeded:5)
//: #### 处理错误
//: - callout(注意):Swift中的错误处理和其他语言中用try，catch和throw进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的。\
//: **用 throwing 函数传递错误**
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = [
        " Candy Bar": Item(price: 12, count: 7),
        "Chips":Item(price: 10, count: 4),
        "Pretzels":Item(price: 7, count: 11)
        ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws{
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice":"Chips",
    "Bob":"Licorice",
    "Eve":"Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed:snackName)
}

struct Purchasedsnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
//:**用 Do-Catch 处理错误**
/*:
 ```
 do {
 try expression
 statements
 } catch pattern 1 {
 statements
 } catch pattern 2 where condition {
 statements
 }
```*/
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
//:**将错误转换成可选值**
/*:
 ```
 func someThrowingFunction() throws -> Int {
 // ...
 }
  
 let x = try? someThrowingFunction()
  
 let y: Int?
 do {
 y = try someThrowingFunction()
 } catch {
 y = nil
 }
 
 func fetchData() -> Data?{
 if let data = try?fetchDataFromDisk(){return data}
 if let data = try?fetchDataFromServer(){return data}
 return nil
 }
 ```*/
//:**禁用错误传递**\
//:[let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")](license)
//: #### 指定清理操作
//:可以使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如return或者break的语句。\
//:defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如break或是return语句，或是抛出一个错误。延迟执行的操作会按照它们被指定时的顺序的相反顺序执行——也就是说，第一条defer语句中的代码会在第二条defer语句中的代码被执行之后才执行，以此类推。
/*:
 ```
 func processFile(filename: String) throws {
 if exists(filename) {
 let file = open(filename)
 defer {
 close(file)
 }
 while let line = try file.readline() {
 // 处理文件。
 }
 // close(file) 会在这里被调用，即作用域的最后。
 }
 }
 ```*/
