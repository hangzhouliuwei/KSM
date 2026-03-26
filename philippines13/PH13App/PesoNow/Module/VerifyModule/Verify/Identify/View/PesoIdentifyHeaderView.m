//
//  PesoIdentifyHeaderView.m
//  PesoApp
//
//  Created by Jacky on 2024/9/16.
//

#import "PesoIdentifyHeaderView.h"
#import "PesoBasicSectionHeader.h"
#import "PesoIdentifyModel.h"
@interface PesoIdentifyHeaderView()
@property (nonatomic, strong) PesoBasicSectionHeader *header;
@property (nonatomic, strong) QMUILabel *titleL;
@property (nonatomic, strong) QMUILabel *valueL;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIImageView *idcardImage;
@property (nonatomic, strong) UIImageView *cameraImage;

@property (nonatomic, assign) BOOL canSelect;

@end
@implementation PesoIdentifyHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        [self createUI];
        self.canSelect = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createUI{
    
    PesoBasicSectionHeader *header = [[PesoBasicSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [self addSubview:header];
    [header updateUIWithTitle:@"Upload your ID" Subtitle:@"" more:NO isSelected:NO];
    _header = header;
    
    QMUILabel *titleL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0x0B2C04)];
    titleL.frame = CGRectMake(14, header.bottom+13, kScreenWidth - 28, 17);
    titleL.numberOfLines = 1;
    titleL.text = @"Relationship";
    [self addSubview:titleL];
    _titleL = titleL;
    
    UIView *valueBg = [[UIView alloc] initWithFrame:CGRectMake(14, titleL.bottom+10, kScreenWidth-28, 44)];
    valueBg.backgroundColor = ColorFromHex(0xFBFBFB);
    valueBg.layer.cornerRadius = 4;
    valueBg.layer.masksToBounds = YES;
    [self addSubview:valueBg];
    
    
    QMUILabel *valueL = [[QMUILabel alloc] qmui_initWithFont:PH_Font(13) textColor:ColorFromHex(0xA6B5A3)];
    valueL.frame = CGRectMake(12, 0, valueBg.width - 12 - 34, 17);
    valueL.numberOfLines = 1;
    valueL.centerY = 22;
    valueL.text = @"Please Select";
    [valueBg addSubview:valueL];
    _valueL = valueL;
    
    UIImageView *arrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basic_arrow_down"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    arrow.frame = CGRectMake(valueBg.width - 12 - 22, 0, 22, 22);
    arrow.centerY = 22;
    arrow.userInteractionEnabled = YES;
    _arrow = arrow;
    [valueBg addSubview:arrow];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCardType)];
    [valueBg addGestureRecognizer:tap];
    
    UIImageView *idcardImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"identify_card_default"]];
    idcardImage.contentMode = UIViewContentModeScaleToFill;
    idcardImage.frame = CGRectMake(0, valueBg.bottom+20, 300, 192);
    idcardImage.centerX = self.centerX;
    idcardImage.userInteractionEnabled = YES;
    [self addSubview:idcardImage];
    _idcardImage = idcardImage;
    
    UIImageView *cameraImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_camera"]];
    cameraImage.contentMode = UIViewContentModeScaleToFill;
    cameraImage.frame = CGRectMake(0, 0, 70, 70);
    cameraImage.center =CGPointMake(150, 192/2);
    cameraImage.userInteractionEnabled = YES;
    [idcardImage addSubview:cameraImage];
    _cameraImage = cameraImage;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadIdcard)];
    [idcardImage addGestureRecognizer:tap2];
}

//选了证件类型 此时 uoload 按钮还是显示
- (void)updateModel:(PesoIdentifyListModel *)model
{
    [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:model.ovrpthirteenunchNc] placeholderImage:[UIImage imageNamed:@"identify_card_default"]];
    self.valueL.text = model.roanthirteenizeNc ? :@"Please Select";
    self.valueL.textColor = ColorFromHex(0x000000);
    self.selectIdCardNo = model.ceNcthirteen;
}
- (void)updateIDcardImage:(UIImage *)IDcardImage
{
    self.idcardImage.image = IDcardImage;
    self.canSelect = NO;
    self.cameraImage.hidden = YES;
}
- (void)updateIDcardImageUrl:(NSString *)url bankName:(nonnull NSString *)name
{
    if (br_isNotEmptyObject(url)) {
        _canSelect = NO;
        self.cameraImage.hidden = YES;
    }
    [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pt_identify_idcard"]];
    self.valueL.text = name;
    self.valueL.textColor = ColorFromHex(0x000000);
}
- (void)clickCardType{
    if (!self.canSelect) {
        return;
    }
    if (self.selectTypeBlock) {
        self.selectTypeBlock();
    }
}
- (void)uploadIdcard{
    if (!self.canSelect) {
        return;
    }
    if (self.uploadClickBlock) {
        self.uploadClickBlock();
    }
}
@end
