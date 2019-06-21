//
//  AVMutableProgressView.h
//  MPV
//
//  Created by admin on 2019/6/21.
//  Copyright © 2019 李飞恒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVMutableProgressView : UIView

+ (instancetype)progressView;

- (void)setupProgressWith:(CGFloat)progress;

- (void)setupStartPoint:(CGFloat)point;

@end

NS_ASSUME_NONNULL_END
