//
//  XTLoginOutCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTLoginOutCell.h"

@interface XTLoginOutCell()

@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation XTLoginOutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self.contentView addSubview:self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(32);
            make.right.equalTo(self.contentView.mas_right).offset(-32);
            make.top.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Log out" font:XT_Font_SD(20) textColor:[UIColor blackColor] cornerRadius:24 borderColor:[UIColor blackColor] borderWidth:1 backgroundColor:[UIColor whiteColor] tag:0];
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
           @strongify(self)
            if(self.block) {
                self.block();
            }
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
}

@end
