//
//  PUBPhoneNoInputView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PUBPhoneNoInputView : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) ReturnIntBlock inputBlock;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)becomeFirstResponder;
@end

NS_ASSUME_NONNULL_END
