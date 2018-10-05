//
//  WBOneViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBOneViewController.h"
#import "WBTwoViewController.h"

@interface WBOneViewController ()
- (IBAction)jump;
@end

@implementation WBOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jump {
    WBTwoViewController *twoVc = [[WBTwoViewController alloc] init];
    twoVc.title = @"two";
    [self.navigationController pushViewController:twoVc animated:YES];
}
@end
