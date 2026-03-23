//
//  PTHeader.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#ifndef PTHeader_h
#define PTHeader_h


#define PTNotNull(str) [PTTools isBlankString:str] ? @"" : str
#define PTAUTOSIZE(A) ([[UIScreen mainScreen] bounds].size.width*A/375)
#define STR_FORMAT(format, args...) [NSString stringWithFormat:format, args]
#define TOP_WINDOW [[[UIApplication sharedApplication] windows] firstObject]
#define PTImageWithName(name) [UIImage imageNamed:name]

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kIs_iphone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f && kIs_iphone

#define PT_Font(x)     [UIFont systemFontOfSize:x]
#define PT_Font_Light(x) [UIFont systemFontOfSize:x weight:UIFontWeightLight]
#define PT_Font_B(x) [UIFont boldSystemFontOfSize:x]
#define PT_Font_W(x,y)  ([UIFont systemFontOfSize:x weight:y])
#define PT_Font_M(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightMedium])
#define PT_Font_SD(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightSemibold])
#define PT_Font_H(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightHeavy])
    
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)( kIs_iPhoneX? (44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (CGFloat)(44.f)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
 /*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

#define kSafeAreaBottomHeight    (kStatusBarHeight > 20 ? 34 : 0)
//导航条高度 + 状态条
#define kNavHeight        (kStatusBarHeight + kNavBarHeight)

//刘海屏 底部预留
#define KBottomHeight \
({float boomheight = 0.0f;\
if (@available(iOS 11.0, *)) {\
boomheight = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom ;\
}\
(boomheight);})


#define appDelegate        ((KDAppDelegate *)[[UIApplication sharedApplication] delegate])
#define KEYWINDOW       ([UIApplication sharedApplication].keyWindow)
#define STATUSBAR  [[UIApplication sharedApplication] statusBarFrame].size.height
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA_HEX(v, a) [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 green:((float)(((v) & 0xFF00) >> 8))/255.0 blue:((float)((v) & 0xFF))/255.0 alpha:(a)]
#define PTUIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]


#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

#define XPOINTOF(view) view.frame.origin.x
#define YPOINTOF(view) view.frame.origin.y
#define WIDTHOF(view) view.frame.size.width
#define HEIGHTOF(view) view.frame.size.height
#define MOVEVIEWTOX(view, x) view.frame = CGRectMake(x, YPOINTOF(view), WIDTHOF(view), HEIGHTOF(view))
#define MOVEVIEWTOY(view, y) view.frame = CGRectMake(XPOINTOF(view), y, WIDTHOF(view), HEIGHTOF(view))
#define CHANGEWIDTHOFVIEW(view, width) view.frame = CGRectMake(XPOINTOF(view), YPOINTOF(view), width, HEIGHTOF(view))
#define CHANGEHEIGHTOFVIEW(view, height) view.frame = CGRectMake(XPOINTOF(view), YPOINTOF(view), WIDTHOF(view), height)
#define LOADIMAGE(file,ext) [UIImage imageNamed:(file)]
#define GBSTR_FROM_DATA(data) [[NSString alloc] initWithData: (data) encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSChineseSimplif)]


#define INT2STRING(intValue) [NSString stringWithFormat:@"%d", intValue]
#define INT2NUMBER(intValue) [NSNumber numberWithInt:intValue]
#define O2STR(obj) (obj ? [NSString stringWithFormat:@"%@", obj] : @"")
#define IDTOSTRING(idValue) (([idValue isKindOfClass:[NSString class]] && ![idValue isEqualToString:@"0"]) ? idValue : (([idValue isKindOfClass:[NSNumber class]] && ![idValue isEqual:@0]) ? O2STR(idValue) : @""))

#define iPhone4 CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define iPhone5 CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define iPhone6 CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define iPhone6p CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define iPhoneX CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)

#define ERROR_DOMAIN(domain) [NSString stringWithFormat:@"com.koudai.error.%@", domain]
#define API_ERRMSG(error) [error.userInfo objectForKey:@"message"] ? [error.userInfo objectForKey:@"message"] : @"接口错误"


#define WIDTHRADIUS WIDTHOFSCREEN/375.0
#define HEIGHTRADIUS HEIGHTOFSCREEN/667.0
#define ICONRADIUS (WIDTHOFSCREEN <= 375.0 ? 1 : 414.0 / 375.0)
#define FONTRADIUS(a) (WIDTHOFSCREEN == 375.0 ? a : WIDTHOFSCREEN == 414.0 ? a+1 : a-1)
#define IOSVERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

#define APPVERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])// 获取app版本号

// 单例.h文件
#define SINGLETON_H(name) + (instancetype)shared##name;

// 单例.m文件
#define SINGLETON_M(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}


#ifdef DEBUG

#define NSLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] )
#endif


#endif /* PTHeader_h */
