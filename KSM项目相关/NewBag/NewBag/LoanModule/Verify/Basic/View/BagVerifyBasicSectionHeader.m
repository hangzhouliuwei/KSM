//
//  BagVerifyBasicSectionHeader.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicSectionHeader.h"

@interface BagVerifyBasicSectionHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@end
@implementation BagVerifyBasicSectionHeader
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.hiddenBtn.hitScale = 3;
}
+ (instancetype)createView{
    BagVerifyBasicSectionHeader *view= [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    [view.hiddenBtn sd_setImageWithURL:[Util loadImageUrl:@"basic_choose_up"] forState:UIControlStateSelected];
    [view.hiddenBtn sd_setImageWithURL:[Util loadImageUrl:@"basic_choose_down"] forState:UIControlStateNormal];
    return view;
}

- (void)updateUIWithTitle:(NSString *)title Subtitle:(NSString*)subtitle more:(BOOL)more isSelected:(BOOL)isSelected
{
    _titleLabel.text = NotNull(title);
    _subTitleLabel.text = subtitle;
    _hiddenBtn.hidden = !more;
    _hiddenBtn.selected = isSelected;
}
- (IBAction)hiddenAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.clickMore) {
        self.clickMore(sender.selected);
    }
}


@end
