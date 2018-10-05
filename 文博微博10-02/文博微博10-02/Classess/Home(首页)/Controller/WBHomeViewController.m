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
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"
#import "WBTableFooterView.h"

@interface WBHomeViewController () <WBMenuViewDelegate>

@property(nonatomic, weak) WBMenuView *menu;
/** 所有的微博数据 */
@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, weak) UILabel *updateLabel;

//@property (nonatomic, weak) UIRefreshControl *refreshView;

@end

@implementation WBHomeViewController

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigatioinBar];
    
    [self setupRefreshView];
    
    [self setupDownRefreshView];
}

- (void)setupDownRefreshView
{
    WBTableFooterView *footerView = [WBTableFooterView footerView];
    self.tableView.tableFooterView = footerView;
    
    footerView.width = self.view.width;
}

- (void)setupUpdateView
{
    if (!self.updateLabel) {
        UILabel *updateLabel = [[UILabel alloc] init];
        [self.navigationController.view insertSubview:updateLabel belowSubview:self.navigationController.navigationBar];
        
        updateLabel.textColor = [UIColor whiteColor];
        updateLabel.textAlignment = NSTextAlignmentCenter;
        updateLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        self.updateLabel = updateLabel;
    } else {
        // 移除所有动画
        [self.updateLabel.layer removeAllAnimations];
    }
    
    self.updateLabel.x = 0;
    self.updateLabel.width = self.view.width;
    self.updateLabel.height = 35;
    self.updateLabel.y = 64 - self.updateLabel.height;
}

- (void)setupRefreshView
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(refreshViewValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl beginRefreshing];
    
    [self refreshViewValueChanged];
}

- (void)refreshViewValueChanged
{
    // 更新数据
    [self refreshAllStatuses];
}

// 更新数据
- (void)refreshAllStatuses
{
//    WBAccount *account = [WBAccountTool account];
//
//    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//
//    WBStatus *status = (WBStatus *)[self.statuses firstObject];
//    params[@"access_token"] = account.access_token;
//    if (status) {
//        params[@"since_id"] = status.idstr;
//    }
//
//    [manage GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//           [self updateStatusesWithDict:responseObject];
//        });
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        WBLog(@"%@", error.domain);
//    }];
}

- (void)updateStatusesWithDict:(NSDictionary *)dict
{
    NSDictionary *statuses = dict[@"statuses"];
    NSArray *statusesArray = [WBStatus mj_objectArrayWithKeyValuesArray:statuses];
    
    NSRange insertRange = NSMakeRange(0, statusesArray.count);
    NSIndexSet *insertSet = [NSIndexSet indexSetWithIndexesInRange:insertRange];
    [self.statuses insertObjects:statusesArray atIndexes:insertSet];
    
    // 显示数据的label
    [self showStatusLabel:statusesArray.count];
    // 刷新tableView
    [self.tableView reloadData];
    // 隐藏refreshView
    [self.refreshControl endRefreshing];
}

- (void)showStatusLabel:(NSInteger)count
{
    // 设置下拉刷新控件
    [self setupUpdateView];
    
    // 从上至下的显示
    self.updateLabel.alpha = 0.0;
    
    NSTimeInterval durationTime = 1.0;
    [UIView animateWithDuration:durationTime animations:^{
        
        self.updateLabel.alpha = 1.0;
        self.updateLabel.transform = CGAffineTransformMakeTranslation(0, self.updateLabel.height);
    } completion:^(BOOL finished) {
        
        NSTimeInterval delayTime = 1.0;
        
        [UIView animateWithDuration:durationTime delay:delayTime options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.updateLabel.alpha = 0.0;
            self.updateLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            // 如果动画正常完成则finished为true，反之为false
            if (finished) {
                [self.updateLabel removeFromSuperview];
            }
        }];
    }];
    
    if (count) {
        self.updateLabel.text = [NSString stringWithFormat:@"更新了%zd条微博", count];
    } else {
        self.updateLabel.text = @"没有更新微博";
    }
}

