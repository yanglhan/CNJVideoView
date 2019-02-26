//
//  CNJVideoModel.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJVideoModel.h"

@implementation CNJVideoAuthorModel

@end

@implementation CNJVideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"author" : [CNJVideoAuthorModel class]};
}

@end
