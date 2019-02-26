//
//  CNJPersonalModel.m
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJPersonalModel.h"

@implementation CNJUserModel

@end

@implementation CNJUserVideoList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [CNJVideoModel class] };
}

@end

@implementation CNJFavorVideoList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [CNJVideoModel class] };
}

@end

@implementation CNJPersonalModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user"            : [CNJUserModel class],
             @"user_video_list" : [CNJUserVideoList class],
             @"favor_video_list": [CNJFavorVideoList class] };
}

@end
