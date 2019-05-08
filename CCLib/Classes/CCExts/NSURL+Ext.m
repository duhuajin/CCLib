//
//  NSURL+Ext.m
//  Live
//
//  Created by Du on 2018/9/6.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "NSURL+Ext.h"

@implementation NSURL (Ext)


- (NSString *)cc_getParamValueForKey:(NSString*)key
{
    
    NSString *url=[self absoluteString];
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)", key];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}


@end
