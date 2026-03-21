//
//  XTPhotoModel.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTPhotoModel.h"
#import "XTOcrNoteModel.h"
#import "XTListModel.h"

@implementation XTPhotoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_relation_id" : @"darysixmanNc",
        @"xt_img" : @"relosixomNc",
        @"xt_type" : @"decasixleNc",
        @"note" : @"tubosixdrillNc",
        @"list" : @"xathsixosisNc",
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"note" : XTOcrNoteModel.class,
        @"list" : XTListModel.class,
    };
}

- (NSString *)xt_name {
    if(!_xt_name) {
        for(XTOcrNoteModel *model in self.note) {
            if([model.xt_type isEqualToString:self.xt_type]) {
                _xt_name = model.xt_name;
                break;
            }
        }
    }
    return _xt_name;
}

@end
