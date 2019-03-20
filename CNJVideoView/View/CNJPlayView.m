//
//  CNJPlayView.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJPlayView.h"
#import "CNJVideoPlayer.h"
#import <MJRefresh.h>

@interface CNJPlayView ()
<UIScrollViewDelegate,
CNJVideoPlayerDelegate,
CNJYVideoControlViewDelegate>

@property (nonatomic, strong) UIScrollView         *scrollView;
@property (nonatomic, strong) CNJVideoControlView  *topView;
@property (nonatomic, strong) CNJVideoControlView  *currentView;
@property (nonatomic, strong) CNJVideoControlView  *bottomView;

@property (nonatomic, assign) NSInteger            index;
@property (nonatomic, assign) NSInteger            currentPlayIndex;
@property (nonatomic,   weak) UIViewController     *vc;
@property (nonatomic, assign) BOOL                 isPushed;
@property (nonatomic, strong) NSMutableArray       *videos;
@property (nonatomic, strong) CNJVideoPlayer       *player;
@property (nonatomic,   copy) NSString             *currentPlayId;
@property (nonatomic, assign) BOOL                 isPlaying_beforeScroll;
@property (nonatomic, assign) BOOL                 isRefreshMore;

@end

@implementation CNJPlayView

- (instancetype)initWithViewController:(UIViewController *)vc isPushed:(BOOL)isPushed {
    if (self = [super init]) {
        self.vc = vc;
        self.isPushed = isPushed;
        
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        if (!isPushed) {
            [self.viewModel getMediaItemsSuccess:^(NSArray * _Nonnull list) {
                [self setModels:list index:0];
            } failure:^(NSError * _Nonnull error) {
                NSLog(@"%@", error);
            }];
            
            self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self.videos removeAllObjects];
                
                [self.viewModel getMoreListWithSuccess:^(NSArray * _Nonnull list) {
                    [self setModels:list index:0];
                    [self.scrollView.mj_header endRefreshing];
                    [self.scrollView.mj_footer endRefreshing];
                } failure:^(NSError * _Nonnull error) {
                    NSLog(@"%@", error);
                    [self.scrollView.mj_header endRefreshing];
                    [self.scrollView.mj_footer endRefreshing];
                }];
            }];
            
            self.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self.player pause];
                // 当播放索引为最后一个时才会触发下拉刷新
                self.currentPlayIndex = self.videos.count - 1;
                
                [self.viewModel getMediaItemsSuccess:^(NSArray * _Nonnull list) {
                    self.isRefreshMore = NO;
                    if (list) {
                        // 处理数据不准问题
                        [self addModels:list index:self.currentPlayIndex];
                        [self.scrollView.mj_footer endRefreshing];
                    }else {
                        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
                    }
                } failure:^(NSError * _Nonnull error) {
                    self.isRefreshMore = NO;
                    [self.scrollView.mj_footer endRefreshingWithNoMoreData];
                }];
            }];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat controlW = CGRectGetWidth(self.scrollView.frame);
    CGFloat controlH = CGRectGetHeight(self.scrollView.frame);
    
    self.topView.frame   = CGRectMake(0, 0, controlW, controlH);
    self.currentView.frame   = CGRectMake(0, controlH, controlW, controlH);
    self.bottomView.frame   = CGRectMake(0, 2 * controlH, controlW, controlH);
}

#pragma mark - publick

- (void)setModels:(NSArray *)models index:(NSInteger)index {
    [self.videos removeAllObjects];
    [self.videos addObjectsFromArray:models];
    
    self.index = index;
    self.currentPlayIndex = index;
    
    if (models.count == 0) return;
    
    if (models.count == 1) {
        [self.currentView removeFromSuperview];
        [self.bottomView removeFromSuperview];
        
        self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
        
        self.topView.model = self.videos.firstObject;
    }else if (models.count == 2) {
        [self.bottomView removeFromSuperview];
        
        self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 2);
        
        self.topView.model = self.videos.firstObject;
        self.currentView.model = self.videos.lastObject;
        
        if (index == 1) {
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        }
    }else {
        if (index == 0) {   // 如果是第一个，则显示上视图，且预加载中下视图
            self.topView.model = self.videos[index];
            self.currentView.model = self.videos[index + 1];
            self.bottomView.model = self.videos[index + 2];
            
            // 播放第一个
            [self playVideoFrom:self.topView];
        }else if (index == models.count - 1) { // 如果是最后一个，则显示最后视图，且预加载前两个
            self.bottomView.model = self.videos[index];
            self.currentView.model = self.videos[index - 1];
            self.topView.model = self.videos[index - 2];
            
            // 显示最后一个
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT * 2);
            // 播放最后一个
            [self playVideoFrom:self.bottomView];
        }else { // 显示中间，播放中间，预加载上下
            self.currentView.model = self.videos[index];
            self.topView.model = self.videos[index - 1];
            self.bottomView.model = self.videos[index + 1];
            
            // 显示中间
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            // 播放中间
            [self playVideoFrom:self.currentView];
        }
    }
}

