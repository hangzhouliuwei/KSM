//
//  PUBEnvironmentManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define PUBEnvironment  [PUBEnvironmentManager sharedPUBEnvironmentManager]
@interface PUBEnvironmentManager : NSObject
@property(nonatomic, copy) NSString * host;
SINGLETON_H(PUBEnvironmentManager)
@end

NS_ASSUME_NONNULL_END
