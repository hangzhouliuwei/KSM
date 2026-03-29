//
//  PPNormalCardRelationAlert.h
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardRelationAlert : UIView
@property (nonatomic, copy) CallBackDic selectBlock;
- (id)initWithData:(NSArray *)arr selected:(NSString *)selectType title:(NSString *)titleStr;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
