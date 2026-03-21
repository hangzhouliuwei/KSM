//
//  BagVerifyBasicEnumCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/6.
//

#import "BagVerifyBasicEnumCell.h"
#import "BagVerifyBasicModel.h"
static BOOL isClicking = NO;

@interface BagVerifyBasicEnumCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConst;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end
@implementation BagVerifyBasicEnumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
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
- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _titleLabel.text = model.fldgfourteeneNc;
    if ([model.daryfourteenmanNc integerValue] != 0) {
        [model.tubofourteendrillNc enumerateObjectsUsingBlock:^(BagBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.itlifourteenanizeNc == model.daryfourteenmanNc.integerValue) {
                self.valueLabel.text = obj.uporfourteennNc;
                *stop = YES;
            }
        }];
        self.valueLabel.hidden = NO;
        self.titleTopConst.constant = 8.f;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textColor = [UIColor br_colorWithRGB:0x999999];

    }else{
        self.valueLabel.hidden = YES;
        self.titleTopConst.constant = 23.f;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor br_colorWithRGB:0x212121];

    }
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
    //[self.arrow sd_setImageWithURL:[Util loadImageUrl:@"basic_choose_down"]];
    [self.arrowBtn sd_setImageWithURL:[Util loadImageUrl:@"basic_choose_down"] forState:UIControlStateNormal];
}

@end
