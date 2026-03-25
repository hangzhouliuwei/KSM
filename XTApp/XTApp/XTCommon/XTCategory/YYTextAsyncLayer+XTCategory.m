//
//  YYTextAsyncLayer+XTCategory.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "YYTextAsyncLayer+XTCategory.h"

@implementation YYTextAsyncLayer (XTCategory)

+ (void)load {
    NSString*claName = @"YYTextAsyncLayer";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [YYTextAsyncLayer exchangeInstanceMethod:NSClassFromString(claName)
                             originalSEL:@selector(_displayAsync:)
                             swizzledSEL:@selector(xt_displayAsync:)];
#pragma clang diagnostic pop
    });

}

- (void)xt_displayAsync:(BOOL)async {
    // 添加条件判断
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) {
        // 如果宽度或高度为零，设置 contents 为 nil 并返回
        self.contents = nil;
        XTLog(@"来了");
        return;
    }
    // 调用原始的 _displayAsync: 方法
    [self xt_displayAsync:async];
}



#pragma mark - Tool
/**
  *  @brief   替换方法实现
  */
+ (void)exchangeInstanceMethod:(Class)otherClass originalSEL:(SEL)originalSEL swizzledSEL:(SEL)swizzledSEL {
    Method originalMethod = class_getInstanceMethod(otherClass, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSEL);
    
    // otherClass 添加替换后的 SEL，避免 unrecognizeSelectorSentToInstance 错误
    class_addMethod( otherClass,
                    swizzledSEL,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
    // 替换 otherClass 类的旧方法实现
    BOOL c = class_addMethod( otherClass,
                             originalSEL,
                             method_getImplementation(swizzledMethod),
                             method_getTypeEncoding(swizzledMethod));
    
    if (!c) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
