//
//  LoginRegistViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPLoginRegistViewController.h"
#import "PLPCodeViewController.h"
#import "PLPWebViewController.h"
@interface PLPLoginRegistViewController ()<UITextFieldDelegate>

@property(nonatomic)UITextField *phoneTF;
@property(nonatomic)UIButton *selectedButton;
@end

@implementation PLPLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideServeImageView = true;
}
-(void)goButtonAction:(UIButton *)button
{
    NSString *phone = _phoneTF.text;
    if([phone isReal]) {
        if (phone.length < 8 || phone.length > 15) {
            kPLPPopInfoWithStr(@"Enter a valid phone number.");
            return;
        }
        if (!self.selectedButton.selected) {
            kPLPPopInfoWithStr(@"Please agree to the terms.");
            return;
        }
        NSString *timeKey = [NSString stringWithFormat:@"%@_time",phone];
        NSString *countKey = [NSString stringWithFormat:@"%@_count",phone];
        if ([kMMKV containsKey:timeKey]) {
            NSDate *lastDate = [kMMKV getDateForKey:timeKey];
            NSInteger lastCount = [kMMKV getInt64ForKey:countKey];
            NSDate *date = [NSDate date];
            if ([date timeIntervalSinceDate:lastDate] < 60 && lastCount > 0) {
                PLPCodeViewController *vc = [PLPCodeViewController new];
                vc.phoneStr = phone;
                vc.lastCount = lastCount;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
        }
        kShowLoading
        [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelvecp/get_code" paramsInfo:@{@"chretwelveographyNc":phone,@"betytwelveNc":@"juyttrr"} successBlk:^(id  _Nonnull responseObject) {
            kHideLoading
            kPLPPopInfoWithStr(responseObject[@"frwntwelveNc"]?:@"");
            PLPCodeViewController *vc = [PLPCodeViewController new];
            vc.phoneStr = phone;
            [self.navigationController pushViewController:vc animated:YES];
        } failureBlk:^(NSError * _Nonnull error) {
            
        }];
    }else
    {
        kPLPPopInfoWithStr(@"Enter the account details.");
    }
}


-(void)handleSelectedButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {
        return true;
    }
    if (textField.text.length >= 15) {
        return false;
    }
    return YES;
}

-(void)BASE_GenerateSubview
{
    [self.view addSubview:self.baseImageView];
    
    CGFloat scale = 375 / 260.0;
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / scale)];
    headImageView.image = kImageName(@"base_head_medium");
    [self.view addSubview:headImageView];
    UIView *logoBgView = [[UIView alloc] initWithFrame:CGRectMake((kScreenW - 250) / 2.0, kStatusHeight + 30, 125, 35)];
    [headImageView addSubview:logoBgView];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    iconImageView.image = kImageName(@"logo");
