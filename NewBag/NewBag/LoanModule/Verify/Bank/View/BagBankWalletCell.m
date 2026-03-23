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
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateUIWithModel:(BagBankItemModel *)model isSelect:(BOOL)isSelect
{

    [_icon sd_setImageWithURL:[NSURL URLWithString:model.wholenessF]];
    _title.text = model.antineoplastonF;
    _selectBtn.selected = isSelect;
}
@end
