//
//  CNJVideoModel.h
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** @parm 媒体资源 model
  * urlString
  * thumbnail
  * conment
  * forwarding
  * likes
  * musicThumbnail
 */
@interface CNJVideoModel : NSObject

@property (nonatomic,   copy) NSString  *urlString;
@property (nonatomic,   copy) NSString  *thumbnail;
@property (nonatomic,   copy) NSString  *musicThumbnail;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger forwards;

@end

NS_ASSUME_NONNULL_END
