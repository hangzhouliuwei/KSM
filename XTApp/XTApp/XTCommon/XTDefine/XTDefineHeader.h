//
//  XTDefineHeader.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#ifndef XTDefineHeader_h
#define XTDefineHeader_h

/**
 *获取屏幕宽高
 */
#define XT_Screen_Width                [UIScreen mainScreen].bounds.size.width
#define XT_Screen_Height               [UIScreen mainScreen].bounds.size.height

/**
 *信息条高度 iPhone X 44 其余20
 */
#define XT_StatusBar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
/**
 *是否是iPhone
 */
#define XT_Is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/**
 *导航条高度 iphone为44 iPad为50
 */
#define XT_NavBar_Height        (XT_Is_iPhone?44.0f:50.0f)
/**
 *导航条高度 + 状态条
 */
#define XT_Nav_Height        (XT_StatusBar_Height + XT_NavBar_Height)
/**
 *iPhone X 底部预留
 */
#define XT_Bottom_Height \
({float boomheight = 0.0f;\
if (@available(iOS 11.0, *)) {\
boomheight = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom ;\
}\
(boomheight);})
/**
 *tabbar高度
 */
#define XT_Tabbar_Height               (XT_Is_iPhone?(XT_Bottom_Height +49.0f):(XT_Bottom_Height == 20.0f?65.0f:50.0f))

/**
 *所有类型转化成String(防止出现nill值显示在UI)
 */
#define XT_Object_To_Stirng(object) ((object && object != (id)[NSNull null])?([object isKindOfClass:[NSString class]]?object:[NSString stringWithFormat:@"%@",object]):@"")

/**
 *Document路径
 */
#define XT_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#define XT_Locality_Url_Path ([NSString stringWithFormat:@"%@/Locality_Url.txt",XT_DocumentPath])

/**
 *获取AppDelegate
 */
#define XT_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
/**
 *创建controller
 */
#define XT_Controller_Init(controllerName) [[NSClassFromString(controllerName) alloc] init]

/**
 *字体
 */
#define XT_Font(x)     [UIFont systemFontOfSize:x]
#define XT_Font_B(x) [UIFont boldSystemFontOfSize:x]
#define XT_Font_W(x,y)  ([UIFont systemFontOfSize:x weight:y])
#define XT_Font_M(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightMedium])
#define XT_Font_SD(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightSemibold])
#define XT_Font_H(x)  ([UIFont systemFontOfSize:x weight:UIFontWeightHeavy])
/**
 *加载本地图片
 */
#define XT_Img(x)     [UIImage imageNamed:x]

/**
 *根据RGB获取color
 */
#define XT_RGBA(r,g,b,a)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define XT_RGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/**
 *获取app BundleId
 */
#define XT_App_BundleId [[NSBundle mainBundle] bundleIdentifier]
/**
 *app版本号
 */
#define XT_App_Version [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 *app名称
 */
#define XT_App_Name [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]


typedef void(^XTDicBlock)(NSDictionary *dic);
typedef void(^XTDicAndStrBlock)(NSDictionary *dic,NSString *str);
typedef void(^XTBlock)(void);
typedef void(^XTBoolBlock)(BOOL success);
typedef void(^XTStrBlock)(NSString *str);
typedef void(^XTIntBlock)(NSInteger index);
typedef void(^XTSelectBlock)(XTDicBlock block);

#ifndef __OPTIMIZE__
    //这里执行的是debug模式下，打印日志，当前行
    #define XTLog(...) printf("%s %s 第%d行: %s\n",__TIME__, __PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
        //这里执行的是release模式下，不打印日志
    #define XTLog(...)
#endif

#endif /* XTDefineHeader_h */
