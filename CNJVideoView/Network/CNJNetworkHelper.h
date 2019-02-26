//
//  CNJNetworkHelper.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNJNetworkHelper : NSObject

- (void)requestHttpHandle:(void (^)(id))completeBlock;

@end

NS_ASSUME_NONNULL_END
