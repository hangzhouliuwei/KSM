//
//  BagMeOverdueCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import "BagMeOverdueCell.h"

@interface BagMeOverdueCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productLogo;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *repayDate;
@property (weak, nonatomic) IBOutlet UIButton *repayBtn;
@property (weak, nonatomic) IBOutlet UIView *repayBgView;

@end
@implementation BagMeOverdueCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //添加渐变色&圆角
    [self.repayBgView br_setGradientColor:[UIColor qmui_colorWithHexString:@"#EA7A5C"] toColor:[UIColor qmui_colorWithHexString:@"#E16A4A"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth-26, 68)];
    [self.repayBgView br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth-26, 68)];
    [self.repayBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAB"] toColor:[UIColor qmui_colorWithHexString:@"#13407C"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth-26, 40)];
    [self.repayBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth-26, 40)];
    // Initialization code
}
- (void)updateUIWithProductName:(NSString *)name logoUrl:(NSString *)logo amount:(NSString *)amount repayDate:(NSString *)repayDate
{
    self.productName.text = name;
    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:logo]];
    self.amount.text = amount;
    self.repayDate.text = repayDate;
}
- (IBAction)repayAction:(id)sender {
    if (self.overdueClickBlock) {
        self.overdueClickBlock();
    }
}


@end
