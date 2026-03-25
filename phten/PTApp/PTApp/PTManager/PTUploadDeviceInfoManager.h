//
//  PTUploadDeviceInfoManager.h
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTUploadDeviceInfoManager : NSObject
+ (PTUploadDeviceInfoManager *)sharedManager;

- (void)uploadDeviceInfo;
@end

NS_ASSUME_NONNULL_END
