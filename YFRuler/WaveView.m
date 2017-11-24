//
//  WaveView.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/24.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView

- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor orangeColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth    = 15.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGFloat width  = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    [path moveToPoint:CGPointMake(0, height/2.0)];
    [path addCurveToPoint:CGPointMake(width, height/2.0) controlPoint1:CGPointMake(width/2.0, 0) controlPoint2:CGPointMake(width/2.0, height)];
    
    [path stroke];
}


@end
