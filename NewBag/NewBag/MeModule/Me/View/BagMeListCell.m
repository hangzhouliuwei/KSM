//
//  BagMeListCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import "BagMeListCell.h"

@interface BagMeListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BagMeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)updateUIWithTitle:(NSString *)title iconUrl:(NSString *)url
{
    self.titleLabel.text = title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage qmui_imageWithColor:[UIColor whiteColor]]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
