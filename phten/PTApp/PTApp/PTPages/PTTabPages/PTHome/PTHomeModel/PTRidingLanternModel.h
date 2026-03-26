//
//  PTRidingLanternModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface PTRidingLanternItemModel : PTHomeBaseModel
@property(nonatomic, copy) NSString *thtenckleafNc;
@property(nonatomic, copy) NSString *eptengynyNc;
@end

@interface PTRidingLanternModel : PTHomeBaseModel
@property(nonatomic, copy) NSString *ittenlianizeNc;
@property(nonatomic, copy) NSArray <PTRidingLanternItemModel*>*gutengoyleNc;
@end

NS_ASSUME_NONNULL_END
