//
//  ViewController.h
//  TWCity
//
//  Created by tilt on 16/11/15.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWCityGroupModel.h"
#define weakSelf(wSelf)  __weak __typeof(&*self)wSelf = self;
@interface ViewController : UIViewController
+ (void)show:(UIViewController *)viewController withBackBlock:(void(^)(TWCityModel *cityModel))backBlock;
@end