- (void)addModels:(NSArray *)models index:(NSInteger)index {
    [self.videos addObjectsFromArray:models];
    self.index = index;
    self.currentPlayIndex = index;
    if (self.videos.count == 0) return;
    
    if (self.videos.count == 1) {
        [self.currentView removeFromSuperview];
        [self.bottomView removeFromSuperview];
        self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
        self.topView.model = self.videos.firstObject;
        [self playVideoFrom:self.topView];
    }else if (self.videos.count == 2) {
        [self.bottomView removeFromSuperview];
        self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 2);
        self.topView.model = self.videos.firstObject;
        self.currentView.model = self.videos.lastObject;
        
        if (index == 1) {
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            
            [self playVideoFrom:self.currentView];
        }else {
            [self playVideoFrom:self.topView];
        }
    }else {
        if (index == 0) {   // 如果是第一个，则显示上视图，且预加载中下视图
            self.topView.model = self.videos[index];
            self.currentView.model = self.videos[index + 1];
            self.bottomView.model = self.videos[index + 2];
            // 播放第一个
            [self playVideoFrom:self.topView];
        }else if (index == self.videos.count - 1) { // 如果是最后一个，则显示最后视图，且预加载前两个
            self.bottomView.model = self.videos[index];
            self.currentView.model = self.videos[index - 1];
            self.topView.model = self.videos[index - 2];
            // 显示最后一个
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT * 2);
            // 播放最后一个
            [self playVideoFrom:self.bottomView];
        }else { // 显示中间，播放中间，预加载上下
            self.currentView.model = self.videos[index];
            self.topView.model = self.videos[index - 1];
            self.bottomView.model = self.videos[index + 1];
            // 显示中间
            self.scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            // 播放中间
            [self playVideoFrom:self.currentView];
        }
    }
}

#pragma mark - player 

- (void)pause {
    if (self.player.isPlaying) {
        self.isPlaying_beforeScroll = YES;
    }else {
        self.isPlaying_beforeScroll = NO;
    }
    
    [self.player pause];
}

- (void)resume {
    if (self.isPlaying_beforeScroll) {
        [self.player resume];
    }
}

- (void)destruction {
    self.scrollView.delegate = nil;
    [self.player removeVideo];
}

#pragma mark - Private Methods
- (void)playVideoFrom:(CNJVideoControlView *)fromView {
    // 移除原来的播放
    [self.player removeVideo];
    
    // 取消原来视图的代理
    self.currentControlView.delegate = nil;
    
    // 切换播放视图
    self.currentPlayId    = fromView.model.post_id;
    self.currentControlView  = fromView;
    self.currentPlayIndex = [self indexOfModel:fromView.model];
    // 设置新视图的代理
    self.currentControlView.delegate = self;
    
    // 重新播放
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.player playVideoWithView:fromView.coverImgView url:fromView.model.video_url];
    });
}

// 获取当前播放内容的索引
- (NSInteger)indexOfModel:(CNJVideoModel *)model {
    __block NSInteger index = 0;
    [self.videos enumerateObjectsUsingBlock:^(CNJVideoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.post_id isEqualToString:obj.post_id]) {
            index = idx;
        }
    }];
    return index;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"********* %f,%f",scrollView.contentOffset.y,SCREEN_HEIGHT);
    // 小于等于三个，不用处理
    if (self.videos.count <= 3) return;
    
    // 上滑到第一个
    if (self.index == 0 && scrollView.contentOffset.y <= SCREEN_HEIGHT) {
        return;
    }
    // 下滑到最后一个
    if (self.index == self.videos.count - 1 && scrollView.contentOffset.y > SCREEN_HEIGHT) {
        return;
    }
    
    // 判断是从中间视图上滑还是下滑
    if (scrollView.contentOffset.y >= 2 * SCREEN_HEIGHT) {  // 上滑
        [self.player removeVideo];  // 在这里移除播放，解决闪动的bug
        if (self.index == 0) {
            self.index += 2;
            
            scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            
            self.topView.model = self.currentView.model;
            self.currentView.model = self.bottomView.model;
            
        }else {
            self.index += 1;
            
            if (self.index == self.videos.count - 1) {
                self.currentView.model = self.videos[self.index - 1];
            }else {
                scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
                
                self.topView.model = self.currentView.model;
                self.currentView.model = self.bottomView.model;
            }
        }
        if (self.index < self.videos.count - 1) {
            self.bottomView.model = self.videos[self.index + 1];
        }
    }else if (scrollView.contentOffset.y <= 0) { // 下滑
        [self.player removeVideo];  // 在这里移除播放，解决闪动的bug
        if (self.index == 1) {
            self.topView.model = self.videos[self.index - 1];
            self.currentView.model = self.videos[self.index];
            self.bottomView.model = self.videos[self.index + 1];
            self.index -= 1;
        }else {
            if (self.index == self.videos.count - 1) {
                self.index -= 2;
            }else {
                self.index -= 1;
            }
            scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            
            self.bottomView.model = self.currentView.model;
            self.currentView.model = self.topView.model;
            
            if (self.index > 0) {
                self.topView.model = self.videos[self.index - 1];
            }
        }
    }
    
    if (self.isPushed) return;
    
    // 自动刷新，如果想要去掉自动刷新功能，去掉下面代码即可
    if (scrollView.contentOffset.y == SCREEN_HEIGHT) {
        if (self.isRefreshMore) return;
        
        // 播放到倒数第二个时，请求更多内容
        if (self.currentPlayIndex == self.videos.count - 2) {
            self.isRefreshMore = YES;
            [self refreshMore];
        }
    }
    
    if (self.isRefreshMore) return;
    
    if (scrollView.contentOffset.y == 2 * SCREEN_HEIGHT) {
        [self refreshMore];
    }
}

