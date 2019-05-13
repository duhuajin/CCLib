//
//  CCBaseModel.m
//  Cadres
//
//  Created by Du on 2018/8/17.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "CCBaseModel.h"
#import "CCJson.h"



static CCBaseModel *baseModel;

@implementation CCBaseDataModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation CCErrorModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


@implementation CCBaseRespModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end



@implementation CCBaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas=[NSMutableArray array];
        [self initData];
    }
    return self;
}


+ (instancetype)model {
    static CCBaseModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCBaseModel alloc]init];
    });
    return sharedInstance;
}


-(void)setDatas:(NSMutableArray *)datas{
    if(_datas!=datas){
        _datas=datas;
    }
}


-(void)initData{
    self.isReload=YES;
    self.hasMore=NO;
    self.isLoading=NO;
    self.pageIndex=0;
    self.pageSize=15;
    
}
-(BOOL)checkEnable{
    return !self.isLoading&&self.hasMore;
}
-(void)addDatas:(NSArray *)datas{
    if(self.isReload){
        [self.datas removeAllObjects];
        self.isReload=NO;
    }
    [self.datas addObjectsFromArray:datas];
    
    if(datas.count<self.pageSize){
        self.hasMore=NO;
    }else{
        self.hasMore=YES;
    }
    self.isLoading=NO;
    self.pageIndex+=1;
}



-(id)invoke:(id)obj to:(Class)model{
    if(!obj){
        return nil;
    }
    if([obj isKindOfClass:[NSDictionary class]]){
        id data=[[model alloc]initWithDictionary:obj error:nil];
        return data;
    }
    if([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *arr=[NSMutableArray array];
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id data=[[model alloc]initWithDictionary:obj error:nil];
            [arr addObject:data];
        }];
        return arr;
    }
    return obj;
}

@end
