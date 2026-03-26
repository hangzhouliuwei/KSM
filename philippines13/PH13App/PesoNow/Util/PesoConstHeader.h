//
//  PesoConstHeader.h
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#ifndef PesoConstHeader_h
#define PesoConstHeader_h

typedef void(^PHBlock)(void);
typedef void(^PHFloBlock)(float f);
typedef void(^PHIntBlock)(NSInteger index);
typedef void(^PHBoolBlock)(BOOL isYes);
typedef void(^PHStrBlock)(NSString *str);
typedef void(^PHDicBlock)(NSDictionary *dic);

static NSString * const AppName = @"Pera Bag";
static NSString * const APiBaseUrl = @"https://api.blnylendingcorp.com/api/";//http://api-13i.ph.dev.ksmdev.top/api/
static NSString * const WebBaseUrl = @"https://api.blnylendingcorp.com";
static NSString * const Privacy  =  @"/#/privacyAgreement";
static NSString * const  BuglyAppId = @"cef35d0426";

#endif /* PesoConstHeader_h */
