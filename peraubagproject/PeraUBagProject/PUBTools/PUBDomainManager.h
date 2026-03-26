//
//  PUBDomainManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBDomainManager : NSObject
SINGLETON_H(PUBDomainManager)
-(void)domainNameCheckResult:(ReturnBoolBlock)result;
@end

NS_ASSUME_NONNULL_END
