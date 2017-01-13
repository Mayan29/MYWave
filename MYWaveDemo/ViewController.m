//
//  ViewController.m
//  MYWaveDemo
//
//  Created by mayan on 2016/12/1.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "UIView+MYWave.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 初始化view
    UIView *waveView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    waveView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:waveView];
    
    
    // 初始化view上的头像图标
    UIImageView *icon = [[UIImageView alloc] init];
    icon.size = CGSizeMake(60, 60);
    icon.centerX = waveView.width * 0.5;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.layer.borderWidth = 2;
    icon.layer.cornerRadius = 20;
    [waveView addSubview:icon];
    
    
    // 设置浪相关属性
    waveView.views = @[icon];
//    waveView.waveCurvature = 1.5;
//    waveView.waveSpeed = 0.5;
//    waveView.waveHeight = 4;
//    waveView.realWaveColor = [UIColor whiteColor];
//    waveView.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [waveView startWaveAnimation];
}



@end
