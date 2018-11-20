//
//  ViewController.m
//  LZ_Circular_Progress_Button
//
//  Created by Lvlinzhe on 2018/11/16.
//  Copyright © 2018 Linzhe. All rights reserved.
//

#import "ViewController.h"
#import "CircularProgressButton.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (nonatomic, strong) CircularProgressButton *progressButton;

@property (nonatomic, assign) BOOL needsReset;

@end

static AFHTTPSessionManager *manager = nil;

@implementation ViewController

- (AFHTTPSessionManager*)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = CGRectMake(
                                 0,
                                 0,
                                 [UIScreen mainScreen].bounds.size.width,
                                 [UIScreen mainScreen].bounds.size.height
                                 );
    
    [self creatProgressButton];
}

- (void)creatProgressButton {
    
    __weak typeof(self) weakSelf = self;
    _progressButton = [[CircularProgressButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80) touchUpInsideBlock:^{
        [weakSelf beginDownLoad];
    }];
//    _progressButton.title = @"test button";
//    _progressButton.titleFont = [UIFont systemFontOfSize:22.0f];
//    _progressButton.titleColor = [UIColor magentaColor];
//    _progressButton.tintColor = [UIColor purpleColor];
//    _progressButton.progressColor = [UIColor orangeColor];
//    _progressButton.progressTrackColor = [UIColor blackColor];
//    _progressButton.progressFillColor = [UIColor cyanColor];
//    _progressButton.progressTrackWidth = 10.0f;
//    _progressButton.cornerRadius = 10.0f;
//    _progressButton.animationDuration = 0.5f;
//    _progressButton.titleScaleDuration = 2.0f;
//    _progressButton.progress = self.progress;
    _progressButton.center = self.view.center;
    [self.view addSubview:_progressButton];
}

- (IBAction)reset:(id)sender {
    
    [self setNeedsReset:YES];
    
    [_progressButton removeFromSuperview];
    _progressButton = nil;
    [self cancel:nil];
    
    [self creatProgressButton];
}

- (IBAction)cancel:(id)sender {
    AFHTTPSessionManager *mgr = [self shareInstance];
    [mgr.downloadTasks enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
}

- (void)beginDownLoad{

    [self setNeedsReset:NO];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *mgr = [self shareInstance];
    NSURLSessionDownloadTask *downLoadTask = [mgr downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.5.2.dmg"]]
                                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                     
                                                                     //this block (progress) is called on the session queue, not the main queue.
                                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                                         
                                                                         //set progress
                                                                         if (!weakSelf.progressButton.progress) {
                                                                             weakSelf.progressButton.progress = downloadProgress;
                                                                         }
                                                                         
                                                                         //or set progressValue
                                                                         //weakSelf.progressButton.progressValue = downloadProgress.fractionCompleted;
                                                                     });
                                                                
                                                                 }
                                                              destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                  
                                                                  NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                                                  return [NSURL fileURLWithPath:filePath];
                                                                  
                                                              } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                  
                                                                  if (weakSelf.needsReset) {
                                                                      return;
                                                                  }
                                                                  
                                                                  if (error) {
                                                                      NSLog(@"error = %@",error);
                                                                      [weakSelf.progressButton doError];
                                                                  }
                                                                  else{
                                                                      [weakSelf.progressButton doSuccess];
                                                                  }
                                                                  
                                                              }];
    [downLoadTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
