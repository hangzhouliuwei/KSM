//
//  PesoRequestArguments.h
//  PesoApp
//
//  Created by Jacky on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoRequestArguments : NSObject<YTKUrlFilterProtocol>
+ (PesoRequestArguments *)filterWithArguments;
+ (NSDictionary *)getURLParam;
@end

NS_ASSUME_NONNULL_END
