//
//  PUBBaseViewModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBBaseViewModel.h"

@interface PUBBaseViewModel ()
@property (atomic, assign) NSInteger requestNum;
@end

@implementation PUBBaseViewModel

- (instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)showMBProgress:(UIView *)view {
    if(self.requestNum == 0) {
        [PUBTools showMBProgress:view message:@""];
    }
    self.requestNum ++;
}

-(void)hideMBProgress:(UIView *)view {
    self.requestNum --;

    if(self.requestNum == 0) {
        [PUBTools hideMBProgress:view];
    }
}

@end
