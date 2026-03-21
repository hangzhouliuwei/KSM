//
//  XTNoticeCell.m
//  XTApp
//
//  Created by xia on 2024/9/23.
//

#import "XTNoticeCell.h"
#import "XTRepayModel.h"

@interface XTNoticeCell ()

@property(nonatomic,strong) UIImageView *bgImg;
@property(nonatomic,weak) XTRepayModel *model;

@end

@implementation XTNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self xt_UI];
    }
    return self;
}

- (void)xt_UI {
    [self.contentView addSubview:self.bgImg];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    UIButton *btn = [UIButton new];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    @weakify(self)
    btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [[XTRoute xt_share] goHtml:self.model.relosixomNc success:nil];
        return [RACSignal empty];
    }];
}

- (void)setXt_data:(id)xt_data {
    if(![xt_data isKindOfClass:[XTRepayModel class]]) {
        return;
    }
    self.model = xt_data;
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:self.model.frwnsixNc] placeholderImage:XT_Img(@"xt_img_def")];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)bgImg {
    if(!_bgImg) {
        _bgImg = [UIImageView new];
        _bgImg.clipsToBounds = YES;
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.layer.cornerRadius = 10.0f;
    }
    return _bgImg;
}

@end
