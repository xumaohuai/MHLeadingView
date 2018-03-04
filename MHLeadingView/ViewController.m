//
//  ViewController.m
//  MHLeadingView
//
//  Created by 徐茂怀 on 2018/3/4.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "ViewController.h"
#import "MHLeadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"这里是主页";
    UIButton *popUpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    popUpBtn.frame = CGRectMake(100, 100, 150, 40);
    popUpBtn.center = self.view.center;
    [popUpBtn setTitle:@"点击弹出引导页" forState:UIControlStateNormal];
    [popUpBtn addTarget:self action:@selector(clickPopupBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popUpBtn];
}
- (void)clickPopupBtn {
    MHLeadingView *leadView = [[MHLeadingView alloc]initWithImageNames:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"]];
    [leadView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
