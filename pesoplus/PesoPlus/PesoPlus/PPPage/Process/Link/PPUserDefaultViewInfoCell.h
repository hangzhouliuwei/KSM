//
//  PPUserDefaultViewInfoCell.h
// FIexiLend
//
//  Created by jacky on 2024/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPUserDefaultViewInfoCell : UITableViewCell
@property (nonatomic, strong) UITextField *textString;
@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) UITextField *textFalse;
@property (nonatomic, strong) UITextField *textTrue;
@property (nonatomic, strong) NSMutableDictionary *needSaveDicData;
- (void)loadData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
