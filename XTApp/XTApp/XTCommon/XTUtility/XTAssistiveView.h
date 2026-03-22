//
//  XTAssistiveView.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTAssistiveView : UIView

+ (instancetype)xt_share;

-(void)xt_showIcon:(NSString *)icon url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
