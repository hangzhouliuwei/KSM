//
//  PTMineViewModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/9.
//

#import "PTBaseViewModel.h"


NS_ASSUME_NONNULL_BEGIN
@class PTHomeBaseModel;
@interface PTMineViewModel : PTBaseViewModel
-(void)getMianeIndexFinish:(void(^)(NSArray<PTHomeBaseModel*>*dataArray,NSString *memberUrl))successBlock failture:(void (^)(void))failtureBlock;

@end

NS_ASSUME_NONNULL_END
