//
//  ScrollableViewController.h
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) id<UIScrollViewDelegate> scrollViewDelegate;
@property (nonatomic, strong) void(^indexDidChanged)(ScrollableViewController *vc, NSInteger index);


- (instancetype)initWithViewControllers:(NSArray *)viewControllers;
- (CGRect)frameForSubviewControllers;

@end
