//
//  PUBLoanViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/23.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBLoanBaseModel,PUBLoanApplyModel,PUBProductDetailModel,PUBUnbuildEgModel,PUBHomePopModel;
@interface PUBLoanViewModel : PUBBaseViewModel
@property(nonatomic, strong) NSMutableArray <PUBLoanBaseModel*>*dataArray;
@property(nonatomic, strong) PUBUnbuildEgModel *unbuildEgModel;

-(void)getHomeView:(UIView *)view
               finish:(void (^)(void))successBlock
             failture:(void (^)(void))failtureBlock;


/// 申请按钮点击
/// - Parameters:
///   - view: <#view description#>
///   - dic: <#dic description#>
///   - successBlock: <#successBlock description#>
///   - failtureBlock: <#failtureBlock description#>
- (void)getApplyView:(UIView *)view
                 dic:(NSDictionary *)dic
                   finish:(void (^)(PUBLoanApplyModel *model))successBlock
                   failture:(void (^)(void))failtureBlock;

/// 上报设备信息
- (void)getUploadDevice;

///订单详情
- (void)getProductDetailView:(UIView *)view dic:(NSDictionary *)dic 
                      finish:(void (^)(PUBProductDetailModel *detailModel))successBlock
                    failture:(void (^)(void))failtureBlock;

///跟进订单号获取跳转地址
- (void)getproductPushView:(UIView *)view
                       dic:(NSDictionary *)dic
                      finish:(void (^)(NSString *url))successBlock
                    failture:(void (^)(void))failtureBlock;

///获取弹窗
- (void)getPopUpfinish:(void (^)(PUBHomePopModel *popModel))successBlock
              failture:(void (^)(void))failtureBlock;

@end

NS_ASSUME_NONNULL_END
