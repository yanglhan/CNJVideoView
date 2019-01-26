//
//  CNJPlayView.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJPlayView.h"
#import "CNJContentShowView.h"
#import "CNJScrollView.h"

@interface CNJPlayView ()
@property (nonatomic, strong) CNJContentShowView *showView;
@property (nonatomic, strong) CNJScrollView      *scrollView;
@property (nonatomic,   copy) NSArray            *videoes;

@end

@implementation CNJPlayView

- (instancetype)init {
    if (self = [super init]) {
        self.videoes = @[].copy;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.showView = [[CNJContentShowView alloc] init];
    [self addSubview:self.showView];
    self.showView.frame = self.bounds;
}

#pragma mark - publick

- (void)videoPlayWithViewModels:(NSArray *)videoes {
    [self.showView showViewWithVideoModel:videoes.firstObject];
}

- (void)play {
    
}

- (void)pause {
    
}

- (void)resume {
    
}

- (void)destruction {
    
}

@end
