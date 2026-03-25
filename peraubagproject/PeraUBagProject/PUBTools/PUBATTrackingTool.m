//
//  PUBATTrackingTool.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/23.
//

#import "PUBATTrackingTool.h"

@implementation PUBATTrackingTool

+ (void)requestTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion {
    if (@available(iOS 14.0, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                NSLog(@"iOS 17.4 ATT bug detected");
                if (@available(iOS 15.0, *)) {
                    __block id observer = nil;
                    observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                        [[NSNotificationCenter defaultCenter] removeObserver:observer];
                        observer = nil;
                        [self requestTrackingAuthorizationWithCompletion:completion];
                    }];
                } else {
                    // Fallback on earlier versions
                }
            } else {
                completion(status);
            }
        }];
    } else {
        // For iOS versions below 14, directly return not determined status
        if (completion) {
            completion(ATTrackingManagerAuthorizationStatusNotDetermined);
        }
    }
}
@end
