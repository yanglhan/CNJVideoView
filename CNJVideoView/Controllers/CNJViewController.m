//
//  CNJViewController.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJViewController.h"
#import "CNJPlayView.h"
#import "CNJVideoViewModel.h"
#import "CNJSearchViewController.h"
#import "CNJPeasonalViewController.h"
#import "CNJPlayerViewController.h"
#import "CNJScrollView.h"

@interface CNJViewController ()
<UIScrollViewDelegate,
GKViewControllerPushDelegate>

@property (nonatomic,   copy) NSArray                    *childVCs;
@property (nonatomic, strong) CNJPlayerViewController    *playerVC;
@property (nonatomic, strong) CNJSearchViewController    *searchVC;
@property (nonatomic, strong) CNJScrollView              *scrollView;

@end

@implementation CNJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navigationBar.hidden = YES;
    
    [self.view addSubview:self.scrollView];
    self.childVCs = @[self.searchVC,self.playerVC];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.scrollView.contentSize = CGSizeMake(self.childVCs.count *SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(idx *SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.scrollView.contentOffset.x == SCREEN_WIDTH) {
        self.gk_statusBarHidden = YES;
    }else {
        self.gk_statusBarHidden = NO;
    }
    self.gk_pushDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.playerVC.playView resume];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.gk_pushDelegate = nil;
    [self.playerVC.playView pause];
}


#pragma mark - scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.gk_statusBarHidden = NO;
    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        // 暂停
        [self.playerVC.playView pause];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == SCREEN_WIDTH) {
        self.gk_statusBarHidden = YES;
        // 恢复播放
        [self.playerVC.playView resume];
    }
}

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    CNJPeasonalViewController *personalVC = [[CNJPeasonalViewController alloc] init];
    personalVC.uid = self.playerVC.playView.currentControlView.model.author.user_id;
    [self.navigationController pushViewController:personalVC animated:YES];
}

#pragma mark - lazy

- (CNJScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [CNJScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (CNJSearchViewController *)searchVC {
    if (!_searchVC) {
        _searchVC = [[CNJSearchViewController alloc] init];
    }
    return _searchVC;
}

- (CNJPlayerViewController *)playerVC {
    if (!_playerVC) {
        _playerVC = [[CNJPlayerViewController alloc] init];
    }
    return _playerVC;
}

@end
