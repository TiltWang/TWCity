//
//  TWSelectCityTableView.m
//  testCity
//
//  Created by tilt on 16/11/5.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import "TWSelectCityTableView.h"

@interface TWSelectCityTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TWSelectCityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.sectionIndexColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groupModelList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TWCityGroupListModel *listModel = self.groupModelList[section];
                                       
    return listModel.citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MFSelectCityTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MFSelectCityTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TWCityGroupListModel *listModel = self.groupModelList[indexPath.section];
    TWCityModel *cityModel = listModel.citys[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cityModel.city];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    }
    //    //设置headerView背景色
    //    UIView *view = [[UIView alloc] init];
    //    view.backgroundColor =  [UIColor redColor];
    //    headerView.backgroundView = view;
    TWCityGroupListModel *listModel = self.groupModelList[section];
    headerView.textLabel.text =  listModel.letter;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TWCityGroupListModel *listModel = self.groupModelList[indexPath.section];
    TWCityModel *cityModel = listModel.citys[indexPath.row];
    _selectCellBlock(cityModel);
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexArr = [NSMutableArray array];
    for (TWCityGroupListModel *listModel  in self.groupModelList) {
        [indexArr addObject:listModel.letter];
    }
    return [indexArr copy];
}

@end
