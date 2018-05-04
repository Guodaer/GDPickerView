//
//  GDDatePickerView.m
//  GDPickerView
//
//  Created by 郭达 on 2018/5/2.
//  Copyright © 2018年 DouNiu. All rights reserved.
//

#import "GDDatePickerView.h"

@interface GDDatePickerView ()

@property (nonatomic, strong) UIDatePicker *myDatePicker;
@property (nonatomic, strong) UIToolbar *actionToolbar;

@end

@implementation GDDatePickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createPickerView];
    }
    return self;
}
- (void)createPickerView {
    
    [self setDefaultConfig];
//    self.alpha = 0;
//    [self myDatePicker];
    
}
- (void)setDefaultConfig {
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:1918];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *minDate = [myCal dateFromComponents:comp];
    self.minimumDate = minDate;
    
    self.maximumDate = [NSDate date];
    
    self.showToolbar = YES;
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];

    self.defaultDisplayTime = currentDateString;
}
- (UIDatePicker *)myDatePicker {
    if (!_myDatePicker) {
        _myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ToolBarHeight, self.bounds.size.width, PickerHeight-ToolBarHeight)];
        [_myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_myDatePicker setMaximumDate:self.maximumDate];
        [_myDatePicker setMinimumDate:self.minimumDate];
        [_myDatePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        [_myDatePicker setDatePickerMode:UIDatePickerModeDate];
        [_myDatePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:self.defaultDisplayTime];
        [_myDatePicker setDate:date animated:YES];

        [self addSubview:_myDatePicker];
        
        if (self.showToolbar) {
            
            _actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ToolBarHeight)];
            _actionToolbar.barStyle = UIBarStyleDefault;
            [_actionToolbar sizeToFit];
            
            _actionToolbar.layer.borderWidth = 0.35f;
            _actionToolbar.layer.borderColor = [[UIColor colorWithWhite:.8 alpha:1.0] CGColor];
            
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [cancelBtn addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            cancelBtn.frame = CGRectMake(0, 0, ToolBarHeight, ToolBarHeight);
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];

            
            UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

            UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [sureBtn addTarget:self action:@selector(actionSure:) forControlEvents:UIControlEventTouchUpInside];
            [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
            sureBtn.frame = CGRectMake(0, 0, ToolBarHeight, ToolBarHeight);
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
            [_actionToolbar setItems:[NSArray arrayWithObjects:cancelButton,flexSpace,doneBtn, nil] animated:YES];
            [self addSubview:_actionToolbar];
        }
        
        
    }
    return _myDatePicker;
}




- (void)showPickerInSuperview:(UIView*)view Animation:(BOOL)animate {
    self.frame = CGRectMake(0, Screen_height, view.bounds.size.width, PickerHeight);

    [self myDatePicker];
    [view addSubview:self];
    
    if (animate) {
        self.frame = CGRectMake(0, view.bounds.size.height, view.bounds.size.width, PickerHeight);
        [UIView animateWithDuration:0.35 animations:^{
            self.frame = CGRectMake(0, Screen_height - PickerHeight, view.bounds.size.width, PickerHeight);
        }];
        
    }else {
        self.frame = CGRectMake(0, Screen_height - PickerHeight, view.bounds.size.width, PickerHeight);
    }
}
- (void)DismissPickerView {
    CGFloat width = self.frame.size.width;
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, Screen_height, width, PickerHeight);
    } completion:^(BOOL finished) {
        [self.myDatePicker removeFromSuperview];
        self.myDatePicker = nil;
        if (self.actionToolbar) {
            [self.actionToolbar removeFromSuperview];
            self.actionToolbar = nil;
        }
        [self removeFromSuperview];
    }];
    
}




#pragma mark - 设置默认显示的时间
//- (void)setDefaultDisplayTime:(NSString *)defaultDisplayTime {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [formatter dateFromString:defaultDisplayTime];
//    [_myDatePicker setDate:date animated:YES];
//}

#pragma mark - 取消
- (void)actionCancel:(UIButton*)sender {
    [self DismissPickerView];
}
#pragma mark - 确认
- (void)actionSure:(UIButton *)sender {
    [self DismissPickerView];
    if (self.selectDateTime) {
        self.selectDateTime([self getSelectedDateStringWithDate:_myDatePicker.date]);
    }
}
- (void)dateChange:(UIDatePicker*)date {
    
    if ([self.gd_delegate respondsToSelector:@selector(gd_pickerChange:)]) {
        [self.gd_delegate gd_pickerChange:[self getSelectedDateStringWithDate:date.date]];
    }
    
//    NSLog(@"🍎--%@",[self getSelectedDateStringWithDate:date.date]);
}
#pragma mark - 转化时差，获取选择的时间
- (NSString *)getSelectedDateStringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
- (void)dealloc {
//    NSLog(@"🐒🐒🐒🐒");
}
@end
