//
//  Header.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#ifndef Header_h
#define Header_h
#import <MMKV.h>
#import <SVProgressHUD.h>

#define kURLDomain @"https://api-12i.ph.dev.ksmdev.top/api"

//#define kURL(url) [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]
#define kURL(url) [NSURL URLWithString:url]

//#define kURLDomain @"http://api.oragon-lending.com/api"

#define kIsLoginKey @"kIsLoginKey"
#define kSessionIDKey @"kSessionIDKey"
#define kTokenKey @"kTokenKey"
#define kUserIdKey @"kUserIdKey"
#define kReviewKey @"kReviewKey"
#define kPhoneKey @"kPhoneKey"
#define kNameKey @"kNameKey"
#define kMMKV [MMKV defaultMMKV]
#define kWindow ((AppDelegate *)[UIApplication sharedApplication].delegate).window
#define kBoldFontSize(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define kFontSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define kStatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kTopHeight (kStatusHeight + 44)
#define kBottomSafeHeight (kStatusHeight != 20 ? 34 : 0)
#define kBottomHeight (kBottomSafeHeight + 49)
#define kImageName(imageName) [UIImage imageNamed:imageName]
#define kHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define kAlphaHexColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define kStringHexColor(hexString) \
({ \
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; \
    if ([colorString hasPrefix:@"#"]) colorString = [colorString substringFromIndex:1]; \
    UIColor *color = nil; \
    if ([colorString length] == 6) { \
        unsigned int rgbValue = 0; \
        [[NSScanner scannerWithString:colorString] scanHexInt:&rgbValue]; \
        color = [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
                                 blue:((float)(rgbValue & 0x0000FF))/255.0 \
                                alpha:1.0]; \
    } else { \
        color = [UIColor clearColor]; \
    } \
    color; \
})


#define kWeakSelf typeof(self) __weak weakSelf = self;
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define kWhiteColor kHexColor(0xffffff)
#define kBlackColor_333333 kHexColor(0x333333)

#define kGrayColor_C9C9C9 kHexColor(0xC9C9C9)
#define kGrayColor_F9F9F9 kHexColor(0xF9F9F9)
#define kGrayColor_999999 kHexColor(0x999999)

#define kBlueColor_0053FF kHexColor(0x0053ff)
#define kBlueColor_3274FD kHexColor(0x3274FD)


#define kOrderChangeIndexNotification @"kOrderChangeIndexNotification"


#define kShowLoading [SVProgressHUD showWithStatus:nil];
#define kHideLoading [SVProgressHUD dismiss];

NS_INLINE void kPLPPopInfoWithStr(NSString *info) {
    [SVProgressHUD showInfoWithStatus:info];
}

//NS_INLINE void kHideLoading(void) {
//    
//}

//static NSString *const bugKey  = @"f580be5e21";

#endif /* Header_h */
