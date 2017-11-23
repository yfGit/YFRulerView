//
//  YFRulerView.h
//  YFRuler
//
//  Created by 许毓方 on 2017/11/7.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YFRulerDirection) {
    /// 横向
    YFRulerDirectionHorizontal,
    /// 纵向
    YFRulerDirectionVertical
};

typedef NS_ENUM(NSUInteger, YFRulerFace) {
    /// 两边
    YFRulerFace_Both,
    /// 横向朝上，纵向朝左
    YFRulerFace_Up_Left,
    /// 横向朝下，纵向朝右
    YFRulerFace_Down_Right
};

typedef NS_ENUM(NSUInteger, YFTextFace) {
    /// 两边
    YFTextFace_Both,
    /// 横向上，纵向左
    YFTextFace_Up_Left,
    /// 横向下，纵向右
    YFTextFace_Down_Right
};

@interface YFRulerView : UIView


/// 指针 pointerFrame 二选一  pointerFrame = .frame
@property (nonatomic, strong) UIView  *pointerView;
/// 指针位置
@property (nonatomic, assign) CGRect  pointerFrame;
/// 指针颜色
@property (nonatomic, strong) UIColor *pointerColor;


// 标尺信息

/// 是否显示刻度值
@property (nonatomic, assign, getter=isShowRulerValue)BOOL showRulerValue;
/// 标尺线颜色
@property (nonatomic, strong) UIColor *rulerColor;
/// 标尺线宽
@property (nonatomic, assign) float rulerWidth;
/// 标尺数字颜色
@property (nonatomic, strong) UIColor *txtColor;
/// 标尺数字字体
@property (nonatomic, strong) UIFont *txtFont;
/// 标尺数字属性 默认为空, 有值时忽略 颜色和字体
@property (nonatomic, strong) NSDictionary *txtAttributes;
/// 数字距离标尺  默认 
@property (nonatomic, assign) float txtPadding;
/// 标尺数字位置  默认标尺上
@property (nonatomic, assign) BOOL  txtPositionBottom;
/// 双刻度时 数字两边都显示 默认NO
@property (nonatomic, assign) YFTextFace txtFace;


// 刻度信息


/// 刻度颜色
@property (nonatomic, strong) UIColor *markColor;
/// 长刻度长度
@property (nonatomic, assign) float l_height;
/// 矮刻度长度
@property (nonatomic, assign) float s_height;
/// 最小值       默认 0
@property (nonatomic, assign) float minValue;
/// 最大值       默认 300
@property (nonatomic, assign) float maxValue;
/// 一个刻度的值     默认 1
@property (nonatomic, assign) float unitValue;
/// 一个刻度的宽度    默认 1
@property (nonatomic, assign) float unitWidth;
/// 刻度间距
@property (nonatomic, assign) float unitPadding;
/// 一个长刻度的个数  默认 10
@property (nonatomic, assign) NSUInteger unitCount;
/// 标尺横纵方向  默认 .Horizontal
@property (nonatomic, assign) YFRulerDirection rulerDirection;
/// 标尺位置     默认 ._Down_Right
@property (nonatomic, assign) YFRulerFace rulerFace;


- (void)redraw;


@end
