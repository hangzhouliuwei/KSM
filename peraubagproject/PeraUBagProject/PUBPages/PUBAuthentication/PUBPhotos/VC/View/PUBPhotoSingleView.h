//
//  PUBPhotoSingleView.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBPhotosHorrificEgModel;
@interface PUBPhotoSingleView : UIView
@property (nonatomic, copy) ReturnObjectBlock confirmBlock;
-(instancetype)initWithData:(NSArray<PUBPhotosHorrificEgModel*>*)dataArr title:(NSString *)title;
- (void)show;
@end

NS_ASSUME_NONNULL_END
