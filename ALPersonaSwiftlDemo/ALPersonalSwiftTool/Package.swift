//
//  Package.swift
//
//  Copyright (c) 2014-2017 Alamofire Software Foundation (http://alamofire.org/)
//swift package --version
//$ mkdir SPMDemo      // 创建文件夹
//$ cd SPMDemo         // 进入文件夹
//$ swift package init --type executable  // 初始化为可执行项目
//Creating executable package: SPMDemo
//Creating Package.swift
//Creating .gitignore
//Creating Sources/
//Creating Sources/main.swift
//Creating Tests/
//$ swift package generate-xcodeproj     //生成Xcode工程，可用Xcode打开
//generated: ./SPMDemo.xcodeproj
//$ swift build                          // swift 编译并生成可执行文件
//Compile Swift Module 'SPMDemo' (1 sources)
//Linking ./.build/debug/SPMDemo
//$ ./.build/debug/SPMDemo               // 执行生成的文件
//Hello, world!                          // 执行效果
//
//更新依赖包
//$ swift package update
//可以用 swift package generate-xcodeproj 更新一下Xcode工程文件，然后就可以build的运行了



import PackageDescription

let package = Package(
    name: "ALPersonalSwiftTool",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.0.0")
    ]
)








