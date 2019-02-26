//
//  CNJVideoPlayer.h
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CNJVideoPlayerStatus) {
    CNJVideoPlayerStatusUnload,      // 未加载
    CNJVideoPlayerStatusPrepared,    // 准备播放
    CNJVideoPlayerStatusLoading,     // 加载中
    CNJVideoPlayerStatusPlaying,     // 播放中
    CNJVideoPlayerStatusPaused,      // 暂停
    CNJVideoPlayerStatusEnded,       // 播放完成
    CNJVideoPlayerStatusError        // 错误
};

@class CNJVideoPlayer;

@protocol CNJVideoPlayerDelegate <NSObject>

- (void)player:(CNJVideoPlayer *)player statusChanged:(CNJVideoPlayerStatus)status;

- (void)player:(CNJVideoPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress;

@end

@interface CNJVideoPlayer : NSObject

@property (nonatomic, weak) id<CNJVideoPlayerDelegate>     delegate;

@property (nonatomic, assign) CNJVideoPlayerStatus         status;

@property (nonatomic, assign) BOOL                         isPlaying;


/**
 根据指定url在指定视图上播放视频
 
 @param playView 播放视图
 @param url 播放地址
 */
- (void)playVideoWithView:(UIView *)playView url:(NSString *)url;

/**
 停止播放并移除播放视图
 */
- (void)removeVideo;

/**
 暂停播放
 */
- (void)pause;

/**
 恢复播放
 */
- (void)resume;


@end

NS_ASSUME_NONNULL_END
