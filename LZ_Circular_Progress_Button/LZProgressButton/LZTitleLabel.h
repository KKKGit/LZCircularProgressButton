//
//  LZTitleLabel.h
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZTitleLabel : UILabel

@property (nonatomic, assign) CFTimeInterval animationDuration;

@property (nonatomic, assign) CFTimeInterval titleScaleDuration;

- (void)touchDownAnimation;

- (void)hideLabelAnimation:(void (^)(void))hideComplete;

- (void)showLabelAnimation:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
