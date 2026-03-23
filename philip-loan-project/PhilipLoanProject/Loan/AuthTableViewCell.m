//
//  AuthTableViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import "AuthTableViewCell.h"

@implementation AuthTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kScreenW - 30, 117)];
        self.bgView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.bgView];
        self.backgroundColor = UIColor.clearColor;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, self.bgView.width - 2 * 14, 0)];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333]];
        [self.bgView addSubview:self.titleLabel];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(14, _titleLabel.bottom + 7, _titleLabel.width, 50)];
        self.textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 4;
        [_textField addTarget:self action:@selector(handleTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        [_textField addTarget:self action:@selector(handleTextFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.layer.borderColor = kBlackColor_333333.CGColor;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 1)];
        _textField.leftView = leftView;
        leftView.userInteractionEnabled = YES;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        [self.bgView addSubview:self.textField];
        self.arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textField.height, _textField.height)];
        _arrowView.userInteractionEnabled = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((_arrowView.width - 15) / 2, (_arrowView.width - 15) / 2, 15, 15)];
        imageView.userInteractionEnabled = YES;
        [self.arrowView addSubview:imageView];
        imageView.image = kImageName(@"mine_item_arrow");
        _textField.rightView = _arrowView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        self.coverView = [[UIView alloc] initWithFrame:self.textField.frame];
