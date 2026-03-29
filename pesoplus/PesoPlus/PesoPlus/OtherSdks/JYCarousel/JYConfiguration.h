//
//  JYConfiguration.h
//  JYBanner
//
//  Created by Dely on 16/11/14.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JYConfiguration;


#define AllImageViewCount 3


#define ViewWidth(view) CGRectGetWidth(view.frame)

#define ViewHeight(view) CGRectGetHeight(view.frame)

#define JYWeakSelf __weak typeof(self) weakSelf = self


typedef JYConfiguration *(^CarouselConfigurationBlock)(JYConfiguration *carouselConfig);


typedef void (^CarouselClickBlock)(NSInteger index);


typedef NS_ENUM(NSInteger, CarouselPageControllType) {
    MiddlePageControl = 0,
    LeftPageControl,
    HomePageControl,
    RightPageControl,
    LabelPageControl,
    NonePageControl
};


static NSTimeInterval DefaultTime = 3.0;


static CGFloat DefaultTitileFont = 10.0;

@interface JYConfiguration : NSObject


@property (nonatomic, strong) UIImage *placeholder;

@property (assign, nonatomic) NSTimeInterval interValTime;

@property (nonatomic, assign) CarouselPageControllType pageContollType;

@property (strong, nonatomic) UIColor *currentPageTintColor;

@property (strong, nonatomic) UIColor *pageTintColor;

@property (nonatomic, assign) UIViewContentMode contentMode;


@property (nonatomic, assign) NSInteger faileReloadTimes;


@property (nonatomic, assign) CGRect titleFrame;

@property (nonatomic, assign) CGFloat titleFont;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, assign) UIColor *titleBackGroundColor;

@property (nonatomic, assign) UIColor *titleColor;

@end
