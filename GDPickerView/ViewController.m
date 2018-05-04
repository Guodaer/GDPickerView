//
//  ViewController.m
//  GDPickerView
//
//  Created by 郭达 on 2018/5/2.
//  Copyright © 2018年 DouNiu. All rights reserved.
//

#import "ViewController.h"
#import "GDDatePickerView.h"
#import "BullTipsView.h"
@interface ViewController ()
{
    NSTimer *timer;
}
@property (nonatomic, strong) GDDatePickerView *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn addTarget:self action:@selector(actionCancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(100, 100, ToolBarHeight, ToolBarHeight);
    [self.view addSubview:cancelBtn];
    
    timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
static int number = 0;
- (void)timerAction{
    if (number%2 == 1) {
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [BullTipsView showMessage:@"你好你好你好你好"];
//        });
        

    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [BullTipsView showMessage:@"🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"];
        });

    }
    NSLog(@"%d",number);
    if (number > 5) {
        [timer invalidate];
    }
    number ++;
    
}
- (GDDatePickerView *)datePicker {
    if (!_datePicker) {
        _datePicker = [[GDDatePickerView alloc] init];
        _datePicker.selectDateTime = ^(NSString *dateTime) {
            NSLog(@"%@",dateTime);
        };
        _datePicker.backgroundColor = [UIColor yellowColor];
        
        _datePicker.defaultDisplayTime = @"2013-01-12";
    }
    return _datePicker;
}

- (void)actionCancel:(UIButton*)sender {
    
    
//    [self.datePicker showPickerInSuperview:self.view Animation:YES];
    
    if (sender.selected) {
        [BullTipsView showMessage:@"你好你好你好你好"];
        sender.selected = !sender.selected;
    }else{
        [BullTipsView showMessage:@"🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎"];
        sender.selected = !sender.selected;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
