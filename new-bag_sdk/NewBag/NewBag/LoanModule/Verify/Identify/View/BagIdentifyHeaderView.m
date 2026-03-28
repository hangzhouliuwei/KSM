//
//  BagIdentifyHeaderView.m
//  NewBag
//
//  Created by Jacky on 2024/4/10.
//

#import "BagIdentifyHeaderView.h"
#import "BagIdentifyModel.h"
@interface BagIdentifyHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *selectBgView;
@property (weak, nonatomic) IBOutlet UIView *uploadCardBgView;
@property (weak, nonatomic) IBOutlet UILabel *selectIDNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *idCardImage;
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;

@property (nonatomic, assign) BOOL canSelect;
@end
@implementation BagIdentifyHeaderView
- (void)awakeFromNib
{
    [super awakeFromNib];
    WEAKSELF
    [[SDWebImageManager sharedManager] loadImageWithURL:[Util loadImageUrl:@"basic_camera_icon"]
                                                options:0
                                               progress:nil
                                              completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        STRONGSELF
        if (image) {
            [strongSelf.upLoadBtn setImage:[Util imageResize:image ResizeTo:CGSizeMake(30.f, 30.f)] forState:UIControlStateNormal];
        }
       
    }];
    [self.idCardImage sd_setImageWithURL:[Util loadImageUrl:@"identify_bg"]];
    [self.arrowBtn sd_setImageWithURL:[Util loadImageUrl:@"icon_choose_down-3"] forState:UIControlStateNormal];
    [self.selectBgView br_setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadius:CGSizeMake(4, 4)];
    [self.selectBgView br_setGradientColor:[UIColor qmui_colorWithHexString:@"#0EB479"] toColor:[UIColor qmui_colorWithHexString:@"#0EB479"] direction:BRDirectionTypeLeftToRight bounds:CGRectMake(0, 0, 256, 36)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCardAction)];
    [self.selectBgView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadAction:)];
    [self.uploadCardBgView addGestureRecognizer:tap2];
    self.frame = CGRectMake(0, 0, kScreenWidth,386);
    self.canSelect = YES;
    [self layoutIfNeeded];
}
- (void)drawRect:(CGRect)rect
{
    self.frame = CGRectMake(0, 0, kScreenWidth,386);

}
+ (instancetype)createView{
    BagIdentifyHeaderView *view = [Util getSourceFromeBundle:NSStringFromClass(self.class)];
    return view;
}
- (void)selectCardAction{
    if (self.canSelect) {
        if (self.selectTypeBlock) {
            self.selectTypeBlock();
        }
    }
}
- (void)updateIDcardImageUrl:(NSString *)url
{
    if (![NotNull(url) br_isBlankString]) {
        _canSelect = NO;
    }
    [self.idCardImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"identify_bg"]];
}
- (void)updateIDcardImage:(UIImage *)IDcardImage
{
    _canSelect = NO;
    self.idCardImage.image = IDcardImage;
}
- (void)updateModel:(BagIdentifyListModel *)model
{
    [self.idCardImage sd_setImageWithURL:[NSURL URLWithString:model.kraterF] placeholderImage:[UIImage imageNamed:@"identify_bg"]];
    self.selectIDNameLabel.text = NotNull(model.monitorshipF);
//    self.selectIDNameLabel.font = [PUBTools isBlankString:model.monitorshipF] ? FONT(13.f) : FONT_Semibold(16.f);
    self.selectIdCardNo = model.conniptionF;
    
}
- (IBAction)uploadAction:(id)sender {
    if (self.canSelect) {
        if (self.idCardImageClickBlock) {
            self.idCardImageClickBlock();
        }
    }
}



@end
