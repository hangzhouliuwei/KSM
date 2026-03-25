//
//  PTTools.m
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import "PTTools.h"

@implementation PTTools


+ (BOOL)isBlankObject:(NSObject *)object {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string caseInsensitiveCompare:@"null"] == NSOrderedSame) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    if([string isEqualToString: @"(null)"]){
        return YES;
    }
    
    return NO;
}

+ (NSString *)cutLeftRightBlankSpacing:(NSString *)content {
    NSString *newContent = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return newContent;
}



+ (int)getRandomNumber:(int)startValue to:(int)endValue {
    int intVal = (int)(startValue + (arc4random() % (endValue - startValue + 1)));
    return intVal;
}

+ (void)showToast:(NSString *)str {
    [PTTools showToast:str time:2.0];
}

+ (void)showToast:(NSString *)str time:(NSTimeInterval)time {
    if (str.length == 0) {
        return;
    }
    [QMUITips showWithText:str inView:KEYWINDOW hideAfterDelay:time];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典转json字符串方法

 + (NSString *)jsonStringWithDictionary:(NSDictionary *)dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err){
        NSLog(@"arr解析失败：%@",err);
        return nil;
    }
    return arr;
}

+ (NSString *)urlZhEncode:(NSString *)urlStr {
    if ([PTTools isBlankString:urlStr]) {
        return @"";
    }
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

+ (void)callWithPhoneNo:(NSString *)str {
    if ([PTTools isBlankString:str]) {
        return;
    }
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (temp.length == 0) {
        return;
    }
    NSMutableString *callStr=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",temp];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr]];
}

+ (UIImage *)scaleSizeImage:(UIImage *)image toSize:(CGSize)size{
    if (image.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }
    return image;
}

+ (UIImage *)scaleBiteImage:(UIImage *)image toKBite:(NSInteger)kbite {
    if (!image) {
        return image;
    }
    kbite*=1024;
    CGFloat scale = 0.9f;
    CGFloat maxScale = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, scale);
    while ([imageData length] > kbite && scale > maxScale) {
        scale -= 0.1;
        imageData = UIImageJPEGRepresentation(image, scale);
    }
    return [UIImage imageWithData:imageData];
}

+ (void)compressImage:(UIImage *)image toSize:(NSUInteger)maxSize completionBlock:(void (^)(NSData *compressedData, UIImage *compressedImage, BOOL isResized))completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat compressionQuality = 0.5f;
        NSData *compressedImageData = UIImageJPEGRepresentation(image, compressionQuality);
        
        if (compressedImageData && compressedImageData.length <= maxSize) {
            NSLog(@"lw======>图片压缩直接成功");
            // 如果图片已经小于或等于目标大小，直接返回
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(compressedImageData, image, NO);
            });
            return;
        }
        
        while (compressionQuality > 0.1) {
            NSLog(@"lw======>图片压缩中");
            compressionQuality -= 0.1;
            compressedImageData = UIImageJPEGRepresentation(image, compressionQuality);
            
            if (compressedImageData && compressedImageData.length <= maxSize) {
                // 如果压缩后的数据满足要求，跳出循环
                UIImage *compressedImage = [UIImage imageWithData:compressedImageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(compressedImageData, compressedImage, YES);
                });
                return;
            }
        }
        
        // 未能成功压缩到指定大小时返回nil
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil, image, YES);
        });
    });
}

+ (NSData *)compressImage:(UIImage *)sourceImage toSize:(NSUInteger)maxSize
{
    CGFloat compressionQuality = 0.8f; // 设置初始压缩比例为0.8（可根据需求调整）
    NSData *imageData = UIImageJPEGRepresentation(sourceImage, compressionQuality);
    
    // 如果初始压缩后的图像数据已经小于等于目标大小，直接返回
    if (imageData.length <= maxSize) {
        return imageData;
    }
    
    while (compressionQuality > 0.1) {
        compressionQuality -= 0.1; // 逐渐降低压缩比例直到达到目标大小或无法再次压缩
        NSData *compressedData = UIImageJPEGRepresentation(sourceImage, compressionQuality);
        
        if (compressedData.length <= maxSize || compressionQuality <= 0.1) {
            // 若压缩后的图像数据小于等于目标大小或压缩比例已经降低到0.1，则返回压缩后的数据
            return compressedData;
        }
    }
    
    return nil; // 未能成功压缩到指定大小时返回nil
}

