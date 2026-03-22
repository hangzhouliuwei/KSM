//
//  XTVerifyContactModel.h
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTContactItemModel;

@interface XTVerifyContactModel : NSObject

@property(nonatomic) NSInteger xt_countdown;
@property(nonatomic,strong) NSArray <XTContactItemModel *>*items;

@end

NS_ASSUME_NONNULL_END
