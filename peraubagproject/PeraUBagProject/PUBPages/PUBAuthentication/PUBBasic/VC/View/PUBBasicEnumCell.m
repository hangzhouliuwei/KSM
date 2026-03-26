//
//  PUBBasicEnumCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import "PUBBasicEnumCell.h"
#import "PUBBasicModel.h"

@interface PUBBasicEnumCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *arrowImageView;
@property(nonatomic, strong) UILabel *seleTitleLabel;
@end

static BOOL isClicking = NO;
@implementation PUBBasicEnumCell

- (void)clickAction
{
    if(self.clickBlock){
        self.clickBlock();
    }
}
-(void)configModel:(PUBBasicSomesuchEgModel*)model
{
    self.titleLabel.text = NotNull(model.neanderthaloid_eg);
    if(model.oerlikon_eg.integerValue !=0){
        WEAKSELF
        [model.horrific_eg enumerateObjectsUsingBlock:^(PUBBasicHorrificEgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(model.oerlikon_eg.integerValue == obj.vibronic_eg){
                strongSelf.seleTitleLabel.text = NotNull(obj.rhodo_eg);
                model.oerlikon_eg = [NSString stringWithFormat:@"%ld",obj.vibronic_eg];
                *stop = YES;
            }
            
        }];
    }
}

- (void)backViewTapClick
{
    if (isClicking) {
        return;
    }
    if(self.clickBlock){
        isClicking = YES;
        self.clickBlock();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isClicking = NO;
        });

    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFrams];
    }
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.arrowImageView];
    [self.backView addSubview:self.seleTitleLabel];
    
    UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTapClick)];
    [self.backView addGestureRecognizer:backViewTap];
}

- (void)initSubFrams
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(14.f);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel.mas_leading);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(2.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(40.f);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8.f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.seleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.f);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(16.f);
    }];
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.12f];
        _backView.layer.cornerRadius = 12.f;
        _backView.clipsToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_down_row"]];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}

- (UILabel *)seleTitleLabel{
    if(!_seleTitleLabel){
        _seleTitleLabel = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(16.f) textColor:[UIColor whiteColor]];
        _seleTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _seleTitleLabel;
}

@end
