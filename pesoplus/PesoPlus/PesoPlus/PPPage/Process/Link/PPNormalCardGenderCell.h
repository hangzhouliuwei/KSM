//
//  PPNormalCardGenderCell.h
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardGenderCell : UITableViewCell
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
- (void)loadData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
