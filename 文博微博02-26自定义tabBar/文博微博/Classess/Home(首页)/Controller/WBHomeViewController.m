//
//  WBHomeViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBOneViewController.h"
#import "WBTitleBtn.h"
#import "WBMenuView.h"

@interface WBHomeViewController () <WBMenuViewDelegate>
@property(nonatomic, weak) WBMenuView *menu;
@end

@implementation WBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建左按钮
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem createWithImgName:@"navigationbar_friendsearch" selectedImgName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(frendSearch)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    // 2. 创建右按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createWithImgName:@"navigationbar_pop" selectedImgName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 3. 首页按钮右边一个箭头
    WBTitleBtn *titleBtn = [[WBTitleBtn alloc] init];
    
    [titleBtn addTarget:self action:@selector(popMenuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleBtn setTitle:@"首页" forState: UIControlStateNormal];
    [titleBtn setTitle:@"首页" forState: UIControlStateHighlighted];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleBtn setBackgroundImage:[UIImage imageRemakeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    titleBtn.width = 100;
    titleBtn.height = 35;
    self.navigationItem.titleView = titleBtn;
}

- (void)popMenuClick
{
    WBTitleBtn *titleBtn = (WBTitleBtn *)self.navigationItem.titleView;
    // 箭头向下
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    // 弹出菜单
    WBMenuView *menu = [WBMenuView menuWithContentView:nil];
    menu.delegate = self;
    [menu showInRect:CGRectMake(100, 100, 100, 100)];
}

- (void)frendSearch
{
    WBLog(@"frendSearch");
    
    WBOneViewController *oneVc = [[WBOneViewController alloc] init];
    oneVc.title = @"oneVc";
    [self.navigationController pushViewController:oneVc animated:YES];
}

- (void)pop
{
    WBLog(@"pop");
}

#pragma mark - WBMenuViewDelegate
- (void)WBMenuViewDidCoverClick
{
    WBTitleBtn *titleBtn = (WBTitleBtn *)self.navigationItem.titleView;
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *testText = [NSString stringWithFormat:@"首页测试数据-----%zd", indexPath.row];
    cell.textLabel.text = testText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor grayColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
