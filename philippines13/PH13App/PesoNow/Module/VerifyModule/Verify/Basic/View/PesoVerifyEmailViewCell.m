//
//  PesoVerifyEmailViewCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/14.
//

#import "PesoVerifyEmailViewCell.h"
@interface PesoVerifyEmailViewCell()
@property (nonatomic, strong) QMUILabel *titleL;
@end
@implementation PesoVerifyEmailViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;;
}
- (void)createUI
{
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_M(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(12, 15, kScreenWidth - 52, 18);
    titleL.numberOfLines = 0;
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, 49,  kScreenWidth - 52, 1)];
    line.backgroundColor = ColorFromHex(0xEEF0F4);
    line.layer.cornerRadius = 4;
    line.layer.masksToBounds = YES;
    [self.contentView addSubview:line];
}
- (void)configtile:(NSString*)title indx:(NSInteger)indx isSelect:(BOOL)select
{
    self.titleL.text = title;
//    self.bgView.backgroundColor = [UIColor clearColor];

//    self.bgView.backgroundColor = select ? RGBA(202, 251, 108, 0.40) : [UIColor clearColor];
}
@end
