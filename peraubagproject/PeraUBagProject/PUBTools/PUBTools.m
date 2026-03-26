//
//  PUBTools.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#import "PUBTools.h"
#import "PUBNavigationController.h"
#import "PUBLoginViewController.h"

@implementation PUBTools

+ (UIColor*) getUIColorWithHex:(int)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(10, 10)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color setFill];
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

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

+ (BOOL)isValidPhoneNo:(NSString *)phoneNo {
    NSString *emailRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:phoneNo];
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString*)phoneNoPrivacy:(NSString *)phoneNo {
    if ([self isBlankString:phoneNo] || ![self isValidPhoneNo:phoneNo]) {
        return @"";
    }else{
        return STR_FORMAT(@"%@****%@", [phoneNo substringToIndex:3], [phoneNo substringFromIndex:7]);
    }
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (int)getRandomNumber:(int)startValue to:(int)endValue {
    int intVal = (int)(startValue + (arc4random() % (endValue - startValue + 1)));
    return intVal;
}

+ (CGSize)getSizeByString:(NSString*)str fontValue:(CGFloat)fontValue maxSize:(CGSize)size {
    NSDictionary *attrs = @{NSFontAttributeName : FONT(fontValue)};
    CGSize sizeaa = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return sizeaa;
}

+ (CGSize)getMediumSizeByString:(NSString*)str fontValue:(CGFloat)fontValue maxSize:(CGSize)size {
    NSDictionary *attrs = @{NSFontAttributeName : FONT_BOLD(fontValue)};
    CGSize sizeaa = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return sizeaa;
}

+ (void)showToast:(NSString *)str {
    [PUBTools showToast:str time:2.0];
}

+ (void)showToast:(NSString *)str time:(NSTimeInterval)time {
    if (str.length == 0) {
        return;
    }
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:TOP_WINDOW.bounds];
    bgView.userInteractionEnabled = YES;
    
    float viewWith = SCREEN_WIDTH / 2;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 10.f, viewWith - 20, 0)];
    [label setText:str];
    [label setNumberOfLines:0];
    [label setFont:FONT(15)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label sizeToFit];

    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, label.width + 20, label.height + 20)];
    grayView.layer.cornerRadius = 10;
    grayView.backgroundColor = COLORA(0.2f, 0.2f, 0.2f, 0.6f);
    [grayView addSubview:label];
    [bgView addSubview:grayView];
    grayView.center = bgView.center;
    
    [TOP_WINDOW addSubview:bgView];
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         grayView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         [NSTimer scheduledTimerWithTimeInterval:time-0.4f
                                                          target:self
                                                        selector:@selector(hideTip:)
                                                        userInfo:bgView
                                                         repeats:NO];
                     }];
}

+ (void)hideTip:(NSTimer *)timer {
    UIView* flashTipView = (UIView *)[timer userInfo];
    [UIView animateWithDuration:0.2f
                     animations:^{
                         flashTipView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [flashTipView removeFromSuperview];
                     }];
}

+ (void)showAlertTitle:(NSString *)title content:(NSString *)content btnText:(NSString *)btnText {
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:btnText style:UIAlertActionStyleCancel handler:nil];
//    [cancelAction setValue:MainColor forKey:@"_titleTextColor"];
//    [alertVC addAction:cancelAction];
//    [VCManager presentViewController:alertVC animated:YES completion:nil];
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
    if ([PUBTools isBlankString:urlStr]) {
        return @"";
    }
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

