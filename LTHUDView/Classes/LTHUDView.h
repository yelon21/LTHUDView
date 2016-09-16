//
//  LTHUDView.h
//  LoadingDemo
//
//  Created by yelon on 16/9/14.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LTHUDType) {
    
    LTHUDType_None = -1,
    LTHUDType_OnlyMessage = 0,
    LTHUDType_LoadingAndMessage,
    LTHUDType_Custom
};

@interface LTHUDView : UIControl

@property(nonatomic,strong,readonly) UIView *contentView;
@property(nonatomic,strong,readonly) UIView *animationView;

@property(nonatomic,strong,readonly) UILabel *messageLabel;

@property (nonatomic,assign) LTHUDType hudType;

-(instancetype)initWithView:(UIView *)view;

- (void)lt_show:(BOOL)animated;

- (void)lt_hide:(BOOL)animated;
@end
