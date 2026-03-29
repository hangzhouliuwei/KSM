//
//  PPUserDefaultViewInfoCell.m
// FIexiLend
//
//  Created by jacky on 2024/11/15.
//

#import "PPUserDefaultViewInfoCell.h"

@interface PPUserDefaultViewInfoCell ()

@property (nonatomic, strong) UILabel *titleValueLabel;
@property (nonatomic, strong) UIImageView *icon;

@end

@implementation PPUserDefaultViewInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, 0, SafeWidth - 110, 40)];
        _titleValueLabel.textColor = TextBlackColor;
        _titleValueLabel.font = Font(12);
        _titleValueLabel.numberOfLines = 0;
        _titleValueLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleValueLabel];

        _text = [[UITextField alloc] initWithFrame:CGRectMake(_titleValueLabel.right - 200, 0, 288, 40)];
        _text.font = Font(12);
        _text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _text.clearButtonMode = UITextFieldViewModeWhileEditing;
        _text.enabled = NO;
        _text.textColor = UIColor.blackColor;
        _text.textAlignment = NSTextAlignmentRight;

        [self.contentView addSubview:_text];
        _text.borderStyle = UITextBorderStyleNone;

        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 30, 12, 16, 16)];
        _icon.image = ImageWithName(@"arrow_bot");
        [self.contentView addSubview:_icon];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, 40, SafeWidth, 1)];
        line.backgroundColor = LineGrayColor;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(NSDictionary *)dic {
    _titleValueLabel.text = dic[p_title];
    
    NSString *subtitlestring =  dic[p_subtitle];
    NSString *catestring = dic[p_cate];
    NSString *codeString = dic[p_code];
    _text.placeholder = notNull(subtitlestring);
    
    if ([catestring isEqualToString:p_enum]) {
        NSString *selectType = self.needSaveDicData[codeString];
        NSArray *noteList = dic[p_note];
        for (NSDictionary *noteInfo in noteList) {
            NSString *name = noteInfo[p_name];
            NSString *type = [noteInfo[p_type] stringValue];
            if ([selectType isEqualToString:type]) {
                _text.text = notNull(name);
            }
        }
    }else if ([catestring isEqualToString:p_day]) {
        _text.text = self.needSaveDicData[codeString];
    }
}

@end
