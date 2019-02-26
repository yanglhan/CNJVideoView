//
//  CNJPersonalModel.h
//  CNJVideoView
//
//  Created by etz on 2019/1/30.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNJVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNJUserModel : NSObject

@property (nonatomic, copy) NSString    *intro;
@property (nonatomic, copy) NSString    *age;
@property (nonatomic, copy) NSString    *nani_id;
@property (nonatomic, copy) NSString    *club_num;
@property (nonatomic, copy) NSString    *is_follow;
@property (nonatomic, copy) NSString    *fans_num;
@property (nonatomic, copy) NSString    *user_id;
@property (nonatomic, copy) NSString    *video_num;
@property (nonatomic, copy) NSString    *user_name;
@property (nonatomic, copy) NSString    *portrait;
@property (nonatomic, copy) NSString    *name_show;
@property (nonatomic, copy) NSString    *agree_num;
@property (nonatomic, copy) NSString    *favor_num;
@property (nonatomic, copy) NSString    *gender;
@property (nonatomic, copy) NSString    *follow_num;

@end

@interface CNJUserVideoList : NSObject

@property (nonatomic, copy) NSString        *has_more;
@property (nonatomic, strong) NSArray       *list;

@end

@interface CNJFavorVideoList : NSObject

@property (nonatomic, copy) NSString        *has_more;
@property (nonatomic, strong) NSArray       *list;

@end

@interface CNJPersonalModel : NSObject

@property (nonatomic, strong) CNJUserModel         *user;
@property (nonatomic, strong) CNJUserVideoList     *user_video_list;
@property (nonatomic, strong) CNJFavorVideoList    *favor_video_list;

@end

NS_ASSUME_NONNULL_END
