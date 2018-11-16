//
//  LZProgressButton.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "LZProgressButton.h"
#import "LZDefines.h"

@interface LZProgressButton () <CAAnimationDelegate>

@property (nonatomic, strong) UIColor *currentColor;

@end

@implementation LZProgressButton

@synthesize lz_tintColor = _lz_tintColor;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DEFAULT_TINT_COLOR;
        self.layer.borderColor = DEFAULT_TINT_COLOR.CGColor;
        self.layer.borderWidth = DEFAULT_TRACK_WIDTH;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)hiddenSubmitButton {
    
    self.userInteractionEnabled = NO;
    
    CFTimeInterval layerTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *radiusAnimation   = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.fromValue           = [NSNumber numberWithFloat:self.layer.cornerRadius];
    radiusAnimation.toValue             = [NSNumber numberWithFloat:self.bounds.size.height/2];
    radiusAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    radiusAnimation.removedOnCompletion = NO;
    radiusAnimation.fillMode            = kCAFillModeForwards;
    radiusAnimation.duration            = self.animationDuration / 2;
    
    CABasicAnimation *backgroundColoraAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColoraAnimation.fromValue         = _currentColor ? _currentColor : (id)self.lz_tintColor.CGColor;
    backgroundColoraAnimation.toValue           = (id)self.progressFillColor.CGColor;
    backgroundColoraAnimation.duration          = self.animationDuration;
    backgroundColoraAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *borderColorAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColorAnimation.duration          = self.animationDuration;
    borderColorAnimation.fromValue         = _currentColor ? _currentColor : (id)self.lz_tintColor.CGColor;
    borderColorAnimation.toValue           = (id)self.progressTrackColor.CGColor;
    borderColorAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.duration          = self.animationDuration;
    boundsAnimation.fromValue         = [NSValue valueWithCGRect:self.bounds];
    boundsAnimation.toValue           = [NSValue valueWithCGRect:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    boundsAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    groupAnimation.beginTime           = layerTime + self.titleScaleDuration;
    groupAnimation.fillMode            = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.duration            = self.animationDuration;
    groupAnimation.animations          = [NSArray arrayWithObjects:radiusAnimation, borderColorAnimation, backgroundColoraAnimation, boundsAnimation, nil];
    
    [self.layer addAnimation:groupAnimation forKey:@"scaleAnimation"];
}

- (void)showSubmitButton:(BOOL)success {
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.fromValue         = [NSNumber numberWithFloat:self.bounds.size.height/2];
    radiusAnimation.toValue           = [NSNumber numberWithFloat:self.layer.cornerRadius];
    radiusAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    radiusAnimation.beginTime         = self.animationDuration / 2;
    radiusAnimation.duration          = self.animationDuration / 2;
    
    CABasicAnimation *backgroundColoraAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColoraAnimation.fromValue         = (id)self.progressFillColor.CGColor;
    backgroundColoraAnimation.toValue           = success ? (id)self.successCorlor.CGColor : (id)self.errorColor.CGColor;
    backgroundColoraAnimation.duration          = self.animationDuration;
    backgroundColoraAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *borderColorAnimation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    borderColorAnimation.duration          = self.animationDuration;
    borderColorAnimation.fromValue         = (id)self.progressColor.CGColor;
    borderColorAnimation.toValue           = success ? (id)self.successCorlor.CGColor : (id)self.errorColor.CGColor;
    borderColorAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    _currentColor = success ? (id)self.successCorlor : (id)self.errorColor;
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.duration          = self.animationDuration;
    boundsAnimation.fromValue         = [NSValue valueWithCGRect:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    boundsAnimation.toValue           = [NSValue valueWithCGRect:self.bounds];
    boundsAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
#warning Memory Leak
    groupAnimation.fillMode            = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.duration            = self.animationDuration;
    groupAnimation.animations          = [NSArray arrayWithObjects:radiusAnimation, borderColorAnimation, backgroundColoraAnimation, boundsAnimation, nil];
    groupAnimation.delegate            = self;
    
    [self.layer addAnimation:groupAnimation forKey:@"expandAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        self.userInteractionEnabled = YES;
    }
}

- (void)setLz_tintColor:(UIColor *)lz_tintColor{
    _lz_tintColor = lz_tintColor;
    self.backgroundColor = lz_tintColor;
    self.layer.borderColor = self.progressColor.CGColor;
}

- (CFTimeInterval)animationDuration{
    return _animationDuration ? _animationDuration : DEFAULT_ANIMATION_DURATION;
}

- (CFTimeInterval)titleScaleDuration{
    return _titleScaleDuration ? _titleScaleDuration : DEFAULT_TITLE_SCALE_DURATION;
}

- (UIColor *)lz_tintColor{
    return _lz_tintColor ? _lz_tintColor : DEFAULT_TINT_COLOR;
}

- (UIColor *)progressTrackColor{
    return _progressTrackColor ? _progressTrackColor : DEFAULT_TRACK_COLOR;
}

- (UIColor *)progressColor{
    return _progressColor ? _progressColor : self.lz_tintColor;
}

-(UIColor *)progressFillColor{
    return _progressFillColor ? _progressFillColor : DEFAULT_FILL_COLOR;
}

- (UIColor *)successCorlor{
    return _successCorlor ? _successCorlor : DEFAULT_SUCCESS_COLOR;
}

- (UIColor *)errorColor{
    return _errorColor ? _errorColor : DEFAULT_ERROR_COLOR;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