//    iconImageView.backgroundColor = UIColor.redColor;
    [logoBgView addSubview:iconImageView];
    iconImageView.userInteractionEnabled = headImageView.userInteractionEnabled = true;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6 + iconImageView.right, 0, logoBgView.width - (6 + iconImageView.right), logoBgView.height)];
    [label pp_setPropertys:@[@"Cashhere", kBoldFontSize(20),kWhiteColor]];
    
    label.width = [label.text widthWithFont:label.font];
    [logoBgView addSubview:label];
    logoBgView.width = label.width + 6 + iconImageView.width;
    logoBgView.left = (kScreenW - logoBgView.width) / 2.0;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW - 300) / 2.0, logoBgView.bottom + 27, 300, 47)];
    [valueLabel pp_setPropertys:@[[PLPCommondTools formatterUnitValue:@"20000"], kWhiteColor, kBoldFontSize(34), @(NSTextAlignmentCenter)]];
    [self.view addSubview:valueLabel];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, valueLabel.bottom, kScreenW, 20)];
    [desLabel pp_setPropertys:@[@"Maximum Borrowable Amount", kAlphaHexColor(0xffffff, 0.6), kFontSize(14), @(NSTextAlignmentCenter)]];
    [self.view addSubview:desLabel];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, headImageView.bottom - 14, kScreenW, kScreenH - (headImageView.bottom - 14))];
    bgView.backgroundColor = kWhiteColor;
    [self.view addSubview:bgView];
    [bgView clipTopLeftAndTopRightCornerRadius:14];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, bgView.width - 2 * 20, 40)];
    [tipLabel pp_setPropertys:@[kFontSize(14),kBlackColor_333333,@"Log in to experience personal loan services now"]];
    tipLabel.height = [tipLabel.text heightWithWidth:tipLabel.width font:tipLabel.font];
    [bgView addSubview:tipLabel];
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 9 + tipLabel.bottom, bgView.width - 40, 50)];
    _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSForegroundColorAttributeName:kGrayColor_C9C9C9,NSFontAttributeName:kFontSize(16)}];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 49, 50)];
    [codeLabel pp_setPropertys:@[@"+63",kBlackColor_333333,@(NSTextAlignmentCenter),kFontSize(16)]];
    [leftView addSubview:codeLabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(codeLabel.right, (leftView.height - 17)/ 2.0, 1, 17)];
    line.backgroundColor = kBlueColor_0053FF;
    [leftView addSubview:line];
    _phoneTF.leftView = leftView;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.backgroundColor = kGrayColor_F9F9F9;
    _phoneTF.layer.cornerRadius = 4;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.delegate = self;
    [bgView addSubview:self.phoneTF];
    PLPCapsuleButton *goButton = [[PLPCapsuleButton alloc]initWithFrame:CGRectMake(20, 30 + _phoneTF.bottom, kScreenW - 40, 50)];
    [goButton setTitle:@"Let's go" forState:UIControlStateNormal];
    goButton.titleLabel.font = kFontSize(16);
    [goButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(goButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:goButton];
    
    UIView *privicyView = [[UIView alloc] initWithFrame:CGRectMake(15, 13 + goButton.bottom, kScreenW - 2 * 20, 20)];
    EnlargeButton *button = [EnlargeButton buttonWithType:UIButtonTypeCustom];
    button.hitTestEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    button.frame = CGRectMake(0, 5, 13, 13);
    [button setBackgroundImage:kImageName(@"privicy_normal") forState:UIControlStateNormal];
    [button setBackgroundImage:kImageName(@"privicy_selected") forState:UIControlStateSelected];
    [button addTarget:self action:@selector(handleSelectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = true;
    self.selectedButton = button;
    [privicyView addSubview:button];
    YYLabel *infoLabel = [[YYLabel alloc] initWithFrame:CGRectMake(18, 5, privicyView.width - 18, 54)];
    [privicyView addSubview:infoLabel];
    NSString *text = @"I have read and agree with the Privacy Agreement";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:kFontSize(13),NSForegroundColorAttributeName:kGrayColor_C9C9C9}];
    infoLabel.numberOfLines = 0;
    kWeakSelf
    [attStr yy_setTextHighlightRange:[text rangeOfString:@"Privacy Agreement"] color:kBlueColor_0053FF backgroundColor:UIColor.clearColor userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf jumpToWebWithURL:@"https://www.oragon-lending.com/#/privacyagreement"];
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    }];
    infoLabel.attributedText = attStr;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(infoLabel.width, 9999) text:attStr];
    infoLabel.height = layout.textBoundingSize.height;
    [privicyView addSubview:infoLabel];
    [bgView addSubview:privicyView];
    
#if DEBUG
//    _phoneTF.text = @"9710121212";
    
//    49949496154661
    //9710121212      121212
//    self.selectedButton.selected = YES;
//    [self goButtonAction:nil];
    
//    CodeViewController *vc = [CodeViewController new];
//    vc.phoneStr = @"12314";
//    [self.navigationController pushViewController:vc animated:YES];
    
    
#endif
    
}
-(void)jumpToWebWithURL:(NSString *)url
{
    PLPWebViewController *vc = [[PLPWebViewController alloc] init];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
