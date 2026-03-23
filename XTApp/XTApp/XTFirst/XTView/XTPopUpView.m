//
//  XTPopUpView.m
//  XTApp
//
//  Created by xia on 2024/9/23.
//

#import "XTPopUpView.h"

@implementation XTPopUpView

- (instancetype)initImg:(NSString *)imgUrl url:(NSString *)url text:(NSString *)text {
    self = [super initWithFrame:CGRectMake(0, 0, XT_Screen_Width, XT_Screen_Height)];
    if(self) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        
        UIImageView *img = [UIImageView new];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(292, 287));
        }];
        [img sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:XT_Img(@"xt_img_def")];
        
        UIImageView *closeImg = [UIImageView xt_img:@"xt_first_close" tag:0];
        [self addSubview:closeImg];
        [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(img.mas_bottom).offset(7);
        }];
        
        UIButton *tapBtn = [UIButton new];
        [self addSubview:tapBtn];
        [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(img);
        }];
        tapBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [[XTRoute xt_share] goHtml:url success:nil];
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        
    }
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
