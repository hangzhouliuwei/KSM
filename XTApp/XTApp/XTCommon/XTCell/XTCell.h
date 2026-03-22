//
//  XTCell.h
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCell : UITableViewCell

@property(nonatomic,copy) NSString *ID;
@property(nonatomic) float xt_height;
@property(nonatomic,strong) id xt_data;

- (void)xt_reloadData:(id)data;

@end

NS_ASSUME_NONNULL_END
