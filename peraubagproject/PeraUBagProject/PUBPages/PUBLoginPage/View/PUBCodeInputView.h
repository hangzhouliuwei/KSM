//
//  PUBCodeInputView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define AuthCodeLength  6

@interface PUBCodeInputView : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) ReturnStrBlock finishBlock;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)reloadUI;

@end

NS_ASSUME_NONNULL_END
