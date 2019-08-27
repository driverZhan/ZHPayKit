//
//  ZHPaymentKit.h
//  ZHPayKit
//
//  Created by  monstar on 2019/8/27.
//  Copyright © 2019 zhany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHPaymentHeader.h"

NS_ENUM(NSInteger, AlipayResult) {
    AlipayResultSuccess = 9000,//支付成功
    AlipayResultProcessing = 8000,//订单处理中
    AlipayResultRepeatRequest = 5000,//重复请求
    AlipayResultCancel = 6001,//中途取消
    AlipayResultNetworkException = 6002,//网络连接出错
    AlipayResultUnknown = 6004,//支付结果未知
    AlipayResultFailed = 4000,//支付失败
    AlipayResultDefault//其他支付错误
};

NS_ASSUME_NONNULL_BEGIN

@protocol ZHPaymentKitDelegate <NSObject>

- (void)AlipayResult:(enum AlipayResult)result success:(BOOL)success;

@end


typedef void(^AlipayResultHandler)(enum AlipayResult result, BOOL success);

@interface ZHPaymentKit : NSObject

@property (nonatomic, copy) AlipayResultHandler alipayResultHandler;
@property (nonatomic, assign) id<ZHPaymentKitDelegate> delegate;

+ (instancetype)shareInstance;

- (NSString *)genAlipayInfo:(NSString *)app_id
                       name:(NSString *)name
                    tradeNo:(NSString *)tradeNo
                       cost:(float)cost;

- (void)payWithAlipay:(NSString *)orderString
            schemeStr:(NSString *)schemeStr
             complete:(nullable AlipayResultHandler)complete;

- (void)payWithAlipay:(NSString *)orderString
        dynamicLaunch:(BOOL)dynamicLaunch
            schemeStr:(NSString *)schemeStr
             complete:(nullable AlipayResultHandler)complete;

- (void)processAlipayResult:(NSURL*)url;


@end

NS_ASSUME_NONNULL_END
