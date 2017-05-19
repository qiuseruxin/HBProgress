//
//  HBProgress.m

//
//  Created by lihanbo on 17-05-18.
//  Copyright (c) 2017年 lihanbo. All rights reserved.
//

#import "HBProgress.h"

@implementation HBProgress
{
    UIImageView *_centerView;
    UILabel *_titleLabel;
    NSTimer *fadeOutTimer;
    UIView *_maskView;
    UIView *_backView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _centerView = [[UIImageView alloc] init];
        _titleLabel=[[UILabel alloc]init];
        _maskView=[[UIView alloc]init];
        _backView=[[UIView alloc]init];
        [self configUI];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {

        _centerView = [[UIImageView alloc] init];
        _titleLabel=[[UILabel alloc]init];
        _maskView=[[UIView alloc]init];
        _backView=[[UIView alloc]init];
        [self configUI];
    }
    return self;
}
-(void)configUI{
    _maskView.layer.masksToBounds=YES;
    _maskView.layer.cornerRadius=10;

     _maskView.frame=CGRectMake(0, 0, 120, 120) ;

     _maskView.backgroundColor=[UIColor colorWithWhite:0.97 alpha:1];

    CGRect smallFrame=CGRectMake((120-70)/2, 10, 70, 70);
    _centerView.frame =smallFrame;

    [_centerView setImage:[UIImage imageNamed:@"HBProgress.png"]];
    

    _titleLabel.frame=CGRectMake(10, 80, 100, 30);
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.adjustsFontSizeToFitWidth=YES;
    _titleLabel.numberOfLines=0;
    _titleLabel.textColor=[UIColor blackColor];
    
    [_maskView addSubview:_centerView];
    [_maskView addSubview:_titleLabel];
}
static  HBProgress *manager;
+(HBProgress *)shareManager{
    if (manager==nil) {
        manager=[[HBProgress alloc]initWithFrame:CGRectZero];
    }
    return manager;
}
+ (void)showInView:(UIView*)view status:(NSString*)string{
    [[HBProgress shareManager] showInView:view status:string];
}
+ (void)dismiss{
    [[HBProgress shareManager] dismiss];
}
+ (void)dismissWithStatus:(NSString *)string afterDelay:(NSTimeInterval)seconds{
    [[HBProgress shareManager]dismissWithStatus:string afterDelay:seconds];
}


- (void)showInView:(UIView*)view status:(NSString*)string{
   
    //修改 _maskView.center=view.center;(因为在界面上偏下）

    _maskView.center=CGPointMake(view.center.x, view.center.y-30);

    _backView.frame = view.bounds;
    
     [view addSubview:_backView];
    
     [view addSubview:_maskView];

    _titleLabel.text=string;

    
    //中间画面
    [self addAnimationInView:_centerView duration:0.5 valueWithCATransform3D:CATransform3DMakeRotation(M_PI , 0, 0, 0.1)];

}
-(void)dismiss{
    
    [_maskView removeFromSuperview];
    [_backView removeFromSuperview];
}

- (void)dismissWithStatus:(NSString *)string afterDelay:(NSTimeInterval)seconds {
  

    if(fadeOutTimer != nil){
        [fadeOutTimer invalidate];
        fadeOutTimer = nil;
    }
    _titleLabel.text=string;
    [self stopAnation];
    fadeOutTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    
}
#pragma mark - 核心动画，哪个View产生动画，动画速度（秒）
-(void)addAnimationInView:(UIView *)view duration:(NSTimeInterval)timeInterval valueWithCATransform3D:(CATransform3D)transform3D{
    //核心内容
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    //角度，x,y,z,参数
    animation.toValue = [NSValue valueWithCATransform3D:transform3D];
    animation.duration = timeInterval;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [view.layer addAnimation:animation forKey:@"animation"];
}
//停止动画
-(void)stopAnation{
    [_centerView.layer removeAnimationForKey:@"animation"];
}

#pragma mark - dealloc 释放定时器
- (void)dealloc{
    if(fadeOutTimer != nil){
        [fadeOutTimer invalidate];
        fadeOutTimer = nil;
    }
    NSLog(@"dealloc");
}

@end