+ (void)addAttentionAnimation:(UIView *)view {
    //大小缩放
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@(0.1),@(2),@(0.7),@(1.3),@(1.0)];
//        scale.duration = 0.5;
    scale.calculationMode = kCAAnimationLinear;
    //透明度
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.values = @[@(1),@(0.3),@(1),@(0.8),@(1.0)];
    opacity.calculationMode = kCAAnimationLinear;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scale, opacity];
    animationGroup.duration = 0.5;
    [view.layer addAnimation:animationGroup forKey:nil];
    [self shake];
}

+ (void)shake {
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
    }
}


+ (NSString *)base64String:(NSString *)str {
    if (!str) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    if (!base64Str) {
        base64Str = @"";
    }
    return base64Str;
}

+ (NSString *)stringWithNumber:(NSNumber *)number {
    NSString *value = STR_FORMAT(@"%lf", number.doubleValue);
    NSDecimalNumber *decNum = [[NSDecimalNumber alloc] initWithString:value];
    NSString *string =  decNum.stringValue;
    return string;
}

+ (NSString *)stringWithValue:(CGFloat)value {
    if (!value || value == 0) {
        return @"0";
    }
    NSString *str = STR_FORMAT(@"%.2f", value);
    if ([str containsString:@".00"]) {
        str = [str substringToIndex:str.length - 3];
    }
    return str;
}

+ (void)hideHud {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (NSInteger)timeWithString:(NSString *)dateStr formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSInteger time = (long)[date timeIntervalSince1970];
    return time;
}

+ (NSString *)stringWithTime:(NSInteger)time formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [NSDate  dateWithTimeIntervalSince1970:time];;
    return [dateFormatter stringFromDate:date];
}

+ (void)setPasteBoardContent:(NSString *)str {
    [[UIPasteboard generalPasteboard] setString:str];
}

+ (NSString *)getPasteBoardContent {
    return [[UIPasteboard generalPasteboard] string];
}

+ (UIImage *)creatQRcodeWithString:(NSString *)codeString size:(CGFloat)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data  = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGRect rect = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(rect), size/CGRectGetHeight(rect));
    size_t width = CGRectGetWidth(rect) * scale;
    size_t height = CGRectGetHeight(rect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:rect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, rect, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *codeImage = [UIImage imageWithCGImage:scaledImage];
    
    UIGraphicsBeginImageContext(codeImage.size);
    [codeImage drawInRect:CGRectMake(0, 0, codeImage.size.width, codeImage.size.height)];
//    UIImage *centerImg = ImageWithName(@"app_icon");
//    CGFloat centerW = codeImage.size.width*0.3;
//    CGFloat centerH = centerW;
//    CGFloat centerX = (codeImage.size.width - centerW)*0.5;
//    CGFloat centerY = (codeImage.size.height - centerH)*0.5;
//    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return codeImage;
}

+ (void)jumpSystemSetting {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        // Fallback on earlier versions
    }
}

+ (NSDecimalNumber *)formatNumber:(NSNumber *)number {
    NSString *value = STR_FORMAT(@"%.2lf", number.doubleValue);
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:value];
    return decimalNumber;
}

+ (NSString *)setNotSeeText:(NSString *)text first:(NSInteger )first last:(NSInteger)last {
    NSString *newText = @"";
    if (text.length <= 6 && text.length>1) {
        NSString *firstString = [text substringWithRange:NSMakeRange(0, 1)];
        NSString *lastString = [text substringWithRange:NSMakeRange(text.length-1, 1)];
        newText = STR_FORMAT(@"%@**%@", firstString,lastString);
    }else if (text.length == 1){
        newText = text;
    }else{
        for (int i = 0; i < text.length; i++) {
            NSString *itemString = [text substringWithRange:NSMakeRange(i, 1)];
            if (i < first) {
                newText = [newText stringByAppendingString:itemString];
            }else if (i >= text.length - last) {
                newText = [newText stringByAppendingString:itemString];
            }else {
                if (![newText containsString:@"****"]) {
                    newText = [newText stringByAppendingString:@"****"];
                }
            }
        }
    }
    return newText;
}

