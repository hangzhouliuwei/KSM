//
//  EmailAlertListCell.m
//  DailyLoan
//
//  Created by gqshHD on 2023/9/1.
//

#import "EmailAlertListCell.h"

@interface EmailAlertListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation EmailAlertListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    self.titleLab.textColor = [UIColor qmui_colorWithHexString:@"#212121"];
    self.titleLab.font = [UIFont systemFontOfSize:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configtile:(NSString*)title indx:(NSInteger)indx
{
    self.titleLab.text = title;
}

@end
