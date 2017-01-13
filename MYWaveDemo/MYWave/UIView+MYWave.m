//
//  UIView+MYWave.m
//  MYWaveDemo
//
//  Created by mayan on 2017/1/13.
//  Copyright © 2017年 mayan. All rights reserved.
//  https://github.com/Mayan29/MYWave.git

#import "UIView+MYWave.h"
#import <objc/message.h>

@interface UIView ()

// 刷屏器
@property (nonatomic, strong) CADisplayLink *timer;
// 真实浪
@property (nonatomic, strong) CAShapeLayer *realWaveLayer;
// 遮罩浪
@property (nonatomic, strong) CAShapeLayer *maskWaveLayer;

@property (nonatomic, assign) CGFloat offset;

@end

@implementation UIView (MYWave)



#pragma mark - 私有属性设置

- (void)setTimer:(CADisplayLink *)timer
{
    objc_setAssociatedObject(self, "timer", timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CADisplayLink *)timer
{
    return objc_getAssociatedObject(self, "timer");
}



- (void)setOffset:(CGFloat)offset
{
    objc_setAssociatedObject(self, "offset", @(offset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)offset
{
    return [objc_getAssociatedObject(self, "offset") floatValue];
}



- (CAShapeLayer *)realWaveLayer
{
    CAShapeLayer *realWaveLayer = objc_getAssociatedObject(self, "realWaveLayer");
    if (!realWaveLayer) {
        
        realWaveLayer = [CAShapeLayer layer];
        realWaveLayer.frame = [self setWaveFrame];
        
        [self.layer addSublayer:realWaveLayer];
        
        objc_setAssociatedObject(self, "realWaveLayer", realWaveLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer
{
    CAShapeLayer *maskWaveLayer = objc_getAssociatedObject(self, "maskWaveLayer");
    if (!maskWaveLayer) {
        
        maskWaveLayer = [CAShapeLayer layer];
        maskWaveLayer.frame = [self setWaveFrame];
        
        [self.layer addSublayer:maskWaveLayer];
        
        objc_setAssociatedObject(self, "maskWaveLayer", maskWaveLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return maskWaveLayer;
}

- (CGRect)setWaveFrame
{
    CGRect frame = self.bounds;
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    
    return frame;
}



#pragma mark - set / get


// 浪弯曲度
- (void)setWaveCurvature:(CGFloat)waveCurvature
{
    objc_setAssociatedObject(self, "waveCurvature", @(waveCurvature), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)waveCurvature
{
    NSNumber *number = objc_getAssociatedObject(self, "waveCurvature");
    
    if (number == nil) {
        return 1.5;
    }
    return number.floatValue;
}



// 浪速
- (void)setWaveSpeed:(CGFloat)waveSpeed
{
    objc_setAssociatedObject(self, "waveSpeed", @(waveSpeed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)waveSpeed
{
    NSNumber *number = objc_getAssociatedObject(self, "waveSpeed");
    
    if (number == nil) {
        return 0.5;
    }
    
    return number.floatValue;
}



// 浪高
- (void)setWaveHeight:(CGFloat)waveHeight
{
    objc_setAssociatedObject(self, "waveHeight", @(waveHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.realWaveLayer.frame = [self setWaveFrame];
    self.maskWaveLayer.frame = [self setWaveFrame];
}

- (CGFloat)waveHeight
{
    NSNumber *number = objc_getAssociatedObject(self, "waveHeight");
    
    if (number == nil) {
        return 4;
    }
    return number.floatValue;
}



// 实浪颜色
- (void)setRealWaveColor:(UIColor *)realWaveColor
{
    objc_setAssociatedObject(self, "waveHeight", realWaveColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.realWaveLayer.fillColor = realWaveColor.CGColor;
}

- (UIColor *)realWaveColor
{
    UIColor *color = objc_getAssociatedObject(self, "realWaveColor");
    
    if (color == nil) {
        return [UIColor whiteColor];
    }
    return color;
}



// 遮罩浪颜色
- (void)setMaskWaveColor:(UIColor *)maskWaveColor
{
    objc_setAssociatedObject(self, "maskWaveColor", maskWaveColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.maskWaveLayer.fillColor = maskWaveColor.CGColor;
}

- (UIColor *)maskWaveColor
{
    UIColor *color = objc_getAssociatedObject(self, "maskWaveColor");
    
    if (color == nil) {
        return [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    }
    return color;
}



- (void)setViews:(NSArray<UIView *> *)views
{
    objc_setAssociatedObject(self, "views", views, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIView *> *)views
{
    return objc_getAssociatedObject(self, "views");
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
    
    
    for (UIView *view in self.views) {
        
        CGRect frame = view.frame;
        frame.origin.y = self.bounds.size.height - frame.size.height + centerY - self.waveHeight;
        view.frame = frame;
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
