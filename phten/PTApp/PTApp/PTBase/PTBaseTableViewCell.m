//
//  PTBaseTableViewCell.m
//  PTApp
//
//  Created by Jacky on 2024/8/22.
//

#import "PTBaseTableViewCell.h"

@implementation PTBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
}
@end
