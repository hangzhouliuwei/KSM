//
//  XTSmallCell.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTSmallCell.h"
#import "XTIndexModel.h"
#import "XTCardModel.h"
#import "XTMarqueeView.h"
#import "XTLanternModel.h"

#import <TYCyclePagerView.h>
#import "XTBannerChildCell.h"
#import "XTBannerModel.h"

#define LanternLabTag 10001
#define LanternH 28
#define LanternW (XT_Screen_Width - 55 - 33)

@interface XTSmallCell()<XTMarqueeViewDelegate,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property(nonatomic,strong)XTCardModel *small;

@property(nonatomic,weak) UIImageView *contentImg;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIImageView *img;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UILabel *descLab;
@property(nonatomic,strong) UIImageView *rightImg;
@property(nonatomic,strong) UIButton *submitBtn;

@property(nonatomic,strong) UIView *lanternView;
@property(nonatomic,strong) XTMarqueeView *marqueeView;
@property(nonatomic,strong) NSArray <XTLanternModel *>*lanternArray;

@property(nonatomic,strong) UIView *bannerView;
@property(nonatomic,strong) TYCyclePagerView *banner;
@property(nonatomic,strong) NSArray *bannerList;

@end

@implementation XTSmallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    UIImageView *bg = [UIImageView new];
    bg.image = XT_Img(@"xt_first_small_bg");
    [self.contentView addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    UIImageView *img = [UIImageView xt_img:@"xt_first_top_bg" tag:0];
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top);
    }];
    UIImageView *contentImg = [UIImageView xt_img:nil tag:0];
    contentImg.image = [XT_Img(@"xt_first_top_content_small_bg") stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    [self.contentView addSubview:contentImg];
    self.contentImg = contentImg;
    [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.right.equalTo(self.contentView.mas_right).offset(-14);
        make.top.equalTo(self.contentView.mas_top).offset(128);
        make.height.mas_equalTo(182);
    }];
    
    UIImageView *tagImg = [UIImageView xt_img:@"xt_first_tag" tag:0];
    [self.contentView addSubview:tagImg];
    [tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentImg.mas_right).offset(-16);
        make.top.equalTo(contentImg.mas_top).offset(10);
    }];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImg.mas_left).offset(16);
        make.top.equalTo(contentImg.mas_top).offset(12);
        make.height.mas_equalTo(17);
    }];
    
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImg.mas_left).offset(66);
        make.top.equalTo(contentImg.mas_top).offset(48);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(19);
        make.right.equalTo(contentImg.mas_right).offset(-10);
        make.top.equalTo(contentImg.mas_top).offset(26);
        make.height.mas_equalTo(76);
    }];
    [self.contentView addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_left);
        make.right.equalTo(contentImg.mas_right).offset(-10);
        make.bottom.equalTo(self.priceLab.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    [self.contentView addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentImg.mas_right).offset(-15);
        make.top.equalTo(contentImg.mas_top).offset(10);
        make.height.mas_equalTo(21);
    }];
    
    [self.contentView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentImg.mas_left).offset(25);
        make.right.equalTo(contentImg.mas_right).offset(-25);
        make.top.equalTo(contentImg.mas_top).offset(117);
        make.height.mas_equalTo(48);
    }];
    
    [self.contentView addSubview:self.lanternView];
    [self.lanternView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(contentImg.mas_bottom).offset(12);
        make.height.mas_equalTo(28);
    }];
    
    [self.contentView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.lanternView.mas_bottom).offset(12);
        make.height.mas_equalTo(115);
    }];
    
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[XTIndexModel class]]){
        return;
    }
    XTIndexModel *model = (XTIndexModel *)xt_data;
    XTCardModel *small = model.small;
    self.small = small;
    self.nameLab.text = small.moossixyllabismNc;
    [self.img sd_setImageWithURL:[NSURL URLWithString:small.sihosixuetteNc] placeholderImage:XT_Img(@"xt_img_def")];
    self.priceLab.text = small.eahosixleNc;
    self.descLab.text = small.cotesixnderNc;
    [self.rightImg sd_setImageWithURL:[NSURL URLWithString:small.brvasixdoNc]];
    [self.submitBtn setTitle:small.maansixNc forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = small.spffsixlicateNc.xt_hexColor;
    
    if(model.lanternArr.count > 0){
        self.lanternArray = model.lanternArr;
        self.lanternView.hidden = NO;
        [self.lanternView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.contentImg.mas_bottom).offset(12);
            make.height.mas_equalTo(28);
        }];
        [self.marqueeView reloadData];
        [self.marqueeView start];
    }
    else{
        self.lanternView.hidden = YES;
        [self.lanternView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.contentImg.mas_bottom);
            make.height.mas_equalTo(28);
        }];
    }
    if(model.bannerArr.count > 0) {
        self.bannerView.hidden = NO;
        self.bannerList = model.bannerArr;
        if(self.bannerList.count > 1){
            self.banner.autoScrollInterval = 3;
        }
        else{
            self.banner.autoScrollInterval = 0;
        }
        [self.banner reloadData];
    }
    else{
        self.bannerView.hidden = YES;
    }
    
}

