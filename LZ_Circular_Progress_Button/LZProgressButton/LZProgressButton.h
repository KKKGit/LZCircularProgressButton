//
//  LZProgressButton.h
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZProgressButton : UIButton

@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) CFTimeInterval titleScaleDuration;

@property (nonatomic, strong) UIColor *lz_tintColor;

@property (nonatomic, strong) UIColor *progressFillColor;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIColor *progressTrackColor;

@property (nonatomic, strong) UIColor *successCorlor;

@property (nonatomic, strong) UIColor *errorColor;

- (void)hiddenSubmitButton;

- (void)showSubmitButton:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
