//
//  PUBLoanBaseModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PUBLoanBaseModel : PUBBaseModel
@property(nonatomic, assign) CGFloat cellHight;
@property(nonatomic, copy) NSString *cellId;
@property(nonatomic, assign) NSInteger level;
@end

NS_ASSUME_NONNULL_END
