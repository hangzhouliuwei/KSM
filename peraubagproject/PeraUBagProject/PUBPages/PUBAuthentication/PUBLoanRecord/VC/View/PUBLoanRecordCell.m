//
//  PUBLoanRecordCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBLoanRecordCell.h"
#import "PUBProductDetailModel.h"

@interface PUBLoanRecordCell()
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIImageView *iocnImageView;
@property(nonatomic, strong) UILabel *titlLabel;
@property(nonatomic, strong) UILabel *tipLabel;
@end

@implementation PUBLoanRecordCell

- (void)configModel:(PUBVerifyItemModel*)model
{
    self.titlLabel.text = NotNull(model.neanderthaloid_eg);
    [self.iocnImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.keten_eg)]];
    self.tipLabel.text = model.vertebration_eg ? @"verified" : @"to fill in >";
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}


- (void)initSubViews
{
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.iocnImageView];
    [self.backView addSubview:self.titlLabel];
    [self.backView addSubview:self.tipLabel];
}

-(void)initSubFrames
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(162.f *WScale, 130.f));
    }];
    [self.iocnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(16.f);
        make.height.mas_equalTo(48.f);
        make.width.mas_equalTo(48.f);
    }];
    
    [self.titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.f);
        make.centerX.mas_equalTo(self.iocnImageView.mas_centerX);
        make.top.mas_equalTo(self.iocnImageView.mas_bottom).offset(12.f);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14.f);
        make.centerX.mas_equalTo(self.titlLabel.mas_centerX);
        make.top.mas_equalTo(self.titlLabel.mas_bottom).offset(4.f);
    }];
}

#pragma mark - lazy
-(UIView *)backView{
    if(!_backView){
        _backView = [[UIView alloc] qmui_initWithSize:CGSizeMake(162.f *WScale, 140.f)];
        _backView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [_backView showRadius:24.f];
    }
    return _backView;
    
}

- (UIImageView *)iocnImageView{
    if(!_iocnImageView){
        _iocnImageView = [[UIImageView alloc] init];
        _iocnImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _iocnImageView;
}
-(UILabel *)titlLabel{
    if(!_titlLabel){
        _titlLabel = [[UILabel alloc] qmui_initWithFont:FONT_Semibold(14.f) textColor:[UIColor whiteColor]];
        _titlLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlLabel;
}

- (UILabel *)tipLabel{
    if(!_tipLabel){
        _tipLabel = [[UILabel alloc] qmui_initWithFont:FONT(12.f) textColor:[UIColor qmui_colorWithHexString:@"#00FFD7"]];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end
