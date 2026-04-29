//
//  PTNetworkConfig.h
//  PTApp
//
//  Created by Codex on 2026/4/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTNetworkConfig : NSObject

+ (void)configureWithBaseURL:(NSString *)baseURL;
+ (void)installURLFilterIfNeeded;
+ (nullable UIWindow *)visibleWindow;

@end

NS_ASSUME_NONNULL_END
