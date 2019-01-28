//
//  CNJVideoCache.h
//  CNJVideoView
//
//  Created by etz on 2019/1/28.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 数据缓存
 *  第二次启动的时候直接去拿缓存的数据
 */
@interface CNJVideoCache : NSObject

+ (BOOL)isCache;

+ (void)getCacheMediaItems:(void (^)(NSArray *videoes))completeBlock;

@end

NS_ASSUME_NONNULL_END
