//
//  PUBBankWalletCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBBankWalletCell.h"
#import "PUBBankModel.h"

@interface PUBBankWalletCell()
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) QMUILabel *titleLabel;
@property(nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation PUBBankWalletCell


- (void)configModel:(PUBBankLysinEgModel*)model selectModel:(PUBBankLysinEgModel*)selectModel
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.unbuild_eg)]];
    self.titleLabel.text = NotNull(model.rhodo_eg);
    self.arrowImageView.image =  [UIImage imageNamed:model == selectModel ? @"pub_bank_walletSelect" : @"pub_bank_walletNone"];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
        [self initSubViews];
        [self initSubFarmes];
    }
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview: self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    
}

- (void)initSubFarmes
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24.f);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(36.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20.f);
        make.centerY.mas_equalTo(0);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18.f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(22.f, 22.f));
    }];
}

#pragma mark - lazy

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 18.f;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (QMUILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _arrowImageView;
}

@end
