//
//  PUBBankPopDetailView.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import "PUBBankPopDetailView.h"

@interface PUBBankPopDetailView()
@property (nonatomic,strong) UILabel *tileLabel;
@property (nonatomic ,strong) UIView *contentView;
@property (nonatomic ,strong) UIView *textFieldBgView;
@property(nonatomic, strong) UILabel *contentlabel;
@end
@implementation PUBBankPopDetailView

-(instancetype)initWithWord:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if(self){
        [self certUIWord:title content:content];
    }
    return self;
}

- (void)certUIWord:(NSString *)title content:(NSString *)content
{
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444959"];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    self.tileLabel = [[UILabel alloc]qmui_initWithFont:FONT_Semibold(14.f) textColor:[UIColor whiteColor]];
    self.tileLabel.text = title;
    self.tileLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.tileLabel];
    [self.tileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(16));
    }];

    self.textFieldBgView = [[UIView alloc]init];
    self.textFieldBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12f];
    [self.textFieldBgView showRadius:12.f];
    [self.contentView addSubview:self.textFieldBgView];
    [self.textFieldBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tileLabel.mas_bottom).offset(4.f);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(40));
    }];
    
    self.contentlabel = [[UILabel alloc] qmui_initWithFont:FONT_BOLD(16.f) textColor:[UIColor whiteColor]];
    self.contentlabel.text = content;
    self.contentlabel.textAlignment = NSTextAlignmentLeft;
    [self.textFieldBgView addSubview:self.contentlabel];
    [self.contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.f);
        make.centerY.mas_equalTo(0);
    }];
}


@end
