//
//  PesoIdentifyHeaderView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>
@class PesoIdentifyListModel;
NS_ASSUME_NONNULL_BEGIN

@interface PesoIdentifyHeaderView : UIView
@property(nonatomic, assign) NSInteger selectIdCardNo;
@property(nonatomic, copy) dispatch_block_t selectTypeBlock;
@property(nonatomic, copy) dispatch_block_t uploadClickBlock;
- (void)clickCardType;

- (void)updateIDcardImageUrl:(NSString *)url bankName:(NSString *)name;
- (void)updateModel:(PesoIdentifyListModel*)model;
- (void)updateIDcardImage:(UIImage*)IDcardImage;
@end

NS_ASSUME_NONNULL_END
