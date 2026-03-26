//
//  PUBBankPopView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBBankPopView : UIView
@property (nonatomic, copy) ReturnNoneBlock cancelBlock;
@property (nonatomic, copy) ReturnArrBlock confirmBlock;
- (instancetype)initWithWord:(NSArray<NSString*>*)wordArr;
- (void)show;
@end

NS_ASSUME_NONNULL_END
