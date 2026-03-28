//
//  BagChooseEnvPassView.m
//  NewBag
//
//  Created by Jacky on 2024/5/16.
//

#import "BagChooseEnvPassView.h"

@interface BagChooseEnvPassView ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
@implementation BagChooseEnvPassView
+ (instancetype)createView
{
    BagChooseEnvPassView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BagChooseEnvPassView.class) owner:nil options:nil]lastObject];
    return view;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClick)];
    [self addGestureRecognizer:tap];
}
- (void)bgClick{
    [self removeFromSuperview];
}
- (void)show{
    [UIApplication.sharedApplication.windows.firstObject addSubview:self];
}
- (IBAction)submitAction:(id)sender {
    if ([self.textfield.text isEqual:@"ksm2023"]) {
        [self.textfield resignFirstResponder];
        [self removeFromSuperview];
        //成功
        if (self.succeedBlock) {
            self.succeedBlock();
        }
    }else{
        if (self.failBlock) {
            self.failBlock();
        }
    }
}

@end
