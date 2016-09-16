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
}


@end
