//
//  CNJNetworkHelper.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "CNJNetworkHelper.h"
#import <AFNetworking.h>

@implementation CNJNetworkHelper

- (void)requestHttpHandle:(void (^)(id))completeBlock {
    /**
     * 网络请求返回值
     */
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self requestWithType:CNJNetworkingTypeGet url:url params:params success:success failure:failure];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self requestWithType:CNJNetworkingTypePost url:url params:params success:success failure:failure];
}

+ (void)requestWithType:(CNJNetworkingType)type url:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"application/x-javascript", nil]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    dic[@"_client_type"] = @"1";
    dic[@"_client_version"] = @"2.2.0";
    dic[@"_os_version"] = @"12.0";
    dic[@"_phone_imei"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    dic[@"_phone_newimei"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    
    dic[@"brand"] = @"iPad";
    dic[@"brand_type"] = @"Unknown iPad";
    dic[@"cuid"] = @"9A910F65D70DBAE95866E00B75934C78|com.baidu.nani";
    dic[@"diuc"] = @"C2D95DB95D613410309F81193FB324F01F9B14E32FHFSIKTGGF";
    dic[@"from"] = @"AppStore";
    dic[@"model"] = @"Unknown iPad";
    dic[@"nani_idfa"] = @"86294854-68D7-49CD-A8FD-6804980FE590";
    dic[@"subapp_type"] = @"nani";
    
    dic[@"z_id"] = @"rFrPVimBUvWH5P7FBld1NBSx7OoCUk8yiHZ8-LLBkC1Wfri7C904CDCrYh9EgDRp64f3LSQZAfGS3XO0hD5ri4w";
    dic[@"tbs"] = @"73254f0d29744cbf1537693822";
    
    if (type == CNJNetworkingTypeGet) {
        [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            !success ? : success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ? : failure(error);
        }];
    }else {
        [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            !success ? : success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            !failure ? : success(error);
        }];
    }
}


@end
