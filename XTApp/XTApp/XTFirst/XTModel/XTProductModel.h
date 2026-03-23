//
//  XTProductModel.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTProductModel : NSObject

///产品id
@property(nonatomic,copy) NSString *regnsixNc;
///产品名称
@property(nonatomic,copy) NSString *moossixyllabismNc;
///产品金额
@property(nonatomic,copy) NSString *eahosixleNc;
///产品tag
@property(nonatomic,strong) NSArray *sefisixshNc;
///产品描述
@property(nonatomic,copy) NSString *liotsixesNc;

///产品logo
@property(nonatomic,copy) NSString *sihosixuetteNc;
///申请按钮文字
@property(nonatomic,copy) NSString *maansixNc;
///申请按钮颜色
@property(nonatomic,copy) NSString *spffsixlicateNc;
///产品额度下面描述文字
@property(nonatomic,copy) NSString *cotesixnderNc;
///产品利率描述
@property(nonatomic,copy) NSString *fatisixshNc;

///产品状态
@property(nonatomic,copy) NSString *godosixlaNc;
///
@property(nonatomic,copy) NSString *prgesixstinNc;
///
@property(nonatomic,copy) NSString *quntsixasomeNc;
///产品类型 1 API 2 H5
@property(nonatomic,copy) NSString *magisixnNc;
///
@property(nonatomic,copy) NSString *cogesixnitallyNc;

///产品利率
@property(nonatomic,copy) NSString *sesisixtisationNc;
///
@property(nonatomic,copy) NSString *relosixomNc;
///产品期限
@property(nonatomic,copy) NSString *urtesixrNc;
///今天是否点击 0否 1是
@property(nonatomic,copy) NSString *stthsixoscopyNc;
///
@property(nonatomic,strong) NSArray *scumsixmageNc;

///
@property(nonatomic,copy) NSString *lipssixyNc;
///
@property(nonatomic,strong) NSArray *casusixpNc;
///
@property(nonatomic,copy) NSString *budisixeNc;
///最大额度
@property(nonatomic,copy) NSString *noilsixladaNc;
///
@property(nonatomic,copy) NSString *fiansixcialNc;

///右上角角标
@property(nonatomic,copy) NSString *brvasixdoNc;
///是否显示进度条
@property(nonatomic) BOOL enpisixritNc;
///是否可点击
@property(nonatomic) BOOL pacasixrditisNc;
///订单状态（174,180表示有待还款的订单。具体取值见EntryOrderEnum-进件单状态枚举定义）
@property(nonatomic,copy) NSString *covisixctiveNc;

@end

NS_ASSUME_NONNULL_END
