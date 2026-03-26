//
//  XTVerifyBaseModel.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTItemsModel;
@interface XTVerifyBaseModel : NSObject

@property(nonatomic) NSInteger xt_countdown;
@property(nonatomic,strong) NSArray <XTItemsModel *>*items;

@end

NS_ASSUME_NONNULL_END
