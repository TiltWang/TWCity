//
//  TWSelectCityTableView.h
//  testCity
//
//  Created by tilt on 16/11/5.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWCityGroupModel.h"

@interface TWSelectCityTableView : UITableView
///tableView滚动时Block
@property (nonatomic, copy) void(^tableViewDidScrollBlock)();
///选中cell的Block
@property (nonatomic, copy) void(^selectCellBlock)(TWCityModel *);
@property (nonatomic, strong) NSArray *groupModelList;
@end
