//
//  CCDatePicker.h
//  Home
//
//  Created by Du on 2018/1/15.
//  Copyright © 2018年 Du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDatePicker : UIViewController


@property (nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

-(void)show;

@property (copy,nonatomic)void(^ccDatePickerDidBlock)(NSDate *date);

@end
