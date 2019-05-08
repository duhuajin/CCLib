//
//  UITableView+Ext.m
//  Live
//
//  Created by Du on 2018/8/31.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "UITableView+Ext.h"

@implementation UITableView (Ext)


- (CGFloat)verticalOffsetOnBottom {
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat contentHeight = self.contentSize.height;
    CGFloat topInset = self.contentInset.top;
    CGFloat bottomInset = self.contentInset.bottom;
    CGFloat bottomOffset = floorf(contentHeight - bottomInset - topInset - viewHeight);
    return MAX(bottomOffset, 0);
}

- (void)scrollToBottom:(BOOL)animated {
    CGPoint bottomOffset = CGPointMake(0, [self verticalOffsetOnBottom]);
    [self setContentOffset:bottomOffset animated:animated];
}

@end
