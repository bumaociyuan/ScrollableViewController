//
//  ViewController.m
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

#define RANDOM_COLOR [UIColor colorWithRed:(float)random() / (float)RAND_MAX green:(float)random() / (float)RAND_MAX blue:(float)random() / (float)RAND_MAX alpha:1]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RANDOM_COLOR;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
