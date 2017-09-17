//
//  ALNSPredicateViewController.m
//  ALPersonalDemo
//
//  Created by Alvin on 2017/9/17.
//  Copyright © 2017年 company. All rights reserved.
//

#import "ALNSPredicateViewController.h"
#import "Person.h"
#import "ALPerson.h"
#import "NSObject+Base.h"
//#import "NSArray+HYBUnicodeReadable.h"

@interface ALNSPredicateViewController ()
@property (strong,nonatomic) NSMutableArray *personArray;
@end

@implementation ALNSPredicateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    [self test5e];
}

-(void)test1{
    NSLog(@"Hello, World!");
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0;i <10 ; i++) {
        
        Person *person = [[Person alloc]init];
        if (i<5) {;
            person.name = [NSString stringWithFormat:@"BeiJing_%d",i];
            
        }else{
            person.name = [NSString stringWithFormat:@"TianJin_%d",i];
            
        }
        
        person.age = @(20+i);
        
        [arr addObject:person];
    }
    
    //判断对象是否满足谓词条件
    
    //第一种方式
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age<25 or age>27"];
    
    //第二种方式
    //NSArray *inArray = @[@"BeiJing_0",@"BeiJing_1"];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name in %@",inArray];
    
    
    //BEGINSWITH,ENDWITHS,CONTRAINS,like和数据库很像，可以进行模糊查找
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"name BEGINSWITH 'TianJin'"];
    //NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"name ENDSWITH '_0' or name ENDSWITH '_1' "];
    
    for (Person *p in arr) {
        BOOL result = [predicate evaluateWithObject:p];
        if(result){
            NSLog(@"%@,%@",p.name,p.age);
        }
    }
    
    //对数组进行过滤
    
    NSArray *filterArr = [arr filteredArrayUsingPredicate:predicate];
    NSLog(@"过滤后的数组:%@",filterArr);
}

-(void)test2{
    //熟悉Predicate
    [self testPredicateDefinition];
    
    //学习Predicate的比较功能
    //[self testPredicateComparation];
    
    //学习Predicate范围运算功能
    //[self testPredicateRange];
    
    //学习Predicate 与自身相比的功能
    //[self testPredicateComparationToSelf];
    
    //学习Predicate 字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
    //[self testPredicateRelateToNSString];
    
    //学习Predicate 的通配
    //[self testPredicateWildcard];
}

#pragma mark - Predicate 的通配
- (void)testPredicateWildcard{
    /*
     (5)通配符：LIKE
     例：@"name LIKE[cd] '*er*'"
     //  *代表通配符,Like也接受[cd].
     @"name LIKE[cd] '???er*'"
     */
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF  like '*ai*' "];
    
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
}

#pragma mark Predicate 字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
- (void)testPredicateRelateToNSString{
    /*
     (4)字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
     例：@"name CONTAIN[cd] 'ang'"   //包含某个字符串
     @"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
     @"name ENDSWITH[d] 'ang'"      //以某个字符串结束
     注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     */
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [cd] 'an' "];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF Beginswith [cd] 'sh' "];
    
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate1];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
    
}

#pragma  mark Predicate 与自身相比的功能
- (void)testPredicateComparationToSelf{
    /*
     (3)字符串本身:SELF
     例：@“SELF == ‘APPLE’"
     */
    
    NSArray *placeArray = [NSArray arrayWithObjects:@"Shanghai",@"Hangzhou",@"Beijing",@"Macao",@"Taishan", nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == 'Beijing'"];
    NSArray *tempArray = [placeArray filteredArrayUsingPredicate:predicate];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj == %@",obj);
    }];
    
}

#pragma mark Predicate范围运算功能
- (void)testPredicateRange{
    /*
     (2)范围运算符：IN、BETWEEN
     例：@"number BETWEEN {1,5}"
     @"address IN {'shanghai','beijing'}"
     */
    NSArray *array = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@2,@6, nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF in {2,5}"]; //找到 in 的意思是array中{2,5}的元素
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {2,5}"];
    NSArray *fliterArray = [array filteredArrayUsingPredicate:predicate];
    [fliterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"fliterArray = %@",obj);
    }];
    
    
}

#pragma mark 测试Predicate的比较功能
- (void)testPredicateComparation{
    /*
     (1)比较运算符>,<,==,>=,<=,!=
     可用于数值及字符串
     例：@"number > 100"
     */
    NSArray *array = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@2,@6, nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF >4"];
    NSArray *fliterArray = [array filteredArrayUsingPredicate:predicate];
    [fliterArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"fliterArray = %@",obj);
    }];
}

