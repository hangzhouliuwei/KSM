//
//  XTBankItemModel.h
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTNoteModel;
@interface XTBankItemModel : NSObject
@property(nonatomic,strong) NSArray <XTNoteModel *>*note;
@property(nonatomic,copy) NSString *xt_channel;
@property(nonatomic,copy) NSString *xt_channel_name;
@property(nonatomic,copy) NSString *xt_account;
@end

NS_ASSUME_NONNULL_END
