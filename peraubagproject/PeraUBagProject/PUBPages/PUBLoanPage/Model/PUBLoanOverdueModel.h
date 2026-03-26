//
//  PUBLoanOverdueModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/7.
//

#import "PUBLoanBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoanOverdueItmeModel : PUBLoanBaseModel
///图片地址
@property(nonatomic, copy) NSString *electioneer_eg;
///跳转
@property(nonatomic, copy) NSString *lobsterman_eg;
@end

@interface PUBLoanOverdueModel : PUBLoanBaseModel
@property(nonatomic, copy) NSString *vibronic_eg;
@property(nonatomic, copy) NSArray <PUBLoanOverdueItmeModel*>*obliterate_eg;
@end

NS_ASSUME_NONNULL_END
