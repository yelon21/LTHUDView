//
//  LYViewController.m
//  LTHUDView
//
//  Created by yelon21 on 09/16/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import "LTHUDView.h"

@interface LYViewController (){

    LTHUDView *hudView;
}

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    hudView = [[LTHUDView alloc]initWithView:self.view];
    hudView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    hudView.userInteractionEnabled = NO;
    [self.view addSubview:hudView];
    
    [hudView addTarget:self action:@selector(hideAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hideAction{

    [hudView lt_hide:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    static NSInteger i = 0;
    NSLog(@"i=%@",@(i));
    NSLog(@"i%%4=%@",@(i%4));
    switch (i%4) {
        case 0:
            
            hudView.messageLabel.text = @"iOS是由苹果公司开发的移动操作系统[1]  。苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上。iOS与苹果的Mac OS X操作系统一样，属于类Unix的商业操作系统。原本这个系统名为iPhone OS，因为iPad，iPhone，iPod touch都使用iPhone OS，所以2010WWDC大会上宣布改名为iOS（iOS为美国Cisco公司网络设备操作系统注册商标，苹果改名已获得Cisco公司授权）。";
            break;
            
        case 1:
            
            hudView.messageLabel.text = @"iOS是由苹果公司开发的移动操作系统[1]  。苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上。iOS与苹果的Mac OS X操作系统一样，属于类Unix的商业操作系统。原本这个系统名为iPhone OS，因为iPad，iPhone，iPod touch都使用iPhone OS，所以2010WWDC大会上宣布改名为iOS（iOS为美国Cisco公司网络设备操作系统注册商标，苹果改名已获得Cisco公司授权）。iOS是由苹果公司开发的移动操作系统[1]  。苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上。iOS与苹果的Mac OS X操作系统一样，属于类Unix的商业操作系统。原本这个系统名为iPhone OS，因为iPad，iPhone，iPod touch都使用iPhone OS，所以2010WWDC大会上宣布改名为iOS（iOS为美国Cisco公司网络设备操作系统注册商标，苹果改名已获得Cisco公司授权）。iOS是由苹果公司开发的移动操作系统[1]  。苹果公司最早于2007年1月9日的Macworld大会上公布这个系统，最初是设计给iPhone使用的，后来陆续套用到iPod touch、iPad以及Apple TV等产品上。iOS与苹果的Mac OS X操作系统一样，属于类Unix的商业操作系统。原本这个系统名为iPhone OS，因为iPad，iPhone，iPod touch都使用iPhone OS，所以2010WWDC大会上宣布改名为iOS（iOS为美国Cisco公司网络设备操作系统注册商标，苹果改名已获得Cisco公司授权）。";
            hudView.foregroundColor = [UIColor orangeColor];
            break;
            
        case 2:
            
            hudView.messageLabel.text = @"iOS";
            if (hudView.loadingType == LTLoadingViewTypeCircleLine) {
                
                hudView.loadingType = LTLoadingViewTypeCirclePoint;
            }
            else{
                
                hudView.loadingType = LTLoadingViewTypeCircleLine;
            }
            break;
            
        default:
            hudView.messageLabel.text = @"iOS是由苹果公司...";
            if (hudView.hudType == LTHUDType_LoadingAndMessage) {
                
                hudView.hudType = LTHUDType_OnlyMessage;
            }
            else{
                
                hudView.hudType = LTHUDType_LoadingAndMessage;
            }
            break;
    }

    [hudView lt_show:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hudView lt_hide:YES];
    });
    i++;

}

@end
