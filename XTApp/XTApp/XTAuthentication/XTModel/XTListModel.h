//
//  XTListModel.h
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XTNoteModel;

@interface XTListModel : NSObject

@property(nonatomic,copy) NSString *xt_id;
@property(nonatomic,copy) NSString *xt_title;
@property(nonatomic,copy) NSString *xt_subtitle;
@property(nonatomic,copy) NSString *xt_code;
///类型
@property(nonatomic,copy) NSString *xt_cate;
@property(nonatomic,strong) NSArray <XTNoteModel *>* noteList;
@property(nonatomic) BOOL xt_optional;
@property(nonatomic,copy) NSString *xt_value;

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *value;

@property(nonatomic,weak) UITableViewCell *cell;

@property(nonatomic) BOOL isHiddenCell;

@end

NS_ASSUME_NONNULL_END
