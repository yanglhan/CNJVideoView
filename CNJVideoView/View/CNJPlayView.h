//
//  CNJPlayView.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNJVideoViewModel.h"
#import "CNJVideoControlView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNJPlayView : UIView

@property (nonatomic, strong) CNJVideoViewModel    *viewModel;
@property (nonatomic, strong) CNJVideoControlView  *currentControlView;

- (instancetype)initWithViewController:(UIViewController *)vc
                              isPushed:(BOOL)isPushed;

- (void)setModels:(NSArray *)models
            index:(NSInteger)index;

- (void)pause;

- (void)resume;

- (void)destruction;

@end

NS_ASSUME_NONNULL_END
