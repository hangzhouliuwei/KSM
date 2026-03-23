//
//  XTVerifyContactCell.m
//  XTApp
//
//  Created by xia on 2024/9/9.
//

#import "XTVerifyContactCell.h"
#import "XTContactItemModel.h"

@interface XTVerifyContactCell()

@property(nonatomic,strong) UILabel *titLab;
@property(nonatomic,strong) UILabel *subLab;
@property(nonatomic,strong) UITextField *threeTextField;

@property(nonatomic,strong) UITextField *firstTextField;
@property(nonatomic,strong) UITextField *secondTextField;
@end

@implementation XTVerifyContactCell

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
        make.height.equalTo(@185);
    }];
    UIView *bgView = [UIView xt_frame:CGRectMake(0, 0, XT_Screen_Width - 30, 185) color:[UIColor whiteColor]];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 10;
    [bgView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0xF3FF9B, 1.0f).CGColor,(__bridge id)XT_RGB(0xFFFFFF, 1.0f).CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 0.22) size:bgView.size]];
    [view addSubview:bgView];
    
    [view addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.top.equalTo(view.mas_top).offset(14);
        make.height.equalTo(@22);
    }];
    
    [view addSubview:self.subLab];
    [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.top.equalTo(self.titLab.mas_bottom).offset(6);
        make.height.equalTo(@16);
    }];
    
    UIImageView *accImg = [UIImageView xt_img:@"xt_cell_acc_down" tag:0];
    [view addSubview:accImg];
    
    [view addSubview:self.threeTextField];
    [self.threeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(accImg.mas_left).offset(-5);
        make.top.equalTo(self.subLab.mas_bottom).offset(2);
        make.height.equalTo(@17);
    }];
    
    [accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-18);
        make.centerY.equalTo(self.threeTextField);
    }];
    
    UIView *lineView = [UIView xt_frame:CGRectZero color:XT_RGB(0xEFEDED, 1.0f)];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(view.mas_right).offset(-18);
        make.top.equalTo(self.threeTextField.mas_bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UIButton *selectBtn = [UIButton new];
    [view addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(view.mas_right).offset(-18);
        make.top.equalTo(self.subLab.mas_top);
        make.bottom.equalTo(lineView.mas_bottom);
    }];
    @weakify(self)
    selectBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if(self.block) {
            self.block(^(NSDictionary *dic) {
                @strongify(self)
                self.model.threeName = dic[@"name"];
                self.model.threeValue = dic[@"value"];
                self.threeTextField.text = self.model.threeName;
            });
        }
        return [RACSignal empty];
    }];
    
    UIView *itemView = [UIView xt_frame:CGRectZero color:XT_RGB(0xF7F7F7, 0)];
    [view addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(18);
        make.right.equalTo(view.mas_right).offset(-18);
        make.top.equalTo(lineView.mas_bottom).offset(9);
        make.height.equalTo(@76);
    }];
    
    UIView *line1View = [UIView xt_frame:CGRectZero color:XT_RGB(0xEFEDED, 1.0f)];
    [itemView addSubview:line1View];
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(itemView.mas_left).offset(13);
        make.right.equalTo(itemView.mas_right).offset(-13);
        make.centerY.equalTo(itemView);
        make.height.equalTo(@1);
    }];
    
    [itemView addSubview:self.firstTextField];
    [self.firstTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(itemView.mas_left).offset(13);
        make.right.equalTo(itemView.mas_right).offset(-13);
        make.top.equalTo(itemView.mas_top);
        make.height.equalTo(itemView).multipliedBy(0.5);
    }];
    
    [itemView addSubview:self.secondTextField];
    [self.secondTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(itemView.mas_left).offset(13);
        make.right.equalTo(itemView.mas_right).offset(-13);
        make.bottom.equalTo(itemView.mas_bottom);
        make.height.equalTo(itemView).multipliedBy(0.5);
    }];
    
    UIImageView *contactImg = [UIImageView xt_img:@"xt_verify_contact_btn" tag:0];
    [itemView addSubview:contactImg];
    [contactImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(itemView.mas_right).offset(-11);
        make.top.equalTo(itemView.mas_top).offset(6);
    }];
    
    
    UIButton *btn = [UIButton new];
    [itemView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(itemView);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if(self.contactBlock) {
            self.contactBlock(^(NSDictionary *dic) {
                @strongify(self)
                self.model.firstValue = dic[@"name"];
                self.model.secondValue = dic[@"value"];
                self.firstTextField.text = self.model.firstValue;
                self.secondTextField.text = self.model.secondValue;
            });
        }
        return [RACSignal empty];
    }];
}

- (void)setModel:(XTContactItemModel *)model {
    _model = model;
    self.titLab.text = model.xt_title;
    self.threeTextField.text = model.threeName;
    self.firstTextField.text = model.firstValue;
    self.secondTextField.text = model.secondValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titLab {
    if(!_titLab) {
        _titLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_SD(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _titLab;
}

- (UILabel *)subLab {
    if(!_subLab) {
        _subLab = [UILabel xt_lab:CGRectZero text:@"Relationship" font:XT_Font_M(12) textColor:XT_RGB(0x81838E, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _subLab;
}

- (UITextField *)threeTextField {
    if(!_threeTextField) {
        _threeTextField = [UITextField xt_textField:NO placeholder:@"Please Select" font:XT_Font_M(12) textColor:[UIColor blackColor] withdelegate:self];
        _threeTextField.userInteractionEnabled = NO;
    }
    return _threeTextField;
}

- (UITextField *)firstTextField {
    if(!_firstTextField) {
        _firstTextField = [UITextField xt_textField:NO placeholder:@"Name" font:XT_Font_M(12) textColor:XT_RGB(0x0BB559, 1.0f) withdelegate:self];
        _firstTextField.userInteractionEnabled = NO;
    }
    return _firstTextField;
}

- (UITextField *)secondTextField {
    if(!_secondTextField) {
        _secondTextField = [UITextField xt_textField:NO placeholder:@"Phone Number" font:XT_Font_M(12) textColor:XT_RGB(0x0BB559, 1.0f) withdelegate:self];
        _secondTextField.userInteractionEnabled = NO;
    }
    return _secondTextField;
}

@end
