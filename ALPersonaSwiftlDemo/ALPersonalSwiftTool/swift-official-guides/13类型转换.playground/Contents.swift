import UIKit
//: ## 类型转换
//: #### 定义一个类层次作为例子
class MediaItem{
    var name: String
    init(name: String) {
        self.name = name;
    }
}
class Movie: MediaItem{
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
    
}
class Song: MediaItem{
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist;
        super.init(name: name);
    }
}

let library = [
    Movie(name:"Cassablance", director:"Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The one and only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//: ### 检查类型
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song{
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")
//: ### 向下转型
for item in library{
    if let movie = item as? Movie{
        print("Movie:'\(movie.name)',dir.\(movie.director)'")
    }else if let song = item as? Song{
        print("Song:'\(song.name)',by\(song.artist)")
    }
}
//: - callout(注意): 转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用
//: ### Any 和 AnyObject 的类型转换
//: - Any 可以表示任何类型，包括函数类型。
//: - AnyObject 可以表示任何类类型的实例。
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"(\(someString)\"")
    case let(x,y) as (Double,Double):
        print("an (x,y) point at \(x),\(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir.\(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
//: - callout(注意): Any类型可以表示所有类型的值，包括可选类型。Swift 会在你用Any类型来表示一个可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显示转换为Any，如下所示
let optionalNumber: Int? = 3
things.append(optionalNumber)
things.append(optionalNumber as Any)     //没有⚠️


