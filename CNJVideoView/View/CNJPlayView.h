//
//  CNJPlayView.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNJPlayView : UIView

- (void)videoPlayWithViewModels:(NSArray *)videoes;

- (void)play;

- (void)pause;

- (void)resume;

- (void)destruction;

@end

NS_ASSUME_NONNULL_END