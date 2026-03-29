//
//  PPDefineHeader.h
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#ifndef PPDefineHeader_h
#define PPDefineHeader_h

typedef void (^CallBackInt)(NSInteger index);
typedef void (^CallBackBool)(BOOL value);
typedef void (^CallBackArr)(NSArray *arr);
typedef void (^CallBackDic)(NSDictionary *dic);
typedef void (^CallBackStr)(NSString *str);
typedef void (^CallBackObject)(id object);
typedef void (^CallBackNone)(void);

#define StrValue(value)             [NSString stringWithFormat:[NSString stringWithFormat:@"%%.%df",0],(double)value]
#define StrFormat(format, args...)  [NSString stringWithFormat:format, args]
#define ImageWithName(name)         [UIImage imageNamed:name]

#define SafeWidth                   (ScreenWidth - 2*LeftMargin)
#define ScreenWidth                 ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight                ([UIScreen mainScreen].bounds.size.height)
#define StatusBarHeight             (([UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height) ?: 20)
#define NavBarHeight                (44.0 + StatusBarHeight)
#define TabBarHeight                (StatusBarHeight > 20 ? 83.0 : 49.0)
#define LeftMargin                  16.0
#define SafeBottomHeight            (StatusBarHeight > 20 ? 34.0 : 0)
#define WS                          (ScreenWidth/375.0)

#define TopWindow                   [[UIApplication sharedApplication] windows].firstObject
#define kWeakself                   __weak typeof(self) weakSelf = self

#define COLOR(r,g,b)                [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0]
#define COLORA(r,g,b,a)             [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define rgba(r,g,b,a)               [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define BGColor                     COLOR(247, 251, 255)
#define TextGrayColor               COLOR(118, 118, 130)
#define MainColor                   COLOR(63, 121, 194)
#define LightMainColor              COLOR(240, 237, 244)
#define TextLightColor              COLOR(176, 177, 184)
#define ShadowColor                 COLORA(0, 0, 0, 0.1)
#define TextBlackColor              COLOR(27, 22, 34)
#define LineGrayColor               COLOR(226, 234, 238)

#define Font(value)                 [UIFont systemFontOfSize:value]
#define FontCustom(value)           [UIFont fontWithName:@"Carter One" size:value]
#define FontBold(value)             [UIFont boldSystemFontOfSize:value]

// 单例.h文件
#define SingletonH(name)           + (instancetype)shared##name;

// 单例.m文件
#define SingletonM(name) \
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


#endif /* PPDefineHeader_h */