+ (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//获取当前的时间
+(NSString*)getCurrentTimes{
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
 //现在时间,你可以输出来看下是什么格式
 NSDate *datenow = [NSDate date];
    NSLog(@"datenow = %@",datenow);
 //----------将nsdate按formatter格式转成nsstring
 NSString *currentTimeString = [formatter stringFromDate:datenow];
 NSLog(@"currentTimeString = %@",currentTimeString);
 return currentTimeString;
}

+(NSString *)getTime{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

// 手机号 保留前3位后3位 中间星号隐藏
+(NSString *)hideMiddleDigitsForPhoneNumber:(NSString *)phoneNumber {
   if (phoneNumber.length > 6) {
       NSString *firstThreeDigits = [phoneNumber substringToIndex:3];
       NSString *lastThreeDigits = [phoneNumber substringFromIndex:phoneNumber.length - 3];
       NSString *hiddenDigits = @"";
       for (NSInteger i = 3; i < phoneNumber.length - 3; i++) {
           hiddenDigits = [hiddenDigits stringByAppendingString:@"*"];
       }
       return [NSString stringWithFormat:@"%@%@%@", firstThreeDigits, hiddenDigits, lastThreeDigits];
   } else {
       return phoneNumber;
   }
}

+(void)checkLogin:(void (^)(NSInteger uid))afterLoginSuccess
{
    //GCLoginController *loginVC = [[GCLoginController alloc]init];
//    GCNavigationController *navigationController = [[GCNavigationController alloc] initWithRootViewController:loginVC];
//    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
//    if(afterLoginSuccess){
//        loginVC.loginResultBlock = afterLoginSuccess;
//    }
//    [VCManager.navigationController  presentViewController:navigationController animated:YES completion:^{}];
}

+ (void)showMBProgress:(UIView *)targetView message:(NSString *)msg
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView ? targetView : TOP_WINDOW  animated:YES];
        
    });
}

+ (void)hideMBProgress:(UIView*)targetView
{
    dispatch_async(dispatch_get_main_queue(), ^{
       [MBProgressHUD hideHUDForView:targetView? targetView:TOP_WINDOW animated:YES];
    });
}

///获取设备相关信息
+(NSDictionary*)getGCDeviceInfo
{
//    NSDictionary *semiliteracyGDic = @{
//                                      @"savonaG":NotNull([NSObject getAvailableDiskSize]),
//                                      @"extravaganceG": NotNull([NSObject getTotalDiskSize]),
//                                      @"dactylographyG": NotNull([NSObject getTotalMemorySize]),
//                                      @"culmG": NotNull([NSObject getAvailableMemorySize]),
//                                      };
//    
//    NSDictionary *battery_statusDic = @{
//                                      @"queenlyG":@([NSObject getBatteryQuantity]),
//                                      @"battery_status":@([NSObject getBatteryStatus] ? 1 : 0),
//                                      @"divotG": @([NSObject getAlcidine] ? 1 : 0),
//                                      };
//    
//        NSDictionary *hardwareDic = @{
//                                      @"reexaminationG":NotNull([NSObject getIOSVersion]),
//                                      @"indurateG":@"iPhone",
//                                      @"mesochroicG": NotNull([NSObject getMobileStyle]),
//                                      @"sophiG":@([NSObject getScreenHeight]),
//                                      @"aimG":@([NSObject getScreenWidth]),
//                                      @"declarerG":NotNull([NSObject physicalDimensions]),
//                                      @"staminalG":@([NSObject getAbsoluteTime])
//                                      };
//    
//          NSDictionary *blentGDic = @{
//                                      @"extensiveG":@"0",
//                                      @"vmiG":@([NSObject isSimulator] ? 1 : 0),
//                                      @"nodousG": @([NSObject isJailbroken] ? 1 : 0),
//                                      };
//      NSDictionary *fireguardGDic = @{
//                                        @"cicatricialG":NotNull([NSObject timeZone]),
//                                        @"belletristG":@([NSObject isUsingProxy] ? 1 : 0),
//                                        @"towermanG": @([NSObject getIsVPNOn] ? 1 : 0),
//                                        @"evictG":NotNull([NSObject getPhoneOperator]),
//                                        @"coownerG": NotNull([NSObject getIDFV]),
//                                        @"quinidineG":NotNull([NSObject lanuage]),
//                                        @"sarreG":NotNull([NSObject getNetworkType]),
//                                        @"tropaeolineG":@(1),
//                                        @"dissonanceG":NotNull([NSObject getIPaddress]),
//                                       };
//    NSMutableDictionary *magnesium_egMutalbeDic = [NSMutableDictionary dictionaryWithDictionary:fireguardGDic];
//    [NSObject getIdfa:^(NSString *idfa) {
//        magnesium_egMutalbeDic[@"aristocratismG"] = NotNull(idfa);
//    }];
//    
//    NSDictionary *narcocatharsis_egDic = @{
//                                            @"gondoleG":NotNull([NSObject getBSSID]),
//                                            @"hyperacidityG":NotNull([NSObject getWifiName]),
//                                            @"vaselineG":NotNull([NSObject getBSSID]),
//                                            @"trampleG":NotNull([NSObject getWifiName]),
//                                           };
//
//    
//    
//    NSDictionary *chalky_egDic = @{@"slavistG":@[narcocatharsis_egDic]};
//    
//    NSDictionary *dic = @{
//                          @"semiliteracyG": semiliteracyGDic,
//                          @"battery_status":battery_statusDic,
//                          @"hardware":hardwareDic,
//                          @"blentG":blentGDic,
//                          @"fireguardG":magnesium_egMutalbeDic,
//                          @"ratlineG":chalky_egDic,
//                         };
    return @{};

}


