//
//  XTBigCell.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTBigCell.h"
#import "XTCardModel.h"
#import <YYLabel.h>

@interface XTBigCell()

@property(nonatomic,strong) XTCardModel *model;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIImageView *img;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *descLab;
@property(nonatomic,strong) UILabel *item1TitLab;
@property(nonatomic,strong) UILabel *item1Lab;
@property(nonatomic,strong) UILabel *item2TitLab;
@property(nonatomic,strong) UILabel *item2Lab;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,strong) YYLabel *altLab;
@end

@implementation XTBigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    UIView *view = [UIView new];
    [self.contentView addSubview:view];
    view.clipsToBounds = YES;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [view.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x0BB559, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(XT_Screen_Width, 420)]];
    UIImageView *img = [UIImageView xt_img:@"xt_first_top_bg" tag:0];
    [view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).offset(15);
    }];
    
    UIImageView *contentImg = [UIImageView xt_img:nil tag:0];
    contentImg.image = [XT_Img(@"xt_first_top_content_bg") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    [view addSubview:contentImg];
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(14);
        make.right.equalTo(view.mas_right).offset(-14);
        make.bottom.equalTo(view.mas_bottom);
        make.height.mas_equalTo(277);
    }];
    
    [view addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImg.mas_left).offset(20);
        make.top.equalTo(contentImg.mas_top).offset(15);
        make.height.mas_equalTo(17);
    }];
    
    [view addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImg.mas_left).offset(60);
        make.top.equalTo(contentImg.mas_top).offset(52);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    [view addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(19);
        make.right.equalTo(contentImg.mas_right).offset(-10);
        make.top.equalTo(contentImg.mas_top).offset(30);
        make.height.mas_equalTo(76);
    }];
    [view addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_left);
        make.right.equalTo(contentImg.mas_right).offset(-10);
        make.bottom.equalTo(self.priceLab.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    UIView *lineView = [UIView xt_frame:CGRectZero color:XT_RGB(0x979797, 1.0f)];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(self.img.mas_bottom).offset(24);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(1);
    }];
    
    [view addSubview:self.item1TitLab];
    [self.item1TitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(lineView.mas_left);
        make.top.equalTo(self.img.mas_bottom).offset(24);
        make.height.mas_equalTo(13);
    }];
    
    [view addSubview:self.item1Lab];
    [self.item1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.right.equalTo(lineView.mas_left);
        make.top.equalTo(self.item1TitLab.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [view addSubview:self.item2TitLab];
    [self.item2TitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view);
        make.left.equalTo(lineView.mas_right);
        make.top.equalTo(self.img.mas_bottom).offset(24);
        make.height.mas_equalTo(13);
    }];
    
    [view addSubview:self.item2Lab];
    [self.item2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view);
        make.left.equalTo(lineView.mas_right);
        make.top.equalTo(self.item2TitLab.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(25);
        make.right.equalTo(view.mas_right).offset(-25);
        make.top.equalTo(lineView.mas_bottom).offset(17);
        make.height.mas_equalTo(48);
    }];
    
    [view addSubview:self.altLab];
    [self.altLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(12);
        make.height.mas_equalTo(17);
    }];
    
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[XTCardModel class]]) {
        return;
    }
    XTCardModel *model = (XTCardModel *)xt_data;
    self.model = model;
    self.nameLab.text = model.moossixyllabismNc;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.sihosixuetteNc] placeholderImage:XT_Img(@"xt_img_def")];
    self.priceLab.text = model.eahosixleNc;
    self.descLab.text = model.cotesixnderNc;
    self.item1TitLab.text = model.paadsixosNc;
    self.item1Lab.text = model.urtesixrNc;
    self.item2TitLab.text = model.fatisixshNc;
    self.item2Lab.text = model.fiansixcialNc;
    
    [self.submitBtn setTitle:model.maansixNc forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = model.spffsixlicateNc.xt_hexColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font(13) textColor:XT_RGB(0x797979, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}

- (UIImageView *)img {
    if(!_img) {
        _img = [UIImageView new];
//        _img.layer.cornerRadius = 8;
        _img.clipsToBounds = YES;
        _img.contentMode = UIViewContentModeScaleAspectFill;
//        _img.backgroundColor = XT_RGB(0xDDDDDD, 1.0f);
    }
    return _img;
}

- (UILabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_B(40) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _priceLab;
}

- (UILabel *)descLab {
    if(!_descLab) {
        _descLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(9) textColor:XT_RGB(0x3B3B3B, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _descLab;
}

- (UILabel *)item1TitLab {
    if(!_item1TitLab) {
        _item1TitLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(9) textColor:XT_RGB(0xAEAEAE, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    }
    return _item1TitLab;
}

- (UILabel *)item1Lab {
    if(!_item1Lab) {
        _item1Lab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(14) textColor:XT_RGB(0x0BB559, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    }
    return _item1Lab;
}

- (UILabel *)item2TitLab {
    if(!_item2TitLab) {
        _item2TitLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(9) textColor:XT_RGB(0xAEAEAE, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    }
    return _item2TitLab;
}

- (UILabel *)item2Lab {
    if(!_item2Lab) {
        _item2Lab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(14) textColor:XT_RGB(0x0BB559, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    }
    return _item2Lab;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"" font:XT_Font_M(20) textColor:[UIColor blackColor] cornerRadius:0 tag:0];
        _submitBtn.clipsToBounds = YES;
        _submitBtn.layer.cornerRadius = 24;
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

- (YYLabel *)altLab{
    if(!_altLab) {
        _altLab = [YYLabel new];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"Click to view the" attributes:@{
            NSFontAttributeName:XT_Font_M(12),
            NSForegroundColorAttributeName:[UIColor blackColor],
        }]];
        NSString *privacyStr = @"Privacy Agreement";
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:privacyStr attributes:@{
            NSFontAttributeName:XT_Font_M(12),
            NSForegroundColorAttributeName:XT_RGB(0x02CC56, 1.0f),
            NSUnderlineStyleAttributeName:[NSString stringWithFormat:@"%ld", NSUnderlineStyleSingle],

        }]];
//        @weakify(self)
        [str yy_setTextHighlightRange:NSMakeRange(str.length - privacyStr.length, privacyStr.length)
                                 color:XT_RGB(0x02CC56, 1.0f)
                       backgroundColor:[UIColor clearColor]
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            @strongify(self)
            [[XTRoute xt_share] goHtml:XT_Privacy_Url success:nil];
            
        }];
        _altLab.attributedText = str;
        
    }
    return _altLab;
}

@end
