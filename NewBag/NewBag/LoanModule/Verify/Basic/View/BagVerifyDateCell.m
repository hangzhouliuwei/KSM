//
//  BagVerifyDateCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/7.
//

#import "BagVerifyDateCell.h"
#import "BagVerifyBasicModel.h"
@interface BagVerifyDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConst;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
static BOOL isClicking = NO;

@implementation BagVerifyDateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _titleLabel.text = model.mudslingerF;

    if ([model.lorrieF integerValue] != 0) {
        self.titleTopConst.constant = 8.f;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textColor = [UIColor br_colorWithRGB:0x999999];
        _valueLabel.hidden = NO;
        _valueLabel.text = model.lorrieF;
    }else{
        self.valueLabel.hidden = YES;
        self.titleTopConst.constant = 23.f;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor br_colorWithRGB:0x212121];
    }
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
