//
//  XTItemsModel.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTListModel;

@interface XTItemsModel : NSObject

@property(nonatomic,copy) NSString *xt_title;
@property(nonatomic,copy) NSString *xt_sub_title;
@property(nonatomic) BOOL xt_more;
@property(nonatomic,strong) NSArray <XTListModel *>*list;

@property(nonatomic) BOOL hiddenChild;

@end

NS_ASSUME_NONNULL_END
