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

@interface CNJViewController ()

@property (nonatomic, strong) CNJVideoViewModel  *viewModel;
@property (nonatomic, strong) CNJPlayView        *playView;
@property (nonatomic, strong) NSMutableArray     *videoModels;

@end

@implementation CNJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initSubViews];
    [self initDatas];
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark - private methods

- (void)initSubViews {
    self.playView = [[CNJPlayView alloc] init];
    [self.view addSubview:self.playView];
    self.playView.frame = self.view.bounds;
}

- (void)initDatas {
    self.viewModel = [[CNJVideoViewModel alloc] init];
    self.videoModels = @[].mutableCopy;
    __weak typeof(self) weakSelf = self;
    [self.viewModel handleMediaItems:^(NSArray * _Nonnull videoes) {
        [weakSelf.videoModels addObjectsFromArray:videoes];
        [weakSelf updatePlayView];
    }];
}

- (void)updatePlayView {
    [self.playView videoPlayWithViewModels:self.videoModels];
}

@end
