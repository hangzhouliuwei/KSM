//
//  XTBankItemModel.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTBankItemModel.h"
#import "XTNoteModel.h"

@implementation XTBankItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"note" : @"unrdsixerlyNc",
        @"xt_channel" : @"koNcsix.blthsixelyNc",
        @"xt_account" : @"koNcsix.ovrcsixutNc",
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"note" : XTNoteModel.class,
    };
}

- (NSString *)xt_channel_name {
    if(!_xt_channel_name) {
        for(XTNoteModel *model in self.note) {
            if([model.xt_type isEqualToString:self.xt_channel]) {
                _xt_channel_name = model.xt_name;
                break;
            }
        }
    }
    return _xt_channel_name;
}

- (NSString *)xt_account {
    if(!_xt_account) {
        if([[XTUserManger xt_share].xt_user.xt_phone hasPrefix:@"0"]) {
            _xt_account = [XTUserManger xt_share].xt_user.xt_phone;
        }
        else {
            _xt_account = [NSString stringWithFormat:@"0%@",[XTUserManger xt_share].xt_user.xt_phone];
        }
    }
    return _xt_account;
}

@end
