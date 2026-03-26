//
//  PUBBasicCountDownView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBBasicCountDownView : UIView
@property(nonatomic, assign) NSInteger countTime;
@property(nonatomic, copy) ReturnNoneBlock countDownEndBlock;
@end

NS_ASSUME_NONNULL_END
