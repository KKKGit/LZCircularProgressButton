//
//  LZProgressView.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "LZProgressView.h"
#import "LZDefines.h"

@interface LZProgressView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIBezierPath *trackBezierPath;

@end

@implementation LZProgressView

@synthesize progressTrackWidth = _progressTrackWidth;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self configLayers];
    }
    return self;
}

- (void)configLayers{

    _trackLayer = [CAShapeLayer layer];
    _trackLayer.strokeColor = DEFAULT_TRACK_COLOR.CGColor;
    _trackLayer.lineWidth = DEFAULT_TRACK_WIDTH;
    _trackLayer.fillColor =  [UIColor clearColor].CGColor;
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.lineJoin = kCALineCapRound;
    [self.layer addSublayer:_trackLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = DEFAULT_PROGRESS_COLOR.CGColor;
    _progressLayer.lineWidth = DEFAULT_TRACK_WIDTH;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineJoin = kCALineCapRound;
    _progressLayer.strokeStart = 0.0f;
    _progressLayer.strokeEnd = 0.0f;
    [self.layer addSublayer:_progressLayer];
    
    [self setBezierPath];
}

- (void)setBezierPath{
    
    _trackBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.height/2.0f, self.bounds.size.height/2.0f)
                                                      radius:(CGRectGetWidth(self.bounds) - self.progressTrackWidth) / 2.0f
                                                  startAngle:- M_PI_2
                                                    endAngle:M_PI * 1.5f
                                                   clockwise:YES];
    _trackLayer.path = _trackBezierPath.CGPath;
    _progressLayer.path = _trackBezierPath.CGPath;
}

- (void)setProgress:(CGFloat)progress{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.5f;
    animation.fromValue = @(_progress);
    animation.toValue = @(progress);
    [self.progressLayer addAnimation:animation forKey:@"progressAnimation"];
    _progress = progress;
}

- (void)resetProgress{
    self.progress = 0.0f;
}

- (void)setProgressTrackWidth:(CGFloat)progressTrackWidth{
    _progressTrackWidth = progressTrackWidth;
    _trackLayer.lineWidth = progressTrackWidth;
    _progressLayer.lineWidth = progressTrackWidth;
    
    [self setBezierPath];
}

- (CGFloat)progressTrackWidth{
    return _progressTrackWidth ? _progressTrackWidth : DEFAULT_TRACK_WIDTH;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setLz_tintColor:(UIColor *)lz_tintColor{
    _lz_tintColor = lz_tintColor;
    if (!_progressColor) {
        _progressLayer.strokeColor = lz_tintColor.CGColor;
    }
}

- (void)setProgressFillColor:(UIColor *)progressFillColor{
    _progressFillColor = progressFillColor;
    _trackLayer.fillColor = progressFillColor.CGColor;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor{
    _progressTrackColor = progressTrackColor;
    _trackLayer.strokeColor = progressTrackColor.CGColor;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}


@end
