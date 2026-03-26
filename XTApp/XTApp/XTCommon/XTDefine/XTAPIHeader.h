//
//  XTAPIHeader.h
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#ifndef XTAPIHeader_h
#define XTAPIHeader_h

#import <Foundation/Foundation.h>

///请求域名
#define XT_Api_domain @"https://api-16i.ph.dev.ksmdev.top"//@"https://api.providence-lending-corp.com"//
//#define XT_Api_domain @"https://api.providence-lending-corp.com"
#define XT_Api_api @"/api"
#define XT_Api ([NSString stringWithFormat:@"%@%@",XT_Api_domain,XT_Api_api])
#define XT_Privacy_Url ([NSString stringWithFormat:@"%@/#/privacyAgreement",XT_Api_domain])


typedef enum : NSUInteger {
    XT_BackType_W,
    XT_BackType_B,
} XT_BackType;

typedef enum : NSUInteger {
    XT_Verify_Base,
    XT_Verify_Contact,
    XT_Verify_Identifcation,
} XT_VerifyType;

#endif /* XTAPIHeader_h */
