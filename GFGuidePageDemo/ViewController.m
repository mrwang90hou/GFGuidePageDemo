//
//  ViewController.m
//  GFGuidePageDemo
//
//  Created by mrwang90hou on 2018/11/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Layout.h"
#import "GuideView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    GuideView *guide = [GuideView new];
    [guide showInView:self.view maskBtn:self.button];
}

- (void)viewWillLayoutSubviews {
    _textView.left = 8;
    _textView.top = 60;
    _textView.width = self.view.width - 16;
    _textView.height = self.view.height - 500;
    _button.centerX = self.view.width/2;
    _button.top = _textView.bottom + 16;
}

@end
