//
//  BagOrderCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagOrderCell.h"
#import "BagOrderModel.h"
@interface BagOrderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *refundStatusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *refundStatusLabelWid;

@property (weak, nonatomic) IBOutlet UIView *haveRefundBagView;
@property (weak, nonatomic) IBOutlet UILabel *haveAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveRepayDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *haveRepayRefundBtn;
@property (weak, nonatomic) IBOutlet UIView *habeRefundTopView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noRefundAmountTop;
@property (weak, nonatomic) IBOutlet UIView *noRefundBagView;
@property (weak, nonatomic) IBOutlet UILabel *noRefundAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *noRefundRepayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *noRefundStatusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noRefundStatusWid;

@end
@implementation BagOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return  self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.noRefundBagView br_setBorderType:BRBorderSideTypeAll borderColor:[UIColor qmui_colorWithHexString:@"#CBD2DC"] borderWidth:0.5];
}
- (void)updateUIWithModel:(BagOrderListModel *)model
{
    _titleLabel.text = model.moosfourteenyllabismNc;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.sihofourteenuetteNc]];
    //refundbtn.hidden = no
    if (![model.maanfourteenNc br_isBlankString]) {
        self.haveRefundBagView.hidden = NO;
        self.haveRefundBagView.backgroundColor = [UIColor whiteColor];
        self.noRefundBagView.hidden = YES;
        self.haveAmountLabel.text = model.istafourteencNc;
        if ([NotNull(model.exerfourteeniencelessNc) isEqual:@""]) {
            self.haveRepayDateLabel.text =@"-";
        }else{
            self.haveRepayDateLabel.text = model.exerfourteeniencelessNc;
        }
        self.refundStatusLabel.hidden = NO;
        self.refundStatusLabel.text = model.laarfourteenckianNc;
        self.refundStatusLabel.textColor = [UIColor qmui_colorWithHexString:model.imotfourteenenceNc];
        self.refundStatusLabel.layer.borderWidth = .5f;
        self.refundStatusLabel.layer.borderColor = [UIColor qmui_colorWithHexString:model.imotfourteenenceNc].CGColor;
        self.habeRefundTopView.backgroundColor = [UIColor qmui_colorWithHexString:model.imotfourteenenceNc];
        self.refundStatusLabelWid.constant = [model.laarfourteenckianNc br_getTextWidth:[UIFont qmui_mediumSystemFontOfSize:14] height:20] + 8;
        self.haveRepayRefundBtn.backgroundColor = [UIColor qmui_colorWithHexString:model.shkafourteenriNc];

    }else{
        self.haveRefundBagView.hidden = YES;
        self.noRefundBagView.hidden = NO;
        self.refundStatusLabel.hidden = YES;
        
        self.noRefundAmountLabel.text = model.istafourteencNc;
        if (![model.exerfourteeniencelessNc br_isBlankString]) {
            self.noRefundRepayDateLabel.hidden = NO;
            self.noRefundRepayDateLabel.text = model.exerfourteeniencelessNc;
            self.noRefundAmountTop.constant = 12;
        }else{
            self.noRefundRepayDateLabel.hidden = YES;
            self.noRefundAmountTop.constant = 22;
        }
        self.noRefundStatusLabel.text = model.laarfourteenckianNc;
        self.noRefundStatusWid.constant = [model.laarfourteenckianNc br_getTextWidth:[UIFont systemFontOfSize:12] height:40] + 10;
        self.noRefundStatusLabel.backgroundColor = [UIColor qmui_colorWithHexString:model.imotfourteenenceNc];

    }
}
- (IBAction)refundAction:(id)sender {
    if (self.refundBtnClickBlock) {
        self.refundBtnClickBlock();
    }
}



@end
