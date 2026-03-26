//
//  DataManager.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLPDataManager : NSObject

@property(nonatomic)NSString *vipShowImageURL;

@property(nonatomic)NSDictionary *serviceInfo;

@property(nonatomic)NSString *rightJumpURL;

@property(nonatomic)NSString *productId;
@property(nonatomic)NSString *orderId;

@property(nonatomic)BOOL showServerImageView;

@property(nonatomic)UIImageView *callImageView;

@property(nonatomic)NSMutableDictionary *controllerMap;

+(instancetype)manager;

-(void)updateInfoWithResponseObject:(NSDictionary *)responseObject;
@end

NS_ASSUME_NONNULL_END
