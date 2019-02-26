//
//  CNJVideoViewModel.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJVideoViewModel.h"
#import "CNJVideoModel.h"
#import "CNJNetworkHelper.h"

@interface CNJVideoViewModel ()

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation CNJVideoViewModel

- (void)getMediaItemsSuccess:(void(^)(NSArray *list))success
                     failure:(void(^)(NSError *error))failure; {
    self.pageNum = 1;
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"new_recommend_type"] = @"3";
    params[@"pn"] = @(self.pageNum);
    params[@"dl"] = @"505F80E58F3817291B7768CE59A90AF8";
    params[@"sign"] = @"3DD6882F963C25F5FA1ECA558F8CEF48";
    params[@"_timestamp"] = @"1537782764313";
    params[@"timestamp"] = @"1537782764313";
    params[@"net_type"] = @"1";
    
    // 推荐列表
    NSString *url = @"http://c.tieba.baidu.com/c/f/nani/recommend/list";
    
    //    NSString *url = @"https://shanguang.chaonengjie.com/v3/get_recommend_video";
    [CNJNetworkHelper get:url params:params success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"error_code"] integerValue] == 0) {
            NSDictionary *data = responseObject[@"data"];
            
            self.has_more = [data[@"has_more"] boolValue];
            
            NSMutableArray *array = [NSMutableArray new];
            for (NSDictionary *dic in data[@"video_list"]) {
                CNJVideoModel *model = [CNJVideoModel yy_modelWithDictionary:dic];
                [array addObject:model];
            }
            
            !success ? : success(array);
        }else {
            NSLog(@"%@", responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

@end
