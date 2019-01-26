//
//  CNJVideoViewModel.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNJVideoViewModel : NSObject

- (void)handleMediaItems:(void (^)(NSArray *videoes))completeBlock;

@end

NS_ASSUME_NONNULL_END
