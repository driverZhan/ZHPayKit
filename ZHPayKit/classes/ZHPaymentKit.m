//
//  ZHPaymentKit.m
//  ZHPayKit
//
//  Created by  monstar on 2019/8/27.
//  Copyright © 2019 zhany. All rights reserved.
//

#import "ZHPaymentKit.h"

@implementation ZHPaymentKit

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ZHPaymentKit *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [[ZHPaymentKit alloc] init];
    });
    return _manager;
}

- (NSString *)genAlipayInfo:(NSString *)app_id
                       name:(NSString *)name
                    tradeNo:(NSString *)tradeNo
                       cost:(float)cost{
    
    
    return @"";
}

- (void)payWithAlipay:(NSString *)orderString
            schemeStr:(NSString *)schemeStr
             complete:(nullable AlipayResultHandler)complete
{
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:schemeStr callback:^(NSDictionary *resultDic) {
        
        enum AlipayResult result = AlipayResultDefault;
        if ([resultDic objectForKey:@"resultStatus"]) {
            result = [[resultDic objectForKey:@"resultStatus"] integerValue];
        }
        BOOL success = result == AlipayResultSuccess;
        if (complete) {
            self.alipayResultHandler = complete;
            complete(result, success);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(AlipayResult:success:)]) {
            [self.delegate AlipayResult:result success:success];
        }
        
    }];
}

- (void)payWithAlipay:(NSString *)orderString
        dynamicLaunch:(BOOL)dynamicLaunch
            schemeStr:(NSString *)schemeStr
             complete:(AlipayResultHandler)complete {
    [[AlipaySDK defaultService] payOrder:orderString dynamicLaunch:dynamicLaunch fromScheme:schemeStr callback:^(NSDictionary *resultDic) {
        
        enum AlipayResult result = AlipayResultDefault;
        if ([resultDic objectForKey:@"resultStatus"]) {
            result = [[resultDic objectForKey:@"resultStatus"] integerValue];
        }
        BOOL success = result == AlipayResultSuccess;
        if (complete) {
            self.alipayResultHandler = complete;
            complete(result, success);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(AlipayResult:success:)]) {
            [self.delegate AlipayResult:result success:success];
        }
        
    }];
}

- (void)processAlipayResult:(NSURL *)url {
    [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
        enum AlipayResult result = AlipayResultDefault;
        if ([resultDic objectForKey:@"resultStatus"]) {
            result = [[resultDic objectForKey:@"resultStatus"] integerValue];
        }
        BOOL success = result == AlipayResultSuccess;
        if (self.alipayResultHandler) {
            self.alipayResultHandler(result, success);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(AlipayResult:success:)]) {
            [self.delegate AlipayResult:result success:success];
        }
    }];
}

@end
