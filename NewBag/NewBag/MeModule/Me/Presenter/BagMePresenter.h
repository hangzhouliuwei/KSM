//
//  BagMePresenter.h
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import <Foundation/Foundation.h>
@class BagMeModel;
NS_ASSUME_NONNULL_BEGIN
@protocol BagMePresenterProtocol <BagBaseProtocol>
- (void)updateUIWithModel:(BagMeModel *)model;

@end
@interface BagMePresenter : NSObject

@property (nonatomic, weak) id<BagMePresenterProtocol> delegate;

- (void)sendGetMeDetailRequest;
@end

NS_ASSUME_NONNULL_END
