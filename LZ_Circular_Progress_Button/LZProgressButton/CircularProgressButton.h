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

/**
 default is "Submit".
 */
@property (nullable, nonatomic, copy) NSString *title;

/**
 default is "[UIColor whiteColor]".
 */
@property (nullable, nonatomic, strong) UIColor *titleColor;

/**
 default is "[UIFont boldSystemFontOfSize:18]".
 */
@property (nullable, nonatomic, strong) UIFont *titleFont;

/**
 default is "0.5f".
 */
@property (nonatomic, assign) CFTimeInterval animationDuration;

/**
 default is "0.25f".
 */
@property (nonatomic, assign) CFTimeInterval titleScaleDuration;

/**
 default is "r:1.0/255.0 g:153.0/255.0 b:204.0/255.0 a:1.0".
 */
@property (nullable, nonatomic, strong) UIColor *tintColor;

/**
 default is "4.0f".
 */
@property (nonatomic, assign) CGFloat progressTrackWidth;

/**
 default is "tintColor".
 */
@property (nullable, nonatomic, strong) UIColor *progressColor;

/**
 default is "r:222.0/255.0 g:222.0/255.0 b:222.0/255.0 a:1.0".
 */
@property (nullable, nonatomic, strong) UIColor *progressTrackColor;

/**
 default is "[UIColor whiteColor]".
 */
@property (nullable, nonatomic, strong) UIColor *progressFillColor;

/**
 default is "0.0f".
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 default is "r:153.0/255.0 g:204.0/255.0 b:0.0/255.0 a:1.0".
 */
@property (nullable, nonatomic, strong) UIColor *successCorlor;

/**
 default is "r:255.0/255.0 g:68.0/255.0 b:68.0/255.0 a:1.0"

 */
@property (nullable, nonatomic, strong) UIColor *errorColor;

/**
 use "progressValue" or "progress", can't be used at the same time.
 */
@property (nonatomic, assign) CGFloat progressValue;

/**
 use "progressValue" or "progress", can't be used at the same time.
 */
@property (nullable, nonatomic, strong) NSProgress *progress;

- (instancetype)initWithFrame:(CGRect)frame touchUpInsideBlock:(void (^)(void))block;

- (void)doSuccess;

- (void)doError;

@end

NS_ASSUME_NONNULL_END
