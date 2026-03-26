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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#494F5D"];
    self.titleLab.textColor = [UIColor qmui_colorWithHexString:@"#8B8B8B"];
    self.titleLab.font = FONT(12.f);
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
