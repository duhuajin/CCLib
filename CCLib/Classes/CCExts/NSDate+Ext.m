//
//  NSDate+CCDate.m
//  Home
//
//  Created by Du on 2018/1/11.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (Ext)

-(NSString*)cc_stringFromFormatter:(NSString*)str{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:str];
   return  [df stringFromDate:self];
}

-(NSDate *)cc_laterDateWithLater:(int)later
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:later];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    
    return mDate;
    
}

-(NSString*)weekDay{
        NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [calendar setTimeZone: timeZone];
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
        return [weekdays objectAtIndex:theComponents.weekday];
}

-(NSComparisonResult )compara:(NSDate *)date{
    NSComparisonResult result = [self compare:date];
    return result;
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    NSLog(@" -- >>  comp : %@  << --",comp);
    return comp.day;
}

@end
