//
//  XTWalletCell.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTWalletCell.h"
#import "XTNoteModel.h"

@interface XTWalletCell()

@property(nonatomic,weak) UIView *view;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *titLab;
@property(nonatomic,strong) UIImageView *accImg;

@end

@implementation XTWalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    UIView *view = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
    view.layer.borderColor = XT_RGB(0xdddddd, 1.0).CGColor;
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 12;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@64);
    }];
    self.view = view;
    
    [view addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(16);
        make.centerY.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [view addSubview:self.accImg];
    [self.accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-16);
        make.centerY.equalTo(view);
    }];
    
    [view addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(8);
        make.centerY.equalTo(view);
    }];
    
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if(isSelect) {
        self.view.backgroundColor = [UIColor clearColor];
        self.accImg.image = XT_Img(@"xt_verify_wallet_select_1");
    }
    else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.accImg.image = XT_Img(@"xt_verify_wallet_select_0");
    }
}

- (void)setModel:(XTNoteModel *)model {
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.xt_icon] placeholderImage:XT_Img(@"xt_img_def")];
    self.titLab.text = model.xt_name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)icon {
    if(!_icon) {
        _icon = [UIImageView new];
    }
    return _icon;
}

- (UIImageView *)accImg {
    if(!_accImg) {
        _accImg = [UIImageView xt_img:@"xt_verify_wallet_select_0" tag:0];
    }
    return _accImg;
}

- (UILabel *)titLab {
    if(!_titLab) {
        _titLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(15) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _titLab;
}

@end
