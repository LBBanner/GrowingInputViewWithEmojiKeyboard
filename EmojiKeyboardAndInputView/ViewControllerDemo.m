//
//  ViewControllerDemo.m
//  EmojiKeyboardAndInputView
//
//  Created by CoderXu on 16/7/8.
//  Copyright © 2016年 CoderXu. All rights reserved.
//

#import "ViewControllerDemo.h"
#import "GrowingInputView.h"
@interface ViewControllerDemo ()<GrowingInputViewDelegate>
{
    GrowingInputView *_growingInputView;//自动增长的输入框
    BOOL _showKeyBoard;
    NSInteger _keyboardHeight;//键盘实际高度
    BOOL _keyboardVisible;
    
    BOOL _canResetGrowingInputView;
}

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGrowingInputView];
}
-(void)setupGrowingInputView {
    if (_growingInputView == nil) {
        _growingInputView = [[GrowingInputView alloc] initWithFrame:CGRectZero];
        _growingInputView.frame = CGRectMake(0, self.view.frame.size.height - [GrowingInputView defaultHeight], self.view.frame.size.width, [GrowingInputView defaultHeight]);
        _growingInputView.placeholder = @"我来说点什么吧~";
        _growingInputView.delegate = self;
        _growingInputView.parentView = self.view;
        
        [self.view addSubview:_growingInputView];
    }
    _growingInputView.hidden = NO;
    //手动激活,调键盘
    [_growingInputView activateInput];
}
#pragma mark - GrowingInputView输入框代理
//输入框改变高度时调用
- (void)growingInputView:(GrowingInputView *)growingInputView didChangeHeight:(CGFloat)height keyboardVisible:(BOOL)keyboardVisible
{
    _keyboardVisible = keyboardVisible;
    if (keyboardVisible) {
        _keyboardHeight = height;
        
    } else {
        _keyboardHeight = 0;
    }
}
//输入框结束编辑
- (void)growingTextViewDidEndEditing:(GrowingInputView *)growingInputView
{
    [self resetGrowingInputView];
    _canResetGrowingInputView = YES;
}
//输入框开始编辑
- (BOOL)growingTextViewShouldBeginEditing:(GrowingInputView *)growingInputView
{
    _canResetGrowingInputView = YES;
    return YES;
}
//点击发送按钮
- (BOOL)growingInputView:(GrowingInputView *)growingInputView didSendText:(NSString *)text
{
    if (text.length>60) {
        
    }
    self.label.text = [self.label.text stringByAppendingString:text];
    return YES;
    
}
//清空输入框
- (void)resetGrowingInputView
{
    if (_canResetGrowingInputView == YES) {
        _growingInputView.placeholder = @"我来说点什么吧~";
    }
}
//切换Emoji
- (void)growingInputViewEmojiBtnClick:(GrowingInputView *)growingInputView
{
    _canResetGrowingInputView = NO;
}
//收到滑动手势时,会自动退键盘,并调用该方法
-(void)growingInputView:(GrowingInputView *)growingInputView didRecognizer:(id)sender {
    
}

- (void)growingWillShow:(GrowingInputView *)growingInputView
{
    
}
- (void)growingWillHide:(GrowingInputView *)growingInputView
{
    
}
- (void)growingDidHide:(GrowingInputView *)growingInputView
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
