//
//  PUBDefineManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#ifndef PUBDefineManager_h
#define PUBDefineManager_h

#define NotNull(str) [PUBTools isBlankString:str]?@"":str
#define StrValue(value, dotNum) [NSString stringWithFormat:[NSString stringWithFormat:@"%%.%df",dotNum],(double)value]
#define STR_FORMAT(format, args...) [NSString stringWithFormat:format, args]
#define ImageWithName(name) [UIImage imageNamed:name]
#define URLEncode(urlstring) [NSURL URLWithString:[PBTools urlZhEncode:urlstring]]
#define NotArrayNull(array) (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0)
#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define UIColorFromHexF(s,f)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:f]

#define LeftMargin              15
#define TopSpace                12
#define SafeWidth               (SCREEN_WIDTH - 2*LeftMargin)
#define KSCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)
#define KSCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)
#define KStatusBarHeight         ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define KNavigationBarHeight     (44 + [PUBTools getStatusBarHight])
#define KTabBarHeight            ([PUBTools getStatusBarHight] > 20 ? 83 : 49)
#define KSafeAreaBottomHeight    ([PUBTools getStatusBarHight] > 20 ? 34 : 0)
#define WScale                   (SCREEN_WIDTH/375)            // 宽度比例 - 相对于6s

#define TOP_WINDOW [[[UIApplication sharedApplication] windows] firstObject]
#define IOS_VRESION_8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define IOS_VRESION_9  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
#define IOS_VRESION_10  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10)
#define IOS_VRESION_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11)
#define IOS_VRESION_12  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12)
#define IOS_VRESION_13  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13)
#define IOS_VRESION_14  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 14)

#define FONT(value) [UIFont systemFontOfSize:value]
#define FONT_BOLD(value) [UIFont boldSystemFontOfSize:value]
#define FONT_Semibold(value) ([UIFont systemFontOfSize:value weight:UIFontWeightSemibold])
#define FONT_MED_SIZE(A)  ([UIFont systemFontOfSize:(A) weight:UIFontWeightMedium])

#define COLORA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define COLOR(r,g,b) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0]
#define ClearColor [UIColor clearColor]
#define TextBlackColor COLOR(33,33,33)
#define MainColor COLOR(255,213,47)
#define TextGrayColor COLOR(117,117,117)
#define TextLightGrayColor COLOR(189,189,189)
#define LineGrayColor COLOR(241,241,241)
#define ViewLightGrayColor COLOR(224,224,224)
#define BlackColor COLOR(51,51,51)
#define LoginSelectColor COLOR(16,180,142)
#define MainBgColor [UIColor qmui_colorWithHexString:@"#252735"];

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

#define DragViewNotifiName @"DragViewNotifiName"

#define TALK_EVENT(event)                           [FETrackManager trackEvent:event]
#define TALK_EVENT_LABEL(event,label)               [FETrackManager trackEvent:event label:label]
#define TALK_EVENT_DATA(event,dic)                  [FETrackManager trackEvent:event data:dic]
#define TALK_EVENT_LABEL_DATA(event,label,dic)      [FETrackManager trackEvent:event label:label data:dic]
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

#endif /* PUBDefineManager_h */
