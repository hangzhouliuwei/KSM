//
//  BagMeHeaderView.m
//  NewBag
//
//  Created by Jacky on 2024/3/30.
//

#import "BagMeHeaderView.h"

@interface BagMeHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *borrowBgView;
@property (weak, nonatomic) IBOutlet UIView *orderBgView;
@property (weak, nonatomic) IBOutlet UIImageView *iocnReImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *iconNfImgeView;
@property (weak, nonatomic) IBOutlet UIButton *reArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *nfArrowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *myNorImageView;

@end

@implementation BagMeHeaderView

+ (instancetype)createHeader{
    BagMeHeaderView *view =[Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return view;
}
- (void)updateUIWithPhone:(NSString *)phone
{
    self.phoneLabel.text = [self subStringWithString:[BagUserManager shareInstance].username];
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth, 255);

}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.iocnReImgeView sd_setImageWithURL:[Util loadImageUrl:@"icon_re"]];
    [self.iconNfImgeView sd_setImageWithURL:[Util loadImageUrl:@"icon_nf"]];
    [self.myNorImageView sd_setImageWithURL:[Util loadImageUrl:@"icon_my_nor"]];
    [self.reArrowBtn sd_setImageWithURL:[Util loadImageUrl:@"icon-more"] forState:UIControlStateNormal];
    [self.nfArrowBtn sd_setImageWithURL:[Util loadImageUrl:@"icon-more"] forState:UIControlStateNormal];
    [self.setBtn sd_setImageWithURL:[Util loadImageUrl:@"icon-setings"] forState:UIControlStateNormal];
    [self br_setGradientColor:[UIColor qmui_colorWithHexString:@"#205EAB"] toColor:[UIColor qmui_colorWithHexString:@"#13407C"] direction:BRDirectionTypeTopToBottom bounds:CGRectMake(0, 0, kScreenWidth, 255)];
    [self.borrowBgView br_setGradientColor:[UIColor qmui_colorWithHexString:@"#1C5194"] toColor:[UIColor qmui_colorWithHexString:@"#1D5194"] direction:BRDirectionTypeTopToBottom bounds:CGRectMake(0, 0, (kScreenWidth - 28 -7)/2, 64)];
    [self.orderBgView br_setGradientColor:[UIColor qmui_colorWithHexString:@"#1C5194"] toColor:[UIColor qmui_colorWithHexString:@"#1D5194"] direction:BRDirectionTypeTopToBottom bounds:CGRectMake(0, 0, (kScreenWidth - 28 -7)/2, 64)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBorringOrder)];
    [self.borrowBgView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAllOrder)];
    [self.orderBgView addGestureRecognizer:tap2];
    
}
- (NSString *)subStringWithString:(NSString *)originalString{
    
    
    // 截取左边3位和右边3位字符
    // 计算需要截取的长度
    NSUInteger leftLength = 3;
    NSUInteger rightLength = 3;
    
    // 确保原始字符串长度足够
    if(originalString.length >= leftLength + rightLength) {
        // 截取左边三位
        NSString *leftPart = [originalString substringToIndex:leftLength];
        
        // 计算中间需要星号替换的长度
        NSUInteger starLength = originalString.length - leftLength - rightLength;
        
        // 生成星号字符串
        NSString *starString = @"*";
        for(int i = 0; i < starLength; i++) {
            starString = [starString stringByAppendingString:@"*"];
        }
        // 截取右边三位
        NSString *rightPart = [originalString substringFromIndex:leftLength + starLength];
        
        // 合并字符串
        NSString *resultString = [NSString stringWithFormat:@"%@%@%@", leftPart, starString, rightPart];
        
        // 输出结果
        return resultString;
    } else {
        return originalString;
    }
}
- (void)goBorringOrder{
    if (self.goBorringOrderBlock) {
        self.goBorringOrderBlock();
    }
}
- (void)goAllOrder{
    if (self.goAllOrderBlock) {
        self.goAllOrderBlock();
    }
    
}
- (IBAction)toSettingAction:(id)sender {
    if (self.goSettingBlock) {
        self.goSettingBlock();
    }
}

@end
