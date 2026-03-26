//
//  XTProductCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTProductCell.h"
#import "XTProductModel.h"

@interface XTProductCell()

@property(nonatomic,strong) XTProductModel *model;
@property(nonatomic,strong) UIImageView *iconImg;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *descLab;
@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation XTProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 16;
    view.layer.shadowColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:0.4600].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 8;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [view addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.top.equalTo(view.mas_top).offset(14);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    [view addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-17);
        make.top.equalTo(view.mas_top).offset(18);
        make.height.mas_equalTo(28);
    }];
    
    [view addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(7);
        make.right.equalTo(self.priceLab.mas_left).offset(-5);
        make.top.equalTo(view.mas_top).offset(11);
        make.height.mas_equalTo(22);
    }];
    
    [view addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(7);
        make.right.equalTo(self.priceLab.mas_left).offset(-5);
        make.top.equalTo(self.nameLab.mas_bottom).offset(2);
        make.height.mas_equalTo(16);
    }];
    
    UIImageView *lineImg = [UIImageView xt_img:@"xt_img_line" tag:0];
    [view addSubview:lineImg];
    [lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.right.equalTo(view.mas_right).offset(-10);
        make.top.equalTo(self.iconImg.mas_bottom).offset(7);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *bgImg = [UIImageView xt_img:@"xt_first_item_bg" tag:0];
    [view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(10);
        make.top.equalTo(lineImg.mas_bottom).offset(10);
    }];
    
    UIImageView *itemIcon1Img = [UIImageView xt_img:@"xt_first_item_icon_1" tag:0];
    [bgImg addSubview:itemIcon1Img];
    [itemIcon1Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg.mas_left).offset(7);
        make.top.equalTo(bgImg.mas_top).offset(2);
    }];
    
    UILabel *itemIcon1Lab = [UILabel xt_lab:CGRectZero text:@"Recommended products with low interest rates" font:XT_Font(8) textColor:XT_RGB(0x0FB158, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [bgImg addSubview:itemIcon1Lab];
    [itemIcon1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(itemIcon1Img.mas_right).offset(6);
        make.centerY.equalTo(itemIcon1Img);
    }];
    
    UIImageView *itemIcon2Img = [UIImageView xt_img:@"xt_first_item_icon_2" tag:0];
    [bgImg addSubview:itemIcon2Img];
    [itemIcon2Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg.mas_left).offset(7);
        make.top.equalTo(itemIcon1Img.mas_bottom).offset(4);
    }];
    
    UILabel *itemIcon2Lab = [UILabel xt_lab:CGRectZero text:@"Products recommended by many people" font:XT_Font(8) textColor:XT_RGB(0xFFA93B, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [bgImg addSubview:itemIcon2Lab];
    [itemIcon2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(itemIcon2Img.mas_right).offset(6);
        make.centerY.equalTo(itemIcon2Img);
    }];
    
    [view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-15);
        make.bottom.equalTo(view.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(88, 28));
    }];
    
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[XTProductModel class]]) {
        return;
    }
    XTProductModel *model = (XTProductModel *)xt_data;
    self.model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.sihosixuetteNc]];
    self.nameLab.text = model.moossixyllabismNc;
    self.priceLab.text = model.eahosixleNc;
    self.descLab.text = model.cotesixnderNc;
    [self.submitBtn setTitle:model.maansixNc forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = model.spffsixlicateNc.xt_hexColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)iconImg{
    if(!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.clipsToBounds = YES;
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImg;
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(16) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}

- (UILabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [UILabel xt_lab:@"" font:XT_Font_B(16) textColor:[UIColor blackColor] alignment:NSTextAlignmentRight isPriority:YES tag:0];
    }
    return _priceLab;
}

- (UILabel *)descLab {
    if(!_descLab) {
        _descLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(11) textColor:XT_RGB(0x9C9C9C, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _descLab;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"" font:XT_Font_M(12) textColor:[UIColor blackColor] cornerRadius:0 tag:0];
        _submitBtn.clipsToBounds = YES;
        _submitBtn.layer.cornerRadius = 14;
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(!self.model.pacasixrditisNc){
                return [RACSignal empty];
            }
            if(self.nextBlock){
                self.nextBlock();
            }
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}

@end
