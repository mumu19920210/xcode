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
#import "WBTableFooterView.h"
#import "WBStatusTool.h"
#import "WBUserTool.h"
#import "WBStatusTableViewCell.h"
#import "WBStatusFrame.h"

@interface WBHomeViewController () <WBMenuViewDelegate>

@property(nonatomic, weak) WBMenuView *menu;
/** 所有的微博数据 */
@property (nonatomic, strong) NSMutableArray *statuses;

/** statusFrames */
@property (nonatomic, strong) NSArray *statusFrames;

@property (nonatomic, weak) UILabel *updateLabel;

@property (nonatomic, weak) WBTableFooterView *footerView;

@property (nonatomic, weak) WBTitleBtn *titleBtn;

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
    
    // 获取个人信息
    [self setupUserInfo];
    
    // 获取未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(noReadStatuscCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

// 获取未读微博数
- (void)noReadStatuscCount
{
    WBNoReadStatusParams *params = [[WBNoReadStatusParams alloc] init];
    params.uid = [WBAccountTool account].uid;
    
    [WBStatusTool noReadStatusWithPatams:params success:^(WBNoReadStatusResult * _Nonnull result) {
       
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.status;
        
    } failure:^(NSError * _Nonnull error) {
        self.tabBarItem.badgeValue = @"我读错了";
        self.tabBarItem.badgeColor = [UIColor blackColor];
    }];
}

// 获取个人信息
- (void)setupUserInfo
{
    WBAccount *account = [WBAccountTool account];
    if (account.screen_name) {
        [self.titleBtn setTitle:account.screen_name forState:UIControlStateNormal];
        [self.titleBtn setTitle:account.screen_name forState:UIControlStateHighlighted];
    }
    
    WBUserInfoParams *params = [[WBUserInfoParams alloc] init];
    params.access_token = [WBAccountTool account].access_token;
    params.uid = [WBAccountTool account].uid;
    
    [WBUserTool userInfoWithPatams:params success:^(WBUserInfoResult * _Nonnull result) {
        // screen_name是用户昵称
        NSString *screen_name = result.screen_name;
        [self.titleBtn setTitle:screen_name forState:UIControlStateNormal];
        [self.titleBtn setTitle:screen_name forState:UIControlStateHighlighted];

        // 缓存至account当中
        [WBAccountTool account].screen_name = screen_name;
        [WBAccountTool save:[WBAccountTool account]];
        
    } failure:^(NSError * _Nonnull error) {
        WBLog(@"%@", error.domain);
    }];
}

- (void)setupDownRefreshView
{
    WBTableFooterView *footerView = [WBTableFooterView footerView];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    
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
    WBReadStatusParams *params = [[WBReadStatusParams alloc] init];
    WBStatus *status = (WBStatus *)[self.statuses firstObject];
    if (status) {
        params.since_id = status.idstr;
    }
    
    [WBStatusTool readStatusWithPatams:params success:^(WBReadStatusResult * _Nonnull result) {
        [self updateStatusesWithResult:result];
    } failure:^(NSError * _Nonnull error) {
        WBLog(@"%@", error.domain);
    }];
}

- (void)updateStatusesWithResult:(WBReadStatusResult *)result
{
    NSArray *statusesArray = result.statuses;
    
    NSRange insertRange = NSMakeRange(0, statusesArray.count);
    NSIndexSet *insertSet = [NSIndexSet indexSetWithIndexesInRange:insertRange];
    [self.statuses insertObjects:statusesArray atIndexes:insertSet];
    
    self.statusFrames = [self statusFrameWithArray:self.statuses];
    
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
    self.titleBtn = titleBtn;
    
    [titleBtn addTarget:self action:@selector(popMenuClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleBtn setTitle:@"首页" forState: UIControlStateNormal];
    [titleBtn setTitle:@"首页" forState: UIControlStateHighlighted];
    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleBtn setBackgroundImage:[UIImage imageRemakeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    titleBtn.width = 100;
    titleBtn.height = 35;
    self.navigationItem.titleView = titleBtn;
    
    UIImage *image = [[UIImage alloc] init];
    
    // 去掉navigationBar底部的那条黑线
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
    // navigationBar变透明了，没关系，设置纯色背景
     [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    // 设置半透明
    self.navigationController.navigationBar.translucent = YES;
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
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    WBReadStatusParams *params = [[WBReadStatusParams alloc] init];
    WBStatus *lastStatus =  [self.statuses lastObject];
    if (lastStatus) {
        // max_id    false    int64    若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params.max_id = [NSString stringWithFormat:@"%lld", ([lastStatus.idstr longLongValue] - 1)];
    }

    [WBStatusTool readStatusWithPatams:params success:^(WBReadStatusResult * _Nonnull result) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            // 微博字典数组
            NSArray *statusDictArray = result.statuses;
            // 微博字典数组 ---> 微博模型数组
            NSArray *newStatuses = [WBStatus mj_objectArrayWithKeyValuesArray:statusDictArray];

            // 将新数据插入到旧数据的最后面
            [self.statuses addObjectsFromArray:newStatuses];
            
            self.statusFrames = [self statusFrameWithArray:self.statuses];

            // 重新刷新表格
            [self.tableView reloadData];

            // 让刷新控件停止刷新（恢复默认的状态）
            [self.footerView stop];
        });
    } failure:^(NSError * _Nonnull error) {
        WBLog(@"%@", error.domain);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footerView stop];
    }];
}

- (NSArray *)statusFrameWithArray:(NSArray *)statuses
{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (WBStatus *status in statuses) {
        WBStatusFrame *statusFrame = [[WBStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
}

#pragma mark - 内部方法
- (void)pullToTop
{
    NSIndexPath *firstRowPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:firstRowPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
//    [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
    
    if (self.tabBarItem.badgeValue.integerValue > 0) {
        // 刷新数据
        self.tabBarItem.badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self.refreshControl beginRefreshing];
        [self refreshAllStatuses];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return CGRectGetMaxY(statusFrame.foolterViewFrame);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WBStatusTableViewCell *cell = [WBStatusTableViewCell cellWithTabelView:tableView];
    
    WBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollView

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    CGFloat pullBottomHeight = contentHeight - offSetY;
    CGFloat pullShowTableViewHeight = self.view.height - self.navigationController.navigationBar.height;
    
    if (pullShowTableViewHeight >= pullBottomHeight - 10) {
        
        self.footerView.upPullMoreStatusText = @"上拉加载更多微博.....";
        [self.footerView start];
    }
    
    
    if (self.footerView.hidden || !self.footerView.isRefreshStatus) return;
    
    if (pullShowTableViewHeight >= pullBottomHeight + 30) {
        
        self.footerView.upPullMoreStatusText = @"正在加载更多微博.....";
        
        // 刷新数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self loadMoreStatuses];
        });
    }
}

@end
