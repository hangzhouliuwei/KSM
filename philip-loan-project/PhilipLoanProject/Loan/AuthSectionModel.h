//
//  AuthSectionModel.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import <Foundation/Foundation.h>
#import "AuthOptionalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AuthSectionModel : NSObject

@property(nonatomic)NSString *fldgtwelveeNc,*sub_title;
@property(nonatomic)BOOL more;

@property(nonatomic)BOOL currentStatus;
@property(nonatomic)NSArray<AuthOptionalModel *> *xathtwelveosisNc;

@property(nonatomic)CGFloat *headerHeight;

@end

NS_ASSUME_NONNULL_END
