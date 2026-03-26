//
//  PUBSetView.m
//  PeraUBagProject
//
//  Created by Jacky on 2024/1/16.
//

#import "PUBSetView.h"

@interface PUBSetView ()
@property (weak, nonatomic) IBOutlet UIImageView *logImageView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation PUBSetView

+ (instancetype)createSetView{
    PUBSetView *view = [[[NSBundle mainBundle] loadNibNamed:@"PUBSetView" owner:nil options:nil] lastObject];
    return view;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.logImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBtnClick)];
    tap.numberOfTapsRequired = 10.f;
    [self.logImageView addGestureRecognizer:tap];
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavigationBarHeight);
    self.versionLabel.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}
- (IBAction)logoutAction:(id)sender {
    if (self.logoutBlock) {
        self.logoutBlock();
    }
}
- (IBAction)cancelAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)changeBtnClick
{
    if(self.logImageBlock){
        self.logImageBlock();
    }
}

@end
