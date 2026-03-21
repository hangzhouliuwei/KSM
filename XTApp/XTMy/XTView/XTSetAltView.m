//
//  XTSetAltView.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTSetAltView.h"

@implementation XTSetAltView

-(id)initWithAlt:(NSString *)alt {
    self = [super initWithFrame:CGRectMake(0, 0, 291, 253)];
    if(self){
        UIImageView *bgImg = [UIImageView xt_img:@"xt_my_set_alt_bg" tag:0];
        [self addSubview:bgImg];
        [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *iconImg = [UIImageView xt_img:@"xt_my_set_alt_icon" tag:0];
        [self addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).offset(21);
        }];
        
        UILabel *altLab = [UILabel xt_lab:CGRectZero text:alt font:XT_Font(18) textColor:XT_RGB(0x3C3C3C, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        altLab.numberOfLines = 2;
        [self addSubview:altLab];
        [altLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(iconImg.mas_bottom).offset(13);
        }];
        
        UIButton *sureBtn = [UIButton xt_btn:@"Confirm" font:XT_Font(18) textColor:XT_RGB(0x0BB559, 1.0f) cornerRadius:20 borderColor:XT_RGB(0x0BB559, 1.0f) borderWidth:1 backgroundColor:[UIColor whiteColor] tag:0];
        [self addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.bottom.equalTo(self.mas_bottom).offset(-24);
            make.size.mas_equalTo(CGSizeMake(124, 40));
        }];
        @weakify(self)
        sureBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.sureBlock){
                self.sureBlock();
            }
            return [RACSignal empty];
        }];
        
        UIButton *cancelBtn = [UIButton xt_btn:@"Cancel" font:XT_Font_SD(18) textColor:[UIColor whiteColor] cornerRadius:20 borderColor:nil borderWidth:0 backgroundColor:XT_RGB(0x0BB559, 1.0f) tag:0];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-13);
            make.bottom.equalTo(self.mas_bottom).offset(-24);
            make.size.mas_equalTo(CGSizeMake(124, 40));
        }];
        cancelBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.cancelBlock) {
                self.cancelBlock();
            }
            return [RACSignal empty];
        }];
        
        
    }
    return self;
}

@end
