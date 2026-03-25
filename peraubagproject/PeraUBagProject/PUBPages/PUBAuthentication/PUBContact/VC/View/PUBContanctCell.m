//
//  PUBContanctCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/4.
//

#import "PUBContanctCell.h"
#import "PUBContactModel.h"

@interface PUBContanctCell ()
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *topLineView;
@property(nonatomic, strong) UIView *relationshipView;
@property(nonatomic, strong) UILabel *relationshipLabel;
@property(nonatomic, strong) UILabel *selectLabel;
@property(nonatomic, strong) UIImageView *arrowImageView;
@property(nonatomic, strong) UIView *bottmeLineView;
@property(nonatomic, strong) UIView *contanctView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *phoneLabel;
@property(nonatomic, strong) UIImageView *contanctLogImageView;
@end

@implementation PUBContanctCell

- (void)configModel:(PUBContactItmeModel*)model
{
    self.titleLabel.text = NotNull(model.neanderthaloid_eg);
    if(model.megrim_eg.featherstitch_eg != 0){
        WEAKSELF
        [model.featherstitch_eg enumerateObjectsUsingBlock:^(PUBContactFeatherstitchEgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(obj.skeeter_eg == model.megrim_eg.featherstitch_eg){
                strongSelf.selectLabel.text = NotNull(obj.rhodo_eg);
                *stop = YES;
            }
        }];
    }
    
    
    self.nameLabel.text = [PUBTools isBlankString:model.megrim_eg.rhodo_eg] ? @"name" : NotNull(model.megrim_eg.rhodo_eg);
    self.nameLabel.font = [PUBTools isBlankString:model.megrim_eg.rhodo_eg] ? FONT(14.f) : FONT_Semibold(14.f);
    self.nameLabel.textColor = [PUBTools isBlankString:model.megrim_eg.rhodo_eg] ? [UIColor qmui_colorWithHexString:@"#B4B8C7"] : [UIColor whiteColor];
    
    self.phoneLabel.text = [PUBTools isBlankString:model.megrim_eg.xat_eg] ? @"Phone Number" : NotNull(model.megrim_eg.xat_eg);
    self.phoneLabel.font = [PUBTools isBlankString:model.megrim_eg.xat_eg] ? FONT(14.f) : FONT_Semibold(14.f);
    self.phoneLabel.textColor = [PUBTools isBlankString:model.megrim_eg.xat_eg] ? [UIColor qmui_colorWithHexString:@"#B4B8C7"] : [UIColor whiteColor];
    
}
- (void)elationshipViewCkick
{
    if(self.relationshipViewBlock){
        self.relationshipViewBlock();
    }
}

- (void)contanctViewCkick
{
    if(self.contactViewBlock){
        self.contactViewBlock();
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFames];
    }
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.topLineView];
    [self.backView addSubview:self.relationshipView];
    [self.relationshipView addSubview:self.relationshipLabel];
    [self.relationshipView addSubview:self.arrowImageView];
    [self.relationshipView addSubview:self.selectLabel];
    [self.backView addSubview:self.bottmeLineView];
    [self.backView addSubview:self.contanctView];
    [self.contanctView addSubview:self.nameLabel];
    [self.contanctView addSubview:self.phoneLabel];
    [self.contanctView addSubview:self.contanctLogImageView];
    
    UITapGestureRecognizer *relationshipViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elationshipViewCkick)];
    [self.relationshipView addGestureRecognizer:relationshipViewTap];
    
    UITapGestureRecognizer *contanctViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contanctViewCkick)];
    [self.contanctView addGestureRecognizer:contanctViewTap];
}

- (void)initSubFames
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(24.f);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(142.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(12.f);
        make.height.mas_equalTo(19.f);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.right.mas_equalTo(-14.f);
        make.top.mas_equalTo(36.f);
        make.height.mas_equalTo(1.f);
    }];
    
    
    [self.relationshipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topLineView.mas_bottom);
        make.height.mas_equalTo(36.f);
    }];
    
    [self.relationshipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14.f);
        make.centerY.mas_equalTo(2.f);
        make.size.mas_equalTo(CGSizeMake(18.f, 18.f));
    }];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImageView.mas_left).offset(-14.f);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.bottmeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.right.mas_equalTo(-14.f);
        make.top.mas_equalTo(self.relationshipView.mas_bottom);
        make.height.mas_equalTo(1.f);
    }];
    
    
    [self.contanctView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottmeLineView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14.f);
        make.top.mas_equalTo(7.f);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8.f);
    }];
    
    [self.contanctLogImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-17.f);
        make.right.mas_equalTo(-17.f);
        make.size.mas_equalTo(CGSizeMake(17.f, 14.f));
    }];
}

#pragma mark - lazy
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] qmui_initWithSize:CGSizeMake(KSCREEN_WIDTH - 20.f, 146.f)];
        _backView.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF" ] colorWithAlphaComponent:0.12f];
        [_backView showRadius:12.f];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT(17.f) textColor:[UIColor qmui_colorWithHexString:@"#00FFD7"]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIView *)topLineView{
    if(!_topLineView){
        _topLineView = [[UIView alloc] qmui_initWithSize:CGSizeZero];
        _topLineView.backgroundColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
        _topLineView.alpha = 0.05f;
    }
    return _topLineView;
}

- (UIView *)relationshipView{
    if(!_relationshipView){
        _relationshipView = [[UIView alloc] qmui_initWithSize:CGSizeZero];
        _relationshipView.backgroundColor = [UIColor clearColor];
    }
    return _relationshipView;
}

- (UILabel *)relationshipLabel{
    if(!_relationshipLabel){
        _relationshipLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _relationshipLabel.text = @"Relationship";
        _relationshipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _relationshipLabel;
}

- (UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_down_row"]];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}

- (UILabel *)selectLabel{
    if(!_selectLabel){
        _selectLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(14.f) textColor:[UIColor whiteColor]];
        _selectLabel.textAlignment = NSTextAlignmentRight;
    }
    return _selectLabel;
}

- (UIView *)bottmeLineView{
    if(!_bottmeLineView){
        _bottmeLineView = [[UIView alloc] init];
        _bottmeLineView.backgroundColor = [UIColor qmui_colorWithHexString:@"#FFFFFF"];
        _bottmeLineView.alpha = 0.05f;
    }
    return _bottmeLineView;
}

- (UIView *)contanctView{
    if(!_contanctView){
        _contanctView = [[UIView alloc] init];
        _contanctView.backgroundColor = [UIColor clearColor];
    }
    return _contanctView;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    if(!_phoneLabel){
        _phoneLabel = [[UILabel alloc] qmui_initWithFont:FONT(14.f) textColor:[UIColor qmui_colorWithHexString:@"#B4B8C7"]];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _phoneLabel;
}

- (UIImageView *)contanctLogImageView{
    if(!_contanctLogImageView){
        _contanctLogImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_contact_log"]];
        _contanctLogImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _contanctLogImageView;
}

@end
