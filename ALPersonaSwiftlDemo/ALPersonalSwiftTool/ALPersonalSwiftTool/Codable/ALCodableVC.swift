//
//  ALCodableVC.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2018/12/11.
//  Copyright © 2018年 company. All rights reserved.
//

//ObjectMapper
//https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/JSONEncoder.swift
//Swift 4.0: Codable https://www.jianshu.com/p/febdd25ae525
import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ALCodableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        class User: Mappable {
            var username: String?
            var age: Int?
            var weight: Double!
            var array: [Any]?
            var dictionary: [String : Any] = [:]
            var bestFriend: User?                       // Nested User object
            var friends: [User]?                        // Array of Users
            var birthday: Date?
            
            required init?(map: Map) {
                
            }
            
            // Mappable
            func mapping(map: Map) {
                username    <- map["username"]
                age         <- map["age"]
                weight      <- map["weight"]
                array       <- map["arr"]
                dictionary  <- map["dict"]
                bestFriend  <- map["best_friend"]
                friends     <- map["friends"]
                birthday    <- (map["birthday"], DateTransform())
            }
        }

        let JSONString = "{\"weight\": \"180\"}"
        let user = User(JSONString: JSONString)
        user?.age = 10
        user?.username = "ash"
        user?.birthday = Date()
        user?.weight = 180
        
        if let jsonStr = user?.toJSONString(prettyPrint: true) {
            debugPrint(jsonStr)
        }
        
        let data = try! JSONEncoder().encode([1: 3])
        let dict = try! JSONDecoder().decode([Int: Int].self, from: data)
        print(dict)
        
        self.testOne()
        self.testCopyable()
        
        
        
//        self.testEncodeSimpleParameter()
//        self.testResponseObject()
//        self.testResponseObjectMapToObject()
//        self.testResponseObjectWithKeyPath()
//        self.testResponseArray()
    }
    
    
    private func testResponseObject() {
        
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        /*
         {
         "location": "Toronto, Canada",
         "three_day_forecast": [
             {
                 "conditions": "Partly cloudy",
                 "day" : "Monday",
                 "temperature": 20
             },
             {
                 "conditions": "Showers",
                 "day" : "Tuesday",
                 "temperature": 22
             },
             {
                 "conditions": "Sunny",
                 "day" : "Wednesday",
                 "temperature": 28
             }
         ]
         }
         */
        Alamofire.request(URL, method:.get).responseObject { (response: DataResponse<WeatherResponse>) in
            let mappedObject = response.result.value
            let placeHolder:String = ""
            print("--------------------------------")
            for forecast in mappedObject!.threeDayForecast!{
                print("\(forecast.day ?? placeHolder) + \" \" + \(forecast.conditions ?? placeHolder) + \" \" + \(forecast.temperature ?? 0)")
            }
        }
    }
    
    private func testResponseObjectMapToObject(){
        //数据样式同上
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        let weatherResponse = WeatherResponse()
        weatherResponse.date = Date()
        Alamofire.request(URL, method: .get).responseObject(mapToObject: weatherResponse) { (response: DataResponse<WeatherResponse>) in
            let mappedObject = response.result.value
            let placeHolder:String = ""
            print("--------------------------------")
            for forecast in mappedObject!.threeDayForecast!{
                print("\(forecast.day ?? placeHolder) + \" \" + \(forecast.conditions ?? placeHolder) + \" \" + \(forecast.temperature ?? 0)")
            }
        }
    }
    private func testResponseObjectWithKeyPath(){
        /*
         {
         "data": {
             "location": "Toronto, Canada",
             "three_day_forecast": [
             {
                 "conditions": "Partly cloudy",
                 "day" : "Monday",
                 "temperature": 20
             },
             {
                 "conditions": "Showers",
                 "day" : "Tuesday",
                 "temperature": 22
             },
             {
                 "conditions": "Sunny",
                 "day" : "Wednesday",
                 "temperature": 28
             }
             ]
           }
         }
         */
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
        Alamofire.request(URL, method: .get).responseObject(keyPath: "data") { (response: DataResponse<WeatherResponse>) in
            let mappedObject = response.result.value
            let placeHolder:String = ""
            print("--------------------------------")
            for forecast in mappedObject!.threeDayForecast!{
                print("\(forecast.day ?? placeHolder) + \" \" + \(forecast.conditions ?? placeHolder) + \" \" + \(forecast.temperature ?? 0)")
            }
        }
    }
    
    private func testResponseObjectWithNestedKeyPath(){
        /*
         {
         "response": {
             "data": {
                 "location": "Toronto, Canada",
                 "three_day_forecast": [
                     {
                         "conditions": "Partly cloudy",
                         "day" : "Monday",
                         "temperature": 20
                     },
                     {
                         "conditions": "Showers",
                         "day" : "Tuesday",
                         "temperature": 22
                     },
                     {
                         "conditions": "Sunny",
                         "day" : "Wednesday",
                         "temperature": 28
                     }
                 ]
                 }
             }
         }
     */
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/97231a04e6e4970612efcc0b7e0c125a83e3de6e/sample_keypath_json"
        Alamofire.request(URL, method: .get).responseObject(keyPath: "response.data") { (response: DataResponse<WeatherResponse>) in
            
        }
    }
    
    private func testResponseArray() {
        /*
         [
         {
             "conditions": "Partly cloudy",
             "day" : "Monday",
             "temperature": 20
         },
         {
             "conditions": "Showers",
             "day" : "Tuesday",
             "temperature": 22
         },
         {
             "conditions": "Sunny",
             "day" : "Wednesday",
             "temperature": 28
         }
         ]
         */
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/f583be1121dbc5e9b0381b3017718a70c31054f7/sample_array_json"
        Alamofire.request(URL, method: .get).responseArray { (response: DataResponse<[Forecast]>) in
            let mappedArray = response.result.value
            guard 3 == mappedArray?.count else{
                return
            }
            let placeHolder:String = ""
            print("---------------+++-----------------")
            for forecast in mappedArray!{
                print("\(forecast.day ?? placeHolder) + \" \" + \(forecast.conditions ?? placeHolder) + \" \" + \(forecast.temperature ?? 0)")
            }
        }
    }
        
}


