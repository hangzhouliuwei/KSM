//
//  PUBAPIDefineManager.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#ifndef PUBAPIDefineManager_h
#define PUBAPIDefineManager_h

//数据上报
#define PB_report_location                 @"pera_report/location"//上报位置信息
#define PB_report_google_Market            @"pera_report/market"//google_market上报
#define PB_report_detail                   @"pera_report/detail"//场景设备信息上报
#define PB_report_point                    @"pera_report/point"//上报风控埋点
#define PB_report_device                   @"pera_report/device"//设备信息上报详细信息
#define PB_report_contents                 @"pera_report/contents"//上报通讯录
#define PB_report_app_contents             @"pera_report/contents"//上报APP应用 短信列表

//是否开启注册埋点
#define PB_openZhucemaindian               @"pera_person/is_point"
#define PB_zhucemaindian                   @"pera_person/point"

//协议
#define PB_loginAndHome                    @"#/privacyAgreement"

//login
#define PB_codeNum                         @"pera_person/get_code"
#define PB_login                           @"pera_person/login"
#define PB_loginout                        @"pera_person/logout"

//home
#define PB_home                            @"pera_home/index"
#define PB_home_pop                        @"pera_home/pop-up"
#define PB_product_apply                   @"v2/pera_ept/apply" //点击申请
#define PB_product_detail                  @"v2/pera_ept/detail"

//mine
#define PB_mine                            @"pera_home/home"

//auth
#define PB_wenJuan                         @"pera_auth/quest"
#define PB_wenJuan_save                    @"v2/pera_auth/person_next"

#define PB_city                            @"pera_home/city"

#define PB_person                          @"pera_auth/person"
#define PB_person_save                     @"pera_auth/person_next"
#define PB_confirm_personal_info           @"/ph/certify/confirm-personal-info"

#define PB_work                            @"pera_auth/work"
#define PB_work_save                       @"pera_auth/work_next"


#define PB_basic                            @"ph/v2/certify/basic-info"
#define PB_basic_save                       @"ph/v2/certify/save-basic-info"

#define PB_contact                         @"v2/pera_auth/contact"
#define PB_contact_save                    @"v2/pera_auth/contact_next"



#define PB_photo                           @"v2/pera_auth/photo"//上传证件照片初始化接口

#define PB_huoti_auth_limit                @"pera_auth/limit"//活体认证次数限制接口
#define PB_huoti_auth                      @"pera_auth/auth"//活体授权接口(advance ai)
#define PB_huoti_upload                    @"v2/pera_auth/detection"//活体认证上传接口
#define PB_ocr_upload                      @"v2/pera_auth/ocr"//ocr上传接口(advance ai)
#define PB_huoti_upload_false              @"pera_auth/auth_err"//Advance Ai活体识别错误上报

#define PB_ocr_upload                      @"v2/pera_auth/ocr"//ocr上传接口
#define PB_image_upload                    @"pera_auth/image"//图片上传接口
#define PB_tark_TestPoin5                  @"testPoint5"//埋点上报方便测试查看

#define PB_photo_save                      @"v2/pera_auth/photo_next"//点击next保存该认证项信息
#define PB_lives_save                      @"v2/pera_auth/saveauth"//点击next保存该认证项信息

#define PB_bank_card                       @"v2/pera_auth/card"//银行卡初始化接口
#define PB_bank_card_save                  @"v2/pera_auth/card_next"//保存银行卡信息

#define PB_city_list                       @"pera_home/city"//城市列表

//order
#define PB_Order_list                      @"pera_order/list"//订单列表
#define PB_genjin_Order                    @"v2/pera_ept/push"//跟进订单号获取跳转地址


