//
//  XTSetCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTSetCell.h"

@interface XTSetCell()

@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *contentLab;

@end

@implementation XTSetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(21);
    }];
    
    [self.contentView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.top.equalTo(self.nameLab.mas_bottom).offset(2);
        make.height.mas_equalTo(25);
    }];
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary *dic = (NSDictionary *)xt_data;
    
    self.nameLab.text = dic[@"title"];
    self.contentLab.text = dic[@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font(15) textColor:XT_RGB(0x999999, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}

- (UILabel *)contentLab {
    if(!_contentLab) {
        _contentLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(18) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _contentLab;
}

@end
