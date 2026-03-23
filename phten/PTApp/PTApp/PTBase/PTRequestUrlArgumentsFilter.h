//
//  PTRequestUrlArgumentsFilter.h
//  PTApp
//
//  Created by 刘巍 on 2024/7/15.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTRequestUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (PTRequestUrlArgumentsFilter *)filterWithArguments;

+ (NSDictionary *)getURLParam;

@end

NS_ASSUME_NONNULL_END
