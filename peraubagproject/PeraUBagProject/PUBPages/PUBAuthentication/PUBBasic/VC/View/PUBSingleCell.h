//
//  PUBSingleCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicHorrificEgModel,PUBContactFeatherstitchEgModel,PUBPhotosHorrificEgModel,PUBBankLysinEgModel;
@interface PUBSingleCell : UITableViewCell
///基础认证
- (void)configModel:(PUBBasicHorrificEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index;
///通讯录
- (void)configContanModel:(PUBContactFeatherstitchEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index;
///身份证
- (void)configPhotosModel:(PUBPhotosHorrificEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index;
///拍照方式选择
- (void)configPhotosCameraStr:(NSString*)cameraStr seleIndex:(NSInteger)seleIndex index:(NSInteger)index;
///银行卡选择
- (void)configBankModel:(PUBBankLysinEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
