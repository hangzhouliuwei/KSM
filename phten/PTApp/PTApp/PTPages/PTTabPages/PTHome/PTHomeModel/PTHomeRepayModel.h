//
//  PTHomeRepayModel.h
//  PTApp
//
//  Created by Jacky on 2024/9/2.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTHomeRepayRealModel : PTHomeBaseModel
@property (nonatomic, copy) NSString *frtenwnNc;//icon
@property (nonatomic, copy) NSString *retenloomNc;//url
@end
@interface PTHomeRepayModel : PTHomeBaseModel

@property (nonatomic, strong) NSArray <PTHomeRepayRealModel *>*gutengoyleNc;
@end

NS_ASSUME_NONNULL_END
