//
//  DefaultBaseProcessPage.h
// FIexiLend
//
//  Created by jacky on 2024/11/20.
//

#import "PPBasePageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DefaultBaseProcessPage : PPBasePageController
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSInteger step;
@property (nonatomic, assign) BOOL canDiss;
- (NSDictionary *)track;
@end

NS_ASSUME_NONNULL_END
