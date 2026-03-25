//
//  XTTextCell.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTTextCell.h"
#import "XTListModel.h"
#import "XTEmailView.h"

@interface XTTextCell()<UITextFieldDelegate>

@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) XTEmailView *emailView;

@end

@implementation XTTextCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

- (void)xt_UI {
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@22);
    }];
    
    UIView *view = [UIView xt_frame:CGRectZero color:[UIColor whiteColor]];
    view.layer.cornerRadius = 12;
    view.layer.shadowColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:0.4600].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,2);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 4;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.nameLab.mas_bottom).offset(3);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
    [view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(12);
        make.right.equalTo(view.mas_right).offset(-12);
        make.centerY.equalTo(view);
        make.height.equalTo(view);
    }];
    
    
}

-(void)becomeFirst{
    [self.textField becomeFirstResponder];
}

- (void)setModel:(XTListModel *)model {
    _model = model;
    self.nameLab.text = model.xt_title;
    self.textField.placeholder = model.xt_subtitle;
    self.textField.text = model.name;
    if([model.xt_code isEqualToString:@"monthly_expenses"]) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if([model.xt_code isEqualToString:@"email"]) {
        self.textField.keyboardType = UIKeyboardTypeEmailAddress;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark textFieldDidChange
- (void)textFieldDidChange:(UITextField *)textField {
    self.model.value = textField.text;
    self.model.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([self.model.xt_code isEqualToString:@"email"]){
        [self.emailView xt_showTextField:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if([self.model.xt_code isEqualToString:@"email"]){
        [self.emailView xt_remove];
    }
    return YES;
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font(12) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}

- (UITextField *)textField {
    if(!_textField) {
        _textField = [UITextField xt_textField:NO placeholder:@"" font:XT_Font(14) textColor:[UIColor blackColor] withdelegate:self];
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (XTEmailView *)emailView {
    if(!_emailView) {
        _emailView = [[XTEmailView alloc] init];
        @weakify(self)
        _emailView.block = ^(NSString *str) {
            @strongify(self)
            [self.textField resignFirstResponder];
            self.textField.text = XT_Object_To_Stirng(str);
            self.model.value = XT_Object_To_Stirng(str);
            self.model.name = XT_Object_To_Stirng(str);
        };
    }
    return _emailView;
}

@end
