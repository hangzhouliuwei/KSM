//
//  EmailAlertListCell.m
//  DailyLoan
//
//  Created by gqshHD on 2023/9/1.
//

#import "PTVerifyEmailAlertListCell.h"

@interface PTVerifyEmailAlertListCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation PTVerifyEmailAlertListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.textColor = [UIColor qmui_colorWithHexString:@"#000000"];
    self.titleLab.font = [UIFont systemFontOfSize:12];
}


- (void)configtile:(NSString*)title indx:(NSInteger)indx isSelect:(BOOL)select
{
    self.titleLab.text = title;
    self.bgView.backgroundColor = [UIColor clearColor];

//    self.bgView.backgroundColor = select ? RGBA(202, 251, 108, 0.40) : [UIColor clearColor];
}

@end
