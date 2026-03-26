//
//  XTPhotoCell.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTPhotoCell.h"
#import "XTPhotoModel.h"

@interface XTPhotoCell()

@property(nonatomic,strong) UILabel *titLab;
@property(nonatomic,strong) UITextField *nameTextField;
@property(nonatomic,weak) UIButton *selectBtn;
@property(nonatomic,strong) UIImageView *cardBGImg;
@property(nonatomic,strong) UIImageView *cardImg;
@property(nonatomic,strong) UIButton *cardBtn;

@end

@implementation XTPhotoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xtUI];
    }
    return self;
}

-(void)xtUI {
    UIView *view = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
    view.layer.shadowColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:0.4600].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 4;
    view.layer.cornerRadius = 10;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@325);
    }];
    UIView *bgView = [UIView xt_frame:CGRectMake(0, 0, XT_Screen_Width - 30, 325) color:[UIColor whiteColor]];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 10;
    [bgView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.22) size:bgView.size]];
    [view addSubview:bgView];
    
    [view addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.top.equalTo(view.mas_top).offset(14);
        make.height.equalTo(@21);
    }];
    
    UILabel *subLab = [UILabel xt_lab:CGRectZero text:@"Select iD Type" font:XT_Font_M(12) textColor:XT_RGB(0x81838E, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    [view addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.top.equalTo(self.titLab.mas_bottom).offset(6);
        make.height.equalTo(@16);
    }];
    
    UIImageView *accImg = [UIImageView xt_img:@"xt_cell_acc_down" tag:0];
    [view addSubview:accImg];
    
    [view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(accImg.mas_left).offset(-5);
        make.top.equalTo(subLab.mas_bottom).offset(2);
        make.height.equalTo(@17);
    }];
    
    [accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-18);
        make.centerY.equalTo(self.nameTextField);
    }];
    
    UIView *lineView = [UIView xt_frame:CGRectZero color:XT_RGB(0xEFEDED, 1.0f)];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(view.mas_right).offset(-18);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(2);
        make.height.equalTo(@1);
    }];
    
    UIButton *selectBtn = [UIButton new];
    [view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(view.mas_right).offset(-18);
        make.top.equalTo(subLab.mas_top);
        make.bottom.equalTo(lineView.mas_bottom);
    }];
    self.selectBtn = selectBtn;
    @weakify(self)
    selectBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if(self.block) {
            self.block(^(NSDictionary *dic) {
                @strongify(self)
                self.model.xt_name = dic[@"name"];
                self.model.value = dic[@"value"];
                self.nameTextField.text = self.model.xt_name;
                NSString *url = dic[@"url"];
                [self.cardImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:XT_Img(@"xt_verify_card_logo")];
            });
        }
        return [RACSignal empty];
    }];
    
    [view addSubview:self.cardBGImg];
    [self.cardBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(view.mas_right).offset(-20);
        make.top.equalTo(lineView.mas_bottom).offset(27);
        make.height.equalTo(@168);
    }];
    [view addSubview:self.cardImg];
    [self.cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.cardBGImg);
        make.size.mas_equalTo(CGSizeMake(260, 141));
    }];
    
    [view addSubview:self.cardBtn];
    [self.cardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.cardBGImg);
        make.size.mas_equalTo(self.cardBGImg);
    }];
}

- (void)setModel:(XTPhotoModel *)model {
    _model = model;
    if(![NSString xt_isEmpty:model.xt_relation_id]) {
        self.selectBtn.userInteractionEnabled = NO;
        self.cardBtn.userInteractionEnabled = NO;
        self.nameTextField.text = model.xt_name;
        if([NSString xt_isValidateUrl:model.xt_img]){
            [self.cardImg sd_setImageWithURL:[NSURL URLWithString:model.xt_img]];
        }
        else if(![NSString xt_isEmpty:model.xt_img]) {
            self.cardImg.image = [UIImage imageWithContentsOfFile:model.xt_img];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titLab {
    if(!_titLab) {
        _titLab = [UILabel xt_lab:CGRectZero text:@"Upload your lD" font:XT_Font_SD(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _titLab;
}

- (UITextField *)nameTextField {
    if(!_nameTextField) {
        _nameTextField = [UITextField xt_textField:NO placeholder:@"Please Select" font:XT_Font_M(12) textColor:[UIColor blackColor] withdelegate:self];
        _nameTextField.userInteractionEnabled = NO;
    }
    return _nameTextField;
}

- (UIImageView *)cardBGImg {
    if(!_cardBGImg) {
        _cardBGImg = [UIImageView xt_img:@"xt_verify_card_bg" tag:0];
    }
    return _cardBGImg;
}
    
- (UIImageView *)cardImg {
    if(!_cardImg) {
        _cardImg = [UIImageView xt_img:@"xt_verify_card_logo" tag:0];
        _cardImg.contentMode = UIViewContentModeScaleAspectFill;
        _cardImg.clipsToBounds = YES;
    }
    return _cardImg;
}

- (UIButton *)cardBtn {
    if(!_cardBtn) {
        _cardBtn = [UIButton new];
        @weakify(self)
        _cardBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if([NSString xt_isEmpty:self.model.value]) {
                [self.selectBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
                return [RACSignal empty];
            }
            if(self.photoBlock){
                self.photoBlock();
            }
            return [RACSignal empty];
        }];
    }
    return _cardBtn;
}

@end
