//
//  PTIdentifyVerifyHeaderView.h
//  PTApp
//
//  Created by Jacky on 2024/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTIdentifyListModel;
@interface PTIdentifyVerifyHeaderView : UIView

@property(nonatomic, copy) PTBlock selectTypeBlock;
@property(nonatomic, copy) PTBlock uploadClickBlock;
//用作上传图片时候
@property(nonatomic, assign) NSInteger selectIdCardNo;
- (void)selectCardAction;

- (void)updateIDcardImageUrl:(NSString *)url bankName:(NSString *)name;
- (void)updateModel:(PTIdentifyListModel*)model;
- (void)updateIDcardImage:(UIImage*)IDcardImage;
@end

NS_ASSUME_NONNULL_END
