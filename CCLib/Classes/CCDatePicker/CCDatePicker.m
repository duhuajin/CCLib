//
//  CCDatePicker.m
//  Home
//
//  Created by Du on 2018/1/15.
//  Copyright © 2018年 Du. All rights reserved.
//

#import "CCDatePicker.h"
#import "UIColor+Hex.h"
#import <Masonry/Masonry.h>


#define kSheetHei 240
#define kLicsenseHei 180

@interface CCDatePicker ()

{
    BOOL _show;
}
@property (strong,nonatomic)UIDatePicker *datePicker;
@property (strong,nonatomic)UIView *sheetView;
@property (strong,nonatomic)UIButton *dismissButton;
@property (strong,nonatomic)UILabel *titleLabel;

@end

@implementation CCDatePicker


-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc]init];
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_titleLabel setTextColor:[UIColor colorWithHex:0x333333]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setText:@"选择日期"];
    }
    return _titleLabel;
}

-(UIView *)sheetView{
    if(!_sheetView){
        _sheetView=[[UIView alloc]init];
        _sheetView.backgroundColor=[UIColor whiteColor];
        [_sheetView addSubview:self.titleLabel];
        CCWeak(_sheetView);
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(ws);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(60);
        }];
        
        UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
        [b setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [b setTitle:@"确定" forState:UIControlStateNormal];
        [b.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [b addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [_sheetView addSubview:b];
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws);
            make.trailing.equalTo(ws);
            make.width.mas_equalTo(68);
            make.height.mas_equalTo(60);
        }];
        UIView *line=[[UIView alloc]init];
        [line setBackgroundColor:[UIColor colorWithHex:0xf0f0f0]];
        [_sheetView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(ws);
            make.top.equalTo(ws).offset(59);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _sheetView;
}


-(UIButton *)dismissButton{
    if(!_dismissButton){
        UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom];
        [b setBackgroundColor:[UIColor blackColor]];
        [b setAlpha:0];
        [b addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _dismissButton=b;
    }
    return _dismissButton;
}

-(UIDatePicker *)datePicker{
    if(!_datePicker){
        _datePicker=[[UIDatePicker alloc]init];
    }
    return _datePicker;
}

-(void)confirm{
    
    if(self.ccDatePickerDidBlock){
        self.ccDatePickerDidBlock(self.datePicker.date);
    }
    [self dismiss];
}

-(void)show{
    
    UIViewController *t=[UIApplication sharedApplication].keyWindow.rootViewController;
    t.definesPresentationContext = YES;
    self.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [t presentViewController:self animated:NO completion:nil];
    
   
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CCWeak(self);

    if(_show){
        return;
    }
    _show=YES;
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration: 0.3 delay:0 usingSpringWithDamping:.7 initialSpringVelocity:0.3 options:0 animations:^{
        [ws.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(ws.view);
            make.bottom.equalTo(ws.view.mas_bottom).offset(0);
            make.height.mas_equalTo(kSheetHei);
        }];
        [ws.dismissButton setAlpha:0.5];
        [ws.view layoutIfNeeded];
    } completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text=self.title;
    self.datePicker.datePickerMode=self.datePickerMode;
    CCWeak(self);
    [self.view addSubview:self.dismissButton];
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(ws.view);
    }];
    
    
    [self.view addSubview:self.sheetView];
    
    [self.sheetView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(ws.sheetView);
        make.bottom.equalTo(ws.sheetView.mas_bottom);
        make.height.mas_equalTo(kLicsenseHei);
        
    }];
    
    [self.sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(ws.view);
        make.bottom.equalTo(ws.view.mas_bottom).offset(kSheetHei);
        make.height.mas_equalTo(kSheetHei);
        
    }];
    
 
    // Do any additional setup after loading the view.
}


-(void)dismiss{
    
    CCWeak(self);
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [ws.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(ws.view);
            make.bottom.equalTo(ws.view.mas_bottom).offset(kSheetHei);
            make.height.mas_equalTo(kSheetHei);
        }];
        [ws.view layoutIfNeeded];
        
        [ws.dismissButton setAlpha:0];
        
    }completion:^(BOOL finished) {
        [ws dismissViewControllerAnimated:NO completion:nil];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
