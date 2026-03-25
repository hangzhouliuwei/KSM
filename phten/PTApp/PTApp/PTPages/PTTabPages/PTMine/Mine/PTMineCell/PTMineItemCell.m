//
//  PTMineItemCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import "PTMineItemCell.h"
#import "PTMineModel.h"
@interface PTMineItemCell()
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) QMUILabel *tilteLabel;
@end

@implementation PTMineItemCell

-(void)configModel:(PTMineItemModel*)model
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:PTNotNull(model.ietenNc)]];
    self.tilteLabel.text = PTNotNull(model.fltendgeNc);
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubUI];
    }
    
    return self;
}

-(void)createSubUI
{
    [self.contentView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(24.f);
        make.width.height.mas_equalTo(24.f);
    }];
    
    [self.contentView addSubview:self.tilteLabel];
    [self.tilteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImage.mas_centerY);
        make.height.mas_equalTo(14.f);
        make.left.mas_equalTo(self.iconImage.mas_right).offset(22.f);
    }];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_mine_arrow"]];
    [self.contentView addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-24.f);
        make.centerY.mas_equalTo(self.iconImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10.f, 12.f));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = PTUIColorFromHex(0xE6F0FD);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(70.f);
        make.right.mas_equalTo(-24.f);
        make.height.mas_equalTo(0.8f);
    }];
}

#pragma mark - lazy
- (UIImageView *)iconImage{
    if(!_iconImage){
        _iconImage = [[UIImageView alloc] init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
//        _iconImage.backgroundColor = UIColor.redColor;
    }
    
    return _iconImage;
}

-(QMUILabel *)tilteLabel{
    if(!_tilteLabel){
        _tilteLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font(14.f) textColor:PTUIColorFromHex(0x333333)];
        _tilteLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tilteLabel;
}

@end
