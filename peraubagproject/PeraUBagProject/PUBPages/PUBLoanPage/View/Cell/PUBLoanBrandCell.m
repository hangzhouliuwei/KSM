//
//  PUBLoanBrandCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/25.
//

#import "PUBLoanBrandCell.h"

@interface PUBLoanBrandCell()
@property(nonatomic, strong) UIImageView *brandImage;
@end

@implementation PUBLoanBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}

- (void)initSubViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.brandImage];
}

-(void)initSubFrames
{
    [self.brandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.top.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - lazy
- (UIImageView *)brandImage{
    if(!_brandImage){
        _brandImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pub_loan_brand"]];
        _brandImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _brandImage;
}

@end
