//
//  PUBATTrackingTool.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/23.
//

#import <Foundation/Foundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PUBATTrackingTool : NSObject

+ (void)requestTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14));

@end

NS_ASSUME_NONNULL_END
