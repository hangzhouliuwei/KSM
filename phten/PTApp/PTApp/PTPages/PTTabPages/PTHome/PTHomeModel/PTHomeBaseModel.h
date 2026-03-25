//
//  PTHomeBaseModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTHomeBaseModel : PTBaseModel
@property(nonatomic, assign) NSInteger  level;
@property(nonatomic, copy) NSString *cellType;
@property(nonatomic, assign) NSInteger  cellHigh;
@end

NS_ASSUME_NONNULL_END
