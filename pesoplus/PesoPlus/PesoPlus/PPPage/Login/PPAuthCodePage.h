//
//  PPAuthCodePage.h
// FIexiLend
//
//  Created by jacky on 2024/11/12.
//

#import "PPBasePageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPAuthCodePage : PPBasePageController
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *msg;
@end

NS_ASSUME_NONNULL_END
