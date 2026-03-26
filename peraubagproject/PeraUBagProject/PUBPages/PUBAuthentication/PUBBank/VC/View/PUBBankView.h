//
//  PUBBankView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBankWiltEgModel,PUBBankLysinEgModel;
@interface PUBBankView : UIView
@property(nonatomic, strong) PUBBankLysinEgModel *selecModel;
@property(nonatomic, copy) NSString *bankText;
- (void)updataModel:(PUBBankWiltEgModel*)model;
@end

NS_ASSUME_NONNULL_END
