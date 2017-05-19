//
//  HBProgress.h
//  HBProgress
//
//  Created by lihanbo on 17-05-18.
//  Copyright (c) 2017年 lihanbo. All rights reserved.
//





#import <UIKit/UIKit.h>


@interface HBProgress : UIView
//正在加载，在那个View上
+ (void)showInView:(UIView*)view status:(NSString*)string;
//消失
+ (void)dismiss; 
//几秒后消失（包括成功和失败都可以调用）
+ (void)dismissWithStatus:(NSString *)string afterDelay:(NSTimeInterval)seconds;

@end