+ (void)callWithPhoneNo:(NSString *)str {
    if ([PUBTools isBlankString:str]) {
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

+ (UIImage *)resetImageName:(NSString *)name color:(UIColor *)color {
    UIImage *image = ImageWithName(name);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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

+ (void)showHud {
    [self showHud:@""];
}

+ (void)showHud:(NSString *)tipsString {
    if ([UIApplication sharedApplication].keyWindow) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        if (tipsString.length > 0) {
            UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            tips.text = tipsString;
            tips.textColor = TextBlackColor;
            tips.font = FONT(12);
            tips.textAlignment = NSTextAlignmentCenter;
            tips.centerY = hud.height/2 + 50;
            [hud addSubview:tips];
        }
    }
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    NSURL *fileUrl = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]URLForResource:@"fun_escape_loading" withExtension:@"gif"];
//    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);//将GIF图片转换成对应的图片源
//    size_t frameCout = CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
//    NSMutableArray *frames = [[NSMutableArray alloc] init];
//    for (size_t i = 0; i < frameCout; i++){
//        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
//        UIImage *image = [UIImage imageWithCGImage:imageRef];
//        CGFloat scale = [[UIScreen mainScreen] scale];
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 60), NO, scale);
//        [image drawInRect:CGRectMake(0, 0, 30, 60)];
//        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [frames addObject:newImage];
//        CGImageRelease(imageRef);
//    }
//    UIImageView *imageview = [[UIImageView alloc] init];
//    imageview.frame = CGRectMake(0, 0, 50, 50);
//    imageview.animationImages = frames;
//    imageview.animationDuration = 0.7;
//    [imageview startAnimating];
//
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = ClearColor;
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.backgroundColor = ClearColor;
//    hud.customView = imageview;
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
    PUBLoginViewController *loginVC = [[PUBLoginViewController alloc]init];
    PUBNavigationController *navigationController = [[PUBNavigationController alloc] initWithRootViewController:loginVC];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    if(afterLoginSuccess){
        loginVC.loginResultBlock = afterLoginSuccess;
    }
    [VCManager  presentViewController:navigationController animated:YES completion:nil];
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
+(NSDictionary*)getNowDeviceInfo
{
    NSDictionary *undeserving_egDic = @{
                                      @"nightmarish_eg":NotNull([NSObject getAvailableDiskSize]),
                                      @"atwirl_eg": NotNull([NSObject getTotalDiskSize]),
                                      @"tranquilite_eg": NotNull([NSObject getTotalMemorySize]),
                                      @"reintroduce_eg": NotNull([NSObject getAvailableMemorySize]),
                                      };
    NSDictionary *battery_statusDic = @{
                                      @"sejant_eg":@([NSObject getBatteryQuantity]),
                                      @"battery_status":@([NSObject getBatteryStatus] ? 1 : 0),
                                      @"alcidine_eg": @([NSObject getAlcidine] ? 1 : 0),
                                      };
    
        NSDictionary *hardwareDic = @{
                                      @"social_eg":NotNull([NSObject getIOSVersion]),
                                      @"spectrobolometer_eg":@"iPhone",
                                      @"humidifier_eg": NotNull([NSObject getMobileStyle]),
                                      @"agape_eg":@([NSObject getScreenHeight]),
                                      @"pipa_eg":@([NSObject getScreenWidth]),
                                      @"catchlight_eg":NotNull([NSObject physicalDimensions]),
                                      @"groundfire_eg":@([NSObject getAbsoluteTime])
                                      };
    
          NSDictionary *suk_egDic = @{
                                      @"psychometrical_eg":@"0",
                                      @"panmunjom_eg":@([NSObject isSimulator] ? 1 : 0),
                                      @"remunerative_eg": @([NSObject isJailbroken] ? 1 : 0),
                                      };
      NSDictionary *magnesium_egDic = @{
                                        @"fungus_eg":NotNull([NSObject timeZone]),
                                        @"tutorly_eg":@([NSObject isUsingProxy] ? 1 : 0),
                                        @"diacetyl_eg": @([NSObject getIsVPNOn] ? 1 : 0),
                                        @"nim_eg":NotNull([NSObject getPhoneOperator]),
                                        @"prevailing_eg": NotNull([NSObject getIDFV]),
                                        @"dauber_eg":NotNull([NSObject lanuage]),
                                        @"oxidative_eg":NotNull([NSObject getNetworkType]),
                                        @"loathsome_eg":@(1),
                                        @"inhabitable_eg":NotNull([NSObject getWANIPAddress]),
                                       };
    NSMutableDictionary *magnesium_egMutalbeDic = [NSMutableDictionary dictionaryWithDictionary:magnesium_egDic];
    [NSObject getIdfa:^(NSString *idfa) {
        magnesium_egMutalbeDic[@"routh_eg"] = NotNull(idfa);
    }];
    
    NSDictionary *narcocatharsis_egDic = @{
                                            @"essay_eg":NotNull([NSObject getBSSID]),
                                            @"guyot_eg":NotNull([NSObject getWifiName]),
                                            @"karstification_eg":NotNull([NSObject getBSSID]),
                                            @"rhodo_eg":NotNull([NSObject getWifiName]),
                                           };

    
    
    NSDictionary *chalky_egDic = @{@"narcocatharsis_eg":@[narcocatharsis_egDic]};
    
    NSDictionary *dic = @{
                          @"undeserving_eg": undeserving_egDic,
                          @"battery_status":battery_statusDic,
                          @"hardware":hardwareDic,
                          @"suk_eg":suk_egDic,
                          @"magnesium_eg":magnesium_egMutalbeDic,
                          @"chalky_eg":chalky_egDic,
                         };
    return dic;

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

//修改图片尺寸
+ (UIImage *)imageResize:(UIImage*)img withResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
