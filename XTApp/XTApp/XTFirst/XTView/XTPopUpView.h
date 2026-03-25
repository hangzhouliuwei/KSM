//
//  XTPopUpView.h
//  XTApp
//
//  Created by xia on 2024/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTPopUpView : UIView

- (instancetype)initImg:(NSString *)imgUrl url:(NSString *)url text:(NSString *)text;

@property(nonatomic,copy) XTBlock closeBlock;

@end

NS_ASSUME_NONNULL_END
