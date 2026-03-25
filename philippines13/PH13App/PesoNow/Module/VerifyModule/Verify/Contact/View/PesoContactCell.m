//
//  PesoContactCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import "PesoContactCell.h"
#import "PesoContactModel.h"
#import "PesoBasicSectionHeader.h"
@interface PesoContactCell()
@property (nonatomic, strong) PesoBasicSectionHeader *header;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *valueL;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) PesoContactModel* model;
@property (nonatomic, strong) UIView *contactBg;

@property (nonatomic, strong) QMUILabel *nameL;
@property (nonatomic, strong) QMUILabel *phoneL;

@end
@implementation PesoContactCell

- (void)createUI
{
    [super createUI];
    PesoBasicSectionHeader *header = [[PesoBasicSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [self.contentView addSubview:header];
    _header = header;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, header.bottom+13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
    titleL.text = @"Relationship";
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UIView *valueBg = [[UIView alloc] initWithFrame:CGRectMake(14, titleL.bottom+10, kScreenWidth-28, 44)];
    valueBg.backgroundColor = ColorFromHex(0xFBFBFB);
    valueBg.layer.cornerRadius = 4;
    valueBg.layer.masksToBounds = YES;
    [self.contentView addSubview:valueBg];
    
    
    QMUILabel *valueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0xA6B5A3)];
    valueL.frame = CGRectMake(12, 0, valueBg.width - 12 - 34, 17);
    valueL.numberOfLines = 1;
    valueL.centerY = 22;
    [valueBg addSubview:valueL];
    _valueL = valueL;
    
    UIImageView *arrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_arrow_down"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(valueBg.width - 12 - 22, 0, 22, 22);
    arrow.centerY = 22;
    arrow.userInteractionEnabled = YES;
    _arrow = arrow;
    [valueBg addSubview:arrow];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRelation)];
    [valueBg addGestureRecognizer:tap];
    
    UIView *contactBg = [[UIView alloc] initWithFrame:CGRectMake(14, valueBg.bottom+10, kScreenWidth-28, 74)];
    contactBg.backgroundColor = ColorFromHex(0xFBFBFB);
    contactBg.layer.cornerRadius = 4;
    contactBg.layer.masksToBounds = YES;
    [self.contentView addSubview:contactBg];
    _contactBg = contactBg;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContact)];
    [contactBg addGestureRecognizer:tap2];
    
    QMUILabel *nameL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14) textColor:ColorFromHex(0xA6B5A3)];
    nameL.frame = CGRectMake(12, 12, 200, 20);
    nameL.numberOfLines = 0;
    [contactBg addSubview:nameL];
    _nameL = nameL;
    
    QMUILabel *phoneL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(14) textColor:ColorFromHex(0xA6B5A3)];
    phoneL.frame = CGRectMake(12, nameL.bottom+10, 200, 20);
    phoneL.numberOfLines = 0;
    [contactBg addSubview:phoneL];
    _phoneL = phoneL;
    
    UIImageView *contactIcon  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contact_icon"]];
    contactIcon.contentMode = UIViewContentModeScaleAspectFit;
    contactIcon.frame = CGRectMake(contactBg.width-12-26, 0, 26, 26);
    contactIcon.centerY = 37;
    contactIcon.userInteractionEnabled = YES;
    [contactBg addSubview:contactIcon];
    
}
- (void)configUIWithModel:(PesoContactItmeModel *)model
{
    [self.header updateUIWithTitle:model.fldgthirteeneNc Subtitle:@"" more:NO isSelected:NO];
    if(model.koNcthirteen.bedithirteeneNc != 0){
        [model.bedithirteeneNc enumerateObjectsUsingBlock:^(PesoContactRelationEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(obj.dempthirteenhasizeNc == model.koNcthirteen.bedithirteeneNc){
                self.valueL.text = obj.uporthirteennNc;
                *stop = YES;
            }
        }];
        self.valueL.textColor = ColorFromHex(0x0B2C04);
    }else{
        self.valueL.text = @"Please Select";
    }
    
    self.nameL.text = br_isEmptyObject(model.koNcthirteen.uporthirteennNc) ? @"Name" : model.koNcthirteen.uporthirteennNc;
    self.nameL.textColor = br_isEmptyObject(model.koNcthirteen.uporthirteennNc) ? ColorFromHex(0xA6B5A3) : ColorFromHex(0x0B2C04);
    self.nameL.font =  br_isEmptyObject(model.koNcthirteen.uporthirteennNc) ? PH_Font(14):PH_Font_SD(14);
    
    self.phoneL.text = br_isEmptyObject(model.koNcthirteen.halothirteenwNc) ? @"Phone" : model.koNcthirteen.halothirteenwNc;
    self.phoneL.textColor = br_isEmptyObject(model.koNcthirteen.halothirteenwNc) ? ColorFromHex(0xA6B5A3) : ColorFromHex(0x0B2C04);
    self.phoneL.font =  br_isEmptyObject(model.koNcthirteen.halothirteenwNc) ? PH_Font(14):PH_Font_SD(14);
    
    if (br_isNotEmptyObject(model.koNcthirteen.uporthirteennNc) ||  br_isNotEmptyObject(model.koNcthirteen.halothirteenwNc)) {
        self.contactBg.backgroundColor = RGBA(245, 250, 244, 1);
        self.contactBg.layer.borderWidth = 1;
        self.contactBg.layer.borderColor = RGBA(197, 227, 191, 1).CGColor;
    }else{
        self.contactBg.backgroundColor =  RGBA(251, 251, 251, 1);
        self.contactBg.layer.borderColor = [UIColor clearColor].CGColor;
    }

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
@end
