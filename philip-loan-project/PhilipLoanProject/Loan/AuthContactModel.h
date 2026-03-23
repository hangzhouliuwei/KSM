//
//  AuthContactModel.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import <Foundation/Foundation.h>
@class AuthContactRelationModel;
@class AuthContactFilledModel;
NS_ASSUME_NONNULL_BEGIN

@interface AuthContactModel : NSObject

@property(nonatomic)NSString *fldgtwelveeNc;

@property(nonatomic)NSArray<NSDictionary *> *inhotwelveationNc;

@property(nonatomic)NSArray<AuthContactRelationModel *> *beditwelveeNc;


@property(nonatomic)AuthContactFilledModel *koNctwelve;

@property(nonatomic)AuthContactRelationModel *selectedModel;
@property(nonatomic)NSString *contactName,*contactPhone;

@end



@interface AuthContactRelationModel: NSObject
@property(nonatomic)NSString *uportwelvenNc;
@property(nonatomic)NSInteger demptwelvehasizeNc;


@end


@interface AuthContactFilledModel: NSObject
@property(nonatomic)NSString *uportwelvenNc;
@property(nonatomic)NSString *halotwelvewNc;
@property(nonatomic)NSInteger beditwelveeNc;


@end







NS_ASSUME_NONNULL_END
