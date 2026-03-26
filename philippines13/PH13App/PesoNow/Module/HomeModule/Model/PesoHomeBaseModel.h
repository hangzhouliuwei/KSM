//
//  PesoHomeBaseModel.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeBaseModel : PesoBaseModel
@property(nonatomic, assign) NSInteger  priority;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, assign) CGFloat  height;
@end

NS_ASSUME_NONNULL_END
