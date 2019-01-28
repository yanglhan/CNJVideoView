//
//  CNJVideoCache.m
//  CNJVideoView
//
//  Created by etz on 2019/1/28.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJVideoCache.h"
#import "CNJVideoModel.h"

@implementation CNJVideoCache

+ (BOOL)isCache {
    return NO;
}

+ (void)getCacheMediaItems:(void (^)(NSArray * _Nonnull))completeBlock {
    NSMutableArray *videoArray = [NSMutableArray array];
    CNJVideoModel *model = [[CNJVideoModel alloc] init];
    [videoArray addObject:model];
    if (completeBlock) {
        completeBlock(videoArray);
    }
}


@end
