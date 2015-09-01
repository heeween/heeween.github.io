//
//  ViewController.m
//  11-级联菜单
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "XMGCategory.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
/** 右边表格 */
@property (weak, nonatomic) IBOutlet UITableView *subcategoryTableView;
/** 左边表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 所有的类别数据 */
@property (nonatomic, strong) NSArray *categories;
@end

@implementation ViewController

- (NSArray *)categories
{
    if (_categories == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"]];
        
        NSMutableArray *categoryArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            [categoryArray addObject:[XMGCategory categoryWithDict:dict]];
        }
        _categories = categoryArray;
    }
    return _categories;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认选中左边表格的第0行
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    self.subcategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"categoryTableView - %@", NSStringFromUIEdgeInsets(self.categoryTableView.contentInset));
    NSLog(@"subcategoryTableView - %@", NSStringFromUIEdgeInsets(self.subcategoryTableView.contentInset));
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 右边表格
    XMGCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    return c.subcategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 左边表格
    if (tableView == self.categoryTableView) {
        static NSString *ID = @"category";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        XMGCategory *c = self.categories[indexPath.row];
        
        // 设置普通图片
        cell.imageView.image = [UIImage imageNamed:c.icon];
        // 设置高亮图片（cell选中 -> cell.imageView.highlighted = YES -> cell.imageView显示highlightedImage这个图片）
        cell.imageView.highlightedImage = [UIImage imageNamed:c.highlighted_icon];
        
        // 设置label高亮时的文字颜色
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        
        cell.textLabel.text = c.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    } else {
        // 右边表格
        static NSString *ID = @"subcategory";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        // 获得左边表格被选中的模型
        XMGCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.textLabel.text = c.subcategories[indexPath.row];
        
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self.subcategoryTableView reloadData];
    }
}

@end
