//
//  XTFirstFootCell.m
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import "XTFirstFootCell.h"

@implementation XTFirstFootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        UIImageView *img = [UIImageView xt_img:@"xt_first_foot_bg" tag:0];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
