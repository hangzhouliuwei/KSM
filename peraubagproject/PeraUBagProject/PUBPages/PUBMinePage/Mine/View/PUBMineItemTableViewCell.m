//
//  PUBMineItemTableViewCell.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/9.
//

#import "PUBMineItemTableViewCell.h"
#import <QMUIKit/UIColor+QMUI.h>
@interface PUBMineItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation PUBMineItemTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 36.f;
    _bgView.layer.borderWidth = 2;
    _bgView.layer.borderColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.11].CGColor;
//    [UIColor qmui_colorWithAlpha]
    
    // Initialization code
}

- (void)updateUIWIthTitle:(NSString *)title iconUrl:(NSString *)url
{
    self.title.text = title;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