+ (CGFloat)getTextHeightWithString:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth numOfLines:(NSInteger)numOfLines
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth, MAXFLOAT)];
    lab.font = font;
    lab.text = string;
    lab.numberOfLines = numOfLines;
    [lab sizeToFit];
    return lab.frame.size.height;
}


/// 获取TextView文本宽度
/// @param value 文本内容
/// @param font 字体
/// @param numberOfLines 行数
+ (CGFloat)getTextVieWideForString:(NSString *)value andHigh:(CGFloat)high andFont:(UIFont*)font andnumberOfLines:(NSInteger)numberOfLines{
    UILabel *remarkLabel = [[UILabel alloc] init];
    remarkLabel.font = font;
    remarkLabel.text = value;
    remarkLabel.numberOfLines = numberOfLines;
    CGSize size  = [remarkLabel sizeThatFits:CGSizeMake(0, high)];
    return size.width;
    
}

+(NSDictionary*)getPointStartTime:(NSString*)startTime ProductId:(NSString*)productId SceneType:(NSString*)sceneType
{
//    NSDictionary *pointDic = @{
//                                @"bookmakingG":@(startTime.integerValue),
//                                @"geocentricG":NotNull(productId),
//                                @"birchG": NotNull(sceneType),
//                                @"scissileG": @(GCLocation.latitude),
//                                @"embodyG": @(GCLocation.longitude),
//                                @"backpackG": NotNull([NSObject getIDFV]),
//                                @"bitG": @([GCTools getTime].integerValue)
//                              };
//    
    
    return @{};
    
}

//查找当前的控制器
+ (UIViewController *)findVisibleViewController {
    UIViewController* currentViewController = (UIViewController*)PTVCRouter.navVC;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
               NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
                if (childViewControllerCount > 0) {
                    currentViewController = currentViewController.childViewControllers.lastObject;
                    return currentViewController;
                } else {
                    return currentViewController;
                }
            }
        }
    }
    
    return currentViewController;
}


/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setBounds:lineView.bounds];

    if (isHorizonal) {

        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];

    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {

        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

//修改图片尺寸
+ (UIImage *)imageResize:(UIImage*)img andResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen]scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/// 修复首次获取idfa错误
+ (void)fixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14))
{
    
    if (@available(iOS 14.0, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusDenied && [ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
                    // 检测到 iOS 17.4 ATT 错误
                    NSLog(@"检测到 iOS 17.4 ATT 错误");
                    if (@available(iOS 15.0, *)) {
                        __weak typeof(self) weakSelf = self;
                        __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                            NSLog(@"进入=====进入高版本逻辑1");
                            [[NSNotificationCenter defaultCenter] removeObserver:observer];
                            [weakSelf fixTrackingAuthorizationWithCompletion:completion];
                        }];
                    } else {
                        // 早期版本的处理方式
                        // 可以在这里添加适当的回退处理
                        // 确保 completion 在主线程上执行
                        if (completion) {
                            NSLog(@"进入=====进入高版本逻辑2");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(status);
                            });
                        }
                    }
                } else {
                    // 未检测到 ATT 错误，直接返回授权状态
                    if (completion) {
                        NSLog(@"进入=====进入高版本逻辑3");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(status);
                        });
                    }
                }
            }];
        }
}


+(NSDictionary*)getStartTime:(NSString*)startTime mutenniumNc:(NSString*)mutenniumNc hytenrarthrosisNc:(NSString*)hytenrarthrosisNc
{
    NSDictionary *dic = @{
                                @"detenamatoryNc":@(startTime.integerValue),
                                @"mutenniumNc":PTNotNull(mutenniumNc),
                                @"hytenrarthrosisNc": PTNotNull(hytenrarthrosisNc),
                                @"botenomofoNc": PTNotNull(PTLocation.latitude),
                                @"untenevoutNc": PTNotNull(PTLocation.longitude),
                                @"catencotomyNc": PTNotNull([PTDeviceInfo idfv]),
                                @"untenulyNc": @([PTTools getTime].integerValue)
                              };
    return dic;
}


+(NSDictionary*)urlParameFromURL:(NSURL *)url
{
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray<NSURLQueryItem *> *queryItems = urlComponents.queryItems;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *queryItem in queryItems) {
        [params setObject:queryItem.value forKey:queryItem.name];
    }
    
    return params;
}

@end
