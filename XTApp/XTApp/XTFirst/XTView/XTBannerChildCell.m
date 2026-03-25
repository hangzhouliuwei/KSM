//
//  XTBannerChildCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTBannerChildCell.h"
#import "XTBannerModel.h"

@interface XTBannerChildCell()

@property(nonatomic,strong) UIImageView *bgImg;

@end

@implementation XTBannerChildCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.bgImg];
        [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(XTBannerModel *)model {
    _model = model;
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.arissixNc] placeholderImage:XT_Img(@"xt_img_def")];
}

- (UIImageView *)bgImg {
    if(!_bgImg) {
        _bgImg = [UIImageView new];
        _bgImg.clipsToBounds = YES;
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.layer.cornerRadius = 10.0f;
    }
    return _bgImg;
}

@end
