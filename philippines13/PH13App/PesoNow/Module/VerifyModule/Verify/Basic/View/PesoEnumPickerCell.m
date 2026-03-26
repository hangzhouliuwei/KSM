//
//  PesoEnumPickerCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoEnumPickerCell.h"

@interface PesoEnumPickerCell()
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) UIImageView *selectImage;
@end
@implementation PesoEnumPickerCell

- (void)createUI
{
    [super createUI];
    QMUILabel *title = [[QMUILabel alloc] qmui_initWithFont:PH_Font_B(15) textColor:ColorFromHex(0x0B2C04)];
    title.frame = CGRectMake(0, 0, kScreenWidth, 55);
    title.numberOfLines = 0;
    title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:title];
    _titleL = title;
    
    UIImageView *selectImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    selectImage.contentMode = UIViewContentModeScaleAspectFit;
    selectImage.frame = CGRectMake(kScreenWidth - 15 - 25, 0, 15, 10);
    selectImage.userInteractionEnabled = YES;
    [self.contentView addSubview:selectImage];
    _selectImage = selectImage;

}
- (void)updateUIWithModel:(NSString *)title isSelected:(BOOL)isSelected{
    _titleL.text = title;
    self.selectImage.hidden = !isSelected;
    self.contentView.backgroundColor = isSelected ? ColorFromHex(0xEDF5EB) : [UIColor whiteColor];
}
@end
