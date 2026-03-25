//
//  PUBOrderDetailViewModel.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/15.
//

#import "PUBBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PUBOrederItemModel;
@interface PUBOrderDetailViewModel : PUBBaseViewModel
@property(nonatomic, strong) NSMutableArray <PUBOrederItemModel*>*dataArray;
///订单列表
- (void)getOrderListView:(UIView *)view
                       dic:(NSDictionary *)dic
                       isFist:(BOOL)isFist
                      finish:(void (^)(void))successBlock
                    failture:(void (^)(void))failtureBlock
                showFoot:(void (^)(BOOL showFoot))showFoot;

@end

NS_ASSUME_NONNULL_END
