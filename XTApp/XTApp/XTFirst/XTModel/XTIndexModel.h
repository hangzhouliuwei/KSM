//
//  XTIndexModel.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XTIconModel;
@class XTBannerModel;
@class XTCardModel;
@class XTRepayModel;
@class XTLanternModel;
@class XTProductModel;
@class XTRepayModel;

@interface XTIndexModel : NSObject

@property(nonatomic,strong) XTIconModel *iconModel;

@property(nonatomic,strong) NSArray <XTBannerModel *>*bannerArr;
@property(nonatomic,strong) XTCardModel *big;
@property(nonatomic,strong) XTCardModel *small;
@property(nonatomic,strong) NSArray <XTRepayModel *>*repayArr;
@property(nonatomic,strong) NSArray <XTLanternModel *>*lanternArr;
@property(nonatomic,strong) NSArray <XTProductModel *>*productArr;
@property(nonatomic,strong) XTRepayModel *noticeModel;


@end

NS_ASSUME_NONNULL_END
