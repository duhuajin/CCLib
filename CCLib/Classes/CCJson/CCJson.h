//
//  CCJson.h
//  DrivingAssiatant
//
//  Created by 杜华金 on 15/9/25.
//  Copyright © 2015年 杜华金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCJson : NSObject

@end


@interface NSDictionary  (CCJSONSerializing)


-(NSData*)cc_JSONData;
-(NSString*)cc_JSONString;

@end

@interface NSArray (CCJSONSerializing)
-(NSData*)cc_JSONData;
-(NSString*)cc_JSONString;

@end

@interface NSString (CCJSONSerializing)

-(NSData*)cc_JSONData;
-(NSString*)cc_JSONString;

@end

@interface NSString (CCJSONDeserializing)

- (id)cc_objectFromJSONString;

@end

@interface NSData (CCJSONDeserializing)

- (id)cc_objectFromJSONData;

@end