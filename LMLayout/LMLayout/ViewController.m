//
//  ViewController.m
//  LMLayout
//
//  Created by lemon on 2017/12/7.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import "ViewController.h"
#import "UIView+layout.h"

@interface ViewController ()
- (IBAction)updateLayout:(id)sender;
- (IBAction)remakeLayout:(id)sender;
@property (nonatomic, weak) UIView *grayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *redview = [[UIView alloc]init];
    redview.backgroundColor = [UIColor redColor];
    
    
    UIView *blackView = [[UIView alloc]init];
    blackView.backgroundColor = [UIColor blackColor];
    
    UIView *greenView = [[UIView alloc]init];
    greenView.backgroundColor = [UIColor greenColor];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    
    UIView *grayView = [[UIView alloc]init];
    self.grayView = grayView;
    grayView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:redview];
    [self.view addSubview:blackView];
    [self.view addSubview:greenView];
    [self.view addSubview:yellowView];
    [self.view addSubview:grayView];

    [redview makeLayout:^void(LMLayout *layout) {
        layout.width.equalTo(@(80));
        layout.height.equalTo(@80);
        layout.left.equalTo(self.view.lm_left).offSet(20);
        layout.top.equalTo(self.view.lm_top).offSet(20);
    }];
    
    [blackView makeLayout:^(LMLayout *layout) {
        layout.left.equalTo(redview.lm_right).offSet(20);
        layout.right.equalTo(self.view.lm_right).offSet(-20);
        layout.top.equalTo(redview.lm_top);
        layout.bottom.equalTo(redview.lm_bottom);
    }];
    
    [greenView makeLayout:^(LMLayout *layout) {
        layout.left.equalTo(self.view.lm_left);
        layout.right.equalTo(self.view.lm_centerX).offSet(-10);
        layout.top.equalTo(redview.lm_bottom).offSet(20);
        layout.height.equalTo(redview.lm_height);
    }];
    
    [yellowView makeLayout:^(LMLayout *layout) {
        layout.left.equalTo(self.view.lm_centerX).offSet(10);
        layout.right.equalTo(self.view.lm_right);
        layout.top.equalTo(greenView.lm_top);
        layout.bottom.equalTo(greenView.lm_bottom);
    }];
   
    [grayView makeLayout:^(LMLayout *layout) {
        layout.left.equalTo(self.view.lm_left);
        layout.right.equalTo(self.view.lm_right);
        layout.top.equalTo(yellowView.lm_bottom).offSet(20);
        layout.height.equalTo(@100);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updateLayout:(id)sender {
    [self.grayView updateLayout:^(LMLayout *layout) {
        layout.height.equalTo(@50);
    }];
}

- (IBAction)remakeLayout:(id)sender {
    [self.grayView remakeLayout:^(LMLayout *layout) {
        layout.left.equalTo(self.view.lm_left);
        layout.right.equalTo(self.view.lm_right);
        layout.top.equalTo(self.view.lm_bottom).offSet(-200);
        layout.height.equalTo(@20);
    }];
}
@end
