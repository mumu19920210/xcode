//
//  WBTwoViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBTwoViewController.h"
#import "WBThreeViewController.h"

@interface WBTwoViewController ()
- (IBAction)jump;
@end

@implementation WBTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    int (^block)(void) = ^(){
        return 1;
    };
    
    int a = block();
    
    WBLog(@"%d", a);
    
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
    WBThreeViewController *threeVc = [[WBThreeViewController alloc] init];
    threeVc.title = @"threeVc";
    [self.navigationController pushViewController:threeVc animated:YES];
}
@end
