//
//  PTMineHeaderView.h
//  PTApp
//
//  Created by 刘巍 on 2024/8/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTMineHeaderView : UIView
@property(nonatomic, copy) PTIntBlock orderClick;
-(void)updataMemberStr:(NSString*)memberStr;
@end

NS_ASSUME_NONNULL_END
