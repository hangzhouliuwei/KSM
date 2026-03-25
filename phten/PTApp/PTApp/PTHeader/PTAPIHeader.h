//
//  PTAPIHeader.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/17.
//

#ifndef PTAPIHeader_h
#define PTAPIHeader_h

///--------公用block
typedef void(^PTBlock)(void);
typedef void(^PTFloBlock)(float f);
typedef void(^PTIntBlock)(NSInteger index);
typedef void(^PTBoolBlock)(BOOL isYes);
typedef void(^PTStrBlock)(NSString *str);
typedef void(^PTDicBlock)(NSDictionary *dic);
typedef void(^PTSelectBlock)(PTDicBlock block);
typedef void (^PTTwoObjectBlock)(NSInteger index,NSString *object2);

static NSString * const AppName = @"PesoPeso";

static NSString * const PTbaseUrl = @"https://api.next-horizon-lendinginc.com/api/";//http://api-10i.ph.dev.ksmdev.top/api/
static NSString * const PTWebbaseUrl = @"https://api.next-horizon-lendinginc.com";//http://api-10i.ph.dev.ksmdev.top
static NSString * const PTPrivacy  =  @"/#/privacyAgreement";
///GoogleMarket
static NSString *const PTGoogleMarket = @"tencr/market";
///上传adid
static NSString *const PTUpdataAdid = @"tencr/aio";
///位置上报
static NSString *const PTUpdateLocation = @"tencr/location";
///设备信息上报
static NSString *const PTUpdateDevice = @"tencr/device";
///获取登录/注册短信验证码
static NSString *const PTGetLonginCode = @"tencp/get_code";
//验证码登陆/注册
static NSString *const PTGetLongin = @"tencp/login";
//APP首页接口请求
static NSString *const PTHomeIndex = @"tench/index";
//个人中心接口请求
static NSString *const PTMineIndex = @"tench/home";
//退出登录
static NSString *const PTSettLogout = @"tencp/logout";
//准入
static NSString *const PTHomeApply = @"tennv2/gce/apply";
//产品详情
static NSString *const PTHomeDetail = @"tennv2/gce/detail";
//跟进订单号获取跳转地址
static NSString *const PTHomeOrderPush = @"tennv2/gce/push";

//初始化基础信息
static NSString *const PTInitBasic = @"tenca/person";
//保存基础信息（第一项）
static NSString *const PTSaveBasic = @"tenca/person_next";

//紧急联系人初始化接口 (第二项)
static NSString *const PTGetContact = @"tenca/contact";
//保存紧急联系人数据 (第二项)
static NSString *const PTSaveContact = @"tenca/contact_next";

//上传证件照片初始化接口（第三项）
static NSString *const PTGetIdentify =@"tenca/photo";
//ocr上传接口(advance ai)（第三项）
static NSString *const PTUploadOcr = @"tenca/ocr";
//点击next保存该认证项信息（第三项）
static NSString *const PTSaveIdentify = @"tenca/photo_next";

//活体认证初始化接口（第四项）
static NSString *const PTInitLive =@"tenca/auth";
//活体认证次数限制接口(advance ai)（第四项）
static NSString *const PTLimitLive = @"tenca/limit";
//活体授权接口(advance ai)（第4项）
static NSString *const PTLicenseLive = @"tenca/license";
//活体认证上传接口(advance ai)（第四项）
static NSString *const PTDetectionLive =@"tenca/detection";
//活体保存（第四项）
static NSString *const PTSaveLive = @"tenca/saveauth";
//Advance Ai活体识别错误上报
static NSString *const PTLiveError = @"tenca/auth_err";

//银行卡初始化接口（第五项）
static NSString *const PTGetCard = @"tenca/card";
//保存银行卡信息（第五项）
static NSString *const PTSaveCard = @"tenca/card_next";

static NSString *const PTBuglyKey = @"cef35d0426";
#endif /* PTAPIHeader_h */
