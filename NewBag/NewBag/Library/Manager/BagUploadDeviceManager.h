//
//  BagUploadDeviceManager.h
//  NewBag
//
//  Created by 刘巍 on 2024/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagUploadDeviceManager : NSObject
+ (instancetype)shareInstance;

- (void)uploadDevice;

@end

NS_ASSUME_NONNULL_END
