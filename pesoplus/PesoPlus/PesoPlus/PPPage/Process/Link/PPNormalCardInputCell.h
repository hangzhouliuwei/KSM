//
//  PPNormalCardInputCell.h
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPNormalCardInputCell : UITableViewCell
@property (nonatomic, strong) UIView *emailView;
@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
///用户即将输入回调给埋点
@property(nonatomic, copy) CallBackNone textBeginBlock;
///用户输入完成
@property (nonatomic,copy) CallBackStr textBlock;

- (void)loadData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
