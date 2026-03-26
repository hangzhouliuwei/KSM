//
//  AuthContactViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "AuthContactViewCell.h"

@implementation AuthContactViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, kScreenW - 30, 247)];
        _bgView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.bgView];
        self.bgView.layer.cornerRadius = 12;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, 24, 4, 13)];
        lineView.backgroundColor = kBlueColor_0053FF;
        lineView.layer.cornerRadius = 2;
        [self.bgView addSubview:lineView];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 17, self.bgView.width - 40, 25)];
        [self.titleLabel pp_setPropertys:@[kBoldFontSize(18),kBlackColor_333333]];
        [self.bgView addSubview:self.titleLabel];
        self.relationShipLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 12 + self.titleLabel.bottom, self.bgView.width - 28, 22)];
        [self.relationShipLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333,@"Relationship"]];
        [self.bgView addSubview:self.relationShipLabel];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(14, self.relationShipLabel.bottom + 8, _relationShipLabel.width, 50)];
        self.textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 4;
        _textField.layer.borderColor = kBlackColor_333333.CGColor;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 1)];
        _textField.leftView = leftView;
        leftView.userInteractionEnabled = YES;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        [self.bgView addSubview:self.textField];
        UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textField.height, _textField.height)];
        arrowView.userInteractionEnabled = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((arrowView.width - 15) / 2, (arrowView.width - 15) / 2, 15, 15)];
        imageView.userInteractionEnabled = YES;
        [arrowView addSubview:imageView];
        imageView.image = kImageName(@"mine_item_arrow");
        _textField.rightView = arrowView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.placeholder = @"please select";
        UIView *coverView = [[UIView alloc] initWithFrame:self.textField.frame];
        [self.bgView addSubview:coverView];
        [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        
        self.infoView = [[UIView alloc] initWithFrame:CGRectMake(14, 12 + _textField.bottom, self.bgView.width - 24, 81)];
        self.infoView.backgroundColor = kGrayColor_F9F9F9;
        self.infoView.layer.cornerRadius = 8;
        [_infoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInfoViewAction)]];
        [self.bgView addSubview:self.infoView];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, _infoView.width - 32, 23)];
        [_nameLabel pp_setPropertys:@[kBoldFontSize(16),kBlackColor_333333]];
        [self.infoView addSubview:self.nameLabel];
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, 3 + _nameLabel.bottom, _nameLabel.width, 23)];
        [self.numberLabel pp_setPropertys:@[kFontSize(16),kBlackColor_333333]];
        [self.infoView addSubview:self.numberLabel];
        
        self.addButton = [[PLPCapsuleButton alloc] initWithFrame:CGRectMake(self.infoView.width - 85 - 16, 25, 85, 32)];
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        [self.addButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _addButton.userInteractionEnabled = false;
//        [self.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.infoView addSubview:self.addButton];
        
    }
    return self;
}
-(void)tapInfoViewAction
{
    if (self.tapItemBlk) {
        self.tapItemBlk(1);
    }
}
-(void)addButtonAction:(UIButton *)button
{
    if (self.tapItemBlk) {
        self.tapItemBlk(1);
    }
}
-(void)setModel:(AuthContactModel *)model
{
    _model = model;
    self.titleLabel.text = model.fldgtwelveeNc;
    if (model.selectedModel) {
        _textField.text = model.selectedModel.uportwelvenNc;
    }else
    {
        _textField.text = @"";
    }
    self.addButton.hidden = [model.contactName isReal] || [model.contactPhone isReal];
    if ([model.contactName isReal]) {
        self.nameLabel.text = [NSString stringWithFormat:@"Name：%@",model.contactName];
    }else
    {
        self.nameLabel.text = @"Name";
    }
    if ([model.contactPhone isReal]) {
        self.numberLabel.text = [NSString stringWithFormat:@"Phone Number：%@",model.contactPhone];
    }else
    {
        self.numberLabel.text = @"Phone Number";
    }
}
-(void)tapAction
{
    if(self.tapItemBlk) {
        self.tapItemBlk(0);
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
