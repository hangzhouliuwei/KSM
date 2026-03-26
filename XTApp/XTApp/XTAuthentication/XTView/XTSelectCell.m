//
//  XTSelectCell.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTSelectCell.h"
#import "XTListModel.h"

@interface XTSelectCell()

@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,weak) UIButton *btn;

@end

@implementation XTSelectCell

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
    
    UIImageView *accImg = [UIImageView xt_img:@"xt_cell_acc_down" tag:0];
    [view addSubview:accImg];
    [accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-13);
        make.centerY.equalTo(view);
    }];
    
    [view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(12);
        make.right.equalTo(accImg.mas_left).offset(-5);
        make.centerY.equalTo(view);
        make.height.equalTo(view);
    }];
    
    UIButton *btn = [UIButton new];
    [view addSubview:btn];
    self.btn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    @weakify(self)
    btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if(self.selectBlock){
            self.selectBlock(^(NSDictionary *dic) {
                @strongify(self)
                self.model.name = dic[@"name"];
                self.model.value = dic[@"value"];
                self.textField.text = self.model.name;
            });
        }
        return [RACSignal empty];
    }];
}

- (void)setModel:(XTListModel *)model {
    _model = model;
    self.nameLab.text = model.xt_title;
    self.textField.placeholder = model.xt_subtitle;
    self.textField.text = model.name;
    
}

-(void)becomeFirst {
    [self.btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        _textField.userInteractionEnabled = NO;
    }
    return _textField;
}

@end
