//
//  CCBaseModel.h
//  Cadres
//
//  Created by Du on 2018/8/17.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface CCBaseDataModel:JSONModel


@end

@interface CCErrorModel:JSONModel

@property (nonatomic)BOOL code;
@property (nonatomic,strong)NSString* details;
@property (strong,nonatomic)NSString* message;
@property (strong,nonatomic)NSString* validationErrors;


@end

@interface CCBaseRespModel:JSONModel

@property (nonatomic)BOOL success;
@property (nonatomic)BOOL __abp;
@property (nonatomic)BOOL unAuthorizedRequest;
@property (strong,nonatomic)CCErrorModel *error;
@property (strong,nonatomic)NSString *targetUrl;

@end


typedef void(^CCRespBlock)(CCBaseRespModel*resp,id obj,NSError *error);


@interface CCBaseModel : NSObject



+ (instancetype)model ;

-(void)initData;

@property (assign,nonatomic)BOOL isReload;
@property (assign,nonatomic)BOOL hasMore;
@property (assign,nonatomic)BOOL isLoading;
@property (assign,nonatomic)NSInteger pageIndex;
@property (assign,nonatomic)NSInteger pageSize;
@property (strong,nonatomic,readonly)NSMutableArray *datas;
@property (strong,nonatomic)NSDictionary *baseCode;

-(BOOL)checkEnable;

-(void)addDatas:(NSArray*)datas;


/**
 
 序列化数据,obj

 @param obj 传NSDictionary 或NSArray
 @param model 序列对象
 @return 结果
 */
-(id)invoke:(id)obj to:(Class)model;

@end
