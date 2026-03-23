//
//  PTHomeRepayCell.m
//  PTApp
//
//  Created by Jacky on 2024/9/2.
//

#import "PTHomeRepayCell.h"
#import "PTHomeRepayModel.h"
@interface PTHomeRepayCell()
@property(nonatomic, strong) UIImageView *bgImage;
@end
@implementation PTHomeRepayCell

- (void)setupUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(98);
        make.top.mas_equalTo(10);
    }];
    self.bgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
    [self.bgImage addGestureRecognizer:tap];
}
- (void)onClick{
    if (self.repayBlock) {
        self.repayBlock();
    }
}
- (void)configUIWithModel:(PTHomeRepayRealModel *)model
{
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:model.frtenwnNc]];
}
- (UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImage.userInteractionEnabled = YES;
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImage;
}
@end
