//
//  CNJVideoControlView.h
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNJVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CNJVideoControlView;

@protocol CNJYVideoControlViewDelegate <NSObject>

- (void)controlViewDidClickSelf:(CNJVideoControlView *)controlView;

- (void)controlViewDidClickIcon:(CNJVideoControlView *)controlView;

- (void)controlViewDidClickPriase:(CNJVideoControlView *)controlView;

- (void)controlViewDidClickComment:(CNJVideoControlView *)controlView;

- (void)controlViewDidClickShare:(CNJVideoControlView *)controlView;

@end

@interface CNJVideoControlView : UIView

@property (nonatomic, weak) id<CNJYVideoControlViewDelegate> delegate;

// 视频封面图:显示封面并播放视频
@property (nonatomic, strong) UIImageView       *coverImgView;

@property (nonatomic, strong) CNJVideoModel    *model;

- (void)setProgress:(float)progress;

- (void)startLoading;
- (void)stopLoading;

- (void)showPlayBtn;
- (void)hidePlayBtn;


@end

NS_ASSUME_NONNULL_END
