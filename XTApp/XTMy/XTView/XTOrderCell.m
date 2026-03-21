//
//  XTOrderCell.m
//  XTApp
//
//  Created by xia on 2024/9/13.
//

#import "XTOrderCell.h"
#import "XTOrderModel.h"

@interface XTOrderCell()

@property(nonatomic,weak) UIView *view;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIButton *stateBtn;
@property(nonatomic,strong) UIView *priceView;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *priceSubLab;
@property(nonatomic,strong) UIView *dateView;
@property(nonatomic,strong) UILabel *dateLab;
@property(nonatomic,strong) UILabel *dateSubLab;
@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation XTOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    UIView *view = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
//    view.clipsToBounds = YES;
    view.layer.cornerRadius = 12;
    view.layer.shadowColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:238/255.0 alpha:0.4000].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 4;
    [self.contentView addSubview:view];
    self.view = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(22);
        make.bottom.equalTo(self.contentView.mas_bottom).priorityHigh();
    }];
    
    UIView *bgView = [UIView xt_frame:CGRectZero color:[UIColor clearColor]];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 12;
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(view);
    }];
    [bgView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xffffff, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.48) size:CGSizeMake(XT_Screen_Width - 30, 210)]];
    
    [view addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(view.mas_left).offset(8);
        make.top.equalTo(view.mas_top).offset(16);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    
    [view addSubview:self.stateBtn];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(view.mas_right).offset(-9);
        make.top.equalTo(view.mas_top).offset(16);
        make.height.mas_equalTo(24);
    }];
    
    [view addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.icon.mas_right).offset(8);
        make.right.lessThanOrEqualTo(self.stateBtn.mas_left).offset(-5);
        make.centerY.equalTo(self.icon);
    }];
    
    [view addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(view.mas_left);
        make.top.equalTo(self.icon.mas_bottom).offset(16);
        make.width.equalTo(view.mas_width).multipliedBy(0.5f);
        make.height.mas_equalTo(80);
    }];
    
    [self.priceView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.priceView);
        make.top.equalTo(self.priceView.mas_top).offset(12);
        make.height.mas_equalTo(26);
    }];
    
    [self.priceView addSubview:self.priceSubLab];
    [self.priceSubLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.priceLab);
        make.top.equalTo(self.priceLab.mas_bottom).offset(4);
        make.height.mas_equalTo(26);
    }];

    
    
    [view addSubview:self.dateView];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(view.mas_right);
        make.top.bottom.equalTo(self.priceView);
        make.width.equalTo(view.mas_width).multipliedBy(0.5f);
    }];
    
    [self.dateView addSubview:self.dateLab];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.dateView);
        make.top.equalTo(self.dateView.mas_top).offset(12);
        make.height.mas_equalTo(26);
    }];
    
    [self.dateView addSubview:self.dateSubLab];
    [self.dateSubLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.dateLab);
        make.top.equalTo(self.dateLab.mas_bottom).offset(4);
        make.height.mas_equalTo(26);
    }];
    
    [view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(view.mas_left).offset(25);
        make.right.equalTo(view.mas_right).offset(-25);
        make.top.equalTo(self.priceView.mas_bottom).offset(6);
        make.bottom.equalTo(view.mas_bottom).offset(-20).priorityHigh();
        make.height.mas_equalTo(50);
    }];
    
}

- (void)setModel:(XTOrderModel *)model {
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.xt_productLogo] placeholderImage:XT_Img(@"xt_img_def")];
    self.nameLab.text = model.xt_productName;
    if([NSString xt_isEmpty:model.xt_orderStatusDesc]) {
        self.stateBtn.hidden = YES;
    }
    else {
        self.stateBtn.hidden = NO;
        [self.stateBtn setTitle:model.xt_orderStatusDesc forState:UIControlStateNormal];
        [self.stateBtn setTitleColor:model.xt_orderStatusColor.xt_hexColor forState:UIControlStateNormal];
    }
    self.priceLab.text = model.xt_orderAmount;
    
    if([NSString xt_isEmpty:model.xt_repayTime]) {
        self.dateView.hidden = YES;
        [self.priceView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.icon.mas_bottom).offset(16);
            make.width.equalTo(self.view);
            make.height.mas_equalTo(80);
        }];
    }
    else{
        self.dateView.hidden = NO;
        self.dateLab.text = model.xt_repayTime;
        [self.priceView mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.icon.mas_bottom).offset(16);
            make.width.equalTo(self.view.mas_width).multipliedBy(0.5f);
            make.height.mas_equalTo(80);
        }];
    }
    
    if([NSString xt_isEmpty:model.xt_buttonText]) {
        self.submitBtn.hidden = YES;
        [self.submitBtn mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).offset(25);
            make.right.equalTo(self.view.mas_right).offset(-25);
            make.top.equalTo(self.priceView.mas_bottom).offset(-50);
            make.bottom.equalTo(self.view.mas_bottom).offset(-16).priorityHigh();
            make.height.mas_equalTo(50);
        }];
    }
    else{
        self.submitBtn.hidden = NO;
        [self.submitBtn mas_remakeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).offset(25);
            make.right.equalTo(self.view.mas_right).offset(-25);
            make.top.equalTo(self.priceView.mas_bottom).offset(6);
            make.bottom.equalTo(self.view.mas_bottom).offset(-20).priorityHigh();
            make.height.mas_equalTo(50);
        }];
        [self.submitBtn setTitle:model.xt_buttonText forState:UIControlStateNormal];
        self.submitBtn.backgroundColor = model.xt_buttonBackground.xt_hexColor;
    }
    
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

- (UIButton *)stateBtn {
    if(!_stateBtn) {
        _stateBtn = [UIButton xt_btn:@"" font:XT_Font_M(12) textColor:XT_RGB(0xE83B30, 1.0f) cornerRadius:6 tag:0];
        _stateBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        _stateBtn.backgroundColor = [UIColor whiteColor];
        _stateBtn.userInteractionEnabled = NO;
    }
    return _stateBtn;
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(20) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}

- (UIView *)priceView {
    if(!_priceView) {
        _priceView = [UIView new];
    }
    return _priceView;
}

- (UILabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_B(22) textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter tag:0];
    }
    return _priceLab;
}

- (UILabel *)priceSubLab {
    if(!_priceSubLab) {
        _priceSubLab = [UILabel xt_lab:CGRectZero text:@"Loan amount" font:XT_Font(15) textColor:XT_RGB(0x676A69, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _priceSubLab;
}

- (UIView *)dateView {
    if(!_dateView) {
        _dateView = [UIView new];
    }
    return _dateView;
}

- (UILabel *)dateLab {
    if(!_dateLab) {
        _dateLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(17) textColor:XT_RGB(0x676A69, 1.0f) alignment:NSTextAlignmentCenter tag:0];
    }
    return _dateLab;
}

- (UILabel *)dateSubLab {
    if(!_dateSubLab) {
        _dateSubLab = [UILabel xt_lab:CGRectZero text:@"Repayment date" font:XT_Font(15) textColor:XT_RGB(0x676A69, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _dateSubLab;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"" font:XT_Font_M(20) textColor:[UIColor whiteColor] cornerRadius:25 tag:0];
        _submitBtn.userInteractionEnabled = NO;
    }
    return _submitBtn;
}

@end
