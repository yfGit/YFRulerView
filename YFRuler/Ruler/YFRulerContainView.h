//
//  YFRulerContainView.h
//  YFRuler
//
//  Created by 许毓方 on 2017/11/7.
//  Copyright © 2017年 许毓方. All rights reserved.
//  参考 https://github.com/clarkIsMe/scrollRulerView

#import <UIKit/UIKit.h>
#import "YFRulerView.h"
@class YFRulerContainView;

#define YF_OC_STRING(STR) [NSString stringWithCString:__STRING(STR) encoding:NSUTF8StringEncoding]
#define ColorHEX(STR) [HEXColor getColor:LB_OC_STRING(STR)]


@protocol YFRulerViewDelegate <NSObject>

@optional

- (void)yfRulerScroll:(YFRulerContainView *)rulerContainView currentIndex:(NSUInteger)index;

- (void)yfRulerScrollEnd:(YFRulerContainView *)rulerContainView endIndex:(NSUInteger)endIndex;

@end


@interface YFRulerContainView : UIView

/// 容器
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
/// 代理
@property (nonatomic, weak) id<YFRulerViewDelegate> delegate;
/// 标尺
@property (nonatomic, strong) YFRulerView *rulerView;
/// 结束动画 默认 YES
@property (nonatomic, assign, getter=isAnimated) BOOL animated;




/**
 配置标尺信息

 xib 默认已加载
 @param rulerView 配置
 */
- (void)redrawRuler:(YFRulerView *)rulerView;


/**
 滚动到对应数值

 @param value    每刻度数值的倍数 否则取整
 @param animated animated
 */
- (void)scrollToValue:(float)value animated:(BOOL)animated;

@end
