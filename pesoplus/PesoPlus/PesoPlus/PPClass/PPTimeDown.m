//
//  PPTimeDown.m
// FIexiLend
//
//  Created by jacky on 2024/10/31.
//

#import "PPTimeDown.h"

@interface PPTimeDown ()
@property (nonatomic, assign) kCountDownType countDonwnType;
@property (nonatomic, nullable, strong) dispatch_source_t loginTimer;
@end

@implementation PPTimeDown
SingletonM(PPTimeDown)

- (void)countDown:(kCountDownType)countDownType time:(NSInteger)time {
    
    self.countDonwnType = countDownType;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t tempTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(tempTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = time;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    dispatch_source_set_event_handler(tempTimer, ^{
        
        int timeInter = [endTime timeIntervalSinceNow];
        if (timeInter <= 0) {
            dispatch_source_cancel(tempTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([tempTimer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CountingStarSecondsFinish object:@(timeInter)];
                }
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([tempTimer isEqual:self.loginTimer]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:CountingStarSecondsAction object:@(timeInter)];
                }
            });
        }
    });
    
    if (self.countDonwnType == CountDownTypeLogin) {
        self.loginTimer = tempTimer;
    }
    dispatch_resume(tempTimer);
}

- (void)stopTimer:(kCountDownType)countDownType {
    
    switch (countDownType) {
        case CountDownTypeLogin:
            if (self.loginTimer) {
                dispatch_source_cancel(self.loginTimer);
                self.loginTimer = nil;
            }
            break;
            
        default:
            break;
    }
}

@end
