//
//  JYBanner.m
//  JYBanner
//
//  Created by Dely on 16/11/14.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import "JYBanner.h"
#import "JYWeakTimer.h"

@interface JYBanner ()<UIScrollViewDelegate>


@property (strong, nonatomic) NSMutableArray *images;

@property (copy, nonatomic) NSString *videoUrl;


@property (strong, nonatomic) NSMutableArray *titles;



@property (nonatomic, strong) UIScrollView  *scrollView;


@property (nonatomic, strong) NSMutableArray *imageViewArray;


@property (nonatomic, copy) CarouselClickBlock clickBlock;


@property (nonatomic, assign) NSInteger imageIndex;

@property (nonatomic, strong) JYConfiguration *config;

@property (nonatomic, strong) JYPageControl *pageControl;

@property (nonatomic, strong) JYTitleLabel *titleLabel;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, assign) BOOL isAutoPlay;

@property (nonatomic, weak) id<JYCarouselDelegate>delegate;

@end


@implementation JYBanner

- (NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray =[[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (NSMutableArray *)titles{
    if (!_titles) {
        _titles =[[NSMutableArray alloc] init];
    }
    return _titles;
}



- (instancetype)initWithFrame:(CGRect)frame configBlock:(CarouselConfigurationBlock)configBlock clickBlock:(CarouselClickBlock)clickBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageIndex = 0;
        if (configBlock) {
            JYConfiguration *configurate = [[JYConfiguration alloc] init];
            configurate.interValTime = DefaultTime;
            configurate.titleFont = DefaultTitileFont;
            self.config = configBlock(configurate);
        }else{
            self.config = [[JYConfiguration alloc] init];
            self.config.interValTime = DefaultTime;
            self.config.titleFont = DefaultTitileFont;
        }
        if (clickBlock) {
            __weak __typeof__(clickBlock) weakClickBlock = clickBlock;
            self.clickBlock = weakClickBlock;
        }
        [self initSelfView];
        [self updateSelfView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame configBlock:(CarouselConfigurationBlock)configBlock target:(id<JYCarouselDelegate>)target{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageIndex = 0;
        self.delegate = target;
        if (configBlock) {
            JYConfiguration *configurate = [[JYConfiguration alloc] init];
            configurate.interValTime = DefaultTime;
            configurate.titleFont = DefaultTitileFont;
            self.config = configBlock(configurate);
        }else{
            self.config = [[JYConfiguration alloc] init];
            self.config.interValTime = DefaultTime;
            self.config.titleFont = DefaultTitileFont;
        }
        [self initSelfView];
        [self updateSelfView];
    }
    return self;
}

- (void)initSelfView{

    if (!self.pageControl) {
        self.pageControl = [[JYPageControl alloc] init];
    }
    
    if (!self.titleLabel) {
        self.titleLabel = [[JYTitleLabel alloc] init];
    }
    
    [self addSubView];
}

- (void)updateSelfView{
    
    for (UIImageView *imageView in self.imageViewArray) {
        imageView.contentMode = self.config.contentMode;
        imageView.clipsToBounds = YES;
    }
}


- (void)addSubView{
    
    if(_scrollView == nil) {
        UIView *firstView = [[UIView alloc] init];
        [self addSubview:firstView];
        //scrollView
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _scrollView.contentSize = CGSizeMake(ViewWidth(_scrollView) *AllImageViewCount, 0);
        _scrollView.contentOffset = CGPointMake(ViewWidth(_scrollView), 0);
        
        //imageView
        for(NSInteger i = 0; i < AllImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * ViewWidth(_scrollView), 0, ViewWidth(_scrollView), ViewHeight(_scrollView))];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = self.config.contentMode;
            [_scrollView addSubview:imageView];
            //imageView.backgroundColor = BGColor;
            imageView.backgroundColor = [UIColor clearColor];
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)]];
            
            [self.imageViewArray addObject:imageView];
        }
    }
}


- (void)setupScrollViewContentSize{
    if(self.images.count > 3){
        self.scrollView.contentSize = CGSizeMake(ViewWidth(_scrollView) *AllImageViewCount, 0);
        self.scrollView.contentOffset = CGPointMake(ViewWidth(_scrollView), 0);
        
    }else{
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset =CGPointZero;
    }
}

- (void)updateConfigWithBlock:(CarouselConfigurationBlock)configBlock{
    JYConfiguration *configurate = self.config;
    if (configBlock) {
        self.config = configBlock(configurate);
        [self updateSelfView];
    }
}


- (void)startCarouselWithArray:(NSMutableArray *)imageArray video:(NSString *)videoUrl {
    self.videoUrl = videoUrl;
    [imageArray insertObject:self.videoUrl atIndex:0];
    [self startCarouselWithArray:imageArray];
}


- (void)startCarouselWithArray:(NSMutableArray *)imageArray{
    self.images = imageArray;
}

- (void)startCarouselWithArray:(NSMutableArray *)imageArray titleArray:(NSMutableArray *)titleArray{
    self.titles = titleArray;
    self.images = imageArray;
}


