//
//  YFRulerView.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/7.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "YFRulerView.h"

@interface YFRulerView ()

@property (nonatomic, assign) float rulerBottom;

// 横向对应Y轴 纵向对应X轴

/// 刻度起x y轴
@property (nonatomic, assign) float mark_bottom;
/// 短刻度头部x y 轴
@property (nonatomic, assign) float mark_short_top;
/// 长刻度头部x y 轴
@property (nonatomic, assign) float mark_long_top;
/// 双刻度 刻度起x y轴
@property (nonatomic, assign) float mark_bottom2;
/// 双刻度 短刻度头部x y 轴
@property (nonatomic, assign) float mark_short_top2;
/// 双刻度 长刻度头部x y 轴
@property (nonatomic, assign) float mark_long_top2;

@end

@implementation YFRulerView


#pragma mark - Life Cycle

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.backgroundColor = [UIColor clearColor];
    
    // x-0.5: 宽度的一半
//    self.pointerFrame = CGRectMake(self.bounds.size.width/2.0-0.5, 0, 1, self.bounds.size.height);
    self.pointerColor = [UIColor grayColor];
    
    self.showRulerValue = YES;
    self.rulerColor = [UIColor clearColor];
    self.rulerWidth = 1;
    self.markColor  = [UIColor darkGrayColor];
    self.txtColor   = [UIColor whiteColor];
    self.txtFont    = [UIFont systemFontOfSize:15];
    self.txtPadding = 3;
    self.txtPositionBottom = NO;
    self.txtFace = YFTextFace_Down_Right;
    
    self.l_height    = 10;
    self.s_height    = 5;
    self.minValue    = 0;
    self.maxValue    = 5000;
    self.unitValue   = 100;
    self.unitWidth   = 1;
    self.unitCount   = 10;
    self.unitPadding = 10;
    self.rulerDirection = YFRulerDirectionHorizontal;
    self.rulerFace      = YFRulerFace_Both;
}


#pragma mark - Event Response
- (void)redraw
{
    [self prepareForRedraw];
    [self setNeedsDisplay];
}

#pragma mark - Private Method
- (void)prepareForRedraw
{
    // 先算起始点  横向对应Y轴 纵向对应X轴
    if (self.rulerFace == YFRulerFace_Both) {
        
        if (self.rulerDirection == YFRulerDirectionHorizontal) {
            self.mark_bottom    = 0;
            self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
            self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;

            self.mark_bottom2    = self.frame.size.height;
            self.mark_long_top2  = self.mark_bottom2 - self.rulerWidth - self.l_height;
            self.mark_short_top2 = self.mark_bottom2 - self.rulerWidth - self.s_height;
        }
        else {
            self.mark_bottom    = 0;
            self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
            self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;
            
            self.mark_bottom2    = self.frame.size.width;
            self.mark_long_top2  = self.mark_bottom2 - self.rulerWidth - self.l_height;
            self.mark_short_top2 = self.mark_bottom2 - self.rulerWidth - self.s_height;
        }
        
    }
    else {
        if (self.rulerDirection == YFRulerDirectionHorizontal) {
            if (self.rulerFace == YFRulerFace_Up_Left) {
                if (self.txtPositionBottom) {
                    self.mark_bottom    = self.frame.size.height / 2.0;
                    self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
                    self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;
                }
                else {
                    self.mark_bottom    = 0;
                    self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
                    self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;
                }
            }
            else {
                if (self.txtPositionBottom) {
                    self.mark_bottom    = self.frame.size.height / 2.0;
                    self.mark_long_top  = self.mark_bottom - self.rulerWidth - self.l_height;
                    self.mark_short_top = self.mark_bottom - self.rulerWidth - self.s_height;
                }
                else {
                    self.mark_bottom    = self.frame.size.height;
                    self.mark_long_top  = self.mark_bottom - self.rulerWidth - self.l_height;
                    self.mark_short_top = self.mark_bottom - self.rulerWidth - self.s_height;
                }
            }
        }
        else {
            if (self.rulerFace == YFRulerFace_Up_Left) {
                if (self.txtPositionBottom) {
                    self.mark_bottom    = self.frame.size.width / 2.0;
                    self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
                    self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;
                }
                else {
                    self.mark_bottom    = 0;
                    self.mark_long_top  = self.mark_bottom + self.rulerWidth + self.l_height;
                    self.mark_short_top = self.mark_bottom + self.rulerWidth + self.s_height;
                }
            }
            else {
                if (self.txtPositionBottom) {
                    self.mark_bottom    = self.frame.size.width / 2.0;
                    self.mark_long_top  = self.mark_bottom - self.rulerWidth - self.l_height;
                    self.mark_short_top = self.mark_bottom - self.rulerWidth - self.s_height;
                }
                else {
                    self.mark_bottom    = self.frame.size.width;
                    self.mark_long_top  = self.mark_bottom - self.rulerWidth - self.l_height;
                    self.mark_short_top = self.mark_bottom - self.rulerWidth - self.s_height;
                }
            }
        }
    }
}