//        _coverView.backgroundColor = UIColor.purpleColor;
        [self.bgView addSubview:self.coverView];
        [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        
        self.emailView = [[EmailPopView alloc] initWithFrame:CGRectMake(_textField.left, _textField.bottom + 5, _textField.width, 150)];
        self.emailView.hidden = YES;
        [self.bgView addSubview:self.emailView];
        
        self.idImageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 33 + _textField.bottom, self.bgView.width - 56, 176)];
        self.idImageView.image = kImageName(@"auth_id_bg");
        self.idImageView.layer.masksToBounds = self.idImageView.layer.cornerRadius = 12;
        [self.bgView addSubview:self.idImageView];
        
        self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cameraButton.frame = CGRectMake((self.bgView.width - 60) / 2.0, 19 + _idImageView.bottom, 60, 60);
        [self.cameraButton addTarget:self action:@selector(handleCameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.cameraButton.hidden = YES;
        [self.cameraButton setBackgroundImage:kImageName(@"auth_camera") forState:UIControlStateNormal];
        [self.bgView addSubview:self.cameraButton];
        
        self.maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.maleButton.frame = CGRectMake(5, _titleLabel.bottom + 7, 80, 26);
        [self.maleButton setTitle:@"Male" forState:UIControlStateNormal];
        self.maleButton.titleLabel.font = kFontSize(16);
        [self.maleButton setTitleColor:kBlackColor_333333 forState:UIControlStateNormal];
        [self.maleButton addTarget:self action:@selector(genderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *normalImage = [kImageName(@"auth_cert_icon_normal") sd_resizedImageWithSize:CGSizeMake(15, 15) scaleMode:SDImageScaleModeFill];
        UIImage *selectedImage = [kImageName(@"auth_cert_icon_selected") sd_resizedImageWithSize:CGSizeMake(15, 15) scaleMode:SDImageScaleModeFill];
        [self.maleButton setImage:normalImage forState:UIControlStateNormal];
        [self.maleButton setImage:selectedImage forState:UIControlStateSelected];
        [self.bgView addSubview:self.maleButton];
        
        self.femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.femaleButton.frame = CGRectMake(self.bgView.width - 80 - 60, _titleLabel.bottom + 7, 80, 26);
        [self.femaleButton setTitle:@"Female" forState:UIControlStateNormal];
        self.femaleButton.titleLabel.font = kFontSize(16);
        [self.femaleButton setTitleColor:kBlackColor_333333 forState:UIControlStateNormal];
        [self.femaleButton addTarget:self action:@selector(genderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.femaleButton setImage:normalImage forState:UIControlStateNormal];
        [self.femaleButton setImage:selectedImage forState:UIControlStateSelected];
        self.femaleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.maleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.bgView addSubview:self.femaleButton];
    }
    return self;
}
-(void)genderButtonAction:(UIButton *)button
{
    button.selected = true;
    if ([button isEqual:self.maleButton]) {
        self.femaleButton.selected = false;
        self.model.valueStr = _model.tubotwelvedrillNc.firstObject.itlitwelveanizeNc;
    }
    if ([button isEqual:self.femaleButton]) {
        self.maleButton.selected = false;
        self.model.valueStr = _model.tubotwelvedrillNc.lastObject.itlitwelveanizeNc;
    }
}
-(void)handleCameraButtonAction:(UIButton *)button
{
    if (self.tapCameraBlk) {
        self.tapCameraBlk();
    }
}
-(void)handleTextFieldValueChange:(UITextField *)textField
{
    if (self.model.type == kAuthCellType_Email) {
        self.model.showEmail = textField.text.length > 0;
    }
    if (self.editValueChangeBlk) {
        self.editValueChangeBlk(textField.text);
    }
    [self.emailView reloadEmaiViewWithStr:textField.text];
}
-(void)handleTextFieldEndEdit:(UITextField *)textField
{
//    self.model.valueStr = textField.text;
    if (self.editCompletedBlk) {
        self.editCompletedBlk(textField.text);
    }
}
-(void)setModel:(AuthOptionalModel *)model
{
    _model = model;
    if (model.isBankPage) {
        self.bgView.height = model.cellHeight;
        self.emailView.hidden = true;
        self.titleLabel.top = 20;
    }else
    {
        self.titleLabel.top = 0;
        if (model.showEmail) {
            self.bgView.height = model.cellHeightEmail;
            self.emailView.hidden = false;
            [_emailView reloadEmaiViewWithStr:self.textField.text];
            _emailView.top = _textField.bottom + 5;
        }else
        {
            self.bgView.height = model.cellHeight;
            self.emailView.hidden = true;
        }
    }
    self.titleLabel.height = model.labelHeight;
    self.textField.top = self.titleLabel.bottom + 7;
    self.coverView.top = self.titleLabel.bottom + 7;
    if (self.model.showOCR) {
        self.idImageView.hidden = false;
        if (self.model.showCamera) {
            self.cameraButton.hidden = false;
        }else
        {
            self.cameraButton.hidden = true;
        }
    }else
    {
        self.idImageView.hidden = self.cameraButton.hidden = true;
    }
    self.idImageView.top = _textField.bottom + 33;
    self.cameraButton.top = _idImageView.bottom + 19;
    self.titleLabel.text = model.fldgtwelveeNc;
    self.textField.placeholder = model.orintwelvearilyNc;
    NSInteger type = model.techtwelveedNc;
    if (type == 0) {
        _textField.keyboardType = UIKeyboardTypeDefault;
    }else if (type == 1) {
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (model.type == kAuthCellType_TextField || model.type ==kAuthCellType_Email) {
        self.coverView.hidden = true;
        self.textField.hidden = false;
        self.textField.rightViewMode = UITextFieldViewModeNever;
        self.femaleButton.hidden = self.maleButton.hidden = true;
    }else if (model.type != kAuthCellType_Gender)
    {
        self.coverView.hidden = false;
        self.textField.hidden = false;
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.femaleButton.hidden = self.maleButton.hidden = true;
    }else
    {
        self.textField.hidden = YES;
        self.coverView.hidden = YES;
        self.maleButton.top = _titleLabel.bottom + 7;
        self.femaleButton.top = _titleLabel.bottom + 7;
        self.femaleButton.hidden = self.maleButton.hidden = false;
        NSString *str = model.valueStr;
        NSInteger index = -1;
        for (int i = 0; i < model.tubotwelvedrillNc.count; i++) {
            AuthItemModel *itemModel = model.tubotwelvedrillNc[i];
            if (i == 0) {
                [self.maleButton setTitle:itemModel.uportwelvenNc forState:UIControlStateNormal];
            }
            if (i == 1) {
                [self.femaleButton setTitle:itemModel.uportwelvenNc forState:UIControlStateNormal];
            }
            if ([itemModel.itlitwelveanizeNc integerValue] == [str integerValue]) {
                index = i;
            }
        }
        switch (index) {
            case -1:
                self.maleButton.selected = false;
                self.femaleButton.selected = false;
                break;
            case 0:
                self.maleButton.selected = true;
                self.femaleButton.selected = false;
                break;
            case 1:
                self.maleButton.selected = false;
                self.femaleButton.selected = true;
                break;
            default:
                break;
        }
    }
    
    if (model.selectedModel) {
        if (model.showOCR) {
            if (model.captureImage) {
                self.idImageView.image = model.captureImage;
            }else
            {
                if ([model.relotwelveomNc isReal]) {
                    [self.idImageView sd_setImageWithURL:kURL(model.relotwelveomNc)];
                }else
                {
                    [self.idImageView sd_setImageWithURL:kURL(model.selectedModel.ovrptwelveunchNc)];
                }
            }
            self.textField.text = [NSString stringWithFormat:@"%@",model.selectedModel.roantwelveizeNc];
        }else
        {
            self.textField.text = model.selectedModel.uportwelvenNc;
        }
    }else
    {
        if (model.valueStr.length > 0) {
            self.textField.text = model.valueStr;
        }else
        {
            self.textField.text = @"";
        }
    }
    
    if (model.needClip) {
        [self.bgView clipBottomLeftAndBottomRightCornerRadius:12];
    }else
    {
        [self.bgView clipBottomLeftAndBottomRightCornerRadius:0];
    }
}



-(void)tapAction
{
    if (self.tapItemBlk) {
        self.tapItemBlk(self.model.type);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
