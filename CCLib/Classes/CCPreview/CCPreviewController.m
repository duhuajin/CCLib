//
//  CCPreviewController.m
//  changdu
//
//  Created by Du on 2018/7/12.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "CCPreviewController.h"
#import <QuickLook/QuickLook.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "UIColor+Hex.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface CCPreviewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
{
    NSInteger _seconds;
    BOOL _unLock;
}
@property (strong,nonatomic)UIView *stateView;
@property (strong,nonatomic)UIView *stateBack;
@property (strong,nonatomic)UILabel *periodLabel;
@property (strong,nonatomic)UILabel*titleLabel;
@property (strong,nonatomic)QLPreviewController*previewController;
@property (strong,nonatomic)NSURL*path;
@property (strong,nonatomic)NSMutableDictionary*pathDic;

@end

@implementation CCPreviewController

-(NSMutableDictionary *)pathDic{
    if(!_pathDic){
        _pathDic=[NSMutableDictionary dictionary];
    }
    return _pathDic;
}

-(UIView *)stateView{
    
    if(!_stateView){
        _stateView=[[UIView alloc]init];
        _stateView.backgroundColor=[UIColor colorWithHex:0xfff2f2];
        UIImageView *ico=[[UIImageView alloc]init];
        [ico setImage:[UIImage imageNamed:@"注意"]];
        [_stateView addSubview:ico];
        [ico mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_stateView).offset(10);
            make.leading.equalTo(_stateView).offset(5);
            make.width.height.mas_equalTo(16);
        }];
        
        [_stateView addSubview:self.periodLabel];
        [self.periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(ico.mas_trailing).offset(5);
            make.trailing.equalTo(_stateView).offset(-5);
            make.top.equalTo(_stateView).offset(5);
            make.height.mas_equalTo(40);
        }];
    }
    return _stateView;
}

-(UIView *)stateBack{
    if(!_stateBack){
        _stateBack=[[UIView alloc]init];
        [_stateBack setBackgroundColor:[UIColor colorWithHex:0xf7f7f7]];
    }
    return _stateBack;
}

-(UILabel *)periodLabel{
    if(!_periodLabel){
        _periodLabel=[[UILabel alloc]init];
        _periodLabel.font=[UIFont systemFontOfSize:14];
        _periodLabel.numberOfLines=0;
        _periodLabel.textColor=[UIColor colorWithHex:0xe65c5c];
    }
    return _periodLabel;
}

-(QLPreviewController *)previewController{
    if(!_previewController){
        _previewController=[[QLPreviewController alloc]init];
        _previewController.delegate=self;
        _previewController.dataSource=self;
    }
    return _previewController;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:18];
        _titleLabel.numberOfLines=0;
        _titleLabel.textColor=[UIColor colorWithHex:0x0f0f0f];
    }
    return _titleLabel;
}
-(UIView *)contentView{
    return self.previewController.view;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"预览";
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    
    CCWeak(self);
    [ws addChildViewController:ws.previewController];
    [ws.view addSubview:ws.previewController.view];
    [ws.previewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(ws.view);
        
    }];
    [self.previewController.view setHidden:YES];
  

    [self start];
}

-(void)start{
    CCWeak(self);
    if(self.url){
        if([self.url hasPrefix:@"http"]){
            [self download:self.url result:^(NSURL *path) {
                ws.path=path;
                [ws.previewController reloadData];
                [ws.previewController.view setHidden:NO];
            }];
        }else{
            self.path=[NSURL fileURLWithPath:self.url];
            [ws.previewController reloadData];
            [self.previewController.view setHidden:NO];
        }
    }
    
    if(self.urls){
        
        __block BOOL download=NO;
        [self.urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(!ws.pathDic[obj]){
                [ws showLoadingView];
                [ws download:obj result:^(NSURL *path) {
                    [ws hideLoadingView];

                    if(!path){
                        path=[NSURL URLWithString:@"http://www.baidu.com/app.jpg"];
                    }
                    [ws.pathDic setObject:path forKey:obj];
                    [ws start];
                }];
                download=YES;
                *stop=YES;
            }
        }];
        if(!download){
            [ws.previewController reloadData];
            [ws.previewController.view setHidden:NO];
        }
    }
}
-(void)setUrl:(NSString *)url{
    _url=url;
    [self start];
}
-(void)setUrls:(NSArray *)urls{
    _urls=urls;
    [self start];
}

-(void)applicationEnterBackground{
}
-(void)applicationBecomeActive{
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    if(self.urls){
        return self.urls.count;
    }
    if(self.path){
        return 1;
    }
    return 0;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    if(self.urls){
        return [self.pathDic objectForKey:[self.urls objectAtIndex:index]];
    }
    return self.path;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    NSLog(@"视图即将dismiss");
}


-(NSString*)localPathWithFile:(NSString*)file{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:file.lastPathComponent];
    return fullPath;
}

-(void)download:(NSString*)file  result:(void(^)(NSURL *path))result{
    
    NSString *fullPath = [self localPathWithFile:file];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:fullPath]){
        if(result){
            result([NSURL fileURLWithPath:fullPath]);
            return;
        }
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:file]];
    //下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request
                                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                     //下载进度
                                                                     NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                                                 }
                                                              destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                  //保存的文件路径
                                                                  //                                                                  NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                                                                  return [NSURL fileURLWithPath:fullPath];
                                                                  
                                                              }
                                                        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                            if(result){
                                                                result(filePath);
                                                            }
                                                        }];
    
    //执行Task
    [download resume];
}

-(NSInteger)getPdfNum:(NSURL*)url{
    CFURLRef ref = (__bridge CFURLRef)url;
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)ref);
    NSInteger indexSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    CGPDFDocumentRelease(pdfDocument);
    return indexSum;
}

@end
