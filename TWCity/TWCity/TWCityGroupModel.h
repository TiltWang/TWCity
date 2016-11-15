//
//  TWCityGroupModel.h
//  testCity
//
//  Created by tilt on 16/11/5.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWCityGroupModel : NSObject
@property (nonatomic, strong) NSMutableArray *citygroup;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityGroupModelWithDict:(NSDictionary *)dict;
@end

@interface TWCityGroupListModel : NSObject
@property (nonatomic, strong) NSString *letter;
@property (nonatomic, strong) NSMutableArray *citys;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityGroupListModelWithDict:(NSDictionary *)dict;
@end

@interface TWCityModel : NSObject
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityModelWithDict:(NSDictionary *)dict;
@end
