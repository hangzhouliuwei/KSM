//
//  XTMyModel.h
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTExtendListModel;
@class XTRepaymentModel;

@interface XTMyModel : NSObject

@property(nonatomic,copy) NSString *xt_memberUrl;
@property(nonatomic,strong) XTRepaymentModel *repayment;
@property(nonatomic,strong) NSArray <XTExtendListModel *>*extendLists;

@end

NS_ASSUME_NONNULL_END
