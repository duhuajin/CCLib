//
//  UIView+Ext.m
//  pbp
//
//  Created by Du on 2019/1/8.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import "UIView+Ext.h"
#import <objc/runtime.h>
#import "CCLoadingDot.h"
#import "CCBaseHeader.h"
#import <Masonry/Masonry.h>

@interface UIView()

@property (nonatomic) UILabel *placeholderLabel;
@property (nonatomic) UIView *emptyView;
@property (nonatomic) CCLoadingDot *loadingView;

@end

@implementation UIView (Ext)


-(void)setDefaultShadow{
    self.layer.shadowColor = [UIColor colorWithRed:6/255.0 green:90/255.0 blue:189/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 3;
    self.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5].CGPath;
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds=NO;
}

-(void)setDefaultShadowBottom{
    self.layer.shadowColor = [UIColor colorWithRed:6/255.0 green:90/255.0 blue:189/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 3;
    self.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.frame.size.height/2,self.frame.size.width, self.frame.size.height/2) cornerRadius:5].CGPath;
    self.layer.cornerRadius = 0;
    self.clipsToBounds=NO;
}

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!label) {
        label=[[UILabel alloc]init];
        [label setText:@"当前暂无数据展示!"];
        [label setTextColor:[UIColor grayColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:14]];
        objc_setAssociatedObject(self, @selector(placeholderLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

-(CCLoadingDot*)loadingView{
    
    CCLoadingDot *loadingView = objc_getAssociatedObject(self, @selector(loadingView));

    if(!loadingView) {
        loadingView = [[CCLoadingDot alloc]init];
        objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return loadingView;
}


-(UIView *)emptyView{
    
    UIView *view = objc_getAssociatedObject(self, @selector(emptyView));
    if (!view) {
        view=[[UIView alloc]init];
        [view setBackgroundColor:[UIColor whiteColor]];
        objc_setAssociatedObject(self, @selector(emptyView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [view addSubview:self.placeholderLabel];
        [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(view);
        }];
    }
    return view;
}


-(void)showEmptyView{
    CCWeak(self);
    [self addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws);
    }];
}

-(void)showEmptyViewWithContent:(NSString*)content{
    CCWeak(self);
    self.placeholderLabel.text=content;
    [self addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws);
    }];
}


-(void)hideEmptyView{
    [self.emptyView removeFromSuperview];
}


-(void)showLoadingView{
    if(self.loadingView.superview!=self){
        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    [self.loadingView startAnimating];
}

-(void)hideLoadingView{
    [self.loadingView stopAnimating];
    [self.loadingView removeFromSuperview];
}

@end
