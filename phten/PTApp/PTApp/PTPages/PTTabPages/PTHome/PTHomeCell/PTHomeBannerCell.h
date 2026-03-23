//
//  PTHomeBannerCell.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTHomeBannerModel;
@interface PTHomeBannerCell : UITableViewCell
@property(nonatomic, copy) PTStrBlock bannerClickBloack;
-(void)configModel:(PTHomeBannerModel*)model;

@end

NS_ASSUME_NONNULL_END
