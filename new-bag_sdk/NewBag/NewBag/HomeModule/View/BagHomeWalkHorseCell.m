//
//  BagHomeWalkHorseCell.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagHomeWalkHorseCell.h"
#import "UUMarqueeView.h"
#import "BagHomeModel.h"
@interface BagHomeWalkHorseCell ()<UUMarqueeViewDelegate>
@property (nonatomic, strong) UUMarqueeView *marqueeView;
@property (nonatomic, copy) NSArray <BagHomeHorseItemModel *>*dataSource;
//@property
@end

@implementation BagHomeWalkHorseCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self setupUI];
//    }
//    return self;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
        [self setupUI];
    }
    return self;
}
- (void)updateUIWithModel:(BagHomeHorseModel *)model
{
    _dataSource = model.hematopoiesisF;
    [self.marqueeView reloadData];
}
- (void)setupUI{
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
    
    self.marqueeView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(14.0f, 6, kScreenWidth - 28, 36.0f)];
    self.marqueeView.backgroundColor = [UIColor whiteColor];
    self.marqueeView.layer.masksToBounds = YES;
    self.marqueeView.layer.cornerRadius = 4.f;
    self.marqueeView.delegate = self;
    self.marqueeView.timeIntervalPerScroll = 2.0f;    // 条目滑动间隔
    self.marqueeView.timeDurationPerScroll = 1.0f;    // 条目滑动时间
    self.marqueeView.touchEnabled = YES;    // 设置为YES可监听点击事件，默认值为NO
    [self.contentView addSubview:self.marqueeView];
    
}
#pragma mark - UUMarqueeViewDelegate
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定可视条目的行数，仅[UUMarqueeViewDirectionUpward]时被调用。
    // 当[UUMarqueeViewDirectionLeftward]时行数固定为1。
    return 1;
}

- (NSUInteger)numberOfDataForMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定数据源的个数。例:数据源是字符串数组@[@"A", @"B", @"C"]时，return 3。
    return self.dataSource.count;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(UUMarqueeView*)marqueeView {
    // 在marquee view创建时（即'-(void)reloadData'调用后），用于创建条目视图的初始结构，可自行添加任意subview。
    // ### 给必要的subview添加tag，可在'-(void)updateItemView:withData:forMarqueeView:'调用时快捷获取并设置内容。
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(8, 0, kScreenWidth - 28 - 16, 36);
    //[btn setImage:[UIImage imageNamed:@"icon_walk"] forState:UIControlStateNormal];
    [btn sd_setImageWithURL:[Util loadImageUrl:@"icon_walk"] forState:UIControlStateNormal placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image){
            UIImage *iconImage = [Util imageResize:image ResizeTo:CGSizeMake(20, 20)];
            [btn setImage:iconImage forState:UIControlStateNormal];
        }
    
    }];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    btn.tag = 1001;
    [btn setTitleColor:[UIColor qmui_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [itemView addSubview:btn];

}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    
    UIButton *content = [itemView viewWithTag:1001];
    BagHomeHorseItemModel *model = self.dataSource[index];
    [content setTitle:model.sluttishF forState:UIControlStateNormal];
    content.backgroundColor = [UIColor whiteColor];
    itemView.backgroundColor = [UIColor whiteColor];

}

- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定条目在显示数据源内容时的视图宽度，仅[UUMarqueeViewDirectionLeftward]时被调用。
    return kScreenWidth - 28;
}

- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    // 点击事件回调。在'touchEnabled'设置为YES后，触发点击事件时被调用。
    NSLog(@"Touch at index %lu", (unsigned long)index);
}
@end
