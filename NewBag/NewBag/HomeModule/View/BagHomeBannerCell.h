//
//  BagHomeBannerCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/28.
//

#import <UIKit/UIKit.h>
@class BagHomeBannerModel,BagHomeBannerItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface BagHomeBannerCell : UITableViewCell
- (void)updateUIWithModel:(BagHomeBannerModel *)model;
@property (nonatomic, copy)void(^bannerClickBlock)(BagHomeBannerItemModel *);
@end

NS_ASSUME_NONNULL_END
