//
//  NSString+CCString.m
//  Home
//
//  Created by Du on 2018/1/11.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Ext.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/utsname.h>
#import "NSDate+Ext.h"

@implementation NSString (Ext)

- (NSString *)cc_urlEncode
{
    NSCharacterSet *allowedCharacters = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    return encodedUrl;
}

-(NSString *)cc_urlDecode{
    
    NSString*str5 = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str5;
    
}



-(NSDate*)cc_dateFromFormatter:(NSString*)formatter{
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:formatter];
    
    NSString *time=[self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    if([self rangeOfString:@"."].location!=NSNotFound){
        NSString *str=[time substringToIndex:[self rangeOfString:@"."].location];
        return [df dateFromString:str];
    }
    return [df dateFromString:time];
}

-(NSString*)fixTime{
    
    if(!self||self.length<=0){
        return nil;
    }
    NSDate *date=[self cc_dateFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
    return [date cc_stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

-(NSString*)formatDate:(NSString*)format{
    
    
    NSString *fix=[self fixTime];
    NSDate *date=[fix cc_dateFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str=[date cc_stringFromFormatter:format];
    return str;
}



/** 将任意一串字符串加密为32位的二进制数据*/
- (instancetype)MD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+(instancetype)timeWithString:(NSString *)time{
    if ([time rangeOfString:@"T"].location !=NSNotFound) {
        NSArray *arrayA=[time componentsSeparatedByString:@"T"];
        NSArray *arratB=[arrayA[1] componentsSeparatedByString:@":"];
        return [NSString stringWithFormat:@"%@ %@:%@",arrayA[0],arratB[0],arratB[1]];
    }
    return time;
}



-(CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    CGSize s = [self boundingRectWithSize:size
                                  options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attrs context:nil].size;
    return s;
    
}

//- (BOOL)isNumber{
//
//    //判断是否是纯数字
//
//    if( ![self isPureInt:self] || ![self isPureFloat:self])
//
//    {
//        return NO;
//    }
//    return YES;
//}
//
//
//- (BOOL)isPureInt:(NSString*)string{
//
//    NSScanner* scan = [NSScanner scannerWithString:string];
//
//    int val;
//
//    return[scan scanInt:&val] && [scan isAtEnd];
//
//}
//
//
//
////判断是否为浮点形：
//
//- (BOOL)isPureFloat:(NSString*)string{
//
//    NSScanner* scan = [NSScanner scannerWithString:string];
//
//    float val;
//
//    return[scan scanFloat:&val] && [scan isAtEnd];
//
//}





- (BOOL)isNumber{
    //    NSString *regex = @"^[0-9]+(.[0-9]{2})?$";
    NSString *regex = @"^[0-9]+(.[0-9])?$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}


- (NSString *)cc_getUrlParamValueForKey:(NSString*)key
{
    
    NSString *url=self;
    
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


+(NSString*)getHHmmss:(NSTimeInterval)time{
    
    NSInteger seconds =time;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    
    
    NSString * format_time;
    if(seconds>=3600){
         format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }else{
         format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
    
    return format_time;
    
    
}

-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key{
    
    NSMutableString *string = [[NSMutableString alloc]initWithString:self];
    @try {
        NSRange range = [string rangeOfString:@"?"];
        if (range.location != NSNotFound) {//找到了
            //如果?是最后一个直接拼接参数
            if (string.length == (range.location + range.length)) {
                NSLog(@"最后一个是?");
                string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果不是最后一个需要加&
                if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
                }else{//如果最后不是&,需要加&后拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
                }
            }
        }else{//没找到
            if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
                string = (NSMutableString *)[string substringToIndex:string.length-1];
            }
            string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    return string.copy;
}

@end
