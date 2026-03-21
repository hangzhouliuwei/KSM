//
//  PUBCountDown.h
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BagCountDown : NSObject

///用NSDate日期倒计时
-(void)cmsCountDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;

///用时间戳倒计时
-(void)cmsCountDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;

/// 用时间间隔倒计时
-(void)cmsCountDownWithtimeStamp:(long long)timeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;

///用秒隔倒计时
-(void)cmsCountDownWithSecond:(NSInteger)timeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;



///每秒走一次，回调block
-(void)cmsCountDownWithPER_SECBlock:(void (^)())PER_SECBlock;
-(void)cmsDestoryTimer;
-(NSDate *)dateWithLongLong:(long long)longlongValue;

@end

NS_ASSUME_NONNULL_END
