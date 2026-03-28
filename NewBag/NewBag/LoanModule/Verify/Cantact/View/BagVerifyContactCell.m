//
//  BagVerifyContactCell.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyContactCell.h"
#import "BagVerifyContactModel.h"
@interface BagVerifyContactCell ()
@property (weak, nonatomic) IBOutlet UILabel *relationTitle;
@property (weak, nonatomic) IBOutlet UILabel *relationValue;
@property (weak, nonatomic) IBOutlet UIView *relationBgView;
@property (weak, nonatomic) IBOutlet UIView *contactBgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BagVerifyContactCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BagVerifyContactCell.class) owner:nil options:nil] lastObject];
    }
    return  self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;

    [self.bgView br_setRoundedCorners:UIRectCornerAllCorners withRadius:CGSizeMake(4, 4) viewRect:CGRectMake(0, 0, kScreenWidth - 28, 117)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRelation)];
    [_relationBgView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContact)];
    [_contactBgView addGestureRecognizer:tap2];
}
- (void)clickRelation{
    if (self.relationClick) {
        self.relationClick();
    }
}
- (void)clickContact{
    if (self.contactClick) {
        self.contactClick();
    }
}
- (void)updateUIWithModel:(BagContactItmeModel *)model
{
    if(model.incessantF.brandyballF != 0){
        [model.brandyballF enumerateObjectsUsingBlock:^(BagContactRelationEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(obj.sovranF == model.incessantF.brandyballF){
                self.relationValue.text = obj.antineoplastonF;
                *stop = YES;
            }
        }];
        self.relationTitle.hidden = YES;
        self.relationValue.hidden = NO;
    }else{
        self.relationTitle.hidden = NO;
        self.relationValue.hidden = YES;
    }
    
    self.name.text = [model.incessantF.antineoplastonF br_isBlankString] ? @"name" : model.incessantF.antineoplastonF;
    self.name.textColor = [model.incessantF.antineoplastonF br_isBlankString] ? [UIColor qmui_colorWithHexString:@"#212121"] : [UIColor qmui_colorWithHexString:@"#0EB479"];
    
    self.phoneNumber.text = [model.incessantF.guerrillaF br_isBlankString] ? @"Phone Number" : model.incessantF.guerrillaF;
    self.phoneNumber.font = [model.incessantF.guerrillaF br_isBlankString] ? [UIFont systemFontOfSize:14] : [UIFont qmui_systemFontOfSize:20 weight:QMUIFontWeightBold italic:NO];
    self.phoneNumber.textColor = [model.incessantF.guerrillaF br_isBlankString] ? [UIColor qmui_colorWithHexString:@"#212121"] : [UIColor qmui_colorWithHexString:@"#0EB479"];
}


@end
