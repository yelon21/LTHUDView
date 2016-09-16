//
//  LTAnimationView.m
//  LoadingDemo
//
//  Created by yelon on 16/9/16.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTAnimationView.h"

@interface LTAnimationView ()

@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CALayer *contentLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation LTAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setUp];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat minWidth = MIN(width, height);
    CGFloat radius = minWidth/sqrt(2.0);
    
    self.replicatorLayer.frame = CGRectMake(0, 0, radius, radius);
    self.replicatorLayer.position = CGPointMake(width/2.0, height/2.0);
    
    if (self.type<0) {
        
        self.type = LTLoadingViewTypeCircleLine;
    }
    else{
        
        self.type = self.type;
    }
}

#pragma mark setter & getter

-(CALayer *)contentLayer{
    
    if (!_contentLayer) {
        
        _contentLayer = [[CALayer alloc]init];
        _contentLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    
    return _contentLayer;
}

-(CAReplicatorLayer *)replicatorLayer{
    
    if (!_replicatorLayer) {
        
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    
    return _replicatorLayer;
}

-(CABasicAnimation *)animation{
    
    if (!_animation) {
        
        _animation = [CABasicAnimation animation];
        _animation.repeatCount = MAXFLOAT;
    }
    
    return _animation;
}

- (void)setUp{
    
    self.backgroundColor = [UIColor clearColor];
    _type = -1;
    
}

-(void)setType:(LTLoadingViewType)type{
    
    _type = type;
    
    switch (self.type) {
        case LTLoadingViewTypeCirclePoint:
            
            [self setCirclePoint];
            break;
        case LTLoadingViewTypeCircleLine:
            
            [self setCircleLine];
            break;
        default:
            break;
    }
    [self startAnimation];
}

- (void)setCirclePoint{
    
    self.contentLayer.frame = CGRectMake(0, 0, 10, 10);
    self.contentLayer.cornerRadius = 5;
    
    CFTimeInterval duration = 1.0;
    
    self.animation.keyPath = @"transform";
    self.animation.duration = duration;
    self.animation.repeatCount = MAXFLOAT;
    self.animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    self.animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 1.0, 1.0)];
    
    NSUInteger count = 12.0;
    
    CGFloat angle = 2.0 * M_PI / count;
    
    self.replicatorLayer.instanceCount = count;
    self.replicatorLayer.instanceDelay = duration / count;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
}

- (void)setCircleLine{
    
    CGFloat width = CGRectGetWidth(self.replicatorLayer.bounds)/2;
    
    self.contentLayer.frame = CGRectMake(width-2.5, 0, 5, width/2.0);
    self.contentLayer.cornerRadius = 2.5;
    
    CFTimeInterval duration = 1.0;
    
    self.animation.keyPath = @"opacity";
    self.animation.duration = duration;
    self.animation.repeatCount = MAXFLOAT;
    self.animation.fromValue = @1.0;
    self.animation.toValue = @0.1;
    
    NSUInteger count = 15.0;
    
    CGFloat angle = 2.0 * M_PI / count;
    
    self.replicatorLayer.instanceCount = count;
    self.replicatorLayer.instanceDelay = duration / count;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    self.replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
    self.replicatorLayer.instanceAlphaOffset = -1.0/count/5;
    
}

- (void)startAnimation{
    
    if (self.animating) {
        
        return;
    }
    _animating = YES;
    
    if (self.type == LTLoadingViewTypeCirclePoint
        ||self.type == LTLoadingViewTypeCircleLine) {
        
        [self.layer addSublayer:self.replicatorLayer];
        [self.replicatorLayer addSublayer:self.contentLayer];
        [self.contentLayer addAnimation:self.animation forKey:@"LT_LAYER_ANIMATION"];
    }
}

-(void)stopAnimation{
    
    if (!self.animating) {
        
        return;
    }
    
    _animating = NO;
    
    if (self.type == LTLoadingViewTypeCirclePoint
        ||self.type == LTLoadingViewTypeCircleLine) {
        
        [self.replicatorLayer removeFromSuperlayer];
        [self.contentLayer removeFromSuperlayer];
        [self.contentLayer removeAnimationForKey:@"LT_LAYER_ANIMATION"];
    }
}

@end