#pragma mark 熟悉Predicate
- (void)testPredicateDefinition{
    NSArray *array = [[NSArray alloc]initWithObjects:@"beijing",@"shanghai",@"guangzou",@"wuhan", nil];;
    //表示在数组里面筛选还有@"be"的字符串
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"be"];
    NSArray *temp = [array filteredArrayUsingPredicate:predicate];
    [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"temp = %@",obj);
    }];
    
    /***************************************************************/
    //NSPredicate给我留下最深印象的是两个数组求交集的一个需求，如果按照一般写法，需要2个遍历，但NSArray提供了一个filterUsingPredicate的方法，用了NSPredicate，就可以不用遍历！
    NSArray *array1 = [NSArray arrayWithObjects:@1,@2,@3,@5,@5,@6,@7, nil];
    NSArray *array2 = [NSArray arrayWithObjects:@4,@5, nil];
    // 表示筛选array1在array2中的元素!YES！其中SELF指向filteredArrayUsingPredicate的调用者。
    /*测试方案：
     NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF  in %@",array2];
     NSArray *temp1 = [array1 filteredArrayUsingPredicate:predicate1];
     结果：
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     
     NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF  in %@",array1];
     NSArray *temp1 = [array2 filteredArrayUsingPredicate:predicate1];
     结果：
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     
     */
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF  in %@",array2];
    NSArray *temp1 = [array1 filteredArrayUsingPredicate:predicate1];
    
    [temp1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"temp1 = %@",obj);
    }];
    
    /*
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     2015-11-08 10:55:19.879 NSPredicateDemo[11595:166012] obj ==5
     */
}
#pragma mark -
- (void)test3{
    NSArray *firstNames = @[ @"Alice", @"Bob", @"Charlie", @"Quentin" ];
    NSArray *lastNames = @[ @"Smith", @"Jones", @"Smith", @"Alberts" ];
    NSArray *ages = @[@24, @27, @33, @31];
    self.personArray = [NSMutableArray array];
    [firstNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Person *person = [[Person alloc] init];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [self.personArray addObject:person];
    }];
    
    NSPredicate *blockPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        return [evaluatedObject firstName].length < 5;
    }];
    
    NSLog(@"blockPredicate :%@", [self.personArray filteredArrayUsingPredicate:blockPredicate]);
    NSLog(@"============================================================");
}

-(void)test4{
    ALPerson *p1 = [ALPerson initWithAge:15 sex:1 name:@"张三"];
    ALPerson *p2 = [ALPerson initWithAge:16 sex:1 name:@"李四"];
    ALPerson *p3 = [ALPerson initWithAge:17 sex:0 name:@"翠花"];
    ALPerson *p4 = [ALPerson initWithAge:18 sex:1 name:@"Tom"];
    ALPerson *p5 = [ALPerson initWithAge:19 sex:0 name:@"cat"];
    
    NSArray *sourceArray = @[p1, p2, p3, p4, p5];
    
    // 搜索名字里有`三`的人
    // tips:用谓词搜索的时候，属性名字的占位符是`%K`,这里的K是大写的
    //
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"%K contains [cd] '三'", @"personName"];
    NSArray *ret1 = [sourceArray filteredArrayUsingPredicate:predicate1];
    NSLog(@"%@", ret1);
    
    // 搜索性别为男的人
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"%K = 1", @"sex"];
    NSArray *ret2 = [sourceArray filteredArrayUsingPredicate:predicate2];
    NSLog(@"%@", ret2);
    
    // 搜索年龄>15 < 19的人
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"%K > 15 && %K < 19", @"age", @"age"];
    NSArray *ret3 = [sourceArray filteredArrayUsingPredicate:predicate3];
    NSLog(@"%@", ret3);
}
#pragma mark -
/*
 * 把 arrayFilter 內的有關鍵字 從 arrayContent 去除，
 * 如果刪掉 NOT 就變成搜尋相同的value，
 * 關鍵字需要一模一樣
 */
-(void)test5a
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"abc", @"abc2", nil];
    NSArray *arrayContent = [NSArray arrayWithObjects:@"a1", @"abc1", @"abc4", @"abc2", nil];
    
    /* @"NOT (SELF in %@)" ->去除關鍵字
     * @"(SELF in %@)" ->尋找相同的value
     */
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", arrayFilter];
    arrayContent = [arrayContent filteredArrayUsingPredicate:thePredicate];
    
    NSLog(@"arrayContent = %@",arrayContent);
}

