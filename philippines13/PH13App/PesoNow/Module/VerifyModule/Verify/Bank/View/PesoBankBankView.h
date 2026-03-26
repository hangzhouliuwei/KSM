//
//  PesoBankBankView.h
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import <UIKit/UIKit.h>
@class PesoBankBankModel,PesoBankItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface PesoBankBankView : UIView
- (void)updateUIWithModel:(PesoBankBankModel *)model;
@property (nonatomic, strong) PesoBankItemModel *selectModel;
@property (nonatomic, copy) NSString *bankText;
@end

NS_ASSUME_NONNULL_END
