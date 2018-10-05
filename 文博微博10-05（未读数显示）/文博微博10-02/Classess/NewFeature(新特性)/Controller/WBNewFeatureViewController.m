//
//  WBNewFeatureViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/26.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBNewFeatureViewController.h"
#import "WBTabBarController.h"

#define WBMaxImageViewCount 4

@interface WBNewFeatureViewController () <UIScrollViewDelegate>
@property(nonatomic, weak) UIPageControl *pageView;
@end

@implementation WBNewFeatureViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置scrolleView
    [self setupScrollView];
    // 设置pageView
    [self setupPageView];
}

// 设置scrolleView
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    
    // 往scrollView上添加4张UIimageView
    for (int i = 0; i < WBMaxImageViewCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [scrollView addSubview:imageView];
        
        NSString *imageName = @"new_feature_";
        imageName = [imageName stringByAppendingString:[NSString stringWithFormat:@"%zd", i + 1]];
        imageView.image = [UIImage imageNamed:imageName];
        
        // 设置iamgeView的frame
        imageView.y = 0;
        imageView.width = self.view.width;
        imageView.x = imageView.width * i;
        imageView.height = self.view.height;
        
        if (i == WBMaxImageViewCount - 1) {
            [self setupButInImgView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(self.view.width * WBMaxImageViewCount, self.view.height);
//    scrollView.bounces = NO;
    scrollView.backgroundColor = WBColor(246, 246, 246);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
}

- (void)setupButInImgView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    // 设置开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [imageView addSubview:startBtn];
    
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startBtn.backgroundColor = [UIColor redColor];
    
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.center = CGPointMake(self.view.center.x, self.view.height * 0.8);
    
    // 设置分享给大家
    UIButton *shareBtn = [[UIButton alloc] init];
    [imageView addSubview:shareBtn];
    
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 将shareBtn按钮的文字部分内切一段
//    shareBtn.contentEdgeInsets; shareBtn整个内容内切
//    shareBtn.imageEdgeInsets; shareBtn中image整个内容内切
//    shareBtn.titleEdgeInsets; shareBtn中title整个内容内切
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    shareBtn.width = 140;
    shareBtn.height = 35;
    shareBtn.center = CGPointMake(self.view.center.x, self.view.height * 0.7);
}

- (void)startBtnClick:(UIButton *)startBtn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
    window.rootViewController = tabBarVc;
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.selected;
}

// 设置pageView
- (void)setupPageView
{
    UIPageControl *pageView = [[UIPageControl alloc] init];
    self.pageView = pageView;
    [self.view addSubview:pageView];
    
    pageView.currentPage = 1;
    pageView.numberOfPages = 4;
    
    pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    
    pageView.width = 100;
    pageView.height = 30;
    pageView.center = CGPointMake(self.view.center.x, self.view.height * 0.95);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageAtIndex = scrollView.contentOffset.x / self.view.width;
    int currentPageIndex = (int)(pageAtIndex + 0.5);
    self.pageView.currentPage = currentPageIndex;
}

@end
