//
//  WBHomeViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/24.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBOneViewController.h"

@interface WBHomeViewController ()

@end

@implementation WBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建左按钮
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem createWithImgName:@"navigationbar_friendsearch" selectedImgName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(frendSearch)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    // 2. 创建右按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createWithImgName:@"navigationbar_pop" selectedImgName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
