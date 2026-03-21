//
//  BagIdentifyHeaderView.h
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BagIdentifyListModel;
@interface BagIdentifyHeaderView : UIView

@property(nonatomic, assign) NSInteger selectIdCardNo;
@property(nonatomic, copy) dispatch_block_t selectTypeBlock;
@property(nonatomic, copy) dispatch_block_t idCardImageClickBlock;


+ (instancetype)createView;
- (void)selectCardAction;
- (void)updateIDcardImageUrl:(NSString *)url;
- (void)updateModel:(BagIdentifyListModel*)model;
- (void)updateIDcardImage:(UIImage*)IDcardImage;
@end

NS_ASSUME_NONNULL_END