extension ALCodableVC{
    private func testOne(){
        class Person: Codable{
            var name: String = ""
            var age: Int = 0
            var score : Double = 0.00
            
            //如果遇到部分数据不需要接收的情况，CodingKey也可以处理，主要在CodingKeys的枚举中不要写这个key就可以了
            enum CodingKeys: String, CodingKey{
                case name = "name_a"
                case age
            }
        }
        //注意类型统一
        //let JSONString = "{\"name\":\"xiaoming\",\"age\":10}"
        let JSONString = "{\"name_a\":\"xiaoming\",\"age\":10,\"score\":98.5}"
        guard let jsonData = JSONString.data(using: .utf8) else{
            return
        }
        
        let decoder = JSONDecoder()
        guard let obj = try? decoder.decode(Person.self, from: jsonData) else{
            return
        }
        print("\(obj.name) + \"   \" + \(obj.age)")
        print(obj.score)
    }
    
    private func testCopyable(){
        class Man: Copyable{
            var height: Int = 0
            var colleage: String = ""
            enum CodingKeys: CodingKey {
                case height
            }
        }
        
        class Person: Copyable{
            var name: String = ""
            var age = 3
            var man: Man = Man()
            /*
             1、遵循了Codable协议的类，其嵌套类型也需要遵循Codable协议；
             2、遵循了Codable协议的类的派生类，需要重写override func encode(to encoder: Encoder) throws方法和required init(from decoder: Decoder) throws方法。这两个方法都需要使用容器来编码和解码，容器中属性的key与自定义遵循了CodingKey协议的枚举值对应，在将子类中的属性编码和解码之后，需要调用父类的编码或解码方法。
             ---------------------！
             */
//            enum CodingKeys: CodingKey {
//                case na
//                case a
//                case man
//            }
//
//            required init(from decoder: Decoder) throws {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//                self.name = try container.decode(String.self, forKey: .na)
//                self.age = try container.decode(Int.self, forKey: .a)
//                self.man = try container.decode(Man.self, forKey: .man)
            //try super.init(from: decoder)
//            }
//
//            func encode(to encoder: Encoder) throws {
//                var container = encoder.container(keyedBy: CodingKeys.self)
//                try container.encode(self.name, forKey: .na)
//                try container.encode(self.age, forKey: .a)
//                try container.encode(self.man, forKey: .man)
            //try super.encode(to: encoder)
//            }
            
        }
        let person = Person()
        person.name = "a"
        person.man.height = 1
        
        let person2 = person.copy()
        print("新副本", person2.name, person2.man.height)
        
        person2.name = "b"
        person2.man.height = 2
        print("修改副本后",
              person.name,
              person.man.height,
              person2.name,
              person2.man.height)
        let jsonString = """
        {"name": "aaa",
         "age": 3,
         "man":
             {"height": 100}
        }
        """
        
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        let person3 = try! decoder.decode(Person.self, from: jsonData)
        
        print(person3.name, person3.man.height) /// "aaa" 100
        
    }
    
