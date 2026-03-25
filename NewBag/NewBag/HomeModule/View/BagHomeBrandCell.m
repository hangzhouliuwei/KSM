//
//  BagHomeBrandCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeBrandCell.h"
#import <YYText.h>

@interface BagHomeBrandCell ()
@property (weak, nonatomic) IBOutlet YYLabel *protocolLabel;

@end

@implementation BagHomeBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BagHomeBrandCell.class) owner:nil options:nil] lastObject];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"Click to view the Privacy Agreement>>"];
    attr.yy_font = [UIFont systemFontOfSize:11];
    attr.yy_color = [UIColor qmui_colorWithHexString:@"#ACACAC"];
    NSRange userRange = [attr.string rangeOfString:@"Click to view the"];
    [attr yy_setTextHighlightRange:userRange
                             color:[UIColor qmui_colorWithHexString:@"#666666"]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        if (self.protocolClick) {
            self.protocolClick();
        }
    }];
    NSRange praviRange = [attr.string rangeOfString:@"Privacy Agreement>>"];

    [attr yy_setTextHighlightRange:praviRange
                             color:[UIColor qmui_colorWithHexString:@"#205EAB"]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        if (self.protocolClick) {
            self.protocolClick();
        }
    }];
    [attr yy_setAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:praviRange];
    
    self.protocolLabel.attributedText = attr;
    self.protocolLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.protocolLabel.textAlignment = NSTextAlignmentLeft;
}

@end
