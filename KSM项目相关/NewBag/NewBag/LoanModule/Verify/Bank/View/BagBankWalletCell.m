//
//  BagBankWalletCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankWalletCell.h"
#import "BagBankModel.h"
@interface BagBankWalletCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
@implementation BagBankWalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectBtn sd_setImageWithURL:[Util loadImageUrl:@"bank_icon_select_0"] forState:UIControlStateNormal];
    [self.selectBtn sd_setImageWithURL:[Util loadImageUrl:@"bank_icon_select_1"] forState:UIControlStateSelected];
    // Initialization code
}
- (void)updateUIWithModel:(BagBankItemModel *)model isSelect:(BOOL)isSelect
{

    [_icon sd_setImageWithURL:[NSURL URLWithString:model.ieNcfourteen]];
    _title.text = model.uporfourteennNc;
    _selectBtn.selected = isSelect;
}
@end
