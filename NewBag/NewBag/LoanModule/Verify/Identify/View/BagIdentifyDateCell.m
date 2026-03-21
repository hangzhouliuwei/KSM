//
//  BagIdentifyDateCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagIdentifyDateCell.h"
#import "BagVerifyBasicModel.h"
static BOOL isClicking = NO;

@interface BagIdentifyDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BagIdentifyDateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    [self.bgView br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(2, 2) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 48)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self.bgView addGestureRecognizer:tap];
    // Initialization code
}
- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _titleLabel.text = model.fldgfourteeneNc;
    _valueLabel.text = model.daryfourteenmanNc;
    
}
- (void)click{
    if (isClicking) {
        return;
    }
    if(self.clickBlock){
        isClicking = YES;
        self.clickBlock();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isClicking = NO;
        });
    }
}
@end
