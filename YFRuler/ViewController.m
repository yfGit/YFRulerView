//
//  ViewController.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/22.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "ViewController.h"
#import "YFRulerContainView.h"
#import "RulerBtn.h"
#import "WaveView.h"

@interface ViewController ()<YFRulerViewDelegate>

@property (weak, nonatomic) IBOutlet YFRulerContainView *rulerContain;

@property (nonatomic, strong) RulerBtn *lastBtn;

@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 横向
    [self ruler];

    [self ruler_1]; // 自定义图片, 内容
    
    // 纵向
    [self ruler_2];

    [self ruler_3]; // 负数
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    float value = arc4random()%3000+1000;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[YFRulerContainView class]]) {
            YFRulerContainView *ruler = (YFRulerContainView *)view;
            [ruler scrollToValue:value animated:YES];
        }
    }
}

- (void)ruler
{
    self.rulerContain.delegate = self;
}

- (void)ruler_1
{
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(0, 210, 400, 80)];
    view.delegate = self;
    [self.view addSubview:view];
    
    YFRulerView *ruler = [YFRulerView new];
    ruler.rulerFace = YFRulerFace_Both;
    UIImage *image = [UIImage imageNamed:@"arrow"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = CGRectMake(100-20/2.0, 0, 20, 10);
    ruler.pointerView = imgView;
    
    ruler.rulerDirection = YFRulerDirectionHorizontal;
    
    ruler.unitPadding = 20;
    ruler.unitCount = 5;
    ruler.txtColor = [UIColor blackColor];
    
    view.rulerView = ruler;
    view.backgroundColor = [UIColor cyanColor];
    
    // 附加内容 pointerFrame确定
    NSUInteger count = (view.rulerView.maxValue-view.rulerView.minValue)/view.rulerView.unitValue / view.rulerView.unitCount;
    float x = view.rulerView.pointerFrame.origin.x;
    for (NSUInteger i = 0; i < count+1; i++) {
        CGRect frame = CGRectMake(x + i*view.rulerView.unitCount*view.rulerView.unitPadding, 20, 20, 20);
        RulerBtn *btn = [[RulerBtn alloc] initWithFrame:frame];
        btn.backgroundColor = [UIColor grayColor];
        btn.alpha = 0.5;
        if (i == 0) {
            btn.selected = YES;
            self.lastBtn = btn;
        }
        btn.tag = 10+i;
        [view.scrollView addSubview:btn];
    }
    
}


- (void)ruler_2
{
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(30, 330, 120, 200)];
    
    YFRulerView *ruler = [YFRulerView new];
    ruler.rulerDirection = YFRulerDirectionVertical;
    ruler.rulerFace = YFRulerFace_Up_Left;
    ruler.txtColor = [UIColor blackColor];
    ruler.txtPositionBottom  = YES;
    ruler.txtPadding = 2;
    ruler.pointerFrame = CGRectMake(120/2, 200/2.0-0.5, 60, 1);
    ruler.pointerColor = [UIColor blueColor];
    ruler.rulerColor = [UIColor redColor];
    view.rulerView = ruler;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor grayColor];
}

- (void)ruler_3
{
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(200, 330, 120, 200)];
    
    YFRulerView *ruler = [YFRulerView new];
    
    ruler.minValue = -0.5;
    ruler.maxValue = 10;
    ruler.unitValue = 0.1;
    ruler.unitCount = 5;
    
    ruler.rulerDirection = YFRulerDirectionVertical;
    ruler.rulerFace = YFRulerFace_Both;
    ruler.txtColor = [UIColor greenColor];
    ruler.rulerWidth = 2;
    ruler.rulerColor = [UIColor magentaColor];
    ruler.markColor = [UIColor blackColor];
    ruler.unitWidth = 3;
    ruler.unitPadding = 15;
    ruler.l_height = 20;
    ruler.s_height = 10;
    ruler.txtPadding = 10;
    ruler.txtFace = YFTextFace_Up_Left;
//    ruler.showRulerValue = NO;
    
    
    UIImage *image = [UIImage imageNamed:@"arrow_right"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = CGRectMake(60, 200/2.0-15, 30, 30);
    ruler.pointerView = imgView;
    view.rulerView = ruler;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor grayColor];
}

#pragma mark - Delegate
- (void)yfRulerScrollEnd:(YFRulerContainView *)rulerContainView endIndex:(NSUInteger)endIndex
{
    if (![rulerContainView isEqual:self.rulerContain]) {
        self.lastBtn.selected = NO;
        
        if (endIndex % rulerContainView.rulerView.unitCount == 0) {
            NSUInteger tag = endIndex / rulerContainView.rulerView.unitCount + 10;
            RulerBtn *btn = [rulerContainView.scrollView viewWithTag:tag];
            NSLog(@"%@",btn);
            btn.selected = YES;
            self.lastBtn = btn;
        }
    }
}

- (void)yfRulerScroll:(YFRulerContainView *)rulerContainView currentIndex:(NSUInteger)index
{
    if ([rulerContainView isEqual:self.rulerContain]) {

    }
}

@end
