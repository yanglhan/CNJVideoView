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
/** @param
 *  completeBlock page
 *  一次取 10 个数据，
 *  滑到第 5 个视频的时候去取新的视频数据
 */
@property (nonatomic, assign) BOOL  has_more;

- (void)getMediaItemsSuccess:(void(^)(NSArray *list))success
                     failure:(void(^)(NSError *error))failure;

- (void)getMoreListWithSuccess:(void(^)(NSArray *list))success
                       failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
