//
//  BagHomeSmallCardCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeSmallCardCell.h"
#import "BagHomeModel.h"
@interface BagHomeSmallCardCell()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountDescLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *biao;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *rateDesc;
@property (weak, nonatomic) IBOutlet UILabel *period;
@property (weak, nonatomic) IBOutlet UILabel *periodDesc;
@property (weak, nonatomic) IBOutlet UIImageView *smallBgImageVIew;

@end
@implementation BagHomeSmallCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    [_applyBtn br_setGradientColor:[UIColor qmui_colorWithHexString:@"#154685"] toColor:[UIColor qmui_colorWithHexString:@"#205EAC"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, 200, 44)];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick)];
    [self.contentView addGestureRecognizer:tap];
    [self.smallBgImageVIew sd_setImageWithURL:[Util loadImageUrl:@"home_small_bg2"]];
}
- (void)updateUIWithModel:(BagHomeSmallCardModel *)model
{
    [self.smallBgImageVIew sd_setImageWithURL:[Util loadImageUrl:@"home_small_bg2"]];
    _biao.hidden = [NotNull(model.ubmrrlF) br_isBlankString] ? YES : NO;
    if(![NotNull(model.ubmrrlF) br_isBlankString]){
        [_biao sd_setImageWithURL:[NSURL URLWithString:model.ubmrrlF]];
    }
    _amountLabel.text = model.inconsolablyF;
    _amountDescLabel.text = model.daysideF;
    _applyBtn.backgroundColor = [UIColor qmui_colorWithHexString:model.unlanguagedF];
    [_applyBtn setTitle:NotNull(model.karakalpakF) forState:UIControlStateNormal];
    _rate.text = model.amobarbitalF;
    _rateDesc.text = model.tenselyF;
    _period.text = model.resinoidF;
    _periodDesc.text = model.ruboutF;
}
- (void)cellClick{
    if (self.applyClickBlock) {
        self.applyClickBlock();
    }
}

@end
