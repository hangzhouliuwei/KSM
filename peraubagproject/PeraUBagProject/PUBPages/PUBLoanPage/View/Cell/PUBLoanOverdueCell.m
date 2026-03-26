//
//  PUBLoanOverdueCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/7.
//

#import "PUBLoanOverdueCell.h"
#import "PUBLoanOverdueModel.h"

@interface PUBLoanOverdueCell ()
@property(nonatomic, strong) UIImageView *tipImageView;
@property(nonatomic, strong) PUBLoanOverdueItmeModel *model;
@end

@implementation PUBLoanOverdueCell

- (void)tipImageViewTapClick
{
    if(self.overdueClickBlock){
        self.overdueClickBlock(self.model.lobsterman_eg);
    }
    
}

- (void)configModel:(PUBLoanOverdueItmeModel*)model
{
    self.model = model;
    WEAKSELF
    [self.tipImageView sd_setImageWithURL:[NSURL URLWithString:NotNull(model.electioneer_eg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        STRONGSELF
        if(image){
            strongSelf.tipImageView.image = [PUBTools imageResize:image withResizeTo:CGSizeMake(KSCREEN_WIDTH -40.f, 72.f)];
        }
        
    }];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}

- (void)initSubViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.tipImageView];
    UITapGestureRecognizer *tipImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipImageViewTapClick)];
    [self.tipImageView addGestureRecognizer:tipImageViewTap];
}

- (void)initSubFrames
{
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-20.f);
        make.height.mas_equalTo(72.f);
    }];
    
}

- (UIImageView *)tipImageView{
    if(!_tipImageView){
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tipImageView.userInteractionEnabled = YES;
    }
    
    return _tipImageView;
}

@end
