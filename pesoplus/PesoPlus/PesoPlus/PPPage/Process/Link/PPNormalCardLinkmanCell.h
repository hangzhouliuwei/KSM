//
//  PPNormalCardLinkmanCell.h
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardLinkmanCell : UIView
@property (nonatomic, strong) NSMutableDictionary *data;
@property(nonatomic, assign) NSInteger lever;
- (id)initWithFrame:(CGRect)frame data:(NSDictionary *)dic;
- (void)relationAction;

@end

NS_ASSUME_NONNULL_END