#pragma mark - UUMarqueeViewDelegate
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(XTMarqueeView*)marqueeView {
    return 1;
}
- (NSUInteger)numberOfDataForMarqueeView:(XTMarqueeView*)marqueeView {
    return self.lanternArray.count;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(XTMarqueeView*)marqueeView {
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LanternW, LanternH)];
    lab.font = XT_Font_M(13);
    lab.numberOfLines = 2;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.tag = LanternLabTag;
    [itemView addSubview:lab];
}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView {
    UILabel *lab = (UILabel *)[itemView viewWithTag:LanternLabTag];
    XTLanternModel *model = self.lanternArray[index];
    lab.textColor = model.epgysixnyNc.xt_hexColor;
    lab.text = model.thcksixleafNc;
}
- (CGFloat)itemViewHeightAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView {
    return LanternH;
}
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView {
    return LanternW;
}
//点击
- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView {
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)bannerView {
    if(!_bannerView) {
        UIView *view = [UIView new];
        [view addSubview:self.banner];
        _bannerView = view;
    }
    return _bannerView;
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

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"" font:XT_Font_M(20) textColor:[UIColor blackColor] cornerRadius:0 tag:0];
        _submitBtn.clipsToBounds = YES;
        _submitBtn.layer.cornerRadius = 24;
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(!self.small.pacasixrditisNc){
                return [RACSignal empty];
            }
            if(self.nextBlock){
                self.nextBlock();
            }
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}

- (UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font(13) textColor:XT_RGB(0x797979, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _nameLab;
}



- (UIImageView *)img {
    if(!_img) {
        _img = [UIImageView new];
        _img.clipsToBounds = YES;
        _img.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _img;
}

- (UILabel *)priceLab {
    if(!_priceLab) {
        _priceLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_B(40) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
    }
    return _priceLab;
}


- (UILabel *)descLab {
    if(!_descLab) {
        _descLab = [UILabel xt_lab:CGRectZero text:@"" font:XT_Font_M(9) textColor:XT_RGB(0x3B3B3B, 1.0f) alignment:NSTextAlignmentLeft tag:0];
    }
    return _descLab;
}

- (UIImageView *)rightImg {
    if(!_rightImg){
        _rightImg = [UIImageView new];
    }
    return _rightImg;
}


- (UIView *)lanternView {
    if(!_lanternView) {
        UIView *view = [UIView xt_frame:CGRectZero color:XT_RGB(0x0BB559, 1.0f)];
        view.layer.cornerRadius = 14;
        
        UIImageView *logoImg = [UIImageView xt_img:@"xt_first_lantern_icon" tag:0];
        [view addSubview:logoImg];
        [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(13);
            make.centerY.equalTo(view);
        }];
        XTMarqueeView *marqueeView = [[XTMarqueeView alloc] initWithFrame:CGRectMake(40, 0, LanternW, LanternH)];
        marqueeView.backgroundColor = [UIColor clearColor];
        marqueeView.delegate = self;
        marqueeView.timeIntervalPerScroll = 2.0f;
        marqueeView.timeDurationPerScroll = 1.0f;
        [view addSubview:marqueeView];
        self.marqueeView = marqueeView;
        
        
        _lanternView = view;
    }
    return _lanternView;
}

@end
