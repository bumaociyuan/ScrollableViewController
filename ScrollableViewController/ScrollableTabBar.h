//
//  ScrollableTabBar.h
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableTabBar : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) void(^onTabClick)(NSInteger index);

@end
