//
//  GDDatePickerView.h
//  GDPickerView
//
//  Created by 郭达 on 2018/5/2.
//  Copyright © 2018年 DouNiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

#define ToolBarHeight 44
#define PickerHeight 200

@protocol GDDatePickerDelegate <NSObject>
@optional

- (void)gd_pickerChange:(NSString *)dateString;

@end


typedef void(^GDDatePickerBlock)(NSString *dateTime);

@interface GDDatePickerView : UIView


@property (nonatomic, retain) NSDate *minimumDate;

@property (nonatomic, retain) NSDate *maximumDate;

@property (nonatomic, assign) BOOL showToolbar;

@property (nonatomic, copy) NSString *defaultDisplayTime;

@property (nonatomic, copy) GDDatePickerBlock selectDateTime;//当前选择的时间

@property (nonatomic, assign) id<GDDatePickerDelegate> gd_delegate;

- (void)showPickerInSuperview:(UIView*)view Animation:(BOOL)animate;
- (void)DismissPickerView;
@end
