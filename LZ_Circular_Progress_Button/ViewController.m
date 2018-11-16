//
//  ViewController.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "ViewController.h"
#import "CircularProgressButton.h"

@interface ViewController (){
    NSInteger i;
}

@property (nonatomic, strong) CADisplayLink *timer;

//@property (nonatomic, assign) CGFloat newProgress;

@property (nonatomic, assign) NSInteger completedUnitCount;

@property (nonatomic, strong) NSProgress *progress;

@end

@implementation ViewController{
    CircularProgressButton *sub;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self newSubmitView];
}

- (void)startTimer{
    if (_timer) {
        return;
    }
    
    i = arc4random() % 2;
    //    self.newProgress = 0.0f;
    self.completedUnitCount = 0;
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerEvent)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    if (!_timer) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}

- (void)timerEvent{
    
    //    self.newProgress += 0.01f;
    //
    //    if (i == 0) {
    //        if (self.newProgress >= 0.4) {
    //            [self stopTimer];
    //            [sub doError];
    //            return;
    //        }
    //    }
    //    else{
    //        if (self.newProgress >= 1.0f) {
    //            [self stopTimer];
    //            [sub doSuccess];
    //            return;
    //        }
    //    }
    //
    //    sub.progressValue = self.newProgress;
    
    self.completedUnitCount += 10;
    
    if (i == 0) {
        if (self.completedUnitCount >= 400) {
            [self stopTimer];
            [sub doError];
            return;
        }
    }
    else{
        if (self.completedUnitCount >= 1000) {
            [self stopTimer];
            [sub doSuccess];
            return;
        }
    }
    
    self.progress.completedUnitCount = self.completedUnitCount;
    
}

- (void)newSubmitView {
    __weak typeof(self) weakSelf = self;
    sub = [[CircularProgressButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80) touchUpInsideBlock:^{
        [weakSelf startTimer];
    }];
    //    sub.tintColor = [UIColor purpleColor];
    //    sub.progressColor = [UIColor orangeColor];
    //    sub.progressTrackColor = [UIColor blackColor];
    //    sub.progressFillColor = [UIColor cyanColor];
    //    sub.progressTrackWidth = 10.0f;
    //    sub.cornerRadius = 10.0f;
    //    sub.animationDuration = 0.5f;
    //    sub.titleScaleDuration = 2.0f;
    self.progress = [NSProgress progressWithTotalUnitCount:1000];
    sub.progress = self.progress;
    sub.center = self.view.center;
    [self.view addSubview:sub];
}

- (IBAction)click:(id)sender {
    [sub removeFromSuperview];
    [self newSubmitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