- (void)startCarouselWithNewConfig:(CarouselConfigurationBlock)configBlock array:(NSMutableArray *)imageArray{
    if (!self.config) {
        self.config = [[JYConfiguration alloc] init];
    }
    JYConfiguration *configurate = self.config;
    if (configBlock) {
        self.config = configBlock(configurate);
        [self updateSelfView];
    }
    
    [self startCarouselWithArray:imageArray];
}

- (void)startCarouselWithNewConfig:(CarouselConfigurationBlock)configBlock array:(NSMutableArray *)imageArray titleArray:(NSMutableArray *)titleArray{
    if (!self.config) {
        self.config = [[JYConfiguration alloc] init];
    }
    JYConfiguration *configurate = self.config;
    if (configBlock) {
        self.config = configBlock(configurate);
        [self updateSelfView];
    }
    
    [self startCarouselWithArray:imageArray titleArray:titleArray];
}

- (void)setImages:(NSMutableArray *)images{

    NSInteger num = images.count;
    if (images.count > 0) {
        id firstObj = [images firstObject];
        id lastObj = [images lastObject];
        [images insertObject:lastObj atIndex:0];
        [images insertObject:firstObj atIndex:images.count];
    }
    
    if (!_images) {
        _images = [NSMutableArray array];
    }
    _images = images;
    self.imageIndex = 1;
    [self.titleLabel initViewWithConfiguration:self.config addInView:self];
    [self.pageControl initViewWithNumberOfPages:num configuration:self.config addInView:self];
    [self updateImageViewContent];
    [self setupScrollViewContentSize];
    
    
    [self stopTimer];
    if (num == 0) {
        self.isAutoPlay = NO;
    }else if (num == 1){
        self.isAutoPlay = NO;
    }else{
        self.isAutoPlay = YES;
        [self beginTimer];
    }
}


- (void)updateImageViewContent{
    if (self.images.count > 2) {
        for (NSInteger i = 0; i < self.imageViewArray.count; i++) {
            UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
            NSInteger imageIndex = 0;
            if (i == 0) {
                imageIndex = self.imageIndex - 1;
                if (imageIndex == -1) {
                    imageIndex = self.images.count - 2;
                }
            } else if (i == 1) {
                imageIndex = self.imageIndex;
            } else if (i == 2) {
                imageIndex = self.imageIndex + 1;
                if (imageIndex == self.images.count) {
                    imageIndex = 1;
                }
            }
            imageView.tag = imageIndex;
            [self loadImage:imageIndex withImageView:imageView];
        }
        
        [self.pageControl updateCurrentPageWithIndex:(self.imageIndex-1)];
        
        NSString *title;
        if ((self.imageIndex-1) < self.titles.count) {
            title = [self.titles objectAtIndex:(self.imageIndex-1)];
        }
        [self.titleLabel updateCurrentTitleLabelWithTitle:title];
    }
}

- (void)loadImage:(NSInteger)imageIndex withImageView:(UIImageView *)imageView{
    
    id obj = [self.images objectAtIndex:imageIndex];
    
    if ([obj isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:obj];
        if (imageView.image == nil) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj]];
        }
        return;
    }else if ([obj isKindOfClass:[NSURL class]]) {
        [imageView sd_setImageWithURL:obj];
        return;
    }else if ([obj isKindOfClass:[UIImage class]]) {
        imageView.image = obj;
        return;
    }
}



- (void)imageClick:(UITapGestureRecognizer *)sender{
    __weak typeof(self) weakSelf = self;
    if (self.clickBlock) {
        [self changeImageIndex];
        weakSelf.clickBlock(weakSelf.imageIndex-1);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselViewClick:)]) {
        [self.delegate carouselViewClick:self.imageIndex-1];
    }
}


- (void)beginTimer{
    if ((self.config.interValTime >0) && (self.timer == nil) && self.isAutoPlay) {
        self.timer = [JYWeakTimer scheduledTimerWithTimeInterval:self.config.interValTime target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}


- (void)stopTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)pauseTimer {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.timer.isValid) return;
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

- (void)timeAction{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.contentOffset = CGPointMake(2 *ViewWidth(self.scrollView), 0);
    } completion:^(BOOL finished) {
        [self changeImageIndex];
        [self updateImageViewContent];
        [self setupScrollViewContentSize];
    }];

}

#pragma mark - -------------------UIScrollViewDelegate-------------------

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self pauseTimer];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self resumeWithTimeInterval:self.config.interValTime];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    UIImageView *middleImageView = nil;
    CGFloat minOffset = MAXFLOAT;

    for (UIImageView *imageView in self.imageViewArray) {
        CGFloat currentOffset = ABS(CGRectGetMinX(imageView.frame) - _scrollView.contentOffset.x);
        if (currentOffset < minOffset){
            minOffset = currentOffset;
            middleImageView = imageView;
        }
        self.imageIndex = middleImageView.tag;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self changeImageIndex];
    [self updateImageViewContent];
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
}

- (void)changeImageIndex{
    if (self.imageIndex == 0) {
        self.imageIndex = self.images.count - 2;
    }else if(self.imageIndex == (self.images.count-1)){
        self.imageIndex = 1;
    }
}

- (void)dealloc{
    [self stopTimer];
#ifdef kDebugLog
    
#endif
}

@end
