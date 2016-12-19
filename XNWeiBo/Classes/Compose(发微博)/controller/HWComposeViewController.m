//
//  HWComposeViewController.m
//  XNWeiBo
//
//  Created by 许楠 on 15/11/5.
//  Copyright © 2015年 CLT. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWTextView.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolbar.h"
#import "HWComposePhotosView.h"
#import "HWEmotionKeyboard.h"
#import "HWEmotion.h"
#import "HWEmotionTextView.h"


@interface HWComposeViewController () <UITextViewDelegate, HWComposeToolbarDelegete, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入框控件 */
@property (nonatomic, weak) HWEmotionTextView *textView;
/** 工具条控件 */
@property (nonatomic, weak) HWComposeToolbar *toolbar;
/** 相册(存放拍照或者相册中选择的图片) */
@property (nonatomic, weak) HWComposePhotosView *photosView;
#warning 一定要用strong
/** 表情框 */
@property (nonatomic, strong) HWEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL *swithcingKeyBoard;
@end

@implementation HWComposeViewController

#pragma mark - 懒加载
- (HWEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
         self.emotionKeyboard = [[HWEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}

#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 不自动调整Scrollview的Inset  默认是yes
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航栏
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotoView];
}
/**
 *  添加相册
 */
- (void)setupPhotoView
{
    HWComposePhotosView *photosView = [[HWComposePhotosView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height; // 高度随便设置
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    HWLog(@"%@",NSStringFromUIEdgeInsets(self.textView.contentInset));
}

#pragma mark - 初始化方法
/**
 *  添加工具条
 */
- (void)setupToolbar
{
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    // 设置显示在键盘顶部的内容 inputAccessoryView
//    self.textView.inputAccessoryView = toolbar;
    
}

/**
 *  添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中 textView的contentInset.top 默认等于64
    HWEmotionTextView *textView = [[HWEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    // textView在垂直方向上弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享你的新鲜事...";
    
    textView.placeholderColor = rgb(150, 150, 150);
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    [textView becomeFirstResponder];
    
    // 监听文字改变的通知
    [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    
    // 监听键盘弹出
    // 键盘的frame发生改变就会调用(位置和尺寸)
//    UIKeyboardWillChangeFrameNotification
//    UIKeyboardDidChangeFrameNotification
     // 键盘显示的时候发出的通知
//    UIKeyboardWillShowNotification
//    UIKeyboardDidShowNotification
    // 键盘隐藏的时候发出的通知
//    UIKeyboardWillHideNotification
//    UIKeyboardDidHideNotification
    
    // 监听键盘事件
    [HWNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听表情选中
    [HWNotificationCenter addObserver:self selector:@selector(HWEmotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];


    // 删除文字的通知
    [HWNotificationCenter addObserver:self selector:@selector(textDidDelegate) name:HWEmotionDeleteNotification object:nil];
}
/**
 *  键盘的frame发生改变时调用(显示,隐藏等)
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
//    HWLog(@"%@",notification);
    /*
    notification.userInfo
    UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 258}},
    // 键盘弹出后的frame
    UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 538},
    
    UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}},
    UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 409}, {375, 258}},
    // 键盘弹出用的时间
    UIKeyboardAnimationDurationUserInfoKey = 0.25,
    UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 796},
    // 键盘弹出\隐藏动画执行节奏(先快慢等)
    UIKeyboardAnimationCurveUserInfoKey = 7,
    UIKeyboardIsLocalUserInfoKey = 1
     */
    
    // 正在切换键盘 就不要执行下面的代码
//    if (self.swithcingKeyBoard) return;
    
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 判断是否超过了self.view.height
        if (keyboardFrame.origin.y >= self.view.height) { // 键盘的y值已经远远的超过了控制器的view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            // 工具条的y值 == 键盘的y值 - 工具条的高度
            self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
        }
    }];
}

- (void)HWEmotionDidSelect:(NSNotification *)notification
{
    HWEmotion *emotion = notification.userInfo[HWEmotionDidSelectKey];
    
    [self.textView insertEmotion:emotion];
    
}

/**
 *  键盘上的删除
 *
 */
- (void)textDidDelegate
{
    // 回删
    [self.textView deleteBackward];
}


/**
 *  监听文字改变的改变状态
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [HWAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.y = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        
        // 自动换行
        titleView.numberOfLines = 0;
        
        // 创建一个带有属性的字符串(比如颜色属性,字体属性等文字属性)
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"发微博\n%@",name]];
        
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:NSMakeRange(0, 3)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:rgb(69, 69, 69) range:NSMakeRange(0, 3)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(3, [HWAccountTool account].name.length+1)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:rgb(187, 187, 187) range:NSMakeRange(4, [HWAccountTool account].name.length)];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}
#pragma mark 监听方法
/**
 *  取消按钮
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送按钮 发微博
 */
- (void)sendClick
{
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送不带图片的微博
 */
- (void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /** status string 要发布的微博内容不超过140个汉字 */
    /** access_token string  true 用户 */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    //创建字典
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    //2.拼接请求参数
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            [MBProgressHUD showSuccess:@"发送成功"];
            HWLog(@"请求成功%@",responseObject);
    
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"发送失败"];
    
            HWLog(@"请求失败%@",error);
        }];
    

}

/**
 *  发送带有图片的微博
 */
- (void)sendWithImage
{
    
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /** status string 要发布的微博内容不超过140个汉字 */
    /** access_token string  true 用户 */
    //1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    //创建字典
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    /** pic binary 要发布的微博的配图 */
    // 2.拼接请求参数 上传图片
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        HWLog(@"请求成功%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        
        HWLog(@"请求失败%@",error);
    }];
    
}


#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - HWComposeToolbarDelegate
- (void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HWComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            break;
        case HWComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
        case HWComposeToolbarButtonTypeMention: // @
        HWLog(@"-@--");

            break;
        case HWComposeToolbarButtonTypeTrend: // #
        HWLog(@"-#--");
            break;
        case HWComposeToolbarButtonTypeEmotion: // 表情
            // 切换键盘
            [self switchKeyboard];
            break;
    }
}
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil 说明使用的系统键盘
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
        self.textView.inputView = self.emotionKeyboard;
        // 显示键盘图标
        self.toolbar.showEmotionButton = YES;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图标
        self.toolbar.showEmotionButton = NO;
    }
    
    // 退出键盘
    [self.textView endEditing:YES];
    
    // 延迟一秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
        
    });
    

}


#pragma mark 打开相机
/**
 *  如果想要自己写一个图片选择控制器,得利用AssetsLibrary.framework 利用这个框架可以获取手机上的所有相册图片
 */
- (void)openCamera
{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark 打开相册
- (void)openAlbum
{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}
/**
 *  调用相机相册
 */
- (void)openImagePicker:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
/**
 *  从控制器选择完图片 后 调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // info中就包含了选择的图片
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    [self.photosView addPhoto:image];
    
}




- (void)dealloc
{
    [HWNotificationCenter removeObserver:self];
}









































//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowColor = [UIColor blueColor];
//    shadow.shadowBlurRadius = 2;
//    shadow.shadowOffset = CGSizeMake(1, 1);
//    [attrStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(4, [HWAccountTool account].name.length)];

@end
