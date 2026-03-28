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
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation BagMeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)updateUIWithTitle:(NSString *)title iconUrl:(NSString *)url
{
    [self.arrowImageView sd_setImageWithURL:[Util loadImageUrl:@"icon-more-2"]];
    self.titleLabel.text = title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage qmui_imageWithColor:[UIColor whiteColor]]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
