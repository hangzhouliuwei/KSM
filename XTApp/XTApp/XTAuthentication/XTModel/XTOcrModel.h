//
//  XTOcrModel.h
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTPhotoModel;

@interface XTOcrModel : NSObject

@property(nonatomic) NSInteger xt_countdown;
@property(nonatomic,strong) XTPhotoModel *model;

@end

NS_ASSUME_NONNULL_END
