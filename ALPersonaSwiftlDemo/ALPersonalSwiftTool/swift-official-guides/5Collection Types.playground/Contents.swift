import UIKit
//: ## Arrays
//写 Swift 数组应该遵循像 Array<Element> 这样的形式，其中 Element 是这个数组中唯一允许存在的数据类型。我们也可以使用像 [Element] 这样的简单语法。


//创建一个空数组
var someInts = [Int]()
print("SomeInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)
someInts = []

//创建一个带有默认值的数组
var threeDoubles = [Double](repeating: 0.0, count: 3)
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles

//用字面量构造数组
var shoppingList: [String] = ["Eggs", "Milk"]

//访问和修改数组
print("The shopping list contains \(shoppingList.count) items.")
if shoppingList.isEmpty {
    print("The shopping list is empty.")
}else{
    print("The shopping list is not empty.")
}
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Chese", "Butter"]
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
//: - callout(注意): 不可以用下标的形式去在数组尾部添加新项
shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)
firstItem = shoppingList[0]
let apples = shoppingList.removeLast()

//数组的遍历
for item in shoppingList{
    print(item)
}
for(index, value)in shoppingList.enumerated(){
    print("Item \(String(index + 1)) : \(value)")
}
//: ## Sets
/*:
 >集合类型的哈希值，一个类型为了存储在集合中，该类型必须提供一个方法来计算它的哈希值\
>String、Int、Double和Bool，以及没有关联值的枚举成员值默认是可哈希化的\
>可以自定义类型符合Swift标准库中的Hashable协议\
>Hashable协议符合Equatable协议（实现==），==的实现必须满足a==a; a==b, b==a;a==b && b==c,=> a==c
 */
//a == a(自反性)
//a == b 意味着 b == a(对称性)
//a == b && b == c 意味着 a == c(传递性)

//创建和构造一个空的集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
letters = []

//letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型

//用数组字面量创建集合
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
//Set类型必须显示申明，然而，使用数组字面量构造可以省略
//var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

//访问和修改一个集合
if favoriteGenres.isEmpty{
    print("As far as music goes, I'm not picky.")
}else{
    print("I have particular music preferences.")
}
favoriteGenres.insert("Jazz")
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
}else{
    print("I never much cared for that.")
}
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
}else{
    print("It's too funky in here.")
}
for genre in favoriteGenres {
    print("\(genre)")
}
//按照特定的顺序遍历一个Set中的值
for genre in favoriteGenres.sorted() {    //??
    print("\(genre)")
}
//:## 集合操作
/*:
 >* 使用 intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合。
 >* 使用 symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 >* 使用 union(_:) 方法根据两个集合的值创建一个新的集合。
 >* 使用 subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4 , 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
//test
for tempIntValue in evenDigits.sorted() {
    print("\(tempIntValue)", terminator: " ")
}
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
/*:
 >* 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。\
 >* 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。\
 >* 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。\
 >* 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。\
 >* 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true”
//:## Dictionary
//创建一个空字典
var namesOfIntegers = [Int : String]()  //namesOfIntegers 是一个空的 [Int: String] 字典
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]
// namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
//:### 用字典字面量创建字典

//var airports: [String: String] = ["XYZ" : "Toronto Pearson", "DUB" : "Dublin"]
var airports = ["XYZ" : "Toronto Pearson", "DUB" : "Dublin"]
//访问和修改字典
print("The dictionary of airports contains \(airports.count) items.")
if airports.isEmpty {
    print("The airports dictionary is empty.")
}else{
    print("The airports dictionary is not empty.")
}
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
//updateValue(_:forKey:)方法会返回对应值的类型的可选值
//如果有值存在于更新前，则这个可选值包含了旧值，否则它会是nil
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
    print("The old value for DUB was \(oldValue)")
}
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
}else{
    print("That airport is not in the airports dicitonary.")
}
airports["APL"] = "Apple Internation"
airports["APL"] = nil
// APL 现在被移除了

//这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回 nil：
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)")
}else{
    print("The airports dictionary does not contain a value for DUB.")
}
//字典遍历
for (airportCode, airportName) in airports{
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: YYZ
// Airport code: LHR
for airportName in airports.values {
    print("Airport name: \(airportName)")
}

//作为某个接受 Array 实例的 API 的参数
let airportCodes = [String](airports.keys)
// airportCodes is ["YYZ", "LHR"]

let airportNames = [String](airports.values)
// airportNames is ["Toronto Pearson", "London Heathrow"]

