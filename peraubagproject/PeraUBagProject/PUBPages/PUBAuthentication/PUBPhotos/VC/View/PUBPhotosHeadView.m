//
//  PUBPhotosHeadView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import "PUBPhotosHeadView.h"
#import "PUBPhotosModel.h"

@interface PUBPhotosHeadView()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *selsectView;
@property(nonatomic, strong) UILabel *selsectTipLabel;
@property(nonatomic, strong) UIImageView *selsectImageView;
@property(nonatomic, strong) UIImageView *idCardImageView;
@property(nonatomic, strong) UIImageView *cameraImageView;
@end

@implementation PUBPhotosHeadView

- (void)updataIDcardImage:(UIImage*)IDcardImage
{
    if(IDcardImage){
        self.idCardImageView.image = IDcardImage;
        self.cameraImageView.hidden = YES;
    }
    
}

- (void)updataIDcardImageUrl:(NSString*)imageUrl
{
    if([PUBTools isBlankString:imageUrl])return;
    [self.idCardImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(imageUrl)] placeholderImage:[UIImage imageNamed:@"pub_photos_idCardBack"]];
    self.cameraImageView.hidden = YES;
}

- (void)updataModel:(PUBPhotosHorrificEgModel*)model
{
    [self.idCardImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.financial_eg)] placeholderImage:[UIImage imageNamed:@"pub_photos_idCardBack"]];
    
    self.selsectTipLabel.text = NotNull(model.trebly_eg);
    self.selsectTipLabel.font = [PUBTools isBlankString:model.trebly_eg] ? FONT(13.f) : FONT_Semibold(16.f);
    self.selsecGrocer_eg = model.grocer_eg;
}

-(void)selsectViewClick
{
    if(self.selsecTypeBlock && !self.cameraImageView.hidden){
        self.selsecTypeBlock();
    }
}

- (void)idCardImageViewClick
{
    if(self.idCardImageClickBlock && !self.cameraImageView.hidden){
        self.idCardImageClickBlock();
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}

- (void)initSubViews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.selsectView];
    [self.selsectView addSubview:self.selsectTipLabel];
    [self.selsectView addSubview:self.selsectImageView];
    [self addSubview:self.idCardImageView];
    [self.idCardImageView addSubview:self.cameraImageView];
    
    UITapGestureRecognizer *selsectViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selsectViewClick)];
    [self.selsectView addGestureRecognizer:selsectViewtap];
    
    UITapGestureRecognizer *idCardImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idCardImageViewClick)];
    [self.idCardImageView addGestureRecognizer:idCardImageViewTap];
}

- (void)initSubFrames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(6.f);
    }];
    
    
    [self.selsectView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15.f);
        make.height.mas_equalTo(40.f);
    }];
    
    [self.selsectTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(33.f);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.selsectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20.f, 20.f));
    }];
    
    [self.idCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(32.f);
        make.top.mas_equalTo(self.selsectView.mas_bottom).offset(10.f);
        make.width.mas_equalTo(KSCREEN_WIDTH - 64.f);
        make.height.mas_equalTo(210.f);
    }];
    
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.height.width.mas_equalTo(78.f);
    }];
    
    
}

#pragma mark - lazy

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_MED_SIZE(12.f) textColor:[UIColor qmui_colorWithHexString:@"#01FED7"]];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"Upload your ID";
    }
    
    return _titleLabel;
}

- (UIView *)selsectView{
    if(!_selsectView){
        _selsectView = [[UIView alloc] init];
        [_selsectView showRadius:12.f];
        _selsectView.backgroundColor = [[UIColor qmui_colorWithHexString:@"#FFFFFF" ] colorWithAlphaComponent:0.12f];
    }
    return _selsectView;
}

-(UILabel *)selsectTipLabel{
    if(!_selsectTipLabel){
        _selsectTipLabel = [[UILabel alloc] qmui_initWithFont:FONT(13.f) textColor:[UIColor whiteColor]];
        _selsectTipLabel.textAlignment = NSTextAlignmentLeft;
        _selsectTipLabel.text = @"Select An ID Type";
    }
    return _selsectTipLabel;
}

- (UIImageView *)selsectImageView{
    if(!_selsectImageView){
        _selsectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_baisc_down_row"]];
        _selsectImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _selsectImageView;
}

- (UIImageView *)idCardImageView{
    if(!_idCardImageView){
        _idCardImageView = [[UIImageView alloc] init];
        _idCardImageView.contentMode = UIViewContentModeScaleAspectFill;
        _idCardImageView.image = [UIImage imageNamed:@"pub_photos_idCardBack"];
        _idCardImageView.userInteractionEnabled = YES;
        _idCardImageView.layer.cornerRadius = 14.f;
        _idCardImageView.layer.masksToBounds = YES;
        _idCardImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _idCardImageView;
}

- (UIImageView *)cameraImageView{
    if(!_cameraImageView){
        _cameraImageView = [[UIImageView alloc] init];
        _cameraImageView.contentMode = UIViewContentModeScaleAspectFill;
        _cameraImageView.image = [UIImage imageNamed:@"pub_photos_idcamera"];
        _cameraImageView.userInteractionEnabled = YES;
        
    }
    return _cameraImageView;
}

@end
