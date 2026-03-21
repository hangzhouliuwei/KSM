//
//  BagIdentifySingleSelectCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagIdentifySingleSelectCell.h"
#import "BagVerifyBasicModel.h"

@interface BagIdentifySingleSelectCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (nonatomic, strong) BagBasicRowModel *model;
@end
@implementation BagIdentifySingleSelectCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstBtn.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionLeft;
    self.secondBtn.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionRight | QMUIViewBorderPositionLeft ;

    [self.firstBtn br_setRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft withRadius:CGSizeMake(2, 2) viewRect:CGRectMake(0, 0, (kScreenWidth - 28)/2, 48)];
    [self.secondBtn br_setRoundedCorners: UIRectCornerTopRight | UIRectCornerBottomRight withRadius:CGSizeMake(2, 2) viewRect:CGRectMake(0, 0, (kScreenWidth - 28)/2, 48)];
    
    self.firstBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
    [self.firstBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];

    self.secondBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
    [self.secondBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];
    self.line.backgroundColor = [UIColor qmui_colorWithHexString:@"#949DA6"];;

    // Initialization code
}
- (void)updateUIWithModel:(BagBasicRowModel *)model
{
    _titleLabel.text = model.fldgfourteeneNc;
    self.model = model;
    if(model.daryfourteenmanNc.integerValue !=0){
        WEAKSELF
        [model.tubofourteendrillNc enumerateObjectsUsingBlock:^(BagBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            STRONGSELF
            if(model.daryfourteenmanNc.integerValue == obj.itlifourteenanizeNc){
                model.daryfourteenmanNc = [NSString stringWithFormat:@"%ld",obj.itlifourteenanizeNc];
                if([obj.uporfourteennNc isEqual:@"Male"]){
                    strongSelf.firstBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
                    [strongSelf.firstBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];

                    strongSelf.secondBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
                    [strongSelf.secondBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"]forState:UIControlStateNormal];


                }else if ([obj.uporfourteennNc isEqual:@"Female"]){
                    strongSelf.firstBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
                    [strongSelf.firstBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"]forState:UIControlStateNormal];

                    strongSelf.secondBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
                    [strongSelf.secondBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];

                }
                *stop = YES;
            }
        }];
    }
}
- (IBAction)firstClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    self.secondBtn.selected = NO;
    self.firstBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
    self.secondBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
    self.line.backgroundColor = [UIColor qmui_colorWithHexString:@"#0EB479"];;
    [self.firstBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"]forState:UIControlStateNormal];
    [self.secondBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];
    [self layoutIfNeeded];
    BagBasicEnumModel *egMOdel = [self.model.tubofourteendrillNc objectAtIndex:0];
    self.model.daryfourteenmanNc = [NSString stringWithFormat:@"%ld",egMOdel.itlifourteenanizeNc];
    if (self.selectBlock) {
        self.selectBlock(self.model.daryfourteenmanNc);
    }
}
- (IBAction)secondClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    self.firstBtn.selected = NO;
    self.firstBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"##949DA6"];
    self.secondBtn.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#0EB479"];
    self.line.backgroundColor = [UIColor qmui_colorWithHexString:@"#949DA6"];
    [self.firstBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#949DA6"]forState:UIControlStateNormal];
    [self.secondBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"]forState:UIControlStateNormal];

    [self layoutIfNeeded];
    BagBasicEnumModel *egMOdel = [self.model.tubofourteendrillNc objectAtIndex:1];
    self.model.daryfourteenmanNc = [NSString stringWithFormat:@"%ld",egMOdel.itlifourteenanizeNc];
    if (self.selectBlock) {
        self.selectBlock(self.model.daryfourteenmanNc);
    }
}

@end
