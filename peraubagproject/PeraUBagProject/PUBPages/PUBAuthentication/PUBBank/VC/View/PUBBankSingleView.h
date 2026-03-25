//
//  PUBBankSingleView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBankLysinEgModel;
@interface PUBBankSingleView : UIView
@property (nonatomic, copy) ReturnObjectBlock confirmBlock;
-(instancetype)initWithData:(NSArray<PUBBankLysinEgModel*>*)dataArr title:(NSString *)title;
- (void)show;

@end

NS_ASSUME_NONNULL_END
