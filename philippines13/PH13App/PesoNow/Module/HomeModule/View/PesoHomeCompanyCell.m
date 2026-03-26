//
//  PesoHomeCompanyCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeCompanyCell.h"

@implementation PesoHomeCompanyCell

- (void)createUI
{
    [super createUI];
    UIImageView *bg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_brand"]];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.frame = CGRectMake(15, 10, kScreenWidth-30, (kScreenWidth -30)/335* 136);
    bg.centerX = kScreenWidth/2;
    bg.userInteractionEnabled = YES;
    [self.contentView addSubview:bg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [bg addGestureRecognizer:tap];
}
- (void)clickAction{
    if (self.block) {
        self.block();
    }
}
@end
