//
//  CNJNetworkHelper.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CNJNetworkingType) {
    CNJNetworkingTypeGet,
    CNJNetworkingTypePost
};

@interface CNJNetworkHelper : NSObject

- (void)requestHttpHandle:(void (^)(id))completeBlock;

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
