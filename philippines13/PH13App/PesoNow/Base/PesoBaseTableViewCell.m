//
//  PesoBaseTableViewCell.m
//  PesoApp
//
//  Created by Jacky on 2024/9/10.
//

#import "PesoBaseTableViewCell.h"

@implementation PesoBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self createUI];
    }
    return self;
}
- (void)createUI{
  
}
- (void)configUIWithModel:(id)model
{
    
}
@end
