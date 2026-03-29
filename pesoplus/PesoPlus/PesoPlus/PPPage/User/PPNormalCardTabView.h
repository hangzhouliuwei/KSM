//
//  PPNormalCardTabView.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardTabView : UIView
@property (nonatomic, copy) CallBackInt clickBlock;
@property (nonatomic, assign) NSInteger selectIndex;

- (id)initWithFrame:(CGRect)frame;
- (void)loadTitles:(NSArray *)arr selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
