//
//  GuideView.m
//  GuideDemo
//
//
//  Created by mrwang90hou on 2018/11/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GuideView.h"
#import "UIView+Layout.h"
#import "UIImage+Mask.h"

@interface GuideView ()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) UIView *maskBg;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIImageView *btnMaskView;
@property (nonatomic, strong) UIImageView *arrwoView;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, weak) UIButton *maskBtn;
@property (nonatomic, strong) UIButton *maskBtn2;

@property (nonatomic, strong) UIView *topMaskView;
@property (nonatomic, strong) UIView *bottomMaskView;
@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.leftMaskView];
        [self addSubview:self.rightMaskView];
        [self addSubview:self.okBtn];
        [self addSubview:self.btnMaskView];
        [self addSubview:self.maskBtn2];
        [self addSubview:self.arrwoView];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = _parentView.bounds;
    _maskBg.frame = self.bounds;
    _btnMaskView.center = [_maskBtn.superview convertPoint:_maskBtn.center toView:_maskBtn.superview];
    CGRect btnMaskRect = _btnMaskView.frame;
    btnMaskRect.size = CGSizeMake(floor(btnMaskRect.size.width), floor(btnMaskRect.size.height));
    btnMaskRect.origin = CGPointMake(floor(btnMaskRect.origin.x), floor(btnMaskRect.origin.y));
    _btnMaskView.frame = btnMaskRect;
    
    _topMaskView.left = 0;
    _topMaskView.top = 0;
    _topMaskView.height = _btnMaskView.top;
    _topMaskView.width = self.width;
    
    _bottomMaskView.left = 0;
    _bottomMaskView.top = _btnMaskView.bottom;
    _bottomMaskView.width = self.width;
    _bottomMaskView.height = self.height - _bottomMaskView.top;
    
    _leftMaskView.left = 0;
    _leftMaskView.top = _btnMaskView.top;
    _leftMaskView.width = _btnMaskView.left;
    _leftMaskView.height = _btnMaskView.height;
    
    _rightMaskView.left = _btnMaskView.right;
    _rightMaskView.top = _btnMaskView.top;
    _rightMaskView.width = self.width - _rightMaskView.left;
    _rightMaskView.height = _btnMaskView.height;
    
    _arrwoView.left = _btnMaskView.centerX;
    _arrwoView.top = _btnMaskView.centerY - 8;
    _maskBtn2.frame = _maskBtn.frame;
    
    _tipsLabel.centerX = _arrwoView.centerX - 6;
    _tipsLabel.top = _arrwoView.bottom + 20;
    
    _okBtn.centerX = self.width/2;
    _okBtn.bottom = self.height - self.width/10;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)showInView:(UIView *)view maskBtn:(UIButton *)btn {
    self.parentView = view;
    self.maskBtn = btn;
    
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




#pragma mark - getter and setter
- (UIButton *)maskBtn2{
    if (!_maskBtn2) {
        //btn
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"new_hand_btn_tips"] forState:UIControlStateNormal];
//        [self addSubview:btn];
        [btn setUserInteractionEnabled:NO];
        _maskBtn2 = btn;
    }
    return _maskBtn2;
}

- (UIView *)maskBg {
    if (!_maskBg) {
        UIView *view = [[UIView alloc] init];
        _maskBg = view;
    }
    return _maskBg;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_hand_btn"] forState:UIControlStateNormal];
        UIFont *font = [UIFont fontWithName:@"Hanzipen SC" size:21];
        btn.titleLabel.font = font;
        [btn setTitle:@"知道啦！" forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _okBtn = btn;
    }
    return _okBtn;
}
- (UIImageView *)arrwoView {
    if (!_arrwoView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_hand_gesturn"]];
        _arrwoView = imageView;
    }
    return _arrwoView;
}
- (UIImageView *)btnMaskView {
    if (!_btnMaskView) {
        UIImageView *image = [[UIImageView alloc]init];
//        image = [image maskImage:[[UIColor blackColor] colorWithAlphaComponent:0.71]];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [_btnMaskView setHidden:YES];
        UIView *uiView = [[UIView alloc]init];
        uiView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        [_btnMaskView addSubview:uiView];
        uiView.frame = _btnMaskView.frame;
        _btnMaskView = image;
        
    }
    return _btnMaskView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"点击“点击充电”按钮，\n开始充电吧！";
        tipsLabel.numberOfLines = 0;
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        [tipsLabel setFont:[UIFont fontWithName:@"gangbi" size:21]];
        UIFont *font = [UIFont fontWithName:@"Hanzipen SC" size:21];
        tipsLabel.font = font;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [tipsLabel sizeToFit];
        _tipsLabel = tipsLabel;
    }
    return _tipsLabel;
}

- (UIView *)topMaskView {
    if (!_topMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _topMaskView = view;
    }
    return _topMaskView;
}

- (UIView *)bottomMaskView {
    if (!_bottomMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _bottomMaskView = view;
    }
    return _bottomMaskView;
}

- (UIView *)leftMaskView {
    if (!_leftMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _leftMaskView = view;
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView {
    if (!_rightMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _rightMaskView = view;
    }
    return _rightMaskView;
}

@end
