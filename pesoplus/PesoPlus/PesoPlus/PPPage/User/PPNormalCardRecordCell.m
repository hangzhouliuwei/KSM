//
//  PPNormalCardRecordCell.m
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPNormalCardRecordCell.h"

@interface PPNormalCardRecordCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *status;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, copy) NSDictionary *dic;
@end

@implementation PPNormalCardRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BGColor;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 10, SafeWidth, 134 - 10)];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView showAddToRadius:10];
        [self.contentView addSubview:_bgView];
        [_bgView ppAddViewToshowShadow:COLORA(0, 0, 0, 0.1)];
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.w, 40)];
        [_topView showAddToRadius:10];
        [_bgView addSubview:_topView];
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 22, 22)];
        [_icon showAddToRadius:4];
        [_bgView addSubview:_icon];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(_icon.right + 10, 10, (SafeWidth - _icon.right - 10 - 15)/2, 22)];
        _name.textColor = COLORA(51, 51, 51, 1);
        _name.font = FontBold(12);
        _name.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_name];
        
        _status = [[UILabel alloc] initWithFrame:CGRectMake(_name.right, _icon.y, _name.w, _icon.h)];
        _status.textColor = COLORA(51, 51, 51, 1);
        _status.font = Font(12);
        _status.textAlignment = NSTextAlignmentRight;
        _status.numberOfLines = 0;
        [_bgView addSubview:_status];
        
        _midView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, _bgView.w, 65)];
        [_bgView addSubview:_midView];

        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.userInteractionEnabled = NO;
        _selectBtn.frame = CGRectMake(50, _midView.bottom, self.bgView.w - 100, 32);
        _selectBtn.titleLabel.font = FontBold(15);
        [_selectBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_selectBtn showAddToRadius:16];
        _selectBtn.hidden = YES;
        [self.bgView addSubview:_selectBtn];
    }
    return self;
}

- (void)loadData:(NSDictionary *)dic {
    _dic = dic;
    [_icon sd_setImageWithURL:[NSURL URLWithString:dic[p_productLogo]]];
    _name.text = dic[p_productName];
    _status.text = dic[p_orderStatusDesc];
    _status.textColor = [PPUserDefaultColorHelper ppToolsColorFromHex:dic[p_orderStatusColor]];
    _topView.backgroundColor = [PPUserDefaultColorHelper ppToolsColorFromHex:dic[p_orderStatusColor]];
    _topView.alpha = 0.2;
    NSString *repayTime = dic[p_repayTime];
    
    [self.midView removeAllViews];
    
    UILabel *amountDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _bgView.w, 15)];
    amountDesc.textColor = COLORA(102, 102, 102, 1);
    amountDesc.font = Font(12);
    amountDesc.text = @"Loan amount";
    amountDesc.textAlignment = NSTextAlignmentCenter;
    [self.midView addSubview:amountDesc];
    
    UILabel *amount = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, _bgView.w, 38)];
    amount.textColor = [PPUserDefaultColorHelper ppToolsColorFromHex:dic[p_orderStatusColor]];
    amount.font = FontBold(32);
    amount.textAlignment = NSTextAlignmentCenter;
    [self.midView addSubview:amount];

    amount.text = dic[p_orderAmount];

    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.w/2, 22, _bgView.w/2 , 38)];
    if (repayTime.length > 0) {
        amountDesc.w = _bgView.w/2;
        amount.w = _bgView.w/2;
        
        UILabel *dateDesc = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.w/2, 10, _bgView.w/2, 15)];
        dateDesc.textColor = COLORA(102, 102, 102, 1);
        dateDesc.font = Font(12);
        dateDesc.text = @"Repayment date";
        dateDesc.textAlignment = NSTextAlignmentCenter;
        [self.midView addSubview:dateDesc];
        
        date.textColor = [PPUserDefaultColorHelper ppToolsColorFromHex:dic[p_orderStatusColor]];
        date.font = FontBold(24);
        date.text = dic[p_repayTime];
        date.textAlignment = NSTextAlignmentCenter;
        [self.midView addSubview:date];
    }
    _selectBtn.hidden = YES;
    _bgView.h = 106;
    NSString *btnString = dic[@"rsemmanuelCiopjko"];
    if (!isBlankStr(btnString)) {
        _bgView.h = 150;
        _selectBtn.hidden = NO;
        [_selectBtn setTitle:btnString forState:UIControlStateNormal];
        NSString *bgColor = dic[p_buttonBgColor];
        if (bgColor.length > 0) {
            _selectBtn.backgroundColor = [PPUserDefaultColorHelper ppToolsColorFromHex:bgColor];
            amount.textColor = [PPUserDefaultColorHelper ppToolsColorFromHex:bgColor];
            date.textColor = [PPUserDefaultColorHelper ppToolsColorFromHex:bgColor];
        }else {
            _selectBtn.backgroundColor = MainColor;
        }
    }
}


+ (CGFloat)cellHeight:(NSDictionary *)dic {
    NSString *btnString = dic[@"rsemmanuelCiopjko"];
    if (!isBlankStr(btnString)) {
        return 160;
    }else {
        return 116;
    }
}

@end
