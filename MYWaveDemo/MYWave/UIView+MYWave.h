//
//  UIView+MYWave.h
//  MYWaveDemo
//
//  Created by mayan on 2017/1/13.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MYWave)


// 浪弯曲度（默认1.5）
@property (nonatomic, assign) CGFloat waveCurvature;

// 浪速（默认0.5）
@property (nonatomic, assign) CGFloat waveSpeed;

// 浪高（默认4）
@property (nonatomic, assign) CGFloat waveHeight;

// 实浪颜色（默认白色）
@property (nonatomic, strong) UIColor *realWaveColor;

// 遮罩浪颜色（默认白色，透明度0.4）
@property (nonatomic, strong) UIColor *maskWaveColor;

// 随着波浪一起起伏的view们
@property (nonatomic, strong) NSArray<UIView *> *views;



// 开始浪
- (void)startWaveAnimation;

// 结束浪
- (void)stopWaveAnimation;




@end
