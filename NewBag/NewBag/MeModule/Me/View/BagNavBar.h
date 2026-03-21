//
//  BagNavBar.h
//  NewBag
//
//  Created by Jacky on 2024/4/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagNavBar : UIView
/**返回点击回调**/
@property (nonatomic, copy) dispatch_block_t gobackBlock;
@property (nonatomic, copy) NSString *backTitle;

+(instancetype)createNavBar;
@end

NS_ASSUME_NONNULL_END
