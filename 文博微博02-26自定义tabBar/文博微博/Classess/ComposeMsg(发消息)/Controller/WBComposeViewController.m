//
//  WBComposeViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/26.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBComposeViewController.h"

@interface WBComposeViewController ()

@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置左右按钮
    [self setupNavBtn];
}

// 设置左右按钮
- (void)setupNavBtn
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(send)];;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)send
{
    
}

@end
