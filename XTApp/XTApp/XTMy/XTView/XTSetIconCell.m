//
//  XTSetIconCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTSetIconCell.h"

@implementation XTSetIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    UIImageView *iconImg = [UIImageView new];
    iconImg.clipsToBounds = YES;
    iconImg.layer.cornerRadius = 10;
    [self.contentView addSubview:iconImg];    
    NSArray *arr = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    if(arr.lastObject) {
        iconImg.image = XT_Img(arr.lastObject);
    }
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(72);
        make.size.mas_equalTo(CGSizeMake(88, 88));
    }];
    
    UILabel *nameLab = [UILabel xt_lab:CGRectZero text:XT_App_Name font:XT_Font_SD(20) textColor:[UIColor blackColor] alignment:NSTextAlignmentCenter tag:0];
    [self.contentView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(iconImg.mas_bottom).offset(16);
        make.height.mas_equalTo(28);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
