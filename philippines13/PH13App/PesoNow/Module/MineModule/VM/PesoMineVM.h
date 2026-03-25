//
//  PesoMineVM.h
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PesoMineVM : NSObject
-(void)loadMineAPI:(void(^)(id model))callback;
@end

NS_ASSUME_NONNULL_END
