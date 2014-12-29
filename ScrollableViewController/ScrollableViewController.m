//
//  ScrollableViewController.m
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import "ScrollableViewController.h"
#import "ScrollableTabBar.h"

@interface ScrollableViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ScrollableTabBar *tabBar;

@end

@implementation ScrollableViewController

- (CGRect)frameForSubviewControllers {
    CGRect result = self.view.bounds;
    result.origin.y += self.tabBar.frame.size.height;
    result.size.height -= self.tabBar.frame.size.height;
    return result;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers {
    self = [super init];
    self.viewControllers = viewControllers;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setupTabBar];
    [self setupScrollView];
    [self setupViewControllers];
    [self updateScrollView];
}

- (void)setupTabBar {
    ScrollableTabBar *tabBar = [[ScrollableTabBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) titles:@[@"vc1",@"vc2"]];
    [tabBar setOnTabClick:^(NSInteger index) {
        self.index = index;
    }];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[self frameForSubviewControllers]];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView = scrollView;
}

- (void)setupViewControllers {
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:viewController];
        [viewController willMoveToParentViewController:self];
        [self.scrollView addSubview:viewController.view];
        viewController.view.frame = CGRectMake(idx * [self viewWidth], 0, [self viewWidth], [self viewHeight]);
        [viewController didMoveToParentViewController:self];
    }];
}

- (void)updateScrollView {
    NSInteger count = self.viewControllers.count;
    self.scrollView.contentSize = CGSizeMake([self viewWidth] * count, [self frameForSubviewControllers].size.height);
}

- (void)updateIndexIfNeeded {
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger index = offset.x / [self viewWidth];
    if (index != self.index) {
        self.index = index;
        self.tabBar.index = index;
    }
}

#pragma mark - property
- (void)setIndex:(NSInteger)index {
    _index = index;
    [self.scrollView setContentOffset:CGPointMake(_index * [self viewWidth], 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateIndexIfNeeded];
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateIndexIfNeeded];
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
//    }
//}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
//    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
//    }
//}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark - helper

- (CGFloat)viewWidth {
    return [self frameForSubviewControllers].size.width;
}

- (CGFloat)viewHeight {
    return [self frameForSubviewControllers].size.height;
}

@end
