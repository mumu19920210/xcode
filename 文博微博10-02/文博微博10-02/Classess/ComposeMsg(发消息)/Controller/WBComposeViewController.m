//
//  WBComposeViewController.m
//  文博微博
//
//  Created by 胡文博 on 2018/2/26.
//  Copyright © 2018年 胡文博. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBTextView.h"
#import "WBComposeToolBarView.h"
#import "WBComposeImageView.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "MBprogressHUD+MJ.h"

@interface WBComposeViewController () <WBComposeToolBarViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (nonatomic, weak) WBComposeToolBarView *toolBarView;
@property (nonatomic, weak) WBComposeImageView *chooseImageView;
@property (nonatomic, weak) WBTextView *textView;
@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发消息";
    
    // 设置左右按钮
    [self setupNavBtn];
    
    // 设置TextView
    [self setupTextView];
    
    // 设置ChooseImageView
    [self setupChooseImageView];
    
    // 设置composeToolBar
    [self setupComposeToolBar];
}

// 设置ChooseImageView
- (void)setupChooseImageView
{
    WBComposeImageView *chooseImageView = [[WBComposeImageView alloc] init];
    [self.view addSubview:chooseImageView];
    self.chooseImageView = chooseImageView;
    
    chooseImageView.y = 200;
    chooseImageView.width = self.view.width;
    chooseImageView.height = self.view.height - chooseImageView.y;
}

// 设置composeToolBar
- (void)setupComposeToolBar
{
    WBComposeToolBarView *toolBarView = [[WBComposeToolBarView alloc] init];
    [self.view addSubview:toolBarView];
    self.toolBarView = toolBarView;
    
    toolBarView.height = 44;
    toolBarView.width = self.view.width;
    toolBarView.y = self.view.height - toolBarView.height;
    
    toolBarView.delegate = self;
    
    // 监听键盘弹起、隐藏等事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *keyBoardDict = notification.userInfo;
    
    CGFloat keyboardHeight = [keyBoardDict[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if (keyboardHeight >= 250) {
        self.toolBarView.y -= keyboardHeight;
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    self.toolBarView.y = self.view.height - self.toolBarView.height;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 设置TextView
- (void)setupTextView
{
    WBTextView *textView = [[WBTextView alloc] init];
    textView.delegate = self;
    [self.view addSubview:textView];
    textView.placeHolder = @"请输入文字...";
    
    textView.frame = self.view.bounds;
    self.textView = textView;
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
    // 发送微博
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送post请求
    
    if (!self.chooseImageView.image) {
        // 不带图片
        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
         progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
             
             [MBProgressHUD showSuccess:@"发表成功"];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             WBLog(@"请求失败--%@", error);
             
             [MBProgressHUD showError:@"发表失败"];
         }];
    } else {
        // 带图片
        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
            NSData *updataImg = UIImageJPEGRepresentation(self.chooseImageView.image, 1.0);
            
            [formData appendPartWithFileData:updataImg name:@"pic" fileName:@"updata.jpg" mimeType:@"JPG"];
            
        } progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
            [MBProgressHUD showSuccess:@"发表成功"];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [MBProgressHUD showError:@"发表失败"];
        }];
    }
}

#pragma mark - WBComposeToolBarViewDelegate
- (void)WBComposeToolBarViewDidButtonClick:(WBComposeToolBarButtonType)type
{   
    switch (type) {
        case WBComposeToolBarButtonCamere:
            WBLog(@"照相");
            [self setupCamera];
            break;
        case WBComposeToolBarButtonPicture:
            WBLog(@"照片");
            [self setupPicture];
            break;
        default:
            WBLog(@"暂时没实现其功能");
            break;
    }
}

- (void)setupCamera
{
    UIImagePickerController *imagePickVC = [[UIImagePickerController alloc] init];
    imagePickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickVC animated:YES completion:nil];
}

- (void)setupPicture
{
    UIImagePickerController *imagePickVC = [[UIImagePickerController alloc] init];
    imagePickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickVC.delegate = self;
    [self presentViewController:imagePickVC animated:YES completion:nil];
}

#pragma - mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.chooseImageView.image = originalImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.textView becomeFirstResponder];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

@end
