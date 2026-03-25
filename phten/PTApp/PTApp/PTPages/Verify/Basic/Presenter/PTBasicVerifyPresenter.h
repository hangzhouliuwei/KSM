//
//  PTBasicVerifyPresenter.h
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import <Foundation/Foundation.h>
@class PTBasicVerifyModel;

NS_ASSUME_NONNULL_BEGIN
@protocol PTBasicVerifyProtocol <PTBaseProtocol>
@optional
- (void)updateUIWithModel:(PTBasicVerifyModel *)model;
- (void)jumpNextPageWithProductId:(NSString *)product_id nextUrl:(NSString *)url;
- (void)removeViewController;
- (void)saveBasicSucceed;
@end

@interface PTBasicVerifyPresenter : NSObject
@property (nonatomic, weak) id <PTBasicVerifyProtocol>delegate;
- (void)pt_sendGetBasicRequestWithProduct_id:(NSString *)product_id;;
- (void)pt_sendSaveBasicRequest:(NSDictionary *)data product_id:(NSString *)product_id;
@end

NS_ASSUME_NONNULL_END