    //偷天换日
    //有时候JSON中的格式并非我们所要，比如String格式的浮点型数字，我们希望直接在转model时转换为Double类型。我们可以使用中间类转化类型。如下
    struct StringToDoubleConverter: Codable { // 此类将获取的String转化为Double
        
        let value: Double?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            value = Double(string)
        }
    }
    private func testEncodeSimpleParameter(){
        //https://github.com/tattn/MoreCodable
//        let encoder = URLQueryItemsEncoder()
//        struct Parameter: Codable {
//            let query: String
//            let offset: Int
//            let limit: Int
//        }
//        let parameter = Parameter(query: "ねこ", offset: 10, limit: 20)
//        do{
//            let params: [URLQueryItem] = try encoder.encode(parameter)
//            var components = URLComponents(string: "https://example.com")
//            components?.queryItems = params
//            print(components?.url?.absoluteString)
//        }catch{
//            print(error)
//        }
        
//        XCTAssertEqual("query", params[0].name)
//        XCTAssertEqual(parameter.query, params[0].value)
//        XCTAssertEqual("offset", params[1].name)
//        XCTAssertEqual(parameter.offset.description, params[1].value)
//        XCTAssertEqual("limit", params[2].name)
//        XCTAssertEqual(parameter.limit.description, params[2].value)
        
//        var components = URLComponents(string: "https://example.com")
//        components?.queryItems = params
//        XCTAssertEqual(components?.url?.absoluteString, "https://example.com?query=%E3%81%AD%E3%81%93&offset=10&limit=20")
    }
}

protocol Copyable: class, Codable {
    func copy() -> Self
}

extension Copyable{
    func copy() -> Self {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            fatalError("encode failure")
        }
        let decoder = JSONDecoder()
        guard let target = try? decoder.decode(Self.self, from: data) else {
            fatalError("decode failure")
        }
        return target
    }
}


// MARK: - Response classes

// MARK: - ImmutableMappable

class ImmutableWeatherResponse: ImmutableMappable {
    let location: String
    let threeDayForecast: [ImmutableForecast]
    
    required init(map: Map) throws {
        location = try map.value("location")
        threeDayForecast = try map.value("three_day_forecast")
    }
    
    func mapping(map: Map) {
        location >>> map["location"]
        threeDayForecast >>> map["three_day_forecast"]
    }
}

class ImmutableForecast: ImmutableMappable {
    let day: String
    let temperature: Int
    let conditions: String
    
    required init(map: Map) throws {
        day = try map.value("day")
        temperature = try map.value("temperature")
        conditions = try map.value("conditions")
    }
    
    func mapping(map: Map) {
        day >>> map["day"]
        temperature >>> map["temperature"]
        conditions >>> map["conditions"]
    }
    
}

// MARK: - Mappable

class WeatherResponse: Mappable {
    var location: String?
    var threeDayForecast: [Forecast]?
    var date: Date?
    
    init(){}
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}

class Forecast: Mappable {
    var day: String?
    var temperature: Int?
    var conditions: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}

struct WeatherResponseImmutable: ImmutableMappable {
    let location: String
    var threeDayForecast: [Forecast]
    var date: Date?
    
    init(map: Map) throws {
        location = try map.value("location")
        threeDayForecast = try map.value("three_day_forecast")
    }
    
    func mapping(map: Map) {
        location >>> map["location"]
        threeDayForecast >>> map["three_day_forecast"]
    }
}

struct ForecastImmutable: ImmutableMappable {
    let day: String
    var temperature: Int
    var conditions: String?
    
    init(map: Map) throws {
        day = try map.value("day")
        temperature = try map.value("temperature")
        conditions = try? map.value("conditions")
    }
    
    func mapping(map: Map) {
        day >>> map["day"]
        temperature >>> map["temperature"]
        conditions >>> map["conditions"]
    }
}

