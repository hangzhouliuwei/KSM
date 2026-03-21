//
//  BagBankBankView.h
//  NewBag
//
//  Created by Jacky on 2024/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BagBankItemModel,BagBankBankModel;

@interface BagBankBankView : UIView

+ (instancetype)createView;
- (void)updateUIWithModel:(BagBankBankModel *)model;

@property (nonatomic, strong) BagBankItemModel *selectModel;
@property (nonatomic, copy) NSString *bankText;

@end

NS_ASSUME_NONNULL_END
