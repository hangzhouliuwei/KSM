//
//  PUBMineRepaymentCell.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import "PUBMineRepaymentCell.h"

@interface PUBMineRepaymentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *repayDate;

@end
@implementation PUBMineRepaymentCell

- (void)updateUIWithProductName:(NSString *)name logo:(NSString *)logo amount:(NSString *)amount repay_date:(NSString *)repay_date
{
    _productName.text = name;
    [_logo sd_setImageWithURL:[NSURL URLWithString:logo]];
    _amount.text = amount;
    _repayDate.text = repay_date;
}
- (IBAction)goRepayAction:(id)sender {
    if (self.goRepayBlock) {
        self.goRepayBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.amount.textColor = [UIColor qmui_colorWithHexString:@"#00FFD7"];
    self.amount.font = FONT_Semibold(21.f);
    self.repayDate.textColor = [UIColor whiteColor];
    self.repayDate.font = FONT(14.f);
    self.productName.textColor = [UIColor whiteColor];
    self.productName.font = FONT(14.f);
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
