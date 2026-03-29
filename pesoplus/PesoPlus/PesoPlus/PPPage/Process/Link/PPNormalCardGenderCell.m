//
//  PPNormalCardGenderCell.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPNormalCardGenderCell.h"
#import "PPIconTitleButtonView.h"

@interface PPNormalCardGenderCell ()

@property (nonatomic, strong) UILabel *titleValue;
@property (nonatomic, copy) NSString *selectValue;
@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, strong) PPIconTitleButtonView *maleIcon;
@property (nonatomic, strong) PPIconTitleButtonView *femaleIcon;


@end

@implementation PPNormalCardGenderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleValue = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, SafeWidth, 40)];
        _titleValue.textColor = TextBlackColor;
        _titleValue.font = FontBold(12);
        _titleValue.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleValue];
        
        _maleIcon = [[PPIconTitleButtonView alloc] initWithFrame:CGRectMake(ScreenWidth - 10 - 160, 0, 80, 40) title:@" Male" color:rgba(170, 208, 255, 1) font:14 icon:@"gender_unselected"];
        _maleIcon.titleLabel.font = FontBold(14);
        [_maleIcon setTitleColor:TextBlackColor forState:UIControlStateSelected];
        [_maleIcon setImage:ImageWithName(@"gender_selected") forState:UIControlStateSelected];
        [_maleIcon addTarget:self action:@selector(maleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_maleIcon];
        
        
        _femaleIcon = [[PPIconTitleButtonView alloc] initWithFrame:CGRectMake(ScreenWidth - 10 - 80, 0, 80, 40) title:@" Female" color:rgba(170, 208, 255, 1) font:14 icon:@"gender_unselected"];
        _femaleIcon.titleLabel.font = FontBold(14);
        [_femaleIcon setTitleColor:TextBlackColor forState:UIControlStateSelected];
        [_femaleIcon setImage:ImageWithName(@"gender_selected") forState:UIControlStateSelected];
        [_femaleIcon addTarget:self action:@selector(femaleClick:) forControlEvents:UIControlEventTouchUpInside];
        _femaleIcon.type = HaoBtnType1;
        [self.contentView addSubview:_femaleIcon];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 40, ScreenWidth - LeftMargin, 0.8)];
        line.backgroundColor = LineGrayColor;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(NSDictionary *)dic {
    _dic = dic;
    _titleValue.text = dic[p_title];
    NSString *code = dic[p_code];
    _selectValue = [self.needSaveDicData[code] stringValue];
    [self refreshUI];
}



- (void)refreshUI {
    if ([_selectValue isEqualToString:@"1"]) {
        _femaleIcon.selected = NO;

        _maleIcon.selected = YES;
    }else if ([_selectValue isEqualToString:@"2"]) {
        _maleIcon.selected = NO;
        _femaleIcon.selected = YES;
    }else {
        _femaleIcon.selected = NO;
        _maleIcon.selected = NO;

    }
}

- (void)maleClick:(UIButton *)sender {
    _selectValue = @"1";
    _needSaveDicData[_dic[p_code]] = _selectValue;
    [self refreshUI];
}

- (void)femaleClick:(UIButton *)sender {
    _selectValue = @"2";
    _needSaveDicData[_dic[p_code]] = _selectValue;
    [self refreshUI];
}
@end