- (void)setupNavigatioinBar
{
    // 1. 创建左按钮
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem createWithImgName:@"navigationbar_friendsearch" selectedImgName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(frendSearch)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    // 2. 创建右按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createWithImgName:@"navigationbar_pop" selectedImgName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 3. 创建标题（首页按钮右边一个箭头）
    WBTitleBtn *titleBtn = [[WBTitleBtn alloc] init];
    
    [titleBtn addTarget:self action:@selector(popMenuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleBtn setTitle:@"首页" forState: UIControlStateNormal];
    [titleBtn setTitle:@"首页" forState: UIControlStateHighlighted];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleBtn setBackgroundImage:[UIImage imageRemakeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    titleBtn.width = 100;
    titleBtn.height = 35;
    self.navigationItem.titleView = titleBtn;
    
    
    UIImage *image = [[UIImage alloc] init];
    // 设置bnavigationBar透明->位置forBarPosition：any是所有，bottom是底部
//    [self.navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    
    // 去掉navigationBar底部的那条黑线
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
    // navigationBar变透明了，没关系，设置纯色背景
     [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    // 设置半透明
    self.navigationController.navigationBar.translucent = YES;
    
    // 改变 barStyle ，默认是导航栏背景颜色是白色，导航栏 title 的颜色是黑色，状态栏的字颜色也是黑色。 更改为 black 之后导航栏背景颜色更改为黑色，导航栏 title 变为白色，状态栏字颜色也为白色。
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIImage *image = nil;
    // 设置画布的范围
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    // 开始画布
    UIGraphicsBeginImageContext(rect.size);
    // 获取当前画布
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 设置画布的颜色
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    // 开始fill画布
    CGContextFillRect(contextRef, rect);
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束画布
    UIGraphicsEndPDFContext();
    return image;
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
    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // navigationBar.translucent = NO; 没弄懂
    // UINavigationItem *topItem = navigationBar.topItem;
    // topItem = <UINavigationItem: 0x7faee8406270> title='首页' titleView=0x7faee855b2f0 leftBarButtonItems=0x60000156fa60 rightBarButtonItems=0x60000156fb60
//     self.navigationController.navigationBar.prefersLargeTitles = NO; 没弄懂
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor]; // 没弄懂
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor]; // 没弄懂
    
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
////     1.获得请求管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//
//    // 2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WBAccountTool account].access_token;
//    WBStatus *lastStatus =  [self.statuses lastObject];
//    if (lastStatus) {
//        // max_id    false    int64    若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
//    }
//
//    WBTableFooterView *footerView = (WBTableFooterView *)self.tableView.tableFooterView;
//    // 3.发送GET请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
//    progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
//        // 微博字典数组
//        NSArray *statusDictArray = responseObject[@"statuses"];
//        // 微博字典数组 ---> 微博模型数组
//        NSArray *newStatuses = [WBStatus mj_objectArrayWithKeyValuesArray:statusDictArray];
//        
//        // 将新数据插入到旧数据的最后面
//        [self.statuses addObjectsFromArray:newStatuses];
//        
//        // 重新刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [footerView stop];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        WBLog(@"请求失败--%@", error);
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [footerView stop];
//    }];
}

#pragma mark - WBMenuViewDelegate
- (void)WBMenuViewDidCoverClick
{
    WBTitleBtn *titleBtn = (WBTitleBtn *)self.navigationItem.titleView;
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    self.tableView.tableFooterView.hidden = !self.statuses.count;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    WBStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    cell.detailTextLabel.text = status.user.name;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    WBTableFooterView *footerView = (WBTableFooterView *)self.tableView.tableFooterView;
    
    [footerView start];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    WBTableFooterView *footerView = (WBTableFooterView *)self.tableView.tableFooterView;
    
    if (footerView.hidden || !footerView.isRefreshStatus) return;
    
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    CGFloat pullBottomHeight = contentHeight - offSetY;
    CGFloat pullShowTableViewHeight = self.view.height - self.navigationController.navigationBar.height;
    
    if (pullShowTableViewHeight >= pullBottomHeight + 30) {
        
        // 刷新数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self loadMoreStatuses];
        });
    }
}

@end
