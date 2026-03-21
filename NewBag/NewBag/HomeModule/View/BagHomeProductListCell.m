//
//  BagHomeProductListCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeProductListCell.h"
#import "BagHomeModel.h"
@interface BagHomeProductListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountDesc;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UILabel *productDesc;

@end
@implementation BagHomeProductListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick)];
    [self.contentView addGestureRecognizer:tap];
    // Initialization code
}
- (void)updateUIWithModel:(BagHomeProductListItemModel *)model
{
    _titleLabel.text = model.moosfourteenyllabismNc;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.sihofourteenuetteNc]];
    _amountDesc.text = model.cotefourteennderNc;
    _amount.text = model.eahofourteenleNc;
    [_applyBtn setTitle:model.maanfourteenNc forState:UIControlStateNormal];
    [_applyBtn setBackgroundColor:[UIColor qmui_colorWithHexString:model.spfffourteenlicateNc]];
    _productDesc.text = model.liotfourteenesNc;
}
- (IBAction)applyClickAction:(id)sender {
    if (self.applyClickBlock) {
        self.applyClickBlock();
    }
}
- (void)cellClick{
    if (self.applyClickBlock) {
        self.applyClickBlock();
    }
}
@end
