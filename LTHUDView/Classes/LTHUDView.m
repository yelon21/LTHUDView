//
//  LTHUDView.m
//  LoadingDemo
//
//  Created by yelon on 16/9/14.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTHUDView.h"

@interface LTHUDView (){

    NSInteger showingCount;
}

@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIView *animationView;
@property(nonatomic,strong) LTAnimationView *loadingView;
@property(nonatomic,strong) UILabel *messageLabel;
@end

@implementation LTHUDView
@synthesize foregroundColor = _foregroundColor;

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }
    return self;
}

-(instancetype)initWithView:(UIView *)view{
    
    if (!view) {
        view = [UIApplication sharedApplication].windows.lastObject;
    }
    
    return [self initWithFrame:view.bounds];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.contentView];
    
    showingCount = 0;
    
    _hudType = -1;
    self.alpha = 0.0;
    
    UIView *superV = self;
    [self addContentViewConstraintToView:superV];
    
    if (self.hudType<0) {
        
        self.hudType = LTHUDType_LoadingAndMessage;
    }
    
    self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
}

#pragma mark setter & getter
-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        _contentView.userInteractionEnabled = NO;
        _contentView.layer.cornerRadius = 5.0;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

-(UIView *)animationView{
    
    if (!_animationView) {
        
        _animationView = [UIView new];
        _animationView.translatesAutoresizingMaskIntoConstraints = NO;
        _animationView.backgroundColor = [UIColor clearColor];
    }
    
    return _animationView;
}

-(LTAnimationView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[LTAnimationView alloc]init];
        _loadingView.loadingType = LTLoadingViewTypeCircleLine;
        _loadingView.foregroundColor = self.foregroundColor;
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_loadingView];
    }
    return _loadingView;
}

-(UILabel *)messageLabel{
    
    if (!_messageLabel) {
        
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = self.foregroundColor;
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_messageLabel];
    }
    
    return _messageLabel;
}

- (void)addContentViewConstraintToView:(UIView *)superView{
    
    UIView *subView = self.contentView;
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeCenterX
                               constant:0.0];
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeCenterY
                               constant:0.0];
    
    [self addLessThanOrEqualConstraintToSuperView:superView
                                        bySubView:subView
                                    withAttribute:NSLayoutAttributeWidth
                                         constant:-80];
    
    [self addLessThanOrEqualConstraintToSuperView:superView
                                        bySubView:subView
                                    withAttribute:NSLayoutAttributeHeight
                                         constant:-80];
}

#pragma mark setter & getter
-(void)setForegroundColor:(UIColor *)foregroundColor{

    if (_foregroundColor != foregroundColor) {
        
        _foregroundColor = foregroundColor;
        
        if (self.hudType == LTHUDType_LoadingAndMessage) {
            
            self.loadingView.foregroundColor = _foregroundColor;
        }
    }
}

-(UIColor *)foregroundColor{
    
    if (!_foregroundColor) {
        
        return [UIColor whiteColor];
    }
    return _foregroundColor;
}

-(void)setLoadingType:(LTLoadingViewType)loadingType{

    if (self.hudType == LTHUDType_LoadingAndMessage) {
        
        if (self.loadingView.loadingType == loadingType) {
            
            return;
        }
        self.loadingView.loadingType = loadingType;
    }
}

-(LTLoadingViewType)loadingType{

    return self.loadingView.loadingType;
}

-(void)setHudType:(LTHUDType)hudType{
    
    if (_hudType == hudType) {
        
        return;
    }
    
    _hudType = hudType;
    
    if (_hudType == LTHUDType_LoadingAndMessage) {
        
        [self.loadingView stopAnimation];
    }
    
    [self resetContentSubViews];
}

- (void)resetContentSubViews{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.contentView removeConstraints:self.contentView.constraints];
    
    UIView *superView = self.contentView;
    
    if (self.hudType == LTHUDType_OnlyMessage) {
        
        [superView addSubview:self.messageLabel];
        
        [self addEqualConstraintToSuperView:superView
                                  bySubView:self.messageLabel
                                 edgeInsets:UIEdgeInsetsMake(10, 10, -10, -10)];
    }
    else if (self.hudType == LTHUDType_LoadingAndMessage){
        
        [superView addSubview:self.loadingView];
        [superView addSubview:self.messageLabel];
        
        [self addEqualConstraintToSuperView:superView
                                  bySubView:self.loadingView
                              withAttribute:NSLayoutAttributeTop
                                   constant:0.0];
        [self addEqualConstraintToSuperView:superView
                                  bySubView:self.loadingView
                              withAttribute:NSLayoutAttributeCenterX
                                   constant:0.0];
        
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:80.0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:80.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:10.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.loadingView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.loadingView
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:5.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.messageLabel
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-5.0]];
        
        [self addEqualConstraintToSuperView:superView
                                  bySubView:self.messageLabel
                              withAttribute:NSLayoutAttributeBottom
                                   constant:-5.0];
    }
}

- (void)addEqualConstraintToSuperView:(UIView *)superView
                            bySubView:(UIView *)subView
                        withAttribute:(NSLayoutAttribute )attribute
                             constant:(CGFloat)constant{
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:attribute
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:attribute
                                                         multiplier:1.0
                                                           constant:constant]];
}


- (void)addEqualConstraintToSuperView:(UIView *)superView
                            bySubView:(UIView *)subView
                           edgeInsets:(UIEdgeInsets)insets{
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeTop
                               constant:insets.top];
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeLeft
                               constant:insets.left];
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeBottom
                               constant:insets.bottom];
    
    [self addEqualConstraintToSuperView:superView
                              bySubView:subView
                          withAttribute:NSLayoutAttributeRight
                               constant:insets.right];
}


- (void)addLessThanOrEqualConstraintToSuperView:(UIView *)superView
                                      bySubView:(UIView *)subView
                                  withAttribute:(NSLayoutAttribute )attribute
                                       constant:(CGFloat)constant{
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                          attribute:attribute
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:superView
                                                          attribute:attribute
                                                         multiplier:1.0
                                                           constant:constant]];
}

- (void)lt_show:(BOOL)animated{
    
    ++showingCount;
    
    if (animated) {
        
        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }
    
    if (self.hudType == LTHUDType_LoadingAndMessage) {
        
        [self.loadingView startAnimation];
    }
    
    if (animated) {
        
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             self.contentView.transform = CGAffineTransformIdentity;
                             self.alpha = 1.0;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    else{
    
        self.contentView.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    }
}

- (void)lt_hide:(BOOL)animated{
    
    --showingCount;
    
    if (showingCount < 0) {
        showingCount = 0;
    }
    if (showingCount > 0) {
        
        return;
    }
    
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         
                         if (self.hudType == LTHUDType_LoadingAndMessage) {
                             
                             [self.loadingView stopAnimation];
                         }
                     }];
    
}

-(BOOL)isShowing{
    
    return showingCount>0;
}
@end
