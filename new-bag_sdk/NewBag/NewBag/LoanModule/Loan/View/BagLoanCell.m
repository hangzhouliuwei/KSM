//
//  BagLoanCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/5.
//

#import "BagLoanCell.h"
#import "BagLoanDeatilModel.h"
@interface BagLoanCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@end
@implementation BagLoanCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
}
- (void)updateUIWithModel:(BagVerifyItemModel *)model isLast:(BOOL)isLast
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.oroideF] placeholderImage:[UIImage qmui_imageWithColor:[UIColor qmui_colorWithHexString:@"#999999"]]];
    _titleLabel.text = model.mudslingerF;
    self.bottomLine.hidden = isLast ? YES : NO;
    //认证已完成
    if (model.thermionicF) {
        self.bgView.backgroundColor = [UIColor qmui_colorWithHexString:@"#ECFFF5"];
        self.rightArrow.image = [UIImage imageNamed:@"loan_finished"];
    }else{
        self.bgView.backgroundColor = [UIColor qmui_colorWithHexString:@"#F4F7FA"];
        self.rightArrow.image = [UIImage imageNamed:@"loan_notFinished"];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
