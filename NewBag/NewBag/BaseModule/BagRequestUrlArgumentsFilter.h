//
//  BagRequestUrlArgumentsFilter.h
//  NewBag
//
//  Created by Jacky on 2024/3/13.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagRequestUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>
+ (BagRequestUrlArgumentsFilter *)filterWithArguments;
+ (BagRequestUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;
+ (NSDictionary *)getURLParam;
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;
- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