/*
 * arrayContents 取得有包含 arrayFilter 關鍵字的結果
 * ex:arrayContents內只要有包含"ip"的value就會列出結果："ipad","iphone"
 */
-(void)test5b
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"pict", @"blackrain", @"ip", nil];
    NSArray *arrayContents = [NSArray arrayWithObjects:@"I am a picture.", @"I am a guy", @"I am gagaga", @"ipad", @"iphone", nil];
    
    
    for(int i = 0; i < arrayFilter.count; i++){
        NSString *arrayItem = (NSString *)[arrayFilter objectAtIndex:i];
        
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", arrayItem];
        
        NSLog(@"Filtered array with filter %@, %@", arrayItem, [arrayContents filteredArrayUsingPredicate:filterPredicate]);
    }
}

/*
 * match的用法，
 * 簡單的比較，
 * 關鍵字要完全相同才會被加入
 */
-(void)test5c
{
    NSString *match = @"match";
    NSArray *directoryContents = @[@"matchCD",@"match",@"ma",@"CD"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@",match];
    NSArray *result = [directoryContents filteredArrayUsingPredicate:predicate];
    NSLog(@"Result = %@",result);
}

/*
 * 效果同 "SELF == %@"
 */
-(void)test5d
{
    NSString *match = @"match";
    NSArray *directoryContents = @[@"matchCD",@"match",@"ma",@"CD"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like %@",match];
    NSArray *result = [directoryContents filteredArrayUsingPredicate:predicate];
    NSLog(@"Result = %@",result);
}

/*
 * 大小寫比較
 * c表示忽略大小寫
 * d表示不區分發音符號，即忽略重音
 * 可以在一起使用
 */
-(void)test5e
{
    NSString *match = @"imagexyz*";
    NSArray *directoryContents = @[@"imagexyz",@"IMAGEXYZ*",@"imagexyz*"];
    
    NSPredicate *predicateC = [NSPredicate predicateWithFormat:@"SELF like[c] %@",match];
    NSArray *resultC = [directoryContents filteredArrayUsingPredicate:predicateC];
    
    NSPredicate *predicateD = [NSPredicate predicateWithFormat:@"SELF like[d] %@",match];
    NSArray *resultD = [directoryContents filteredArrayUsingPredicate:predicateD];
    
    NSPredicate *predicateCD = [NSPredicate predicateWithFormat:@"SELF like[cd] %@",match];
    NSArray *resultCD = [directoryContents filteredArrayUsingPredicate:predicateCD];
    
    NSLog(@"ResultC = %@",resultC);
    NSLog(@"ResultD = %@",resultD);
    NSLog(@"ResultCD = %@",resultCD);
}
#pragma mark -
-(void)test6{
    NSString *text = @"sender.text";
    
    /*
     比较运算符 > , < , == , >= , <= , !=
     运算符还可以跟逻辑运算符一起使用，&&  ,  || ,AND, OR 谓词不区分大小写
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age == %ld" ,[text integerValue]];
     */
    
    /*
     范围运算符：IN、BETWEEN
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age in{ 40, 50}" ,[text integerValue]]; //age == 40 age == 50
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age BETWEEN{ 40, 50}" ,[text integerValue]]; // 40 <= age <= 50
     */
    
    /*
     字符串本身:SELF
     NSArray *array=[NSArray arrayWithObjects: @"abc", @"def", @"ghi",@"jkl", nil nil];
     NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF=='abc'"];
     NSArray *array2 = [array filteredArrayUsingPredicate:pre];
     
     */
    
    /*
     字符串相关：BEGINSWITH 以···开始、ENDSWITH 以···结尾、CONTAINS 包含
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@" ,text];
     //注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     */
    
    /*
     通配符：LIKE  *代表通配符Like还接受[cd]  ?只匹配一个字符并且还可以接受[cd].
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self LIKE '?z'"];
     self.predicateArr = [[NSArray arrayWithObjects:@"az", @"zzz", @"zaa", @"arw", nil] filteredArrayUsingPredicate:predicate];
     */
    
    /*
     正则表达式：MATCHES
     NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     //判断指定的对象是否满足NSPredicate创建的过滤条件
     [phoneTest evaluateWithObject:@"手机字符串"];
     */
    
    
    //创建NSPredicate（相当于创建一个过滤条件）
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@" ,text];
    
    //过滤出符合条件的对象（返回所有符合条件的对象）
    //self.predicateArr = [self.mutArr filteredArrayUsingPredicate:predicate];
}
-(void)test7{
//    for (NSString *aleph in [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil])
//    {
//        NSPredicate *alephPredicate = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",@"cSpell",aleph];
//        NSArray *tempArray = [self.traderListDataSource filteredArrayUsingPredicate:alephPredicate];
//
//        if (tempArray.count > 0)
//        {
//            self.filterDictionary[aleph] = tempArray;
//        }
//    }
    
    
//    NSMutableArray *resultArray = (NSMutableArray *)[[NDSearchTool tool] searchWithAllFieldArray:@[@[@"name",@"cSpell"],@[@"name",@"cSpell"]]
//                    inputString:searchText
//                    inAllArray:@[self.usualListDataSource,self.traderListDataSource]];
    
//    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"]
//                 inputString:searchText
//                     inArray:self.dataSource];
}
-(void)test8{
//    {
//        describe(@"should generate valid NSPredicate", ^{
//            it(@"for == predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for != predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath != 10"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").notEquals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for IN predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath IN %@", @[@1, @2, @3]] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").in(@[@1, @2, @3]) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for BETWEEN predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath BETWEEN %@", @[@1, @20]] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").between(@[@1, @20]) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for > predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath > %@", @10] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").greaterThan(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for >= predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath >= %@", @10] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").greaterThanOrEquals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for < predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath < %@", @10] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").lessThan(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for <= predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath <= %@", @10] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").lessThanOrEquals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//
//            it(@"for BEGINSWITH predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath BEGINSWITH \"test\""] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").beginsWith(@"test") format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for CONTAINS predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath CONTAINS \"test\""] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").contains(@"test") format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for ENDSWITH predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath ENDSWITH \"test\""] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").endsWith(@"test") format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for LIKE predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath LIKE \"test\""] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").like(@"test") format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for MATCHES predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath MATCHES \"test\""] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").matches(@"test") format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for two AND subpredicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10 AND keypath2 == 20"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.where(@"keypath2").equals(@20) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for three AND subpredicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10 AND keypath2 == 20 AND keypath3 == 30"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.
//                                                    where(@"keypath2").equals(@20).and.
//                                                    where(@"keypath3").equals(@30) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for mixed OR and AND subpredicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"(keypath == 10 AND keypath2 == 20) OR keypath3 == 30"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").equals(@10).and.
//                                                    where(@"keypath2").equals(@20).or.
//                                                    where(@"keypath3").equals(@30) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for logical NOT", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"NOT keypath IN %@", @[@1, @2, @3]] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.where(@"keypath").not.in(@[@1, @2, @3]) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//
//            it(@"for predicates with ANY modifier", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"ANY keypaths == 10"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.whereAny(@"keypaths").equals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for predicates with ALL modifier", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"ALL keypaths == 10"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.whereAll(@"keypaths").equals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//            it(@"for SELF predicates", ^{
//                SFPPredicateFormatter *formatter = [[SFPPredicateFormatter alloc] init];
//                NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"SELF == 10"] predicateFormat];
//                NSString *actualPredicateFormat = [[formatter.whereSelf.equals(@10) format] predicateFormat];
//                expect(actualPredicateFormat).to.equal(expectedPredicateFormat);
//            });
//
//
//        });
//
//
//    }
}
-(void)test9{
//    {
//        it(@"should provide pretty interface to produce NSPredicate's", ^ {
//            NSString *expectedPredicateFormat = [[NSPredicate predicateWithFormat:@"keypath == 10"] predicateFormat];
//            NSString *actualPredicateFormat = [[NSPredicate predicate:where(@"keypath").equals(@10)] predicateFormat];
//            expect(expectedPredicateFormat).to.equal(actualPredicateFormat);
//        });
//
//        it(@"should produce valid predicates for filtering arrays", ^ {
//            NSArray* originalArray = @[@10, @20, @30, @40, @50];
//            NSArray* filteredArray = [originalArray filteredArrayUsingPredicate:[NSPredicate predicate:whereSelf().greaterThan(@25)]];
//            expect(filteredArray).to.equal(@[@30, @40, @50]);
//        });
//
    /*
    Allows to work with NSPredicate's in much safer manner with compile-time checks. For example instead of this:
    ```objc
    [NSPredicate predicateWithFormat:@"keypath == %@ AND keypath2 IN %@", @10, @[@1, @2, @3]]
    ```
    you can just write:
    ```objc
    [NSPredicate predicate:where(@"keypath").equals(@10).and.where(@"keypath2").in(@[@1, @2, @3])]
    ```
    */
    //
//    }
}
-(void)test10{
    
}
-(void)test11{
    
}
-(void)test12{
    
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