//用户登录注册时获取短信验证码
static NSString * const SendSmsCode = @"/eagleUser/dlnadmnale";
//验证码登陆/注册
static NSString * const SmsCodeLogin = @"/eagleUser/ofilethvhori";
//首页展示接口请求
static NSString * const LoanData = @"/eagleIndex/eahsrhohsi";
//上报位置信息
static NSString * const UploadLocatio = @"/eagleData/seonesaguelo";
//google_market上报
static NSString * const googleMarket = @"/eagleData/ssaomoe";
//点击申请产品
static NSString * const productApply = @"/v2/eagleProduct/crerrc";
//设备信息上报详细信息
static NSString * const uploadDevice = @"/eagleData/hmneoh";
//产品详情
static NSString * const prodDetail = @"/v2/eagleProduct/edinnrestnd";
//跟进订单号获取跳转地址
static NSString * const productPush = @"/v2/eagleProduct/tonroul";
//初始化基础信息（第一项）
static NSString * const certifyInfo = @"ph/v2/certify/basic-info";
//保存基础信息（第一项）
static NSString * const saveBasicInfo = @"/v2/eagleInput/gltln";
//紧急联系人初始化接口 (第二项)
static NSString * const certifyContact = @"/v2/eagleInput/lcnltsido";
//保存紧急联系人数据 (第二项)
static NSString * const saveEmergencyContact = @"/v2/eagleInput/dieisllyylrt";
//上传证件照片初始化接口（第三项）
static NSString * const certifyPhotos = @"/v2/eagleInput/lest";
//ocr上传接口(advance ai)（第三项）
static NSString * const uploadOcrImage = @"/v2/eagleInput/aekhiw";
//点击next保存该认证项信息（第三项）
static NSString * const saveIdPhoto = @"/v2/eagleInput/sryeahiho";
//活体认证初始化接口（第四项）
static NSString * const certifyLiveness = @"/v2/eagleInput/nhhhseojfrmg";
//活体认证次数限制接口(advance ai)（第四项）
static NSString * const livenessLimit = @"/eagleInput/nirs";
//活体授权接口(advance ai)（第四项）
static NSString * const advanceLicense = @"/eagleInput/nhhhseojfrmg";
//活体认证上传接口(advance ai)（第四项）
static NSString * const livenessDetection = @"/v2/eagleInput/eandeiaolea";
//活体保存（第四项）
static NSString * const saveLiveness = @"/v2/eagleInput/savenhhhseojfrmg";
//Advance Ai活体识别错误上报
static NSString * const livenessError = @"/eagleInput/iuuciltsuthl";
//银行卡初始化接口（第五项）
static NSString * const bindCardInit = @"/v2/eagleInput/fsotom";
//保存银行卡信息（第五项）
static NSString * const saveBindCard = @"/v2/eagleInput/ffcernib";
//订单列表
static NSString * const orderList = @"/eagleOrder/tasaeliiie";
//我的
static NSString * const mine = @"/eagleIndex/deloq";
//注销
static NSString * const deleteAccount = @"/ph/user/del-account";
//获取弹窗
static NSString * const getPopUp = @"/eagleIndex/uatsp";
//隐私协议
static NSString * const privacyAgreement = @"#/privacyAgreement";
////埋点上报方便测试查看
static NSString * const testPoint5 = @"testPoint5";
///buglyKEY
static NSString * const buglyKey = @"05bf022713";
///健康检测
static NSString * const checkPing = @"/eagleIndex/M";
///动态域名公钥
static NSString *const checkPublicKey =@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3qlYvQDuxAX8D7f316ndsKOnm1ATW33KwCQE4WKw0mcSlcFoTRXUn6wBHpaWzAuJ29IMjTz0dNn5CO9fFJB5f5l59Ku+DFHtNzzQkZYobmSaga3N2CxvmP8M3+xZL3mT1VjDgzNwXpPRhx2XM4UJFY16/cjxnPiuJDCVbrciVDhVGCzXVoot/uGI5I99Qrxnva9cnaSJqbjC8CNiQRqObYBtQKvUHS4HK/ezYtttWGzJrcuq4B3Bj/e+R6k0onK/6J3ikiocpGv81xOkut17zzyjj+ECkSzAXBjY4SzNEPfqMK16VEQ9Aejn0tcvf1qSy+K7jNOWOlU+tPkSJoVdtQIDAQAB";
#endif /* PUBAPIDefineManager_h */
