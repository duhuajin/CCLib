//
//  NSObject+JSContextTracker.m
//  zhtc
//
//  Created by Du on 2018/1/30.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "NSObject+JSContextTracker.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation NSObject (JSContextTracker)

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)alsoUnused {
    if (!ctx)
        return;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CCCreatJSContex" object:ctx];
}


@end
