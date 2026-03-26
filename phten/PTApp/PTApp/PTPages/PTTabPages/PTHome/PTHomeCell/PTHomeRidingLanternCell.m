//
//  PTHomeRidingLanternCell.m
//  PTApp
//
//  Created by 刘巍 on 2024/8/3.
//

#import "PTHomeRidingLanternCell.h"
#import "PTRidingLanternModel.h"
#import "UUMarqueeView.h"

@interface PTHomeRidingLanternCell()<UUMarqueeViewDelegate>
@property(nonatomic, strong) UUMarqueeView *marqueeView;
@property(nonatomic, strong) PTRidingLanternModel *model;
@end

@implementation PTHomeRidingLanternCell

-(void)configModel:(PTRidingLanternModel*)model
{
    self.model = model;
    [self.marqueeView reloadData];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self createSubUI];
    }
    return self;
}

- (void)createSubUI
{
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_lanternBack"]];
    [self.contentView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16.f);
        make.right.mas_equalTo(-14.f);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(32.f);
    }];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PT_home_lanternleft"]];
    [backImage addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(96.f);
    }];
    
    self.marqueeView.frame = CGRectMake(108.f, 0, kScreenWidth - 96.f -40.f, 32.f);
    [backImage addSubview:self.marqueeView];
}

#pragma mark - UUMarqueeViewDelegate

- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    return 1;
}

- (NSUInteger)numberOfDataForMarqueeView:(UUMarqueeView*)marqueeView {
    return self.model.gutengoyleNc.count;
}

- (void)createItemView:(UIView*)itemView forMarqueeView:(UUMarqueeView*)marqueeView {
    QMUILabel *content = [[QMUILabel alloc] qmui_initWithFont:PT_Font(12.f) textColor:PTUIColorFromHex(0x000000)];
    content.frame = CGRectMake(0, 8.f, kScreenWidth - 96.f -40.f, 18.f);
    content.tag = 1001;
    [itemView addSubview:content];
}

- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {
    if(self.model.gutengoyleNc.count < index) return;
    PTRidingLanternItemModel *itmeModel = [self.model.gutengoyleNc objectAtIndex:index];
    UILabel *content = [itemView viewWithTag:1001];
    content.textColor = [UIColor qmui_colorWithHexString:itmeModel.eptengynyNc];
    content.text = PTNotNull(itmeModel.thtenckleafNc);
}

- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(UUMarqueeView*)marqueeView {

    return kScreenWidth - 28.f;
}



#pragma mark - lazy
-(UUMarqueeView *)marqueeView{
    if(!_marqueeView){
        _marqueeView = [[UUMarqueeView alloc] initWithDirection:UUMarqueeViewDirectionUpward];
        _marqueeView.delegate = self;
        _marqueeView.timeDurationPerScroll = 1.2f;
        _marqueeView.timeIntervalPerScroll = 0.8f;

    }
    return _marqueeView;
}

@end
