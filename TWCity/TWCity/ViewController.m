//
//  ViewController.m
//  TWCity
//
//  Created by tilt on 16/11/15.
//  Copyright © 2016年 tilt. All rights reserved.
//

#import "ViewController.h"
#import "TWSelectCityTableView.h"
#import "TWCityGroupModel.h"
@interface ViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) TWCityGroupModel *groupModel;
@property (nonatomic, strong) TWSelectCityTableView *selectCityTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
///选中cell的Block
@property (nonatomic, copy) void(^selectCellBlock)(TWCityModel *);
///返回的Block
@property (nonatomic, copy) void(^backBlock)(TWCityModel *);
@end

@implementation ViewController
- (TWCityGroupModel *)groupModel {
    if (!_groupModel) {
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"TWCitys" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        //        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *jsonParserDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        // 判断JSON解析是否成功
        if (jsonParserDic) {
            NSLog(@"JSON解析成功!");
            //            NSLog(@"%@",jsonParserDic);
            _groupModel = [TWCityGroupModel cityGroupModelWithDict:jsonParserDic];
            
        } else {
            NSLog(@"JSON解析失败!");
        }
    }
    return _groupModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelectCityTableView];
    [self setupSearchBar];
}

- (void)setupSelectCityTableView {
    TWSelectCityTableView *tableView = [[TWSelectCityTableView alloc] initWithFrame:CGRectMake(0, 64 + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 44) style:UITableViewStylePlain];
    tableView.groupModelList = self.groupModel.citygroup;
    [self.view addSubview:tableView];
    self.selectCityTableView = tableView;
    weakSelf(wSelf);
    self.selectCityTableView.tableViewDidScrollBlock = ^() {
        if ([wSelf.searchBar isFirstResponder]) {
            [wSelf.searchBar resignFirstResponder];
        }
    };
    self.selectCityTableView.selectCellBlock = ^(TWCityModel *cityModel){
        [wSelf.navigationController popViewControllerAnimated:YES];
        NSLog(@"%@", cityModel.city);
        if (wSelf.backBlock) {
            wSelf.backBlock(cityModel);
        }
        
    };
}
+ (void)show:(UIViewController *)viewController withBackBlock:(void(^)(TWCityModel *cityModel))backBlock {
    ViewController *selectVC = [[ViewController alloc] init];
    selectVC.backBlock = backBlock;
    [viewController.navigationController pushViewController:selectVC animated:YES];
}
- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    searchBar.placeholder = @"搜索目的地城市";
    searchBar.delegate = self;
    for (id subview in [searchBar.subviews[0] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            UIView *view = subview;
            [view removeFromSuperview];
        }
    }
    searchBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *arr = [NSMutableArray array];
    for (TWCityGroupListModel *listModel in self.groupModel.citygroup) {
        for (TWCityModel *cityModel in listModel.citys) {
            if ([cityModel.city containsString:searchText]) {
                TWCityModel *model = cityModel;
                [arr addObject:model];
            }
        }
    }
    TWCityGroupListModel *groupList = [[TWCityGroupListModel alloc] init];
    groupList.letter = @"检索内容";
    groupList.citys = arr;
    if (arr.count == 0) {
        self.selectCityTableView.groupModelList = self.groupModel.citygroup;
        [self.selectCityTableView reloadData];
    } else {
        self.selectCityTableView.groupModelList = @[groupList];
        [self.selectCityTableView reloadData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
