//
//  CircularProgressButton.h
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^buttonClickBlock) (void);

@interface CircularProgressButton : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) CFTimeInterval titleScaleDuration;

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, assign) CGFloat progressTrackWidth;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIColor *progressTrackColor;

@property (nonatomic, strong) UIColor *progressFillColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, strong) UIColor *successCorlor;

@property (nonatomic, strong) UIColor *errorColor;

@property (nonatomic, assign) CGFloat progressValue;

@property (nonatomic, strong) NSProgress *progress;

- (instancetype)initWithFrame:(CGRect)frame touchUpInsideBlock:(void (^)(void))block;

- (void)doSuccess;

- (void)doError;

@end

NS_ASSUME_NONNULL_END
