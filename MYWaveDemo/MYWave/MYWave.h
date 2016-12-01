//
//  MYWave.h
//  波浪框架
//
//  Created by mayan on 2016/12/1.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYWave : UIView



// 浪弯曲度
@property (nonatomic, assign) CGFloat waveCurvature;

// 浪速
@property (nonatomic, assign) CGFloat waveSpeed;

// 浪高
@property (nonatomic, assign) CGFloat waveHeight;

// 实浪颜色
@property (nonatomic, strong) UIColor *realWaveColor;

// 遮罩浪颜色
@property (nonatomic, strong) UIColor *maskWaveColor;




@property (nonatomic, strong) void (^MYWaveBlock)(CGFloat currentY);






- (void)stopWaveAnimation;

- (void)startWaveAnimation;




@end
