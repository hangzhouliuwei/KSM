//
//  BagOrderNodataView.m
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import "BagOrderNodataView.h"

@implementation BagOrderNodataView

+ (instancetype)createView{
    BagOrderNodataView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    return view;
}
- (IBAction)applyAction:(id)sender {
    if (self.applyBlock) {
        self.applyBlock();
    }
}

@end
