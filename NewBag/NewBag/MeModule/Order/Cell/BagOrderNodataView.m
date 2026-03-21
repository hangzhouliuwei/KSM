//
//  BagOrderNodataView.m
//  NewBag
//
//  Created by Jacky on 2024/4/15.
//

#import "BagOrderNodataView.h"

@interface BagOrderNodataView()
@property (weak, nonatomic) IBOutlet UIImageView *orderNodataImageView;


@end

@implementation BagOrderNodataView

+ (instancetype)createView{
    BagOrderNodataView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];;
    [view.orderNodataImageView sd_setImageWithURL:[Util loadImageUrl:@"ordr_nodata"]];
    return view;
}


- (IBAction)applyAction:(id)sender {
    if (self.applyBlock) {
        self.applyBlock();
    }
}

@end
