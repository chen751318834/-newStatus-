//
//  RCSendStatusViewController.m
//  高仿微博
//
//  Created by Raychen on 15/4/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSendStatusViewController.h"
#import "HWEmotionTextView.h"
#import "RCSendStatusTool.h"
#import "RCSendStatusParam.h"
#import "RCAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "RCSendStatusToolBar.h"
#import "UIView+Extension.h"
#import "HWEmotionKeyboard.h"
#import "HWConst.h"
#import "HWEmotion.h"
#import "RCSendStatusPhotoView.h"
@interface RCSendStatusViewController () <UITextViewDelegate,RCSendStatusToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak) HWEmotionTextView * textView;
@property(nonatomic,weak) RCSendStatusToolBar * toolBar;
@property(strong,nonatomic) HWEmotion * emotion;
@property(nonatomic,weak) RCSendStatusPhotoView * photoView;
@property(nonatomic,weak) UIImage * image;

@end
@implementation RCSendStatusViewController
#pragma mark - 初始化
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setUpNavigationBar];
    [self setUpTextView];
    [self setUpPhotoView];

    [self setUpToolBar];
    [self setUpNotifactionCenter];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.textView endEditing:YES];
}
/**
 *  设置导航栏
 */
- (void)setUpNavigationBar{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
    
    //标题
    NSString * name = [RCAccountTool account].name;
    NSString * str = [NSString stringWithFormat:@"发微博\n%@",name];
    if (name) {
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString * attrText = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range = NSMakeRange(0, 2);
        [attrText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:range];
        [titleLabel setAttributedText:attrText];
        
        [attrText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        [titleLabel setAttributedText:attrText];
        self.navigationItem.titleView = titleLabel;
    }
   }
#pragma mark - 设置输入控件

- (void)setUpTextView{
    HWEmotionTextView * textView = [[HWEmotionTextView alloc]initWithFrame:self.view.bounds];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeHolder = @"分享新鲜事.....";
    [self.view addSubview:textView];
    self.textView = textView;

}

#pragma mark - 发送微博

- (void)sendStatus{
    
    RCSendStatusParam * param = [[RCSendStatusParam alloc]init];
    param.access_token = [RCAccountTool account].access_token;
    param.status = [self.textView fullText];
    
    
    if (self.photoView.subviews.count) {  //有图片
        
        [self sendImageStatusWithParam:param];
    }else{
        [self sendStatusWithParam:param];

    
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送带有图片的微博
 *
 */
- (void)sendImageStatusWithParam:(RCSendStatusParam *)param{
    NSData * imageData = UIImageJPEGRepresentation(self.image, 0.5);

    [RCSendStatusTool sendOneImageStatusWithparam:param data:imageData success:^(RCSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];

    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@",error);

    }];

}
/**
 *  发送只有文本的微博
 *
 */
- (void)sendStatusWithParam:(RCSendStatusParam *)param{
    [RCSendStatusTool sendOneStatusWithparam:param success:^(RCSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@",error);
        
    }];

}
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}
#pragma mark - 设置工具条
- (void)setUpToolBar{
    RCSendStatusToolBar * toolBar = [[RCSendStatusToolBar alloc]init];
//    toolBar.backgroundColor = [UIColor redColor];
    CGFloat toolBarW = self.view.bounds.size.width;
    CGFloat toolBarH = 44;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = self.view.bounds.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    [self.view addSubview:toolBar];
    toolBar.delegate = self;
    self.toolBar = toolBar;

}
#pragma mark - 设置通知中心

- (void)setUpNotifactionCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     //选中表情按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedEmtionButton:) name:HWEmotionDidSelectNotification object:nil];;
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickedDeleteButton) name:HWEmotionDidDeleteNotification object:nil];;

}
- (void)didSelectedEmtionButton:(NSNotification *)note{
    HWEmotion * emtion = note.userInfo[HWSelectEmotionKey];
    self.emotion = emtion;
    [self.textView insertEmotion:emtion];
 
    
}
- (void)didClickedDeleteButton{
    [self.textView deleteBackward];
}
/**
 *  键盘的即将隐藏
 *
 */
- (void)keyBoardWillHide:(NSNotification *)note{
     CGFloat  duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
   [UIView animateWithDuration:duration animations:^{
       self.toolBar.transform = CGAffineTransformIdentity;
   }];
}
/**
 *  键盘的即将显示
 *
 */
- (void)keyBoardWillShow:(NSNotification *)note{
    NSLog(@"%@",note.userInfo);
      CGFloat  duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    }];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];;
    
}
#pragma mark - RCSendStatusToolBarDelegate
- (void)sendStatusToolBar:(RCSendStatusToolBar *)toolBar didClickedButtonType:(RCSendStatusToolBarButtonType)buttonType{
    switch (buttonType) {
        case RCSendStatusToolBarButtonTypePicture:
            [self openPicture];
                  break;
        case RCSendStatusToolBarButtonTypeMention:
//            NSLog(@"RCSendStatusToolBarButtonTypeMention");

            break;
        case RCSendStatusToolBarButtonTypeTrend:
//            NSLog(@"RCSendStatusToolBarButtonTypeTrend");

            break;
        case RCSendStatusToolBarButtonTypeMoticon:
        {
            HWEmotionKeyboard * keyBoard = [[HWEmotionKeyboard alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 258)];
            if (self.textView.inputView == nil) {
                //正在显示系统自动键盘
                self.textView.inputView = keyBoard;
            }else{  //正在显示表情键盘
                self.textView.inputView = nil;
            }
         [self.textView reloadInputViews];
           
        }

            break;
        case RCSendStatusToolBarButtonTypeMore:
//            NSLog(@"RCSendStatusToolBarButtonTypeMore");
            break;
            
        default:
            break;
    }



}
/**
 *  打开相册
 */
- (void)openPicture{
    UIImagePickerController * imagePickerC = [[UIImagePickerController alloc]init];
    imagePickerC.delegate = self;
    [self presentViewController:imagePickerC animated:YES completion:nil];

}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    self.image = image;
    //设置图片
    self.photoView.photo = image;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{


}
#pragma mark - 设置显示图片的View
- (void)setUpPhotoView{
    RCSendStatusPhotoView * photoView = [[RCSendStatusPhotoView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.size.height - 200)];
    photoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:photoView];
    self.photoView = photoView;

}
@end
