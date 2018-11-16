//
//  CircularProgressButton.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "CircularProgressButton.h"
#import "LZProgressButton.h"
#import "LZProgressView.h"
#import "LZTitleLabel.h"

@interface CircularProgressButton ()

@property (nonatomic, strong) LZProgressButton *progressButton;
@property (nonatomic, strong) LZProgressView *progressView;
@property (nonatomic, strong) LZTitleLabel *titleLabel;

@property (nonatomic, copy) void(^touchUpInsideBlock)(void);

@end

@implementation CircularProgressButton

- (instancetype)initWithFrame:(CGRect)frame touchUpInsideBlock:(void (^)(void))block{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.touchUpInsideBlock = block;
    }
    return self;
}

- (void)setupSubViews {
    
    _progressButton = [[LZProgressButton alloc] initWithFrame:self.bounds];
    [_progressButton addTarget:self action:@selector(progressButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_progressButton addTarget:self action:@selector(progressButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_progressButton];
    
    _titleLabel = [[LZTitleLabel alloc] initWithFrame:self.bounds];
    [self addSubview:_titleLabel];
    
    CGFloat progressX = self.bounds.size.width/2 - self.bounds.size.height/2;
    CGFloat progressWH = self.bounds.size.height;
    CGRect progressFrame = (CGRect){{progressX, 0}, {progressWH, progressWH}};
    
    //创建一个进度环view
    _progressView = [[LZProgressView alloc] initWithFrame:progressFrame];
    _progressView.hidden = YES;
    [self addSubview:_progressView];
}

- (void)progressButtonTouchDown {
    [self.titleLabel touchDownAnimation];
}

- (void)progressButtonTouchUpInside:(UIButton *)submitBtn {
    
    [self.progressButton hiddenSubmitButton];
    [self.titleLabel hideLabelAnimation:^{
        [self drawProgressLayer];
        self.touchUpInsideBlock();
    }];
}

//进度环动
- (void)drawProgressLayer {
    self.progressView.hidden = NO;
}

- (void)doSuccess{
    [self showResults:YES];
}

- (void)doError{
    [self showResults:NO];
}

- (void)showResults:(BOOL)success {
    self.progressView.hidden = YES;
    [self.progressView resetProgress];
    [self.progressButton showSubmitButton:success];
    [self.titleLabel showLabelAnimation:success];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    self.progressButton.lz_tintColor = tintColor;
    self.progressView.lz_tintColor = tintColor;
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration{
    _animationDuration = animationDuration;
    self.progressButton.animationDuration = animationDuration;
    self.titleLabel.animationDuration = animationDuration;
}

- (void)setTitleScaleDuration:(CFTimeInterval)titleScaleDuration{
    _titleScaleDuration = titleScaleDuration;
    self.titleLabel.titleScaleDuration = titleScaleDuration;
    self.progressButton.titleScaleDuration = titleScaleDuration;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.progressButton.layer.cornerRadius = cornerRadius;
}

- (void)setProgressTrackWidth:(CGFloat)progressTrackWidth{
    _progressTrackWidth = progressTrackWidth;
    self.progressButton.layer.borderWidth = progressTrackWidth;
    self.progressView.progressTrackWidth = progressTrackWidth;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor{
    _progressTrackColor = progressTrackColor;
    self.progressButton.progressTrackColor = progressTrackColor;
    self.progressView.progressTrackColor = progressTrackColor;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressButton.progressColor = progressColor;
    self.progressView.progressColor = progressColor;
}

- (void)setProgressFillColor:(UIColor *)progressFillColor{
    _progressFillColor = progressFillColor;
    self.progressButton.progressFillColor = progressFillColor;
    self.progressView.progressFillColor = progressFillColor;
}

- (void)setSuccessCorlor:(UIColor *)successCorlor{
    _successCorlor = successCorlor;
    self.progressButton.successCorlor = successCorlor;
}

- (void)setErrorColor:(UIColor *)errorColor{
    _errorColor = errorColor;
    self.progressButton.errorColor = errorColor;
}

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    _progressView.progress = progressValue;
}

- (void)setProgress:(NSProgress *)progress{
    [_progress removeObserver:self forKeyPath:@"fractionCompleted"];
    _progress = progress;
    [_progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.progressValue = self.progress.fractionCompleted;
}

- (void)dealloc{
    [_progress removeObserver:self forKeyPath:@"fractionCompleted"];
    NSLog(@"%s",__func__);
}

@end
