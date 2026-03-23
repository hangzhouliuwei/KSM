//
//  LoanCycleViewCell.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/28.
//

#import "LoanCycleViewCell.h"

@implementation LoanCycleViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, self.contentView.width - 5 * 2, 17)];
        [self.titleLabel pp_setPropertys:@[kFontSize(12), kWhiteColor, @(NSTextAlignmentCenter)]];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
@end
