//
//  PUBLiveViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/10.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBLiveModel;
@interface PUBLiveViewModel : PUBBaseViewModel

///活体认证初始化接口（第四项）
- (void)getCertifyLivenessView:(UIView *)view dic:(NSDictionary *)dic
                finish:(void (^)(PUBLiveModel *model))successBlock
              failture:(void (^)(void))failtureBlock;

///活体保存（第四项）
- (void)saveLivenessView:(UIView *)view dic:(NSDictionary *)dic
                  finish:(void (^)(NSDictionary *dic))successBlock
                failture:(void (^)(void))failtureBlock;


///活体认证次数限制接口(advance ai)（第四项）
- (void)getLivenessLimitView:(UIView *)view dic:(NSDictionary *)dic
                      finish:(void (^)(NSDictionary *dic))successBlock
                    failture:(void (^)(void))failtureBlock;

///活体授权接口(advance ai)（第四项）
- (void)getAdvanceLicenseView:(UIView *)view dic:(NSDictionary *)dic
                      finish:(void (^)(NSDictionary *dic))successBlock
                    failture:(void (^)(void))failtureBlock;

///活体认证上传接口(advance ai)（第四项）
- (void)getlivenessDetectionView:(UIView *)view dic:(NSDictionary *)dic
                      finish:(void (^)(NSDictionary *dic))successBlock
                    failture:(void (^)(void))failtureBlock;

///Advance Ai活体识别错误上报
- (void)getlivenessErrorView:(UIView *)view dic:(NSDictionary *)dic
                      finish:(void (^)(void))successBlock
                    failture:(void (^)(void))failtureBlock;

@end

NS_ASSUME_NONNULL_END
