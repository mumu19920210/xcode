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
#import "WBChooseImageView.h"

@interface WBComposeViewController () <WBComposeToolBarViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) WBComposeToolBarView *toolBarView;
@property (nonatomic, weak) WBChooseImageView *chooseImageView;
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
    
    // 设置composeToolBar
    [self setupComposeToolBar];
    
    // 设置ChooseImageView
    [self setupChooseImageView];
}

// 设置ChooseImageView
- (void)setupChooseImageView
{
    WBChooseImageView *chooseImageView = [[WBChooseImageView alloc] init];
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
    [self.view addSubview:textView];
    
    textView.placeHolder = @"请输入文字...";
    textView.placeHolderColor = [UIColor grayColor];
    
    textView.width = self.view.width;
    textView.height = 300;
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
}

@end
