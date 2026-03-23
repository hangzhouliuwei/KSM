//
//  PTIdentifyVerifySelectCardVC.h
//  PTApp
//
//  Created by Jacky on 2024/8/25.
//

#import "PTBaseVC.h"

NS_ASSUME_NONNULL_BEGIN
@class PTIdentifyListModel;
@interface PTIdentifyVerifySelectCardVC : PTBaseVC
@property (nonatomic, copy) NSArray <PTIdentifyListModel *>*data;
@property (nonatomic, copy) void(^selectBlock)(PTIdentifyListModel *model);
@end

NS_ASSUME_NONNULL_END
