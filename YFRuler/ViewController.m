//
//  ViewController.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/22.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "ViewController.h"
#import "YFRulerContainView.h"

@interface ViewController ()<YFRulerViewDelegate>

@property (weak, nonatomic) IBOutlet YFRulerContainView *rulerContain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ruler];

    [self ruler_1];
    
    [self ruler_2];
    
    [self ruler_3];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    float value = arc4random()%3000+1000;
    NSLog(@"%f", value);
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
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(0, 210, 400, 60)];
    [self.view addSubview:view];
    
    YFRulerView *ruler = [YFRulerView new];
    ruler.rulerFace = YFRulerFace_Both;
    UIImage *image = [UIImage imageNamed:@"arrow"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = CGRectMake(100-20/2.0, 60-10, 20, 10);
    ruler.pointerView = imgView;
    
    ruler.rulerDirection = YFRulerDirectionHorizontal;
    
    ruler.unitPadding = 20;
    ruler.unitCount = 5;
    ruler.txtColor = [UIColor blackColor];
    
    view.rulerView = ruler;
    view.backgroundColor = [UIColor cyanColor];
}


- (void)ruler_2
{
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(10, 300, 80, 200)];
    
    YFRulerView *ruler = [YFRulerView new];
    ruler.rulerDirection = YFRulerDirectionVertical;
    ruler.rulerFace = YFRulerFace_Up_Left;
    ruler.txtColor = [UIColor blackColor];
    ruler.txtPositionBottom  = YES;
    ruler.txtPadding = 2;
    ruler.pointerFrame = CGRectMake(80/2, 200/2.0-0.5, 40, 1);
    ruler.pointerColor = [UIColor blueColor];
    ruler.rulerColor = [UIColor redColor];
    view.rulerView = ruler;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor grayColor];
}

- (void)ruler_3
{
    YFRulerContainView *view = [[YFRulerContainView alloc] initWithFrame:CGRectMake(120, 300, 120, 200)];
    
    YFRulerView *ruler = [YFRulerView new];
    
    ruler.minValue = -0.3;
    ruler.maxValue = 10;
    ruler.unitValue = 0.1;
    ruler.unitCount = 5;
    
    ruler.rulerDirection = YFRulerDirectionVertical;
    ruler.rulerFace = YFRulerFace_Both;
    ruler.txtColor = [UIColor greenColor];
    ruler.rulerWidth = 2;
    ruler.rulerColor = [UIColor magentaColor];
    ruler.markColor = [UIColor blueColor];
    ruler.unitWidth = 3;
    ruler.unitPadding = 15;
    ruler.l_height = 20;
    ruler.s_height = 10;
    ruler.txtPadding = 10;
    ruler.txtFace = YFTextFace_Up_Left;
//    ruler.showRulerValue = NO;
    
    ruler.pointerFrame = CGRectMake(0, 200/2.0-0.5, 120, 1);
    ruler.pointerColor = [UIColor redColor];
    view.rulerView = ruler;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor grayColor];
}

@end
