//
//  XTVerifyHeadView.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTVerifyHeadView.h"

@implementation XTVerifyHeadView

- (instancetype)initWithFrame:(CGRect)frame type:(XT_VerifyType)type{
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:[UIView xt_frame:CGRectMake(0, 0, self.width, self.height + 20) color:XT_RGB(0x0BB559, 1.0f)]];
        
        UIImageView *img = [UIImageView xt_img:@"xt_verify_head_bg" tag:0];
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(12);
            make.left.greaterThanOrEqualTo(self.mas_left).offset(0);
            make.right.lessThanOrEqualTo(self.mas_right).offset(0);
            make.height.equalTo(@67);
            make.centerX.equalTo(self);
        }];
        if(type == XT_Verify_Contact) {
            img.image = XT_Img(@"xt_verify_head_contact_bg");
        }
        else if(type == XT_Verify_Identifcation) {
            img.image = XT_Img(@"xt_verify_head_ide_bg");
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
