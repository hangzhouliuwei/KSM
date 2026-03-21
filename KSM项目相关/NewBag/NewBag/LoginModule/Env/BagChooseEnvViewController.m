//
//  BagChooseEnvViewController.m
//  NewBag
//
//  Created by Jacky on 2024/5/16.
//

#import "BagChooseEnvViewController.h"
#import <YYCache/YYCache.h>
@interface BagChooseEnvViewController ()<UITextFieldDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation BagChooseEnvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTitle = @"Choose Env";
    self.leftTitleColor = @"#333333";
    self.navigationController.delegate = self;
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    if ([cache objectForKey:cacheHostURL]) {
        self.textfield.text = (NSString *)[cache objectForKey:cacheHostURL];
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    if (isSelf) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

//从输入框读
- (IBAction)switchAction:(UIButton *)sender {
    [self btnAnimation:sender];
    NSString *inputHost = self.textfield.text;
    if (inputHost == nil || inputHost == 0) {
        [self showToast:@"host illegality" duration:1.5];
        return;
    }

    if (![inputHost hasPrefix:@"https://"] && ![inputHost hasPrefix:@"http://"]) {
        [self showToast:@"host illegality" duration:1.5];
        return;
    }
    if (![inputHost hasSuffix:@"/"]) {
        inputHost = [inputHost stringByAppendingString:@"/"];
    }
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    [cache setObject:inputHost forKey:cacheHostURL];
    
     [[BagUserManager shareInstance] logout];

     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         exit(0);
     });
    
}
//切换到正式环境
- (IBAction)switchFormalAction:(UIButton *)sender {
    [self btnAnimation:sender];
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    NSString *url = (NSString *)[cache objectForKey:cacheHostURL];
    if ([url isEqual:Host]) {
        [self showToast:@"当前已经是正式环境!" duration:1.5];
        return;
    }
    [cache setObject:Host forKey:cacheHostURL];
   
    [[BagUserManager shareInstance] logout];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
    
}
- (IBAction)switchTestAction:(id)sender {
    [self btnAnimation:sender];
    YYCache *cache = [[YYCache alloc] initWithName:cacheName];
    NSString *host = (NSString *)[cache objectForKey:cacheHostURL];
    if ([host isEqual: TestHost]) {
        [self showToast:@"当前已经是测试环境!" duration:1.5];
        return;
    }
    [cache setObject:TestHost forKey:cacheHostURL];
    
    [[BagUserManager shareInstance] logout];
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}
- (void)btnAnimation:(UIButton *)sender{
    CGRect bounds = sender.bounds;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        sender.bounds =CGRectMake(bounds.origin.x - 20, bounds.origin.y, bounds.size.width+60, bounds.size.height);
        sender.enabled = false;
    } completion:^(BOOL finished) {
        sender.enabled = YES;
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 50) {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textfield resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textfield resignFirstResponder];
}
@end
