//
//  PesoLiveView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoLiveView.h"
@interface PesoLiveView()
@property (nonatomic, strong) QMUILabel *descL;
@property (nonatomic, strong) UIImageView *image;
@end
@implementation PesoLiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = UIColor.whiteColor;
    QMUILabel *descL = [[QMUILabel alloc] qmui_initWithFont:PH_Font_SD(15) textColor:ColorFromHex(0x0B2C04)];
    descL.frame = CGRectMake(50, 25, kScreenWidth-100, 42);
    descL.textAlignment = NSTextAlignmentCenter;
    descL.numberOfLines = 0;
    descL.text = @"To ensure it is operated by yourself,\n we needs to verify your identity.";
    [self addSubview:descL];
    _descL = descL;
    
    UIImageView *image  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_image_normal"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.frame = CGRectMake(0, descL.bottom, 210, 210);
    image.centerX = kScreenWidth/2;
    image.userInteractionEnabled = YES;
    [self addSubview:image];
    _image = image;
    
    QMUIButton *startBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(30, image.bottom+6, kScreenWidth-60, 50);
    [startBtn setTitle:@"Start" forState:UIControlStateNormal];
    startBtn.backgroundColor = ColorFromHex(0xFCE815);
    startBtn.titleLabel.font = PH_Font_B(18);
    [startBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    startBtn.layer.cornerRadius = 25;
    startBtn.layer.masksToBounds = YES;
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:startBtn];
    
    UIImageView *bottomImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_image_bottom"]];
    bottomImage.contentMode = UIViewContentModeScaleAspectFit;
    bottomImage.frame = CGRectMake(0, startBtn.bottom+40, 307, 132);
    bottomImage.userInteractionEnabled = YES;
    bottomImage.centerX = kScreenWidth/2;

    [self addSubview:bottomImage];
}
- (void)updateUIFail
{
    _descL.text = @"Authentication failed, please try again";
    _descL.textColor = ColorFromHex(0xDF3047);
    _image.image = [UIImage imageNamed:@"live_image_fail"];
}
- (void)startAction{
    if (self.startBlock) {
        self.startBlock();
    }
}
@end
