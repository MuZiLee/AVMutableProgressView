//
//  ViewController.m
//  MPV
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 李飞恒. All rights reserved.
//

#import "ViewController.h"
#import "AVMutableProgressView.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupMutableProgressView];
}

- (IBAction)setupMutableProgressView
{
    
    CGRect frame = CGRectMake(0, self.view.center.y, self.view.bounds.size.width, 2);
    AVMutableProgressView *avMPV = [AVMutableProgressView progressView];
    avMPV.frame = frame;
    avMPV.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:avMPV];
    
    
    
    
}

- (IBAction)senderSliderEvent:(UISlider *)sender {
    
    
    [[AVMutableProgressView progressView] setupProgressWith:sender.value];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat w = self.view.bounds.size.width;
    int max = 90 + arc4random() % 812;
    [[AVMutableProgressView progressView] setupStartPoint:max];
}


@end
