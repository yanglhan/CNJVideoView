//
//  CNJVideoViewModel.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJVideoViewModel.h"
#import "CNJVideoModel.h"

@implementation CNJVideoViewModel

- (void)handleMediaItems:(void (^)(NSArray *videoes))completeBlock {
    /** handle metas*/
    NSMutableArray *metas = [NSMutableArray array];
    CNJVideoModel  *model = [CNJVideoModel new];
    [metas addObject:model];
    if (completeBlock) {
        completeBlock(metas);
    }
}

@end
