//
//  ViewController.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = UIColor.blackColor;
    self.view.backgroundColor = UIColor.greenColor;
    self.view.frame = CGRectMake(0, 100, 100, 100);
    [HttPPUBRequest getWithPath:PB_home params:nil success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull mode) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
