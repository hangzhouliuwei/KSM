//
//  XTListModel.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTListModel.h"
#import "XTNoteModel.h"
#import "XTSelectCell.h"
#import "XTTextCell.h"

@implementation XTListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_id" : @"regnsixNc",
        @"xt_title" : @"fldgsixeNc",
        @"xt_subtitle" : @"orinsixarilyNc",
        @"xt_code" : @"imeasixsurabilityNc",
        @"xt_cate" : @"lebosixardNc",
        @"noteList" : @"tubosixdrillNc",
        @"xt_value" : @"darysixmanNc",
        @"xt_optional":@"tapasixxNc",
    };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"noteList" : XTNoteModel.class,
    };
}

- (void)setXt_value:(NSString *)xt_value {
    _xt_value = xt_value;
    self.value = xt_value;
}

- (NSString *)name {
    if(!_name) {
        if([self.xt_cate isEqualToString:@"AASIXTENBG"] || [self.xt_cate isEqualToString:@"AASIXTENBL"] || [self.xt_cate isEqualToString:@"AASIXTENBJ"]) {
            _name = self.value;
        }
        else if([self.value integerValue] > 0){
            for(XTNoteModel *model in self.noteList){
                if([model.xt_type isEqualToString:self.value]) {
                    _name = model.xt_name;
                    break;
                }
            }
        }
        else {
            _name = @"";
        }
    }
    return _name;
}

@end
