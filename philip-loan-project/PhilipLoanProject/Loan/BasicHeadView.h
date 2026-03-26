//
//  BasicHeadView.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicHeadView : UIView


@property(nonatomic)NSInteger index;


-(instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
