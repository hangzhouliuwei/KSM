//
//  PUBContanSingleView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBContactFeatherstitchEgModel;
@interface PUBContanSingleView : UIView

@property (nonatomic, copy) ReturnObjectBlock confirmBlock;
-(instancetype)initWithData:(NSArray<PUBContactFeatherstitchEgModel*>*)dataArr title:(NSString *)title;
- (void)show;
@end

NS_ASSUME_NONNULL_END
