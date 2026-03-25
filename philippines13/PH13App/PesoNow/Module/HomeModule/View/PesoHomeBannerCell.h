//
//  PesoHomeBannerCell.h
//  PesoApp
//
//  Created by Jacky on 2024/9/11.
//

#import "PesoBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PesoHomeBannerCell : PesoBaseTableViewCell
@property (nonatomic, copy) void(^click)(NSString *url);
@end

NS_ASSUME_NONNULL_END
