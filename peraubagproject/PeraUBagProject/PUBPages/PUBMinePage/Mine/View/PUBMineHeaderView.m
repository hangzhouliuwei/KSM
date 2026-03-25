//
//  PUBMineHeaderView.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/15.
//

#import "PUBMineHeaderView.h"

@interface PUBMineHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation PUBMineHeaderView

+ (PUBMineHeaderView *)createHeader{
    PUBMineHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"PUBMineHeaderView" owner:nil options:nil] lastObject];
    return view;
}
- (void)updateUIWithUsername:(NSString *)phone{
    self.phone.text = [self subStringWithString:phone];
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
        NSLog(@"结果字符串： %@", resultString);
    } else {
        return originalString;
        NSLog(@"字符串长度不足");
    }
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 103);

}
- (IBAction)goSetting:(id)sender {
    if (self.goSetBlock) {
        self.goSetBlock();
    }
}
@end
