//
//  RulerBtn.m
//  YFRuler
//
//  Created by 许毓方 on 2017/11/24.
//  Copyright © 2017年 许毓方. All rights reserved.
//

#import "RulerBtn.h"

@implementation RulerBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = frame.size.width / 2.0;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    self.backgroundColor   = selected ? [UIColor blueColor] : [UIColor grayColor];
    self.layer.borderWidth = selected ? 2 : 0;
}

@end
