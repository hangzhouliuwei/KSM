//
//  PTHomeTipCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/2.
//

#import "PTHomeTipCell.h"

@implementation PTHomeTipCell

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

-(void)createSubUI
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_tipBack"]];
    [self.contentView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-12.f);
    }];
    
    UIImageView *topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_tipTap"]];
    [backImage addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10.f);
        make.left.mas_equalTo(16.f);
        make.size.mas_equalTo(CGSizeMake(200.f, 48.f));
    }];
    
    UIImageView *serviceBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_service"]];
    [backImage addSubview:serviceBackImage];
    [serviceBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topImage.mas_bottom).offset(16.f);
        make.left.mas_equalTo(16.f);
        make.size.mas_equalTo(CGSizeMake(PTAUTOSIZE(164.f), 148.f));
        
    }];
    
    QMUILabel *timeServiceLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_SD(28.f) textColor:[UIColor blackColor]];
    timeServiceLabel.text = @"24/7 ";
    timeServiceLabel.textAlignment = NSTextAlignmentLeft;
    [serviceBackImage addSubview:timeServiceLabel];
    [timeServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.top.mas_equalTo(16.f);
        make.height.mas_equalTo(30.f);
    }];
    
    
    QMUILabel *serviceLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(12.f) textColor:[UIColor blackColor]];
    serviceLabel.text = @"Customer Service ";
    timeServiceLabel.textAlignment = NSTextAlignmentLeft;
    [serviceBackImage addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(timeServiceLabel.mas_leading);
        make.top.mas_equalTo(timeServiceLabel.mas_bottom).offset(4.f);
        make.height.mas_equalTo(14.f);
    }];
    
    UIImageView *serviceFastBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_fast"]];
    [backImage addSubview:serviceFastBackImage];
    [serviceFastBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.top.mas_equalTo(topImage.mas_bottom).offset(16.f);
        make.left.mas_equalTo(serviceBackImage.mas_right).offset(16.f);
        make.height.mas_equalTo(66.f);
    }];
    
    
    QMUILabel *serviceFastLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(14.f) textColor:[UIColor blackColor]];
    serviceFastLabel.text = @"Easy and \nfast";
    serviceFastLabel.numberOfLines = 2.f;
    serviceFastLabel.textAlignment = NSTextAlignmentLeft;
    [serviceFastBackImage addSubview:serviceFastLabel];
    [serviceFastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.top.mas_equalTo(4.f);
        make.height.mas_equalTo(40.f);
    }];
    
    
    UIImageView *serviceReliableBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_reliable"]];
    [backImage addSubview:serviceReliableBackImage];
    [serviceReliableBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16.f);
        make.bottomMargin.mas_equalTo(serviceBackImage.mas_bottomMargin);
        make.left.mas_equalTo(serviceBackImage.mas_right).offset(16.f);
        make.height.mas_equalTo(66.f);
    }];
    
    
    QMUILabel *serviceReliableLabel = [[QMUILabel alloc] qmui_initWithFont:PT_Font_B(14.f) textColor:[UIColor blackColor]];
    serviceReliableLabel.text = @"Safe and \nreliable";
    serviceReliableLabel.numberOfLines = 2.f;
    serviceReliableLabel.textAlignment = NSTextAlignmentLeft;
    [serviceReliableBackImage addSubview:serviceReliableLabel];
    [serviceReliableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.top.mas_equalTo(4.f);
        make.height.mas_equalTo(40.f);
    }];
}


@end
