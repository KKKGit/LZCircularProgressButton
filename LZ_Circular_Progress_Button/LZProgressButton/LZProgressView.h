//
//  LZProgressView.h
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZProgressView : UIView

@property (nonatomic, strong) UIColor *lz_tintColor;

@property (nonatomic, assign) CGFloat progressTrackWidth;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIColor *progressTrackColor;

@property (nonatomic, strong) UIColor *progressFillColor;

@property (nonatomic, assign) CGFloat progress;

- (void)resetProgress;

@end

NS_ASSUME_NONNULL_END
