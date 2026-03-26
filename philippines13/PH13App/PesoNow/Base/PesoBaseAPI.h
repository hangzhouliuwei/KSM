//
//  PesoBaseAPI.h
//  PesoApp
//
//  Created by Jacky on 2024/9/9.
//

#import <YTKNetwork/YTKNetwork.h>
#import <YTKNetwork/YTKBaseRequest.h>
#import <YTKNetwork/YTKNetworkPrivate.h>

NS_ASSUME_NONNULL_BEGIN
@interface PesoBaseRequestDelegate : NSObject

@end
@interface PesoBaseAPI : YTKBaseRequest
@property (nonatomic, assign) BOOL showLoading;
@property (nonatomic, copy) NSString *loadingText;

@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, copy) NSString *responseMessage;
@property (nonatomic, copy) NSDictionary *responseDic;

- (instancetype)initWithData:(id)data;
- (void)hiddenLoading;
@end

NS_ASSUME_NONNULL_END
