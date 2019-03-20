//
//  CNJPlayerViewController.m
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJPlayerViewController.h"

@interface CNJPlayerViewController ()

@end

@implementation CNJPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.gk_navigationBar.hidden = YES;
    
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    
    [self.view addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.playView resume];
}

-(void)dealloc {
    [self.playView description];
}

#pragma lazy

- (CNJPlayView *)playView {
    if (!_playView) {
        _playView = [[CNJPlayView alloc] initWithViewController:self isPushed:NO];
    }
    return _playView;
}

@end
