//
//  PUBSingleView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicHorrificEgModel;
@interface PUBSingleView : UIView
@property (nonatomic, copy) ReturnObjectBlock confirmBlock;
-(instancetype)initWithData:(NSArray<PUBBasicHorrificEgModel*>*)dataArr title:(NSString *)title;
- (void)show;
@end

NS_ASSUME_NONNULL_END
