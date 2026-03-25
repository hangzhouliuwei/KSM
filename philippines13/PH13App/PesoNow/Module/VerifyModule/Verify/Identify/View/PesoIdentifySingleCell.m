//
//  PesoIdentifySingleCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoIdentifySingleCell.h"
#import "PesoBasicModel.h"

@interface PesoIdentifySingleCell()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUIButton *firsetBtn;
@property (nonatomic, strong) QMUIButton *secondBtn;
@property (nonatomic, strong) PesoBasicRowModel *model;

@end
@implementation PesoIdentifySingleCell

- (void)createUI
{
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, 13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(14, titleL.bottom+10, kScreenWidth-28, 44)];
    bgView.backgroundColor = RGBA(10, 118, 53, 0.10);
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    
    QMUIButton *firstBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(4, 4, (bgView.width-8)/2, 36);
    [firstBtn setTitle:@"Male" forState:UIControlStateNormal];
    firstBtn.backgroundColor = [UIColor clearColor];
    firstBtn.titleLabel.font = PH_Font_B(14);
    [firstBtn setTitleColor:ColorFromHex(0x0B2C04) forState:UIControlStateNormal];
    firstBtn.layer.cornerRadius = 4;
    firstBtn.layer.masksToBounds = YES;
    [firstBtn addTarget:self action:@selector(firstClick:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setImage:[UIImage imageNamed:@"identify_btn_normal"] forState:UIControlStateNormal];
    [firstBtn setImage:[UIImage imageNamed:@"identify_btn_selected"] forState:UIControlStateSelected];

    [bgView addSubview:firstBtn];
    _firsetBtn = firstBtn;
    
    QMUIButton *secondBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(4+(bgView.width-8)/2, 4, (bgView.width-8)/2, 36);
    [secondBtn setTitle:@"Male" forState:UIControlStateNormal];
    secondBtn.backgroundColor = [UIColor clearColor];
    secondBtn.titleLabel.font = PH_Font_B(14);
    [secondBtn setTitleColor:ColorFromHex(0x0B2C04) forState:UIControlStateNormal];
    secondBtn.layer.cornerRadius = 4;
    secondBtn.layer.masksToBounds = YES;
    [secondBtn addTarget:self action:@selector(secondClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:secondBtn];
    [secondBtn setImage:[UIImage imageNamed:@"identify_btn_normal"] forState:UIControlStateNormal];
    [secondBtn setImage:[UIImage imageNamed:@"identify_btn_selected"] forState:UIControlStateSelected];
    _secondBtn = secondBtn;
    
}
- (void)firstClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.secondBtn.backgroundColor = UIColor.clearColor;
    self.firsetBtn.backgroundColor = UIColor.whiteColor;
    self.secondBtn.selected = NO;
    PesoBasicEnumModel *enumModel = [self.model.tubothirteendrillNc objectAtIndex:0];

    self.model.darythirteenmanNc = @(enumModel.itlithirteenanizeNc).stringValue;
    if (self.selectBlock) {
        self.selectBlock(self.model.darythirteenmanNc);
    }
}
- (void)secondClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.secondBtn.backgroundColor = UIColor.whiteColor;
    self.firsetBtn.backgroundColor = UIColor.clearColor;
    self.firsetBtn.selected = NO;

    PesoBasicEnumModel *enumModel = [self.model.tubothirteendrillNc objectAtIndex:1];

    self.model.darythirteenmanNc = @(enumModel.itlithirteenanizeNc).stringValue;
    if (self.selectBlock) {
        self.selectBlock(self.model.darythirteenmanNc);
    }
}
- (void)configUIWithModel:(PesoBasicRowModel *)model
{
    _model = model;
    _titleL.text = model.fldgthirteeneNc;
    [model.tubothirteendrillNc enumerateObjectsUsingBlock:^(PesoBasicEnumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [self.firsetBtn setTitle:obj.uporthirteennNc forState:UIControlStateNormal];
            
        }else{
            [self.secondBtn setTitle:obj.uporthirteennNc forState:UIControlStateNormal];
        }
        if (obj.itlithirteenanizeNc == model.darythirteenmanNc.intValue) {
            if (idx == 0) {
                self.firsetBtn.selected = YES;
                self.firsetBtn.backgroundColor = UIColor.whiteColor;
                
            }else{
                self.secondBtn.selected = YES;
                self.secondBtn.backgroundColor = UIColor.whiteColor;

            }
        }
    }];
}
@end
