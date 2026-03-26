//
//  PesoHomeBannerModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PesoHomeBannerItemModel : PesoHomeBaseModel
@property (nonatomic, copy) NSString *aristhirteenNc;//image
@property (nonatomic, copy) NSString *relothirteenomNc;//link
@end
@interface PesoHomeBannerModel : PesoHomeBaseModel
@property(nonatomic, copy) NSArray <PesoHomeBannerItemModel*>*gugothirteenyleNc;

@end

NS_ASSUME_NONNULL_END
