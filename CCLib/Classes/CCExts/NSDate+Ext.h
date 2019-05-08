//
//  NSDate+CCDate.h
//  Home
//
//  Created by Du on 2018/1/11.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ext)

-(NSString*)cc_stringFromFormatter:(NSString*)str;
-(NSDate *)cc_laterDateWithLater:(int)later;
-(NSString*)weekDay;

-(NSComparisonResult)compara:(NSDate*)date;

+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
