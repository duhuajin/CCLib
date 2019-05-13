
//
//  DotActivityIndicatorView.m
//  DotsLoaderActivityIndicator
//
//  Created by EhabAlsharkawy on 1/22/16.
//  Copyright © 2016 EhabAlsharkawy. All rights reserved.
//

#import "CCLoadingDot.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Hex.h"

const CGFloat AnimatedDuration=0.5f;
const CGFloat LoadingWidth=40;
const CGFloat LoadingHei=10;
const CGFloat DotWid=10;
const CGFloat DotHei=10;

@interface CCLoadingDot()<CAAnimationDelegate>

@property (nonatomic)NSArray *colors;

@end

@implementation CCLoadingDot
{
    BOOL isAnimating;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colors=@[[UIColor colorWithHex:0xffc600],[UIColor colorWithHex:0x00ddbc],[UIColor colorWithHex:0xff1e1e]];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)startAnimating
{
    if (!isAnimating)
    {

        
        [self addCircles];
        
        isAnimating = YES;
    }
}

- (void)addCircles
{
    for (NSUInteger i = 0; i < 3; i++)
    {
        [self createCircleWithIndex:i];
    }
}

- (void)createCircleWithIndex:(NSUInteger)index
{
   
    UIView *circle = [[UIView alloc] init];
    
    circle.frame=CGRectMake(0, 0, DotWid,DotHei);
    circle.backgroundColor = self.colors[index];
    circle.layer.cornerRadius = DotHei/2;
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    [circle setTransform:CGAffineTransformMakeScale(1, 1)];
    
    if(index==0){
        circle.center=CGPointMake(DotWid/2, LoadingHei/2);
        CAKeyframeAnimation *animated= [self createAnimation:@[[NSValue valueWithCGPoint:circle.center],[NSValue valueWithCGPoint:CGPointMake(LoadingWidth-DotWid/2, LoadingHei/2)],[NSValue valueWithCGPoint:circle.center]]];
        [circle.layer addAnimation:animated forKey:@"1"];
        
    }else  if(index==1){
        circle.center=CGPointMake(LoadingWidth/2, LoadingHei/2);
    }else  if(index==2){
        circle.center=CGPointMake(LoadingWidth-DotWid/2, LoadingHei/2);
        CAKeyframeAnimation *animated= [self createAnimation:@[[NSValue valueWithCGPoint:circle.center],
                                [NSValue valueWithCGPoint:CGPointMake(DotWid/2, LoadingHei/2)],[NSValue valueWithCGPoint:circle.center]]];
        [circle.layer addAnimation:animated forKey:@"2"];

    }
    
    [self addSubview:circle];
   
}

- (CAKeyframeAnimation *)createAnimation:(NSArray*)values
{

    CAKeyframeAnimation *animation   = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion    = NO;
    animation.fillMode               = kCAFillModeForwards;
    animation.duration               = 1;
    animation.repeatCount            = NSIntegerMax;
    animation.beginTime              = CACurrentMediaTime();
    animation.calculationMode        = kCAAnimationCubicPaced;
    animation.keyTimes               = @[@(0),@(0.5),@(1)];
    animation.values                 = values;
    
    return animation;
}
- (void)stopAnimating
{
    if (isAnimating)
    {
        [self removeCircles];
        
        isAnimating = NO;
    }
}

- (void)removeCircles
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         
         [obj removeFromSuperview];
     }];
}

@end
