//
//  LTAnimationView.h
//  LoadingDemo
//
//  Created by yelon on 16/9/16.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LTLoadingViewType) {
    
    LTLoadingViewTypeCirclePoint = 0,
    LTLoadingViewTypeCircleLine
};

@interface LTAnimationView : UIView

@property(nonatomic,assign) LTLoadingViewType type;

@property(nonatomic,assign,readonly) BOOL animating;

- (void)startAnimation;

- (void)stopAnimation;

@end
