//
//  UITextField+VerCodeTF.m
//  Test1
//
//  Created by cxn on 2023/7/20.
//

#import "UITextField+VerCodeTF.h"
#import <objc/runtime.h>

@implementation UITextField (VerCodeTF)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(vc_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

/**
 当删除按钮点击是触发的事件
 */
- (void)vc_deleteBackward {
    [self vc_deleteBackward];
     
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <VerCodeTFDelegate> delegate  = (id<VerCodeTFDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
}
 
@end
