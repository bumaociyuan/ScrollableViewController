//
//  ScrollableTabBar.m
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import "ScrollableTabBar.h"
#import "FrameAccessor.h"
#define RANDOM_COLOR [UIColor colorWithRed:(float)random() / (float)RAND_MAX green:(float)random() / (float)RAND_MAX blue:(float)random() / (float)RAND_MAX alpha:1]
@interface ScrollableTabBar ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *floatBlock;

@end

@implementation ScrollableTabBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    self.titles = titles;
    [self setup];
    return self;
}

- (void)setup {
    [self setupTabs];
    [self setupFloatBlock];
}

- (void)setupTabs {
    NSInteger count = self.titles.count;
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height;
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = RANDOM_COLOR;
        button.frame = CGRectMake(idx * width, 0, width, height);
        button.tag = idx;
        [self addSubview:button];
        [self.buttons addObject:button];
    }];
}

- (void)setupFloatBlock {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, 0, 4);
    UIButton *button = self.buttons[_index];
    view.width = button.width;
    view.maxY = self.height;
    [self addSubview:view];
    self.floatBlock = view;
}

#pragma mark - target action
- (void)buttonPressed:(UIButton *)sender {
    self.index = sender.tag;
    if (self.onTabClick) {
        self.onTabClick(sender.tag);
    }
}

#pragma mark - property
- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray new];
    }
    return _buttons;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
    }];
    UIButton *button = self.buttons[_index];
    [UIView animateWithDuration:.1 animations:^{
        self.floatBlock.midX = button.midX;
        self.floatBlock.width = button.width;
    }];
}


@end
