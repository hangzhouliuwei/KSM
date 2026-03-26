//
//  PUBTools.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnNoneBlock)(void);
typedef void (^ReturnBoolBlock)(BOOL value);
typedef void (^ReturnIntBlock)(NSInteger index);
typedef void (^ReturnTwoIntBlock)(NSInteger index1, NSInteger index2);
typedef void (^ReturnDoubleBlock)(CGFloat value);
typedef void (^ReturnStrBlock)(NSString *str);
typedef void (^ReturnArrBlock)(NSArray *arr);
typedef void (^ReturnMutableArrBlock)(NSMutableArray *mutableArr);
typedef void (^ReturnDicBlock)(NSDictionary *dic);
typedef void (^ReturnObjectBlock)(id object);
typedef void (^ReturnErrorBlock)(NSError *error);
typedef void (^ReturnTwoDoubleBlock)(CGFloat value1,NSInteger value2);
typedef void (^ReturnTwoObjectBlock)(id object1,id object2);
typedef void (^ReturnTwoObjectLoginBlock)(NSInteger index,NSString *object2);
typedef void (^ReturnTwoBoolBlock)(BOOL value1, BOOL value2);

@interface PUBTools : NSObject
//根据十六进制生成颜色
+ (UIColor*) getUIColorWithHex:(int)rgbValue;
//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//判断对象是否为空
+ (BOOL)isBlankObject:(NSObject *)object;
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
//去掉首尾空格和换行
+ (NSString *)cutLeftRightBlankSpacing:(NSString *)content;
//判断手机号是否合法
+ (BOOL)isValidPhoneNo:(NSString *)phoneNo;
//判断邮箱是否合法
+ (BOOL)isValidEmail:(NSString *)email;
//手机号隐私处理(显示前三后四,中间*号)
+ (NSString*)phoneNoPrivacy:(NSString *)phoneNo;
//判断是否表情输入
+ (BOOL)stringContainsEmoji:(NSString *)string;
//获取随机数
+ (int)getRandomNumber:(int)startValue to:(int)endValue;
//计算字符串的size
+ (CGSize)getSizeByString:(NSString*)str fontValue:(CGFloat)fontValue maxSize:(CGSize)size;
+ (CGSize)getMediumSizeByString:(NSString*)str fontValue:(CGFloat)fontValue maxSize:(CGSize)size;
//显示消息框
+ (void)showToast:(NSString *)str;
//显示消息框（时间）
+ (void)showToast:(NSString *)str time:(NSTimeInterval)time;
//显示提示框
+ (void)showAlertTitle:(NSString *)title content:(NSString *)content btnText:(NSString *)btnText;
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
//改变image颜色
+ (UIImage *)resetImageName:(NSString *)name color:(UIColor *)color;
//str转base64
+ (NSString *)base64String:(NSString *)str;
//NSNumber转NSString
+ (NSString *)stringWithNumber:(NSNumber *)number;
//double转NSString
+ (NSString *)stringWithValue:(CGFloat)value;
//显示loading框
+ (void)showHud;
//显示loading框带文字描述
+ (void)showHud:(NSString *)tipsString;
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
+(NSDictionary*)getNowDeviceInfo;

/// 获取文字高度
/// - Parameters:
///   - string: <#string description#>
///   - font: <#font description#>
///   - maxWidth: <#maxWidth description#>
///   - numOfLines: <#numOfLines description#>
+ (CGFloat)getTextHeightWithString:(NSString *)string
                              font:(UIFont *)font
                          maxWidth:(CGFloat)maxWidth
                        numOfLines:(NSInteger)numOfLines;

// 获取TextView文本宽度
/// @param value 文本内容
/// @param high 限制高度
/// @param font 字体
/// @param numberOfLines 行数
+ (CGFloat)getTextVieWideForString:(NSString *)value
                           andHigh:(CGFloat)high
                           andFont:(UIFont*)font
                  andnumberOfLines:(NSInteger)numberOfLines;

//修改图片尺寸
+ (UIImage *)imageResize:(UIImage*)img
            withResizeTo:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
