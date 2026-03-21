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
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *iocnBtn;

@end
@implementation BagVerifyContactCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    }
    return  self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    [self.iocnBtn sd_setImageWithURL:[Util loadImageUrl:@"contact_icon"] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            [self.iocnBtn setImage:[Util imageResize:image ResizeTo:CGSizeMake(30, 30)] forState:UIControlStateNormal];
        }
    }];
    [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@"basic_choose_down"]
                                                options:0
                                               progress:nil
                                              completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL *  _Nullable imageURL) {
        if(image){
            [self.arrowBtn setImage:[Util imageResize:image ResizeTo:CGSizeMake(20.f, 20.f)] forState:UIControlStateNormal];
        }

    }];
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
    if(model.koNcfourteen.bedifourteeneNc != 0){
        [model.bedifourteeneNc enumerateObjectsUsingBlock:^(BagContactRelationEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(obj.dempfourteenhasizeNc == model.koNcfourteen.bedifourteeneNc){
                self.relationValue.text = obj.uporfourteennNc;
                *stop = YES;
            }
        }];
        self.relationTitle.hidden = YES;
        self.relationValue.hidden = NO;
    }else{
        self.relationTitle.hidden = NO;
        self.relationValue.hidden = YES;
    }
    
    self.name.text = [model.koNcfourteen.uporfourteennNc br_isBlankString] ? @"name" : model.koNcfourteen.uporfourteennNc;
    self.name.textColor = [model.koNcfourteen.uporfourteennNc br_isBlankString] ? [UIColor qmui_colorWithHexString:@"#212121"] : [UIColor qmui_colorWithHexString:@"#0EB479"];
    
    self.phoneNumber.text = [model.koNcfourteen.halofourteenwNc br_isBlankString] ? @"Phone Number" : model.koNcfourteen.halofourteenwNc;
    self.phoneNumber.font = [model.koNcfourteen.halofourteenwNc br_isBlankString] ? [UIFont systemFontOfSize:14] : [UIFont qmui_systemFontOfSize:20 weight:QMUIFontWeightBold italic:NO];
    self.phoneNumber.textColor = [model.koNcfourteen.halofourteenwNc br_isBlankString] ? [UIColor qmui_colorWithHexString:@"#212121"] : [UIColor qmui_colorWithHexString:@"#0EB479"];
}


@end
