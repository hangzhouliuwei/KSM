//
//  BaseTableView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/25.
//

#import "PLPBaseTableView.h"

@implementation PLPBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:self.tipView];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((_tipView.width - 165) / 2.0, 0, 165, 103)];
        imageView.image = kImageName(@"order_placeholder");
        [self.tipView addSubview:imageView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom, _tipView.width, 20)];
        [titleLabel pp_setPropertys:@[kFontSize(14),@"No Records",@(NSTextAlignmentCenter),kGrayColor_999999]];
        [self.tipView addSubview:titleLabel];
        UIButton *applyButtpn = [[PLPCapsuleButton alloc] initWithFrame:CGRectMake((_tipView.width - 145) / 2.0, 20 + titleLabel.bottom, 145, 34)];
        [self.tipView addSubview:applyButtpn];
        applyButtpn.titleLabel.font = kFontSize(13);
        [applyButtpn setTitle:@"Apply now" forState:UIControlStateNormal];
        [applyButtpn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [applyButtpn addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _tipView.height = applyButtpn.bottom;
        self.tipView.hidden = true;
        _tipView.centerY = self.height / 2.0 - 60;
        
        self.pageIndex = 1;
    }
    return self;
}
-(void)reloadData
{
    [super reloadData];
    self.tipView.hidden = self.dataList.count != 0;
}
-(void)handleButtonAction:(UIButton *)button
{
    if (self.applyButtonBlk) {
        self.applyButtonBlk();
    }
    [self beginUpdates];
    [self endUpdates];
}
-(NSMutableArray *)dataList
{
    if (!_dataList ) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
-(UIView *)listView
{
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