// 结束滚动后开始播放
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"********* %f,%f",scrollView.contentOffset.y,SCREEN_HEIGHT);
    if (scrollView.contentOffset.y == 0) {
        if (self.currentPlayId == self.topView.model.post_id) return;
        [self playVideoFrom:self.topView];
    }else if (scrollView.contentOffset.y == SCREEN_HEIGHT) {
        if (self.currentPlayId == self.currentView.model.post_id) return;
        [self playVideoFrom:self.currentView];
    }else if (scrollView.contentOffset.y == 2 * SCREEN_HEIGHT) {
        if (self.currentPlayId == self.bottomView.model.post_id) return;
        [self playVideoFrom:self.bottomView];
    }
    
    if (self.isPushed) return;
    
    // 当只剩最后两个的时候，获取新数据
    if (self.currentPlayIndex == self.videos.count - 2) {
        [self.viewModel getMediaItemsSuccess:^(NSArray * _Nonnull list) {
            [self.videos addObjectsFromArray:list];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)refreshMore {
    [self.viewModel getMoreListWithSuccess:^(NSArray * _Nonnull list) {
        self.isRefreshMore = NO;
        if (list) {
            [self.videos addObjectsFromArray:list];
            [self.scrollView.mj_footer endRefreshing];
        }else {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
        self.isRefreshMore = NO;
        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
    }];
}

#pragma mark - CNJVideoPlayerDelegate
- (void)player:(CNJVideoPlayer *)player statusChanged:(CNJVideoPlayerStatus)status {
    switch (status) {
        case CNJVideoPlayerStatusUnload:   // 未加载
            
            break;
        case CNJVideoPlayerStatusPrepared:   // 准备播放
            
            break;
        case CNJVideoPlayerStatusLoading: {     // 加载中
            [self.currentControlView startLoading];
            [self.currentControlView hidePlayBtn];
        }
            break;
        case CNJVideoPlayerStatusPlaying: {    // 播放中
            [self.currentControlView stopLoading];
            [self.currentControlView hidePlayBtn];
        }
            break;
        case CNJVideoPlayerStatusPaused: {     // 暂停
            [self.currentControlView stopLoading];
            [self.currentControlView showPlayBtn];
        }
            break;
        case CNJVideoPlayerStatusEnded:   // 停止
            
            break;
        case CNJVideoPlayerStatusError:   // 错误
            
            break;
            
        default:
            break;
    }
}

- (void)player:(CNJVideoPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress {
    [self.currentControlView setProgress:progress];
}

#pragma mark - CNJVideoControlViewDelegate
- (void)controlViewDidClickSelf:(CNJVideoControlView *)controlView {
    if (self.player.isPlaying) {
        [self.player pause];
    }else {
        [self.player resume];
    }
}

- (void)controlViewDidClickIcon:(CNJVideoControlView *)controlView {
    
}

- (void)controlViewDidClickPriase:(CNJVideoControlView *)controlView {
    
}

- (void)controlViewDidClickComment:(CNJVideoControlView *)controlView {
    
}

- (void)controlViewDidClickShare:(CNJVideoControlView *)controlView {
    
}

#pragma mark - 懒加载
- (CNJVideoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CNJVideoViewModel new];
    }
    return _viewModel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        [_scrollView addSubview:self.topView];
        [_scrollView addSubview:self.currentView];
        [_scrollView addSubview:self.bottomView];
        _scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 3);
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _scrollView;
}

- (CNJVideoControlView *)topView {
    if (!_topView) {
        _topView = [CNJVideoControlView new];
    }
    return _topView;
}

- (CNJVideoControlView *)currentView {
    if (!_currentView) {
        _currentView = [CNJVideoControlView new];
    }
    return _currentView;
}

- (CNJVideoControlView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CNJVideoControlView new];
    }
    return _bottomView;
}

- (NSMutableArray *)videos {
    if (!_videos) {
        _videos = [NSMutableArray new];
    }
    return _videos;
}

- (CNJVideoPlayer *)player {
    if (!_player) {
        _player = [CNJVideoPlayer new];
        _player.delegate = self;
    }
    return _player;
}

@end
