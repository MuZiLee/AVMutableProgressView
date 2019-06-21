//
//  AVMutableProgressView.m
//  MPV
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 李飞恒. All rights reserved.
//

#import "AVMutableProgressView.h"

@interface AVMutableProgressView ()

@property (nonatomic, strong) CALayer *gradientLayer;

@property (nonatomic, strong) CAGradientLayer *leftLayer;
@property (nonatomic, strong) CALayer *pointLayer;
@property (nonatomic, strong) CALayer *rightLayer;


@property (nonatomic, strong) CAShapeLayer *maskPathLayer;

@end
@implementation AVMutableProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (instancetype)progressView
{
    static dispatch_once_t onceToken;
    static AVMutableProgressView *mProgressView;
    dispatch_once(&onceToken, ^{
        mProgressView = [[[self class] alloc] init];
    });
    return mProgressView;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self _setupMutableGradientLayer];
}

- (IBAction)setupMutableProgressView
{
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];
    [self.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
    leftLayer.locations = @[@0.3, @0.9, @.1];
    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor,
                         (id)[UIColor greenColor].CGColor,
                         (id)[UIColor brownColor].CGColor];
    [gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[@0.3, @0.9, @.1];
    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor,
                          (id)[UIColor redColor].CGColor,
                          (id)[UIColor magentaColor].CGColor];
    [gradientLayer addSublayer:rightLayer];
    

    
    
}

- (void)_setupMutableGradientLayer
{
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];
    [self.layer addSublayer:gradientLayer];
    
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
    leftLayer.locations = @[@0.0, @0.9, @1.];
    //startPoint&endPoint 颜色渐变的方向   (0,0)(1.0,0)代表水平方向渐变,
    //startPoint&endPoint 颜色渐变的方向   (0,0)(0,1.0)代表竖直方向渐变
    leftLayer.startPoint = CGPointMake(0, 0);
    leftLayer.endPoint = CGPointMake(1.0, 0);
    leftLayer.colors = @[(id)[UIColor clearColor].CGColor,
                         (id)[UIColor yellowColor].CGColor];
    [gradientLayer addSublayer:leftLayer];
    self.leftLayer = leftLayer;
    
    //标记点
    CALayer *pointLayer = [CALayer layer];
    pointLayer.frame = CGRectMake(leftLayer.bounds.size.width, 0, 5, self.bounds.size.height);    // 分段设置渐变色
    pointLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [gradientLayer addSublayer:pointLayer];
    self.pointLayer = pointLayer;
    
    //记录层
    CALayer *rightLayer = [CALayer layer];
    rightLayer.frame = CGRectMake(leftLayer.bounds.size.width + 5, 0, self.bounds.size.width - leftLayer.bounds.size.width - 5, self.bounds.size.height);    // 分段设置渐变色
    rightLayer.backgroundColor = [UIColor redColor].CGColor;
    [gradientLayer addSublayer:rightLayer];
    self.rightLayer = rightLayer;
    
    
    //mask 层
    CAShapeLayer *maskPathLayer = [CAShapeLayer layer];//创建一个track shape layer
    maskPathLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    maskPathLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    maskPathLayer.strokeColor = [[UIColor greenColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    maskPathLayer.opacity = 1; //背景颜色的透明度
    maskPathLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    maskPathLayer.lineWidth = self.bounds.size.height;//线的宽度
    [self.layer setMask:maskPathLayer];
    self.maskPathLayer = maskPathLayer;
    
    
//    self.clipsToBounds = YES;
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = self.bounds.size.height * 0.5;
}

#pragma mark - 设置标记位置 （自带动画）
- (void)setupStartPoint:(CGFloat)point
{
    self.leftLayer.frame = CGRectMake(0, 0, point, self.bounds.size.height);
    self.pointLayer.frame = CGRectMake(point, 0, 5, self.bounds.size.height);
    self.rightLayer.frame = CGRectMake(CGRectGetMaxX(self.pointLayer.frame),
                                       0,
                                       self.bounds.size.width - CGRectGetMaxX(self.pointLayer.frame),
                                       self.bounds.size.height);
}

#pragma mark - 路径控制mask
- (void)setupProgressWith:(CGFloat)progress
{
    //计算进度条终点位置
    CGFloat endA = self.bounds.size.width * progress;
    NSLog(@"%f - %f - %f", progress, self.bounds.size.width, endA);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,
                                                                            0,
                                                                            endA,
                                                                            self.bounds.size.height)
                                                    cornerRadius:self.layer.cornerRadius];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    self.maskPathLayer.path = [path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
}



@end
