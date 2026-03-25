//
//  XTCellModel.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTCell;

@interface XTCellModel : NSObject

///cell高度
@property (nonatomic) CGFloat height;
@property (nonatomic) id xt_data;

///当前的cell
@property (nonatomic, strong) XTCell * _Nonnull indexCell;

+ (XTCellModel *)xt_cellClassName:(NSString *)className height:(CGFloat)height model:(id __nullable)model;

+ (XTCellModel *)xt_cellClassName:(NSString *)className height:(CGFloat)height model:(id __nullable)model ID:(NSString *)ID;

@end

NS_ASSUME_NONNULL_END
