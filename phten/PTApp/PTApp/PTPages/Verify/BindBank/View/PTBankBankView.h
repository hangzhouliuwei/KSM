//
//  PTBankBankView.h
//  PTApp
//
//  Created by Jacky on 2024/8/26.
//

#import <UIKit/UIKit.h>
@class PTBankBankModel,PTBankItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface PTBankBankView : UIView
- (void)updateUIWithModel:(PTBankBankModel *)model;
@property (nonatomic, strong) PTBankItemModel *selectModel;
@property (nonatomic, copy) NSString *bankText;
@end

NS_ASSUME_NONNULL_END
