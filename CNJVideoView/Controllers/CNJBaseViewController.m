//
//  CNJBaseViewController.m
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJBaseViewController.h"

@interface CNJBaseViewController ()

@end

@implementation CNJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createInvalidView {
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"invalid_view_icon"];
}

@end
