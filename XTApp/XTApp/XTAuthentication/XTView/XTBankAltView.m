//
//  XTBankAltView.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTBankAltView.h"

@implementation XTBankAltView

- (instancetype)initTit:(NSString *)tit name:(NSString *)name account:(NSString *)account{
    self = [super initWithFrame:CGRectMake(0, 0, 290, 413)];
    if(self) {
        UIImageView *bgImg = [UIImageView xt_img:@"xt_verify_bank_alt_bg" tag:0];
        [self addSubview:bgImg];
        [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIImageView *iconImg = [UIImageView xt_img:@"xt_verify_bank_alt_icon" tag:0];
        [self addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).offset(12);
        }];
        
        UILabel *altLab = [UILabel xt_lab:CGRectZero text:@"Please confirm your withdrawal\naccount information belongs to\nyourself and is correct" font:XT_Font(16) textColor:XT_RGB(0x3c3c3c, 1.0f) alignment:NSTextAlignmentCenter tag:0];
        altLab.numberOfLines = 0;
        [self addSubview:altLab];
        [altLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(iconImg.mas_bottom).offset(10);
            make.height.equalTo(@60);
        }];
        
        UILabel *titLab = [UILabel xt_lab:CGRectZero text:tit font:XT_Font(14) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.top.equalTo(altLab.mas_bottom).offset(20);
            make.height.equalTo(@19);
        }];
        
        UITextField *nameText = [UITextField xt_textField:NO placeholder:@"" font:XT_Font_SD(14) textColor:[UIColor blackColor] withdelegate:self];
        nameText.backgroundColor = XT_RGB(0xF8F8F8, 1.0f);
        nameText.leftViewMode = UITextFieldViewModeAlways;
        nameText.leftView = [UIView xt_frame:CGRectMake(0, 0, 12, 40) color:[UIColor clearColor]];
        nameText.layer.cornerRadius = 9;
        nameText.text = name;
        nameText.userInteractionEnabled = NO;
        [self addSubview:nameText];
        [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.right.equalTo(self.mas_right).offset(-13);
            make.top.equalTo(titLab.mas_bottom).offset(5);
            make.height.equalTo(@43);
        }];
        
        UILabel *accTitLab = [UILabel xt_lab:CGRectZero text:@"Account number" font:XT_Font(14) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:accTitLab];
        [accTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.top.equalTo(nameText.mas_bottom).offset(12);
            make.height.equalTo(@19);
        }];
        
        UITextField *accText = [UITextField xt_textField:NO placeholder:@"" font:XT_Font_SD(14) textColor:[UIColor blackColor] withdelegate:self];
        accText.backgroundColor = XT_RGB(0xF8F8F8, 1.0f);
        accText.leftViewMode = UITextFieldViewModeAlways;
        accText.leftView = [UIView xt_frame:CGRectMake(0, 0, 12, 40) color:[UIColor clearColor]];
        accText.layer.cornerRadius = 9;
        accText.text = account;
        accText.userInteractionEnabled = NO;
        [self addSubview:accText];
        [accText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.right.equalTo(self.mas_right).offset(-13);
            make.top.equalTo(accTitLab.mas_bottom).offset(5);
            make.height.equalTo(@43);
        }];
        
        UIButton *submitBtn = [UIButton xt_btn:@"Confirm" font:XT_Font(18) textColor:XT_RGB(0x0BB559, 1.0f) cornerRadius:20 borderColor:XT_RGB(0x0BB559, 1.0f) borderWidth:1 backgroundColor:[UIColor clearColor] tag:0];
        [self addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-13);
            make.top.equalTo(accText.mas_bottom).offset(14);
            make.size.mas_equalTo(CGSizeMake(124, 40));
        }];
        @weakify(self)
        submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.submitBlock) {
                self.submitBlock();
            }
            if(self.cancelBlock) {
                self.cancelBlock();
            }
            return [RACSignal empty];
        }];
        
        UIButton *cancelBtn = [UIButton xt_btn:@"Cancel" font:XT_Font_SD(18) textColor:[UIColor whiteColor] cornerRadius:20 tag:0];
        cancelBtn.backgroundColor = XT_RGB(0x0BB559, 1.0f);
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(13);
            make.top.equalTo(accText.mas_bottom).offset(14);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
