//
//  BagBankSegmentView.m
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import "BagBankSegmentView.h"

@interface BagBankSegmentView ()
@property (weak, nonatomic) IBOutlet UIButton *walletBtn;
@property (weak, nonatomic) IBOutlet UIView *walletLine;
@property (weak, nonatomic) IBOutlet UIButton *bankBtn;
@property (weak, nonatomic) IBOutlet UIView *bankLine;

@end
@implementation BagBankSegmentView
+ (instancetype)createView{
    BagBankSegmentView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return view;
}
- (void)setSelecctIndex:(NSInteger)selecctIndex
{
    _selecctIndex = selecctIndex;
    [self updateUIWithSelectIndex:selecctIndex];
}
- (void)updateUIWithSelectIndex:(NSInteger)index{
    if (index == 0) {
        self.walletLine.hidden = NO;
        self.bankLine.hidden = YES;
        [self.walletBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"] forState:UIControlStateNormal];
        [self.bankBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#252E41"] forState:UIControlStateNormal];
    }else{
        self.walletLine.hidden = YES;
        self.bankLine.hidden = NO;
        [self.bankBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#0EB479"] forState:UIControlStateNormal];
        [self.walletBtn setTitleColor:[UIColor qmui_colorWithHexString:@"#252E41"] forState:UIControlStateNormal];
    }
}
- (IBAction)walletClickAction:(id)sender {
    [self updateUIWithSelectIndex:0];
    self.selecctIndex = 0;
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}
- (IBAction)bankClickAction:(id)sender {
    [self updateUIWithSelectIndex:1];
    self.selecctIndex = 1;
    self.clickBlock(1);
}

@end
