//
//  MYWave.m
//  波浪框架
//
//  Created by mayan on 2016/12/1.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "MYWave.h"

@interface MYWave ()

// 刷屏器
@property (nonatomic, strong) CADisplayLink *timer;
// 真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
// 遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;\

@property (nonatomic, assign) CGFloat offset;

@end

@implementation MYWave



#pragma mark - 初始化

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
    }
    return self;
}



- (void)setupData
{
    
    
    self.userInteractionEnabled = NO;
    
    self.waveSpeed = 0.5;
    self.waveCurvature= 1.5;
    self.waveHeight = 4;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];

    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
}



#pragma mark - 懒加载

- (CAShapeLayer *)realWaveLayer
{
    if (!_realWaveLayer) {
        
        CAShapeLayer *realWaveLayer = [CAShapeLayer layer];
        realWaveLayer.frame = [self setWaveFrame];
        realWaveLayer.fillColor = self.realWaveColor.CGColor;
        
        _realWaveLayer = realWaveLayer;
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer
{
    if (!_maskWaveLayer) {
        
        CAShapeLayer *maskWaveLayer = [CAShapeLayer layer];
        maskWaveLayer.frame = [self setWaveFrame];
        maskWaveLayer.fillColor = self.realWaveColor.CGColor;
        
        _maskWaveLayer = maskWaveLayer;
    }
    return _maskWaveLayer;
}

- (CGRect)setWaveFrame
{
    CGRect frame = self.bounds;
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    
    return frame;
}



#pragma mark - set 属性

- (void)setWaveHeight:(CGFloat)waveHeight
{
    _waveHeight = waveHeight;
    
    _realWaveLayer.frame = [self setWaveFrame];
    _maskWaveLayer.frame = [self setWaveFrame];
}




#pragma mark - 开始&结束

- (void)startWaveAnimation
{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)wave
{
    self.offset += self.waveSpeed;
    
    CGFloat width = [self setWaveFrame].size.width;
    CGFloat height = self.waveHeight;
    
    // 真实浪
    CGMutablePathRef realpath = CGPathCreateMutable();
    CGPathMoveToPoint(realpath, NULL, 0, height);
    CGFloat realY = 0.f;
    
    // 遮罩浪
    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    
    for (CGFloat x = 0.f; x <= width; x++) {
        
        realY = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(realpath, NULL, x, realY);
        
        maskY = -realY;
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    
    // 变化的中间Y值
    CGFloat centerX = width * 0.5;
    CGFloat centerY = height * sinf(0.01 * self.waveCurvature * centerX + self.offset * 0.045);
    if (self.MYWaveBlock) {
        self.MYWaveBlock(centerY);
    }
    
    CGPathAddLineToPoint(realpath, NULL, width, height);
    CGPathAddLineToPoint(realpath, NULL, 0, height);
    CGPathCloseSubpath(realpath);
    self.realWaveLayer.path = realpath;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(realpath);
    
    CGPathAddLineToPoint(maskpath, NULL, width, height);
    CGPathAddLineToPoint(maskpath, NULL, 0, height);
    CGPathCloseSubpath(maskpath);
    self.maskWaveLayer.path = maskpath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskpath);
}


- (void)stopWaveAnimation
{
    [self.timer invalidate];
    self.timer = nil;
}


@end
