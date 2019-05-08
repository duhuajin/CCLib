//
//  CCJson.m
//  DrivingAssiatant
//
//  Created by 杜华金 on 15/9/25.
//  Copyright © 2015年 杜华金. All rights reserved.
//

#import "CCJson.h"

@implementation CCJson

@end

@implementation NSDictionary  (CCJSONSerializing)

-(NSData *)cc_JSONData{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}
-(NSString *)cc_JSONString{
    
    NSData *data=[self cc_JSONData];
    if(data){
        NSString *json =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

@end

@implementation NSArray (CCJSONSerializing)

-(NSData *)cc_JSONData{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}
-(NSString *)cc_JSONString{
    NSData *data=[self cc_JSONData];
    if(data){
        NSString *json =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}
@end

@implementation NSString (CCJSONSerializing)

-(NSData *)cc_JSONData{
    return [NSJSONSerialization dataWithJSONObject:[self cc_objectFromJSONString] options:NSJSONWritingPrettyPrinted error:nil];
}
-(NSString *)cc_JSONString{
    NSData *data=[self cc_JSONData];
    if(data){
        NSString *json =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}
@end

@implementation NSString (CCJSONDeserializing)

-(id)cc_objectFromJSONString{
    
    NSData *data=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return object;

}
@end

@implementation NSData (CCJSONDeserializing)

-(id)cc_objectFromJSONData{
    
    NSError *error;
    id object= [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    return object;
}
@end
