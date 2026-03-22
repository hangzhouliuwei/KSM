//
//  XTContactItemModel.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTContactItemModel.h"
#import "XTNoteModel.h"

@implementation XTContactItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"xt_title" : @"fldgsixeNc",
        @"xt_field" : @"inhosixationNc",
        @"relation" : @"bedisixeNc",
        
        @"xt_name" : @"koNcsix.uporsixnNc",
        @"xt_mobile" : @"koNcsix.halosixwNc",
        @"xt_relation" : @"koNcsix.bedisixeNc",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"relation" : XTNoteModel.class,
    };
}

- (NSString *)firstValue {
    if(!_firstValue) {
        _firstValue = self.xt_name;
    }
    return _firstValue;
}

- (NSString *)secondValue {
    if(!_secondValue) {
        _secondValue = self.xt_mobile;
    }
    return _secondValue;
}

- (NSString *)threeValue {
    if(!_threeValue) {
        _threeValue = self.xt_relation;
        
    }
    return _threeValue;
}

- (NSString *)threeName {
    if(!_threeName) {
        for(XTNoteModel *model in self.relation) {
            if([model.xt_type isEqualToString:self.xt_relation]) {
                self.threeName = model.xt_name;
                break;
            }
        }
    }
    return _threeName;
}

@end
