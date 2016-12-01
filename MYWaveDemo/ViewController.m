//
//  ViewController.m
//  MYWaveDemo
//
//  Created by mayan on 2016/12/1.
//  Copyright © 2016年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "MYWave.h"


#define MYScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end


@implementation ViewController




- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.size = CGSizeMake(60, 60);
        _imgView.centerX = MYScreenW * 0.5;
        _imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imgView.layer.borderWidth = 2;
        _imgView.layer.cornerRadius = 20;
    }
    return _imgView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    MYWave *wave = [[MYWave alloc] initWithFrame:CGRectMake(0, 0, MYScreenW, 200)];
    wave.backgroundColor = [UIColor orangeColor];
    wave.MYWaveBlock = ^(CGFloat currentY) {
        
        self.imgView.y = wave.height - self.imgView.height + currentY - wave.waveHeight;
    };
    
    [self.view addSubview:wave];
    
    [wave startWaveAnimation];
    
    
    [wave addSubview:self.imgView];
}



@end
