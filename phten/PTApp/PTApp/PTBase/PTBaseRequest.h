//
//  PTBaseRequest.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBaseRequest.h>
#import <YTKNetwork/YTKNetworkPrivate.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTBaseRequest : YTKBaseRequest
@property (nonatomic, assign) BOOL isShowLoading;
@property (nonatomic, copy) NSString *loadingText;

@property (nonatomic, assign) NSInteger response_code;
@property (nonatomic, copy) NSString *response_message;
@property (nonatomic, copy) NSDictionary *response_dic;

- (void)hiddenLoading;


@end

NS_ASSUME_NONNULL_END
