//
//  RepayView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/31.
//

#import "RepayView.h"

@implementation RepayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.layer.cornerRadius = 12;
        self.iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _iconImageView.layer.masksToBounds = self.iconImageView.layer.cornerRadius = 12;
        _iconImageView.userInteractionEnabled = true;
        [_iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        [self addSubview:self.iconImageView];
    }
    return self;
}
-(void)setInfo:(NSDictionary *)info
{
    _info = info;
    [self.iconImageView sd_setImageWithURL:kURL(info[@"frwntwelveNc"])];
}
-(void)tapAction
{
    if (self.tapBlk) {
        self.tapBlk();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
