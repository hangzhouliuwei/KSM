//
//  PTHomeBrandCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/2.
//

#import "PTHomeBrandCell.h"

@implementation PTHomeBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self createSubUI];
    }
    return self;
}
- (void)onClick{
    if(self.privacyClickBloack){
        self.privacyClickBloack();
    }
}
-(void)createSubUI
{
    UIImageView *bindBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    bindBackImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:bindBackImageView];
    [bindBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-16.f);
        make.height.mas_equalTo(110.f);
    }];
    
    UIImageView *bindSecImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_bindSEC"]];
    bindSecImageView.userInteractionEnabled = YES;
    bindSecImageView.contentMode = UIViewContentModeScaleAspectFit;
    [bindBackImageView addSubview:bindSecImageView];
    [bindSecImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10.f);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(343, 110));
//        make.left.mas_equalTo(32.f);
//        make.right.mas_equalTo(-32.f);
//        make.height.mas_equalTo(54.f);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
    [bindSecImageView addGestureRecognizer:tap];
    
    
//    UIImageView *privacyBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_bindPrivacy"]];
//    privacyBackImageView.userInteractionEnabled = YES;
//    [bindBackImageView addSubview:privacyBackImageView];
//    [privacyBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(bindSecImageView.mas_bottom).offset(12.f);
//        make.centerX.mas_equalTo(0);
//        make.left.mas_equalTo(32.f);
//        make.right.mas_equalTo(-32.f);
//        make.height.mas_equalTo(20.f);
//    }];
//    
//    UIImageView *privacyTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_bindtip"]];
//    [privacyBackImageView addSubview:privacyTipImageView];
//    [privacyTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(0);
//        make.left.mas_equalTo(6.f);
//        make.height.width.mas_equalTo(12.f);
//    }];
    
    
//    YYLabel *agreementLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
//    NSDictionary *attributes = @{NSFontAttributeName:PT_Font(12), NSForegroundColorAttributeName: [UIColor qmui_colorWithHexString:@"#CFDADC"]};
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Click to view the Privacy Agreement>>" attributes:attributes];
//    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:[[text string] rangeOfString:@"Privacy Agreement>>"]];
//    //设置高亮色和点击事件
//    WEAKSELF
//    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"Privacy Agreement>>"] color:[UIColor qmui_colorWithHexString:@"#C1FA54"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        STRONGSELF
//        if(strongSelf.privacyClickBloack){
//            strongSelf.privacyClickBloack();
//        }
//    }];
//   
//    agreementLabel.attributedText = text;
//    [privacyBackImageView addSubview: agreementLabel];
//    [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10.f);
//        make.centerY.mas_equalTo(0);
//        make.height.mas_equalTo(20.f);
//    }];
}

@end
