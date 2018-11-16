//
//  LZTitleLabel.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "LZTitleLabel.h"
#import "LZDefines.h"

@interface LZTitleLabel ()

@property (nonatomic, strong) CAShapeLayer *completeLayer;
@property (nonatomic, strong) UIBezierPath *successPath;
@property (nonatomic, strong) UIBezierPath *errorPath;

@end

@implementation LZTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.text = DEFAULT_TITLE;
        self.textColor = DEFAULT_TITLE_COLOR;
        self.backgroundColor = [UIColor clearColor];
        self.font = DEFAULT_TITLE_FONT;
        self.textAlignment = NSTextAlignmentCenter;
        [self creatCompleteLayer];
    }
    return self;
}

- (void)touchDownAnimation {
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration          = self.titleScaleDuration / 2;
    scaleAnimation.autoreverses      = YES;
    scaleAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.fromValue         = [NSNumber numberWithFloat:1.0f];
    scaleAnimation.toValue           = [NSNumber numberWithFloat:0.8f];
    [self.layer addAnimation:scaleAnimation forKey:@"titleScaleAnimation"];
}

- (void)hideLabelAnimation:(void (^)(void))hideComplete{
    [UIView animateWithDuration:self.animationDuration
                          delay:self.titleScaleDuration
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (hideComplete) {
                             hideComplete();
                         }
                     }];
}

- (void)showLabelAnimation:(BOOL)success{
    self.text = @"";
    if (success) {
        [self creatSuccessPath];
    }else{
        [self creatErrorPath];
    }
    [self setCompleteAnimation];
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.alpha = 1;
    }];
}

- (void)creatCompleteLayer {
    
    _completeLayer = [CAShapeLayer layer];
    _completeLayer.fillColor = [UIColor clearColor].CGColor;
    _completeLayer.strokeColor = [UIColor whiteColor].CGColor;
    _completeLayer.lineJoin  = kCALineJoinRound;
    _completeLayer.lineWidth = 4;
    _completeLayer.strokeStart = 0.0f;
    _completeLayer.strokeEnd = 0.0f;
    [self.layer addSublayer:_completeLayer];
}

- (void)creatErrorPath{
    if (!_errorPath) {
        _errorPath = [UIBezierPath bezierPath];
        CGFloat margin = 10 * 4 / 5;
        CGPoint centerPoint = (CGPoint){self.bounds.size.width/2, self.bounds.size.height/2};
        
        [_errorPath moveToPoint:CGPointMake(centerPoint.x + margin, centerPoint.y - margin)];
        [_errorPath addLineToPoint:CGPointMake(centerPoint.x - margin, centerPoint.y + margin)];
        [_errorPath moveToPoint:CGPointMake(centerPoint.x - margin, centerPoint.y - margin)];
        [_errorPath addLineToPoint:CGPointMake(centerPoint.x + margin, centerPoint.y + margin)];
    }
    _completeLayer.lineCap = kCALineCapSquare;
    _completeLayer.path = _errorPath.CGPath;
}

- (void)creatSuccessPath{
    
    if (!_successPath) {
        _successPath = [UIBezierPath bezierPath];
        CGFloat margin = 10;
        CGPoint centerPoint = (CGPoint){self.bounds.size.width/2 + margin / 4, self.bounds.size.height/2 + margin / 2};
        
        [_successPath moveToPoint:CGPointMake(centerPoint.x - margin * 5 / 4, centerPoint.y - margin / 4)];
        [_successPath addLineToPoint:CGPointMake(centerPoint.x - margin / 2, centerPoint.y + margin / 2)];
        [_successPath addLineToPoint:CGPointMake(centerPoint.x + margin, centerPoint.y - margin)];
    }
    _completeLayer.lineCap = kCALineCapRound;
    _completeLayer.path = _successPath.CGPath;
}

- (void)setCompleteAnimation{
    
    CFTimeInterval layerTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    CABasicAnimation *strokeAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.duration            = self.titleScaleDuration;
    strokeAnimation.beginTime           = layerTime + self.titleScaleDuration;
    strokeAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnimation.fromValue           = [NSNumber numberWithFloat:0.0f];
    strokeAnimation.toValue             = [NSNumber numberWithFloat:1.0f];
    strokeAnimation.removedOnCompletion = NO;
    strokeAnimation.fillMode            = kCAFillModeForwards;
    [self.completeLayer addAnimation:strokeAnimation forKey:@"strokeEndAnimation"];
}

- (CFTimeInterval)animationDuration{
    return _animationDuration ? _animationDuration : DEFAULT_ANIMATION_DURATION;
}

- (CFTimeInterval)titleScaleDuration{
    return _titleScaleDuration ? _titleScaleDuration : DEFAULT_TITLE_SCALE_DURATION;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
