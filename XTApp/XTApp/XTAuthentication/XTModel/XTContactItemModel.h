//
//  XTContactItemModel.h
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTNoteModel;

@interface XTContactItemModel : NSObject

@property(nonatomic,copy) NSString *xt_title;
@property(nonatomic,strong) NSArray *xt_field;
@property(nonatomic,strong) NSArray <XTNoteModel *>*relation;

@property(nonatomic,copy) NSString *xt_name;
@property(nonatomic,copy) NSString *xt_mobile;
@property(nonatomic,copy) NSString *xt_relation;

@property(nonatomic,copy) NSString *firstValue;
@property(nonatomic,copy) NSString *secondValue;
@property(nonatomic,copy) NSString *threeValue;
@property(nonatomic,copy) NSString *threeName;

@end

NS_ASSUME_NONNULL_END