#pragma mark - Getter & Setter

// 1.标尺轴 2.刻度 3.文字
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 文字属性
    NSDictionary *attributes;
    if (self.txtAttributes) {
        attributes = self.txtAttributes;
    }
    else {
        NSMutableParagraphStyle *txtStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        txtStyle.lineBreakMode = NSLineBreakByWordWrapping;
        txtStyle.alignment     = NSTextAlignmentCenter;
        attributes = @{NSForegroundColorAttributeName : self.txtColor,
                       NSFontAttributeName            : self.txtFont,
                       NSParagraphStyleAttributeName  : txtStyle.copy
                       };
    }
    
    // X Y轴
    [self.rulerColor setStroke];
    CGContextSetLineWidth(context, self.rulerWidth);
    
    CGPoint points[2];
    if (self.rulerDirection == YFRulerDirectionHorizontal) {

        points[0] = CGPointMake(0, self.mark_bottom-self.rulerWidth/2.0);
        points[1] = CGPointMake(self.frame.size.width, self.mark_bottom-self.rulerWidth/2.0);
    }
    else {

        points[0] = CGPointMake(self.mark_bottom+self.rulerWidth/2.0, 0);
        points[1] = CGPointMake(self.mark_bottom+self.rulerWidth/2.0, self.frame.size.height);
    }
    CGContextAddLines(context, points, 2);
    CGContextDrawPath(context, kCGPathStroke);

    if (self.rulerFace == YFRulerFace_Both) {
        CGPoint bPoints[2];
        if (self.rulerDirection == YFRulerDirectionHorizontal) {

            bPoints[0] = CGPointMake(0, self.mark_bottom2+self.rulerWidth/2.0);
            bPoints[1] = CGPointMake(self.frame.size.width+self.rulerWidth/2.0, self.mark_bottom2);
        }
        else {

            bPoints[0] = CGPointMake(self.mark_bottom2-self.rulerWidth/2.0, 0);
            bPoints[1] = CGPointMake(self.mark_bottom2-self.rulerWidth/2.0, self.frame.size.height);
        }
        CGContextAddLines(context, bPoints, 2);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // 刻度
    float originPoint = (self.rulerDirection == YFRulerDirectionHorizontal) ?
                        self.pointerFrame.origin.x + self.pointerFrame.size.width/2.0 :
                        self.pointerFrame.origin.y + self.pointerFrame.size.height/2.0;

    NSUInteger count = (self.maxValue - self.minValue) / self.unitValue;
    for (NSUInteger i = 0; i < count+1; i++) {
        [self.markColor setStroke];
        CGContextSetLineWidth(context, self.unitWidth);
        BOOL isHeight = (i % self.unitCount) == 0;
        CGPoint points[2];
        
        // 刻度
        if (self.rulerDirection == YFRulerDirectionHorizontal) {
            
            points[0] = CGPointMake(originPoint + i*self.unitPadding, self.mark_bottom + self.rulerWidth);
            points[1] = CGPointMake(originPoint + i*self.unitPadding, isHeight ? self.mark_long_top : self.mark_short_top);
            
            if (self.rulerFace == YFRulerFace_Both) {
                CGPoint bPoint[2];
                bPoint[0] = CGPointMake(originPoint + i*self.unitPadding, self.mark_bottom2 - self.rulerWidth);
                bPoint[1] = CGPointMake(originPoint + i*self.unitPadding, isHeight ? self.mark_long_top2 : self.mark_short_top2);
                CGContextAddLines(context, bPoint, 2);
            }
        }
        else {
            points[0] = CGPointMake(self.mark_bottom + self.rulerWidth, originPoint + i*self.unitPadding);
            points[1] = CGPointMake(isHeight ? self.mark_long_top : self.mark_short_top, originPoint + i*self.unitPadding);
            
            if (self.rulerFace == YFRulerFace_Both) {
                CGPoint bPoint[2];
                bPoint[0] = CGPointMake(self.mark_bottom2 - self.rulerWidth, originPoint + i*self.unitPadding);
                bPoint[1] = CGPointMake(isHeight ? self.mark_long_top2 : self.mark_short_top2, originPoint + i*self.unitPadding);
                CGContextAddLines(context, bPoint, 2);
            }
        }
        CGContextAddLines(context, points, 2);
        CGContextDrawPath(context, kCGPathStroke);
        
        // 文字
        if (self.isShowRulerValue && isHeight) {
            NSString *text = @(self.minValue + i*self.unitValue).stringValue;
            CGSize textSize = [self sizeForText:text attributes:attributes];
            
            if (self.rulerDirection == YFRulerDirectionHorizontal) {
                
                CGPoint point = CGPointMake(originPoint + i*self.unitPadding, self.mark_bottom);
                point.x -= textSize.width / 2.0;
                
                if (self.rulerFace == YFRulerFace_Both) {
                    CGPoint bPoint = CGPointMake(originPoint + i*self.unitPadding, self.mark_bottom2);
                    bPoint.x -= textSize.width / 2.0;
                    
                    if (self.txtFace == YFTextFace_Both) {
                        
                        point.y -= -(self.txtPadding + self.l_height);
                        [text drawAtPoint:point withAttributes:attributes];
                        bPoint.y -= self.l_height + self.txtPadding + textSize.height;
                        [text drawAtPoint:bPoint withAttributes:attributes];
                    }else if (self.txtFace == YFTextFace_Down_Right) {
                        
                        bPoint.y -= self.l_height + self.txtPadding + textSize.height;
                        [text drawAtPoint:bPoint withAttributes:attributes];
                    }else {
                        point.y -= -(self.txtPadding + self.l_height);
                        [text drawAtPoint:point withAttributes:attributes];
                    }
                    
                }else {
                    if (self.rulerFace == YFRulerFace_Down_Right) {
                        point.y -= self.txtPositionBottom ? self.txtPadding : self.txtPadding + textSize.height + self.l_height;
                    }else {
                        point.y -= self.txtPositionBottom ? self.txtPadding + textSize.height : -(self.txtPadding + self.l_height);
                    }
                    [text drawAtPoint:point withAttributes:attributes];
                }
                
            }
            else {
                
                CGPoint point = CGPointMake(self.mark_bottom, originPoint + self.unitWidth/2.0 + i*self.unitPadding);
                point.y -= textSize.height / 2.0 + self.unitWidth / 2.0;
                
                if (self.rulerFace == YFRulerFace_Both) {
                    CGPoint bPoint = CGPointMake(self.mark_bottom2, originPoint + self.unitWidth/2.0 + i*self.unitPadding);
                    bPoint.y -= textSize.height / 2.0 + self.unitWidth / 2.0;
                    
                    if (self.txtFace == YFTextFace_Both) {
                        
                        point.x -= -(self.txtPadding + self.l_height);
                        [text drawAtPoint:point withAttributes:attributes];
                        bPoint.x -= self.l_height + self.txtPadding + textSize.width;
                        [text drawAtPoint:bPoint withAttributes:attributes];
                    }else if (self.txtFace == YFTextFace_Down_Right) {
                        
                        bPoint.x -= self.l_height + self.txtPadding + textSize.width;
                        [text drawAtPoint:bPoint withAttributes:attributes];
                    }else {
                        point.x -= -(self.txtPadding + self.l_height);
                        [text drawAtPoint:point withAttributes:attributes];
                    }
                    
                }else {
                    if (self.rulerFace == YFRulerFace_Down_Right) {
                        point.x -= self.txtPositionBottom ? self.txtPadding : self.txtPadding + textSize.width + self.l_height;
                    }else {
                        point.x -= self.txtPositionBottom ? self.txtPadding + textSize.width : -(self.txtPadding + self.l_height);
                    }
                    [text drawAtPoint:point withAttributes:attributes];
                }
            }
        }
    }
    CGContextDrawPath(context, kCGPathStroke);
}


/// 计算文字size
- (CGSize)sizeForText:(NSString *)text attributes:(NSDictionary *)attributes
{
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;

//    textSize.height = ceil(textSize.height);
    return textSize;
}

- (void)setPointerView:(UIView *)pointerView
{
    _pointerView = pointerView;
    self.pointerFrame = pointerView.frame;
}

@end

