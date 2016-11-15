//
//  TWCityGroupModel.m
//  testCity
//
//  Created by tilt on 16/11/5.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import "TWCityGroupModel.h"

@implementation TWCityGroupModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _citygroup = [NSMutableArray array];
        for (NSDictionary *dic in [dict mutableArrayValueForKey:@"citygroup"] ) {
            TWCityGroupListModel *model = [[TWCityGroupListModel alloc] initWithDict:dic];
            [_citygroup addObject:model];
        }
    }
    return self;
}
+ (instancetype)cityGroupModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end


@implementation TWCityGroupListModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _letter = [dict objectForKey:@"letter"];
        _citys = [NSMutableArray array];
        for (NSDictionary *dic in [dict mutableArrayValueForKey:@"citys"] ) {
            TWCityModel *model = [[TWCityModel alloc] initWithDict:dic];
            [_citys addObject:model];
        }
    }
    return self;
}
+ (instancetype)cityGroupListModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end

@implementation TWCityModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _province = [dict objectForKey:@"province"];
        _city = [dict objectForKey:@"city"];
    }
    return self;
}
+ (instancetype)cityModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
