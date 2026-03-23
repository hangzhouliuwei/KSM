//
//  XTRoute.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTRoute : NSObject

+ (instancetype)xt_share;

-(void)goHtml:(NSString *)url
      success:(XTBoolBlock __nullable)success;
-(void)goVerifyList:(NSString *)productId;

-(void)goVerifyItem:(NSString *)code
          productId:(NSString *)productId
            orderId:(NSString *)orderId
            success:(XTBoolBlock __nullable)success;

@end

NS_ASSUME_NONNULL_END
