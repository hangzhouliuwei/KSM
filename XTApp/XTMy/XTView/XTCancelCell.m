//
//  XTCancelCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTCancelCell.h"

@interface XTCancelCell()

@property(nonatomic,strong) UIButton *submitBtn;

@end

@implementation XTCancelCell

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
        _submitBtn = [UIButton xt_btn:@"Cancel Account" font:XT_Font_M(20) textColor:[UIColor whiteColor] cornerRadius:24 borderColor:nil borderWidth:0 backgroundColor:XT_RGB(0x0BB559, 1.0f) tag:0];
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
