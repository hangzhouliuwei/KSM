//
//  XTMyHeadView.m
//  XTApp
//
//  Created by xia on 2024/9/12.
//

#import "XTMyHeadView.h"
#import "XTMyModel.h"

@interface XTMyHeadView()

@property(nonatomic,strong) UILabel *tagLab;

@end

@implementation XTMyHeadView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, XT_Screen_Width, 166 + XT_StatusBar_Height)];
    if(self){
        [self addSubview:[UIView xt_frame:CGRectMake(0, 0, self.width, XT_StatusBar_Height) color:XT_RGB(0x0BB559, 1.0f)]];

        self.backgroundColor = XT_RGB(0x0BB559, 1.0f);
        UIImageView *logoImg = [UIImageView xt_img:@"xt_my_head_logo" tag:0];
        [self addSubview:logoImg];
        [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(-9 + XT_StatusBar_Height);
            make.left.equalTo(self.mas_left).offset(18);
            make.size.mas_equalTo(CGSizeMake(91, 96));
        }];
        
        UILabel *phoneLab = [UILabel xt_lab:CGRectZero text:[XTUserManger xt_share].xt_user.xt_phone.xt_phonePrivacy font:XT_Font_SD(20) textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:phoneLab];
        [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(18 + XT_StatusBar_Height);
            make.left.equalTo(logoImg.mas_right).offset(8);
            make.height.mas_equalTo(28);
        }];

        [self addSubview:self.tagLab];
        [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneLab.mas_bottom).offset(7);
            make.left.equalTo(logoImg.mas_right).offset(8);
            make.height.mas_equalTo(21);
        }];
        
        UIImageView *footBgImg = [UIImageView xt_img:@"xt_my_foot_bg" tag:0];
        [self addSubview:footBgImg];
        [footBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(80);
        }];
        
        UIImageView *iconImg = [UIImageView xt_img:@"xt_my_head_list_logo" tag:0];
        [self addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(35);
            make.top.equalTo(footBgImg.mas_top).offset(17);
            make.size.mas_equalTo(CGSizeMake(21, 21));
        }];
        
        UILabel *nameLab = [UILabel xt_lab:CGRectZero text:@"My list" font:XT_Font_M(18) textColor:XT_RGB(0x161616, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg.mas_right).offset(9);
            make.centerY.equalTo(iconImg);
            make.height.mas_equalTo(21);
        }];
        
        UILabel *subLab = [UILabel xt_lab:CGRectZero text:@"Click to view my order status" font:XT_Font(12) textColor:XT_RGB(0x888888, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [self addSubview:subLab];
        [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg);
            make.top.equalTo(iconImg.mas_bottom).offset(4);
            make.height.mas_equalTo(17);
        }];
        
        UIButton *btn = [UIButton xt_btn:@"Click enter" font:XT_Font_M(14) textColor:XT_RGB(0x010000, 1.0f) cornerRadius:16 tag:0];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-28);
            make.top.equalTo(footBgImg.mas_top).offset(22);
            make.size.mas_equalTo(CGSizeMake(120, 32));
        }];
        [btn.layer insertSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x02CC56, 1.0f).CGColor,(__bridge id)XT_RGB(0xC6FF95, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.54, 0.85) endPoint:CGPointMake(0.54, 0) size:CGSizeMake(120, 32)] atIndex:0];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.block) {
                self.block();
            }
            return [RACSignal empty];
        }];
    }
    return self;
}

- (void)setModel:(XTMyModel *)model {
    _model = model;
    if([NSString xt_isEmpty:model.xt_memberUrl]) {
        self.tagLab.text = @"Hello, New User";
    }
    else {
        self.tagLab.text = @"Hello, Esteemed Member";
    }
    
}

- (UILabel *)tagLab {
    if(!_tagLab) {
        _tagLab = [UILabel xt_lab:CGRectZero text:@"Hello, Esteemed Member" font:XT_Font_M(15) textColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _tagLab;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
