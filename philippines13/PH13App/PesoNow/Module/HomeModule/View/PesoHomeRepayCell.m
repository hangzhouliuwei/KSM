//
//  PesoHomeRepayCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoHomeRepayCell.h"

@interface PesoHomeRepayCell()
@property (nonatomic, strong) UIImageView *bgImage;
@end
@implementation PesoHomeRepayCell

- (void)createUI
{
    [super createUI];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImage  = [[UIImageView alloc] initWithImage:[UIImage br_imageWithColor:[UIColor clearColor]]];
//    bgImage.contentMode = UIViewContentModeScaleAspectFit;
    bgImage.frame = CGRectMake(15, 10, kScreenWidth - 30, (kScreenWidth-30)/345*65);
    bgImage.userInteractionEnabled = YES;
    _bgImage = bgImage;
    [self.contentView addSubview:bgImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [bgImage addGestureRecognizer:tap];
}
- (void)click{
    if (self.block) {
        self.block();
    }
}
- (void)configUIWithModel:(NSString *)url
{
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
