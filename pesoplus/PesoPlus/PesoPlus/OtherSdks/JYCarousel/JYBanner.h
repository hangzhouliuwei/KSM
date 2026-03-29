//
//  JYBanner.h
//  JYBanner
//
//  Created by Dely on 16/11/14.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYConfiguration.h"
#import "JYPageControl.h"
#import "JYTitleLabel.h"

@protocol JYCarouselDelegate <NSObject>

@optional
- (void)carouselViewClick:(NSInteger)index;

@end

@interface JYBanner : UIView

- (instancetype)initWithFrame:(CGRect)frame
                  configBlock:(CarouselConfigurationBlock)configBlock
                   clickBlock:(CarouselClickBlock)clickBlock;

- (instancetype)initWithFrame:(CGRect)frame
                  configBlock:(CarouselConfigurationBlock)configBlock
                       target:(id<JYCarouselDelegate>)target;


- (void)startCarouselWithArray:(NSMutableArray *)imageArray;
- (void)startCarouselWithArray:(NSMutableArray *)imageArray video:(NSString *)videoUrl;
- (void)startCarouselWithArray:(NSMutableArray *)imageArray titleArray:(NSMutableArray *)titleArray;

- (void)startCarouselWithNewConfig:(CarouselConfigurationBlock)configBlock array:(NSMutableArray *)imageArray;
- (void)startCarouselWithNewConfig:(CarouselConfigurationBlock)configBlock array:(NSMutableArray *)imageArray titleArray:(NSMutableArray *)titleArray;



@end
