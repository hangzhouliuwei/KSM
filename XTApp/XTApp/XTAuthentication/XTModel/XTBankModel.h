//
//  XTBankModel.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTBankItemModel;
@interface XTBankModel : NSObject

@property(nonatomic) NSInteger xt_countdown;
@property(nonatomic,strong) XTBankItemModel *bankModel;
@property(nonatomic,strong) XTBankItemModel *walletModel;

@end

NS_ASSUME_NONNULL_END
