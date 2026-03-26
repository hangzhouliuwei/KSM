//
//  PUBSingleCell.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/1/2.
//

#import "PUBSingleCell.h"
#import "PUBBasicModel.h"
#import "PUBContactModel.h"
#import "PUBPhotosModel.h"
#import "PUBBankModel.h"

@interface PUBSingleCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;
@end

@implementation PUBSingleCell

///银行卡选择
- (void)configBankModel:(PUBBankLysinEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index
{
    self.titleLabel.text = NotNull(model.rhodo_eg);
    if(seleIndex == -1)return;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString: seleIndex == index ? @"#00FFD7" : @"#FFFFFF"];
    
}

///拍照方式选择
- (void)configPhotosCameraStr:(NSString*)cameraStr seleIndex:(NSInteger)seleIndex index:(NSInteger)index
{
    self.titleLabel.text = NotNull(cameraStr);
    if(seleIndex == -1)return;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString: seleIndex == index ? @"#00FFD7" : @"#FFFFFF"];
}

///身份证
- (void)configPhotosModel:(PUBPhotosHorrificEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index
{
    self.titleLabel.text = NotNull(model.trebly_eg);
    if(seleIndex == -1)return;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString: seleIndex == index ? @"#00FFD7" : @"#FFFFFF"];
}


///通讯录
- (void)configContanModel:(PUBContactFeatherstitchEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index
{
    self.titleLabel.text = NotNull(model.rhodo_eg);
    if(seleIndex == -1)return;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString: seleIndex == index ? @"#00FFD7" : @"#FFFFFF"];
}

- (void)configModel:(PUBBasicHorrificEgModel*)model seleIndex:(NSInteger)seleIndex index:(NSInteger)index
{
    self.titleLabel.text = NotNull(model.rhodo_eg);
    if(seleIndex == -1)return;
    self.titleLabel.textColor = [UIColor qmui_colorWithHexString: seleIndex == index ? @"#00FFD7" : @"#FFFFFF"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor qmui_colorWithHexString:@"#313848"];
        [self initSubViews];
        [self initSubFrames];
    }
    return self;
}

- (void)initSubViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lineView];
    
}

- (void)initSubFrames
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.8f);
    }];
}

#pragma mark - lazy
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] qmui_initWithFont:FONT_BOLD(17.f) textColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qmui_colorWithHexString:@"#777C8E"];
    }
    return _lineView;
}

@end
