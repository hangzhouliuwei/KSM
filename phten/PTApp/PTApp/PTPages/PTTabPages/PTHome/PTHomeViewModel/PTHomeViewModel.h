//
//  PTHomeViewModel.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/1.
//

#import "PTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PTHomeBaseModel,PTHomeIetenNcModel;

@protocol PTHomeViewModelProtocol <NSObject>

@optional
- (void)router:(NSString *)url;
- (void)updatePopWithIconURL:(NSString *)url jumpURL:(NSString *)jumpUrl;
@end

@interface PTHomeViewModel : PTBaseViewModel
@property(nonatomic, strong) NSMutableArray <PTHomeBaseModel*>*homeDataArray;

@property(nonatomic,weak) id<PTHomeViewModelProtocol>delegate;
-(void)getHomeIndexfinish:(void (^)(BOOL isShowNav, BOOL isShowMember,PTHomeIetenNcModel *ietenNcModel))successBlock
                 failture:(void (^)(void))failtureBlock;

/**点击申请请求**/
- (void)sendApplyRequest:(NSString *)product_id;
/**获取产品详情请求**/
- (void)sendGetProductDetailRequest:(NSString *)product_id;

- (void)sendGetHomePop;
@end

NS_ASSUME_NONNULL_END
