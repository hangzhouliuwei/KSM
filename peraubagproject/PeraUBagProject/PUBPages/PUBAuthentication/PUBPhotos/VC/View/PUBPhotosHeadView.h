//
//  PUBPhotosHeadView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBPhotosHorrificEgModel;
@interface PUBPhotosHeadView : UIView
///身份证类型选择
@property (nonatomic, copy) ReturnNoneBlock selsecTypeBlock;
///拍照选择
@property (nonatomic, copy) ReturnNoneBlock idCardImageClickBlock;

@property(nonatomic, assign) NSInteger selsecGrocer_eg;

- (void)updataModel:(PUBPhotosHorrificEgModel*)model;
- (void)updataIDcardImage:(UIImage*)IDcardImage;
- (void)updataIDcardImageUrl:(NSString*)imageUrl;

-(void)selsectViewClick;

@end

NS_ASSUME_NONNULL_END
