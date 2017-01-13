# MYWave
低耦合仿百度外卖波浪动画

网上有很多仿百度外卖波浪动画框架，之前我也写过继承 UIView 的 MYWaveView，但是不太适合加入现有项目中，修改太麻烦。昨天年前的项目终于结束了，终于有时间修改一下之前的代码，运用 runTime 将波浪动画设置成 UIView 的扩展类，零耦合接入项目中，HAPPY！！！ 



##### 浪弯曲度（默认1.5）
``` objc
@property (nonatomic, assign) CGFloat waveCurvature;
```

##### 浪速（默认0.5）
``` objc
@property (nonatomic, assign) CGFloat waveSpeed;
```

##### 浪高（默认4）
``` objc
@property (nonatomic, assign) CGFloat waveHeight;
```

##### 实浪颜色（默认白色）
``` objc
@property (nonatomic, strong) UIColor *realWaveColor;
```

##### 遮罩浪颜色（默认白色，透明度0.4）
``` objc
@property (nonatomic, strong) UIColor *maskWaveColor;
```

##### 随着波浪一起起伏的view们
``` objc
@property (nonatomic, strong) NSArray<UIView *> *views;
```


##### 开始浪
``` objc
- (void)startWaveAnimation;
```

##### 结束浪
``` objc
- (void)stopWaveAnimation;
```

