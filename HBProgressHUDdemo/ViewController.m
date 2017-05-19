//
//  ViewController.m
//  HBProgressHUDdemo
//
//  Created by dev on 2017/5/19.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ViewController.h"
#import "HBProgress.h"
@interface ViewController ()
- (IBAction)show:(UIButton *)sender;

- (IBAction)dismisswithstring:(UIButton *)sender;

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


- (IBAction)show:(UIButton *)sender {
    [HBProgress showInView:self.view status:@"正在加载"];
    //此处模拟网络请求3秒,正常使用可在网络加载成功后直接使用dismiss 失败时使用dismissWithStatus输出错误信息
    [self performSelector:@selector(dismissAct) withObject:nil afterDelay:3.0];
}


- (IBAction)dismisswithstring:(UIButton *)sender {
    [HBProgress showInView:self.view status:@"正在加载"];
    //此处模拟网络请求3秒
    [self performSelector:@selector(errorAct) withObject:nil afterDelay:3.0];
    
}
-(void)dismissAct{
    [HBProgress dismiss];
}
-(void)errorAct{
    //失败时输出的错误信息  持续时间可随意设置
    [HBProgress dismissWithStatus:@"连接失败,请检查您的网络" afterDelay:3.0];
}
@end
