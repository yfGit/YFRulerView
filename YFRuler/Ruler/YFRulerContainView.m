
//  YFRulerContainView.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/7.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "YFRulerContainView.h"

@interface YFRulerContainView ()<UIScrollViewDelegate>
{
    YFRulerView *_rulerView;
}

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger lastIndex;

// 指针信息

/// 指针图片
@property (nonatomic, strong) UIView  *pointerView;
/// 指针位置 图片两选一
@property (nonatomic, assign) CGRect  pointerFrame;
/// 指针颜色
@property (nonatomic, strong) UIColor *pointerColor;

@end

@implementation YFRulerContainView


#pragma mark - Life Cycle

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
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
    self.animated = YES;
    self.lastIndex = -1;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 直接配置不用再赋值 YFRulerView
    if (CGRectEqualToRect(self.scrollView.frame, CGRectZero)) {
        [self redrawRuler:self.rulerView];
    }
}

#pragma mark - Event Response

- (void)redrawRuler:(YFRulerView *)rulerView
{
    self.rulerView = rulerView;
}

- (void)scrollToValue:(float)value animated:(BOOL)animated
{
    float padding = (int)(value / self.rulerView.unitValue) * self.rulerView.unitPadding;
    
    if (self.rulerView.rulerDirection == YFRulerDirectionHorizontal) {
        [self.scrollView setContentOffset:CGPointMake(padding, 0) animated:animated];
    }else {
        [self.scrollView setContentOffset:CGPointMake(0, padding) animated:animated];
    }
}

#pragma mark - Private Method

- (void)layoutForDraw
{
    self.scrollView.frame = self.bounds;
    float length = (self.rulerView.maxValue - self.rulerView.minValue) / self.rulerView.unitValue * (self.rulerView.unitPadding);
    self.rulerView.contentMode = UIViewContentModeRedraw;
    
    
    if (_rulerView.rulerDirection == YFRulerDirectionHorizontal) {
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width + length, self.scrollView.frame.size.height);
    }else {
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.scrollView.frame.size.height + length);
    }
    
    self.rulerView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.scrollView addSubview:self.rulerView];
    
    UIView *pointView;
    if (self.rulerView.pointerView) {
        pointView = self.rulerView.pointerView;
    }else {
        CGRect frame = CGRectEqualToRect(self.rulerView.pointerFrame, CGRectZero) ? CGRectMake(self.bounds.size.width/2.0-0.5, 0, 1, self.bounds.size.height) : self.rulerView.pointerFrame;
        self.rulerView.pointerFrame = frame;
        pointView = [[UIView alloc] initWithFrame:frame];
        pointView.backgroundColor = self.rulerView.pointerColor;
    }
    self.pointerView  = pointView;
    self.pointerFrame = pointView.frame;
    self.pointerColor = pointView.backgroundColor;
    [self addSubview:pointView];
    
    [self.rulerView redraw];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.rulerView.rulerDirection == YFRulerDirectionHorizontal) {
        
        NSInteger index = scrollView.contentOffset.x / self.rulerView.unitPadding + 0.5;
        [scrollView setContentOffset:CGPointMake(index * self.rulerView.unitPadding, 0) animated:self.isAnimated];
        if ([self.delegate respondsToSelector:@selector(yfRulerScrollEnd:endIndex:)]) {
            [self.delegate yfRulerScrollEnd:self endIndex:index];
        }
    }
    else {
        NSInteger index = scrollView.contentOffset.y / self.rulerView.unitPadding + 0.5;
        [scrollView setContentOffset:CGPointMake(0, index * self.rulerView.unitPadding) animated:self.isAnimated];
        if ([self.delegate respondsToSelector:@selector(yfRulerScrollEnd:endIndex:)]) {
            [self.delegate yfRulerScrollEnd:self endIndex:index];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if (self.rulerView.rulerDirection == YFRulerDirectionHorizontal) {
            
            NSInteger index = scrollView.contentOffset.x / self.rulerView.unitPadding + 0.5;
            [scrollView setContentOffset:CGPointMake(index * self.rulerView.unitPadding, 0) animated:self.isAnimated];
            if ([self.delegate respondsToSelector:@selector(yfRulerScrollEnd:endIndex:)]) {
                [self.delegate yfRulerScrollEnd:self endIndex:index];
            }
        }
        else {
            NSInteger index = scrollView.contentOffset.y / self.rulerView.unitPadding + 0.5;
            [scrollView setContentOffset:CGPointMake(0, index * self.rulerView.unitPadding) animated:self.isAnimated];
            if ([self.delegate respondsToSelector:@selector(yfRulerScrollEnd:endIndex:)]) {
                [self.delegate yfRulerScrollEnd:self endIndex:index];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.rulerView.rulerDirection == YFRulerDirectionHorizontal) {
        
        int index = scrollView.contentOffset.x / self.rulerView.unitPadding + 0.5;
        if (self.lastIndex != index) {
            self.lastIndex = index;
            if ([self.delegate respondsToSelector:@selector(yfRulerScroll:currentIndex:)]) {
                [self.delegate yfRulerScroll:self currentIndex:index];
            }
        }
    }
    else {
        int index = scrollView.contentOffset.y / self.rulerView.unitPadding + 0.5;
        if (self.lastIndex != index) {
            self.lastIndex = index;
            if ([self.delegate respondsToSelector:@selector(yfRulerScroll:currentIndex:)]) {
                [self.delegate yfRulerScroll:self currentIndex:index];
            }
        }
    }
}

#pragma mark - Getter & Setter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (YFRulerView *)rulerView
{
    if (!_rulerView) {
        _rulerView = [[YFRulerView alloc] init];
//        [self.scrollView addSubview:_rulerView];
    }
    return _rulerView;
}

#pragma mark - 切换逻辑
- (void)setRulerView:(YFRulerView *)rulerView
{
    // 旧
    [_rulerView removeFromSuperview];
    [self.pointerView removeFromSuperview];
    
    // 新
    _rulerView = rulerView;
    
    [self layoutForDraw];
}





@end

