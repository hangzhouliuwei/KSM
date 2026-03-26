//
//  PTOrderPresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PTOrderListModel;
@protocol PTOrderDelegate <PTBaseProtocol>

- (void)updateUIWithDataArray:(NSArray <PTOrderListModel *>*)array;
- (void)endRefresh;
- (void)hiddenFooter:(BOOL)hidden;

@end

@interface PTOrderPresenter : NSObject
@property (nonatomic,weak) id<PTOrderDelegate>delegate;
- (void)sendGetOrderRequestFirstPage:(BOOL)first tag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
