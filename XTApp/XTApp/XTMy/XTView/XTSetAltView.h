//
//  XTSetAltView.h
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTSetAltView : UIView

-(id)initWithAlt:(NSString *)alt;

@property(nonatomic,copy) XTBlock sureBlock;
@property(nonatomic,copy) XTBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
