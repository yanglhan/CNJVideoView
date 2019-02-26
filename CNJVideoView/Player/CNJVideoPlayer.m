//
//  CNJVideoPlayer.m
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJVideoPlayer.h"
#import <KSYMediaPlayer/KSYMediaPlayer.h>

@interface CNJVideoPlayer ()

@property (nonatomic, strong) KSYMoviePlayerController  *player;
@property (nonatomic, assign) float                     duration;
@property (nonatomic, assign) BOOL                      isNeedResume;

@end

@implementation CNJVideoPlayer

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark - notification

- (void)appDidEnterBackground:(NSNotification *)notify {
    if (self.status == CNJVideoPlayerStatusLoading || self.status ==CNJVideoPlayerStatusPlaying) {
        [self pause];
        self.isNeedResume = YES;
    }
}

- (void)appWillEnterForeground:(NSNotification *)notify {
    if (self.isNeedResume && self.status == CNJVideoPlayerStatusPaused) {
        self.isNeedResume = NO;
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resume];
        });
    }
}

#pragma mark - public

- (void)playVideoWithView:(UIView *)playView url:(NSString *)url {
    [playView addSubview:self.player.view];
    [self.player setUrl:[NSURL URLWithString:url]];
    [self.player prepareToPlay];
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.player play];
    });
}

- (void)removeVideo {
    [self.player reset:YES];
    [self.player stop];
    self.player = nil;
}

- (void)pause {
    [self.player pause];
}

- (void)resume {
    [self.player play];
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}

#pragma mark - lazy

- (KSYMoviePlayerController *)player {
    if (!_player) {
        _player = [[KSYMoviePlayerController alloc] init];
        _player.controlStyle = MPMovieControlStyleNone;
        [_player setBufferSizeMax:50];
        _player.shouldLoop = YES;
        _player.shouldAutoplay = false;
        [self.player reset:NO];
        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _player.scalingMode = MPMovieScalingModeFill;
        
    }
    return _player;
}

@end
