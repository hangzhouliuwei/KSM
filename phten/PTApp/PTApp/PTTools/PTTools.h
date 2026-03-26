//
//  PTTools.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
NS_ASSUME_NONNULL_BEGIN

@interface PTTools : NSObject
//判断对象是否为空
+ (BOOL)isBlankObject:(NSObject *)object;
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
//去掉首尾空格和换行
+ (NSString *)cutLeftRightBlankSpacing:(NSString *)content;
//获取随机数
+ (int)getRandomNumber:(int)startValue to:(int)endValue;
//显示消息框
+ (void)showToast:(NSString *)str;
//显示消息框（时间）
+ (void)showToast:(NSString *)str time:(NSTimeInterval)time;
//string转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//json转string
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic;
//string转arr
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
//url中文转义
+ (NSString *)urlZhEncode:(NSString *)urlStr;
//打电话
+ (void)callWithPhoneNo:(NSString *)str;
//压缩尺寸
+ (UIImage *)scaleSizeImage:(UIImage *)image toSize:(CGSize)size;
//压缩容量
+ (UIImage *)scaleBiteImage:(UIImage *)image toKBite:(NSInteger)kbite;
//点赞动画
+ (void)addAttentionAnimation:(UIView *)view;
//震动
+ (void)shake;
//str转base64
+ (NSString *)base64String:(NSString *)str;
//NSNumber转NSString
+ (NSString *)stringWithNumber:(NSNumber *)number;
//double转NSString
+ (NSString *)stringWithValue:(CGFloat)value;
//隐藏loading框
+ (void)hideHud;
//时间字符串转时间戳
+ (NSInteger)timeWithString:(NSString *)dateStr formatter:(NSString *)formatter;
//时间戳转时间字符串
+ (NSString *)stringWithTime:(NSInteger)time formatter:(NSString *)formatter;
//设置粘贴板内容
+ (void)setPasteBoardContent:(NSString *)str;
//获取粘贴板内容
+ (NSString *)getPasteBoardContent;
//通过字符串获取二维码
+ (UIImage *)creatQRcodeWithString:(NSString *)codeString size:(CGFloat)size;
//打开系统设置页面
+ (void)jumpSystemSetting;
//处理NSNumber小数点
+ (NSDecimalNumber *)formatNumber:(NSNumber *)number;
//字符串中间4位*
+ (NSString *)setNotSeeText:(NSString *)text first:(NSInteger )first last:(NSInteger)last;
//获取状态栏高度
+ (CGFloat)getStatusBarHight;
//十六进制
+ (UIColor *) colorWithHexString: (NSString *)color;
//获取当前的时间
+(NSString*)getCurrentTimes;
+(NSString *)getTime;
// 手机号 保留前3位后3位 中间星号隐藏
+(NSString *)hideMiddleDigitsForPhoneNumber:(NSString *)phoneNumber;
//调登录
+(void)checkLogin:(void (^)(NSInteger uid))afterLoginSuccess;

//!!!!: 风火轮加载信息
/**
 *  风火轮加载信息
 *
 *  @param targetView 对象
 *  @param msg        提示信息
 */
+ (void)showMBProgress:(UIView *)targetView message:(NSString *)msg;

///隐藏风火轮
+ (void)hideMBProgress:(UIView*)targetView;

///获取设备相关信息
+(NSDictionary*)getGCDeviceInfo;

/// 获取文字高度
+ (CGFloat)getTextHeightWithString:(NSString *)string
                              font:(UIFont *)font
                          maxWidth:(CGFloat)maxWidth
                        numOfLines:(NSInteger)numOfLines;

// 获取TextView文本宽度
+ (CGFloat)getTextVieWideForString:(NSString *)value
                           andHigh:(CGFloat)high
                           andFont:(UIFont*)font
                  andnumberOfLines:(NSInteger)numberOfLines;

/// 获取point
+(NSDictionary*)getPointStartTime:(NSString*)startTime
                        ProductId:(NSString*)productId
                        SceneType:(NSString*)sceneType;

///查找当前的控制器
+ (UIViewController *)findVisibleViewController;


/// 图片压塑
/// - Parameters:
///   - image: 原始图片
///   - maxSize: 指定大小Bt
///   - block: 压塑完成回调
+ (void)compressImage:(UIImage *)image
               toSize:(NSUInteger)maxSize
      completionBlock:(void (^)(NSData *compressedData, UIImage *compressedImage, BOOL isResized))completionBlock;
/// 图片压塑
/// - Parameters:
///   - image: 原始图片
///   - maxSize: 指定大小Bt
+ (NSData *)compressImage:(UIImage *)sourceImage
                   toSize:(NSUInteger)maxSize;
/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                       lineDirection:(BOOL)isHorizonal;

/// 修改图片尺寸
/// - Parameters:
///   - img: img description
///   - newSize: <#newSize description#>
+ (UIImage *)imageResize:(UIImage*)img
             andResizeTo:(CGSize)newSize;


/// 修复首次获取idfa错误
+ (void)fixTrackingAuthorizationWithCompletion:(void (^)(ATTrackingManagerAuthorizationStatus status))completion API_AVAILABLE(ios(14));

+(NSDictionary*)getStartTime:(NSString*)startTime mutenniumNc:(NSString*)mutenniumNc hytenrarthrosisNc:(NSString*)hytenrarthrosisNc;

+(NSDictionary*)urlParameFromURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
