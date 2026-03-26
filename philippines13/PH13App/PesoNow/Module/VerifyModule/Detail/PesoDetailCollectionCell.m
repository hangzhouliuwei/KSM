//
//  PesoDetailCollectionCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoDetailCollectionCell.h"

@interface PesoDetailCollectionCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@end
@implementation PesoDetailCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.contentView.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupUI{
    UIImageView *image  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//    image.contentMode = UIViewContentModeScaleAspectFit;
    image.frame = CGRectMake(0, 0, self.width, self.height);
    [self.contentView addSubview:image];
    _iconImage = image;
}
- (void)configUIWithModel:(NSString *)iconUrl{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage br_imageWithColor:[UIColor orangeColor]]];
}
@end

