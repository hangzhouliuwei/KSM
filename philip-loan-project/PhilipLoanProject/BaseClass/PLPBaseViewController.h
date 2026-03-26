//
//  BaseViewController.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLPBaseViewController : UIViewController
@property(nonatomic)NSString *startTime;
@property(nonatomic)UIImageView *baseImageView;
@property(nonatomic)NSString *holdConetent;
@property(nonatomic)BOOL shouldPopHome;
@property(nonatomic)BOOL hideServeImageView;
-(void)BASE_GenerateSubview;
-(void)BASE_RequestHTTPInfo;
-(void)BASE_BackAction;
-(NSDictionary *)BASE_GeneragePointDictionaryWithType:(NSString *)type;

-(void)decodeAuthResponseData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
