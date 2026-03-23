//
//  LoanAlertView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/11.
//

#import "LoanAlertView.h"

@implementation LoanAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 345)];
//        self.imageView.layer.masksToBounds = self.imageView.layer.cornerRadius =
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        [self addSubview:self.imageView];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake((self.width -32) / 2.0, _imageView.bottom + 24, 32, 32);
        [cancelButton setBackgroundImage:kImageName(@"pop_close") forState:UIControlStateNormal];
        [self addSubview:cancelButton];
    }
    return self;
}
-(void)tapAction
{
    [self plp_dismiss];
    if (self.tapBlk) {
        self.tapBlk();
    }
}
-(void)buttonAction
{
    [self plp_dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
