//
//  PesoBasicEnumCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBasicEnumCell.h"
#import "PesoBasicModel.h"
@interface PesoBasicEnumCell()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *valueL;
@property (nonatomic, strong) UIImageView *arrow;
@end
@implementation PesoBasicEnumCell

- (void)createUI
{
    [super createUI];
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, 13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
    
}
- (void)click{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
- (void)configUIWithModel:(PesoBasicRowModel *)model
{
    PesoBasicRowModel *row = model;
    self.titleL.text = row.fldgthirteeneNc;
    if ([row.darythirteenmanNc intValue] != 0) {
        self.valueL.font = PH_Font_SD(14);
        self.valueL.textColor = ColorFromHex(0x0B2C04);
        if ([row.cellType isEqual:@"day"]) {
            self.valueL.text = row.darythirteenmanNc;
        }else{
            [row.tubothirteendrillNc enumerateObjectsUsingBlock:^(PesoBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.itlithirteenanizeNc == row.darythirteenmanNc.integerValue) {
                    self.valueL.text = obj.uporthirteennNc;
                    *stop = YES;
                }
            }];
        }
    }else {
        self.valueL.text = row.orinthirteenarilyNc;
        self.valueL.font = PH_Font(14);
        self.valueL.textColor = ColorFromHex(0xA6B5A3);
    }
}

@end
