//
//  BagVerifyPickerCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagVerifyPickerCell.h"
@interface BagVerifyPickerCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end
@implementation BagVerifyPickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
//        [self.bgView addGestureRecognizer:tap];
    }
    return self;
}
- (void)onTap{
    
}
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected
{
    _titleLabel.text = title;
    _titleLabel.textColor = isSelected ? [UIColor br_colorWithHexString:@"#0EB479"] : [UIColor br_colorWithHexString:@"#252E41"];
    if (isSelected) {
        [_bgView br_setBorderType:BRBorderSideTypeAll borderColor:[UIColor qmui_colorWithHexString:@"#0EB479"] borderWidth:1];
        self.arrow.hidden = NO;
    }else{
        [_bgView br_setBorderType:BRBorderSideTypeAll borderColor:[UIColor clearColor] borderWidth:1];
        self.arrow.hidden = YES;

    }
   
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
