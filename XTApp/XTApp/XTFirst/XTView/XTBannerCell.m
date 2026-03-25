//
//  XTBannerCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTBannerCell.h"
#import <TYCyclePagerView.h>
#import "XTBannerChildCell.h"
#import "XTBannerModel.h"

@interface XTBannerCell()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property(nonatomic,strong) TYCyclePagerView *banner;
@property(nonatomic,strong) NSArray *bannerList;

@end

@implementation XTBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

-(void)xt_UI {
    [self.contentView addSubview:self.banner];
}

#pragma mark - TYCyclePagerViewDataSource

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(self.banner.width, self.banner.height);
    layout.itemSpacing = 10;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerList.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    XTBannerChildCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"XTBannerChildCell" forIndex:index];
    XTBannerModel *model = self.bannerList[index];
    cell.model = model;
    return cell;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    XTBannerModel *model = self.bannerList[index];
    [[XTRoute xt_share] goHtml:model.relosixomNc success:nil];
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[NSArray class]]) {
        return;
    }
    NSArray *array = (NSArray *)xt_data;
    self.bannerList = array;
    if(array.count > 1){
        self.banner.autoScrollInterval = 3;
    }
    else{
        self.banner.autoScrollInterval = 0;
    }
    [self.banner reloadData];
}

-(TYCyclePagerView *)banner{
    if(!_banner){
        _banner = [[TYCyclePagerView alloc]initWithFrame:CGRectMake(15, 0, XT_Screen_Width - 30, 115)];
        _banner.isInfiniteLoop = NO;
        _banner.dataSource = self;
        _banner.delegate = self;
        // registerClass or registerNib
        [_banner registerClass:[XTBannerChildCell class] forCellWithReuseIdentifier:@"XTBannerChildCell"];
    }
    return _banner;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
