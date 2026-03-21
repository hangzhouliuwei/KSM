//
//  BagOrderPresenter.h
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import <Foundation/Foundation.h>
@class BagOrderListModel;
NS_ASSUME_NONNULL_BEGIN
@protocol BagOrderProtocol <BagBaseProtocol>
- (void)updateUIWithDataArray:(NSArray <BagOrderListModel *>*)array;
- (void)endRefresh;
- (void)hiddenFooter:(BOOL)hidden;
@end
@interface BagOrderPresenter : NSObject
@property (nonatomic,weak)id<BagOrderProtocol>delegate;

- (void)sendGetOrderRequestFirstPage:(BOOL)first tag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
