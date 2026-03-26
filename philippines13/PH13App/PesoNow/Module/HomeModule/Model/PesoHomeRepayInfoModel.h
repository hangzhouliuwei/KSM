//
//  PesoHomeRepayInfoModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PHRepayItemModel : PesoHomeBaseModel
@property (nonatomic, copy) NSString *frwnthirteenNc;//icon
@property (nonatomic, copy) NSString *relothirteenomNc;//link
@end
@interface PesoHomeRepayInfoModel : PesoHomeBaseModel
@property (nonatomic, strong) NSArray <PHRepayItemModel *>*gugothirteenyleNc;
@property(nonatomic, copy) NSString *itlithirteenanizeNc;

@end

NS_ASSUME_NONNULL_END
