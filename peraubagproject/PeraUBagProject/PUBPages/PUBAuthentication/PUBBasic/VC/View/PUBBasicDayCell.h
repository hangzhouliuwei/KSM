//
//  PUBBasicDayCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicSomesuchEgModel;
@interface PUBBasicDayCell : UITableViewCell
@property (nonatomic, copy)ReturnNoneBlock clickBlock;
-(void)configModel:(PUBBasicSomesuchEgModel*)model;
- (void)clickAction;
@end

NS_ASSUME_NONNULL_END
