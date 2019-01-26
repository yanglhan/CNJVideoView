//
//  CNJContentShowView.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJContentShowView.h"
#import <Masonry.h>
#import <YYWebImage.h>

@interface CNJContentShowView ()
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UIImageView *musicImageView;
@property (nonatomic, strong) UILabel     *forwardLabel;
@property (nonatomic, strong) UILabel     *commentLabel;
@property (nonatomic, strong) UILabel     *likeLabel;

@end

@implementation CNJContentShowView

- (instancetype)init {
    if (self = [super init]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    /**
     @parms
     * @musicImageView
     * @forward
     * @comment
     * @like
     * @userImageView
     */
}

#pragma mark - publick
- (void)showViewWithVideoModel:(CNJVideoModel *)model {
    [self.userImageView yy_setImageWithURL:[NSURL URLWithString:model.thumbnail] options:YYWebImageOptionRefreshImageCache];
    [self.musicImageView yy_setImageWithURL:[NSURL URLWithString:model.musicThumbnail] options:YYWebImageOptionRefreshImageCache];
    self.likeLabel.text = [NSString stringWithFormat:@"%ld",(long)model.likes];
    self.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)model.comments];
}

@end
