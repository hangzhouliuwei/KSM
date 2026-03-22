//
//  XTPhotoModel.h
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class XTOcrNoteModel;
@class XTListModel;

@interface XTPhotoModel : NSObject

@property(nonatomic,copy) NSString *xt_relation_id;
@property(nonatomic,copy) NSString *xt_img;
@property(nonatomic,copy) NSString *xt_type;
@property(nonatomic,copy) NSString *xt_name;

@property(nonatomic,strong) NSArray <XTOcrNoteModel *>*note;
@property(nonatomic,strong) NSArray <XTListModel *>*list;

@property(nonatomic,copy) NSString *path;
@property(nonatomic,copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
