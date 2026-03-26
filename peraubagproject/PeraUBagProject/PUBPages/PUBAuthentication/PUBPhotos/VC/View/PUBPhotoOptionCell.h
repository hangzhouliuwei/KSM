//
//  PUBPhotoOptionCell.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PUBBasicSomesuchEgModel;
@interface PUBPhotoOptionCell : UITableViewCell
@property (nonatomic,copy) ReturnStrBlock photoOptionBlock;
-(void)configModel:(PUBBasicSomesuchEgModel*)model;
@end

NS_ASSUME_NONNULL_END
