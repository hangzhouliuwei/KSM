//
//  BagMeListCell.h
//  NewBag
//
//  Created by Jacky on 2024/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagMeListCell : UITableViewCell
- (void)updateUIWithTitle:(NSString *)title iconUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
