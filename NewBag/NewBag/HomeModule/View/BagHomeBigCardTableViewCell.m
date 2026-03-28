//
//  BagHomeBigCardTableViewCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeBigCardTableViewCell.h"
#import "BagHomeModel.h"
@interface BagHomeBigCardTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountDesc;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *applyBtnBottom;

@end

@implementation BagHomeBigCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BagHomeBigCardTableViewCell.class) owner:nil options:nil]lastObject];
    
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    /*[_applyBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#29CB2D"] toColor:[UIColor qmui_colorWithHexString:@"#0EB479"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, kScreenWidth - 88, 44)]*/;
    [_applyBtn br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 88, 44)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick)];
    [self.bgImageView addGestureRecognizer:tap];
    if (kScreenHeight/kScreenWidth < 2.0f) {
        self.applyBtnBottom.constant = -48.f;
    }
}
- (void)updateUIWithModel:(BagHomeBigCardItemModel *)model
{
    _amountLabel.text = model.inconsolablyF;
    _amountDesc.text = model.daysideF;
    _rateLabel.text = model.amobarbitalF;
    _rateDescLabel.text = model.tenselyF;
    _periodLabel.text = model.resinoidF;
    _periodDescLabel.text = model.ruboutF;
    _applyBtn.backgroundColor = [UIColor qmui_colorWithHexString:model.unlanguagedF];
    [_applyBtn setTitle:NotNull(model.karakalpakF) forState:UIControlStateNormal];
}
- (void)cellClick{
    if (self.applyClickBlock) {
        self.applyClickBlock();
    }
}
- (IBAction)applyAction:(UIButton *)sender {
    if (self.applyClickBlock) {
        self.applyClickBlock();
    }
}

@end
