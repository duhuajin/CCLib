//
//  UIView+Ext.h
//  pbp
//
//  Created by Du on 2019/1/8.
//  Copyright © 2019 LiuHeYuanJiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Ext)

-(void)setDefaultShadow;
-(void)setDefaultShadowBottom;


@property (nonatomic, readonly) UILabel *placeholderLabel;
-(void)showEmptyView;
-(void)showEmptyViewWithContent:(NSString*)content;
-(void)hideEmptyView;

-(void)showLoadingView;
-(void)hideLoadingView;


@end

NS_ASSUME_NONNULL_END
