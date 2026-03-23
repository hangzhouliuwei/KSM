//
//  XTSelectViewCell.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTSelectViewCell.h"
#import "XTNoteModel.h"

@interface XTSelectViewCell()

@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIView *bgView;

@end

@implementation XTSelectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)setModel:(XTNoteModel *)model {
    _model = model;
    self.nameLab.text = model.xt_name;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if(isSelect) {
        self.bgView.hidden = NO;
        self.nameLab.textColor = [UIColor blackColor];
    }
    else {
        self.bgView.hidden = YES;
        self.nameLab.textColor = XT_RGB(0xD8D8D8, 1.0f);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(18) textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter tag:0];
    }
    return _nameLab;
}

- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [UIView xt_frame:CGRectMake(15, 0, XT_Screen_Width - 30, 42) color:[UIColor whiteColor]];
        _bgView.hidden = YES;
        [_bgView.layer addSublayer:[UIView xt_layer:@[(__bridge id)XT_RGB(0x0BB559, 1.0f).CGColor,(__bridge id)[UIColor whiteColor].CGColor] locations:@[@0,@1.0f] startPoint:CGPointMake(0.04, 0.5) endPoint:CGPointMake(1, 0.5) size:_bgView.size]];
    }
    return _bgView;
}

@end
