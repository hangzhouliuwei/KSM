//
//  AuthPhotoViewController.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/5.
//

#import "PLPAuthOCRViewController.h"
#import "BasicHeadView.h"
#import "BasicTimerView.h"
#import "AuthTableViewCell.h"
#import "AuthSelectAlertView.h"
#import "CameraViewController.h"
#import "AuthDateAlertView.h"
//#import "<#header#>"
@interface PLPAuthOCRViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic)UITableView *tableView;
@property(nonatomic)NSMutableArray *dataSource;
@property(nonatomic)UIView *headerView;
@property(nonatomic)BasicHeadView *progressView;
@property(nonatomic)BasicTimerView *timerView;
@property(nonatomic)NSInteger index;
@property(nonatomic)UIButton *nextButton;
@property(nonatomic)UIImagePickerController *pickerC;
@property(nonatomic)NSString *seiatwelvebstractNc;
@property(nonatomic)NSString *light;
@end

@implementation PLPAuthOCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"identihcation";
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 283);
    gradientLayer.colors = @[
        (__bridge id)kBlueColor_0053FF.CGColor,  // #2964F6
        (__bridge id)kHexColor(0xF5F5F5).CGColor   // #F9F9F9
    ];
    gradientLayer.startPoint = CGPointMake(0.5, 0.0);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.shouldPopHome = true;
    self.holdConetent = @"Complete your identification now for achance to increase your loan limit";
}
-(void)handleNextButtonAction:(UIButton *)button
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    AuthSectionModel *temp = self.dataSource.lastObject;
//    for (AuthSectionModel *temp in ) {
        for (AuthOptionalModel *model in temp.xathtwelveosisNc) {
            if (model.tapatwelvexNc == 0) {
                if ([model.valueStr isReal]) {
                    result[model.imeatwelvesurabilityNc] = model.valueStr;
                }else
                {
                    NSString *info = [NSString stringWithFormat:@"Please complete %@",model.orintwelvearilyNc];
                    kPLPPopInfoWithStr(info);
                    return;
                }
            }else
            {
                if ([model.valueStr isReal]) {
                    result[model.imeatwelvesurabilityNc] = model.valueStr;
                }
            }
        }
//    }
    result[@"point"] = [self BASE_GeneragePointDictionaryWithType:@"24"];
    result[@"liettwelveusNc"] = [PLPDataManager manager].productId;
    if ([self.seiatwelvebstractNc isReal]) {
        result[@"seiatwelvebstractNc"] = self.seiatwelvebstractNc;
    }
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/photo_next" paramsInfo:result successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"][@"deectwelvetibleNc"];
        [self decodeAuthResponseData:data];
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
    [PLPCommondTools uploadDeviceInfo];
    
}
-(void)BASE_RequestHTTPInfo
{
    kShowLoading
    [[PLPNetRequestManager plpJsonManager] POSTURL:@"twelveca/photo" paramsInfo:@{@"liettwelveusNc":[PLPDataManager manager].productId} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *data = responseObject[@"viustwelveNc"];
        NSInteger time = [data[@"paeotwelvegrapherNc"] integerValue];
        if (time > 0) {
            self.timerView.count = time;
            [self.timerView startTimer];
            [self.headerView addSubview:self.timerView];
            self.headerView.height = self.timerView.bottom + 12;
            self.tableView.tableHeaderView = _headerView;
        }
        
//        NSArray *list = data[@"casatwelvebNc"][@"xathtwelveosisNc"];
        AuthSectionModel *model = [[AuthSectionModel alloc] init];
        model.fldgtwelveeNc = @"Upload your ID";
        AuthOptionalModel *optionModel = [AuthOptionalModel yy_modelWithDictionary:data[@"casatwelvebNc"]];
        optionModel.cellHeight = 410;
        optionModel.labelHeight = 22;
        optionModel.fldgtwelveeNc = @"Select iD Type";
        optionModel.showOCR = true;
        optionModel.showCamera = true;
        optionModel.orintwelvearilyNc = @"Please Select";
        optionModel.type = kAuthCellType_Select;
        optionModel.needClip = true;
        model.xathtwelveosisNc = @[optionModel];
        [self.dataSource addObject:model];
        
        NSInteger decatwelveleNc = [data[@"casatwelvebNc"][@"decatwelveleNc"] integerValue];
        if (decatwelveleNc != 0) {
            self.seiatwelvebstractNc = data[@"casatwelvebNc"][@"darytwelvemanNc"];
            for (AuthItemModel *item in optionModel.tubotwelvedrillNc) {
                if (item.ceNctwelve == decatwelveleNc) {
                    optionModel.selectedModel = item;
                    optionModel.showCamera = false;
                    optionModel.cellHeight = 330;
                    AuthSectionModel *existModel = [self generateSectionMoodel:data[@"casatwelvebNc"][@"xathtwelveosisNc"]];
                    self.nextButton.hidden = false;
                    [self.dataSource addObject:existModel];
                }
            }
        }
        
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!optionModel.selectedModel) {
                [self tapItemIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }
        });
    } failureBlk:^(NSError * _Nonnull error) {
        
    }];
}
-(AuthSectionModel *)generateSectionMoodel:(NSArray *)info
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < info.count; i++) {
        NSDictionary *dic = info[i];
        AuthOptionalModel *temp = [AuthOptionalModel yy_modelWithDictionary:dic];
        temp.valueStr = temp.darytwelvemanNc;
        CGFloat height = [temp.fldgtwelveeNc heightWithWidth:kScreenW - 30 - 28 font:kFontSize(16)];
        temp.labelHeight = height;
        temp.cellHeight = height + 50 + 16 + 7;
        [array addObject:temp];
        NSString *cellType = temp.lebotwelveardNc;
        if ([cellType isEqualToString:@"AATWELVEBF"]) {
            temp.type = kAuthCellType_Select;
        }else if ([cellType isEqualToString:@"AATWELVEBG"]) {
            if ([temp.fldgtwelveeNc isEqualToString:@"Email"]) {
                temp.type = kAuthCellType_Email;
                temp.cellHeightEmail = height + 50 + 16 + 7 + 150 + 5 * 2;
            }else
            {
                temp.type = kAuthCellType_TextField;
            }
        }else if ([cellType isEqualToString:@"AATWELVEBJ"]) {
            temp.type = kAuthCellType_Date;
        }else if ([cellType isEqualToString:@"AATWELVEBI"]) {
            temp.type = kAuthCellType_Gender;
        }
        if (i == info.count - 1) {
            temp.needClip = true;
        }
    }
    AuthSectionModel *model = [AuthSectionModel new];
    model.fldgtwelveeNc = @"First Name";
    model.xathtwelveosisNc = array;
    return model;
}
-(void)tapCameraIndexPath:(NSIndexPath *)indexPath
{
    AuthSectionModel *model = self.dataSource[indexPath.section];
    if(!model.xathtwelveosisNc.firstObject.selectedModel) {
        AuthOptionalModel *optionModel = model.xathtwelveosisNc.firstObject;
        kPLPPopInfoWithStr(optionModel.fldgtwelveeNc);
        return;
    }
    NSString *light = [NSString stringWithFormat:@"%ld",model.xathtwelveosisNc.firstObject.selectedModel.ceNctwelve];
    self.light = light;
    if (![light isReal]) {
        return;
    }
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Select Type" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerC.allowsEditing = false;
        pickerC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pickerC animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([light isReal]) {
            [PLPCommondTools requestCameraAuthority:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CameraViewController *vc = [CameraViewController new];
                    vc.light = light;
                    __weak typeof(self) weakSelf = self;
                    vc.takeFinish = ^(id responseObject, UIImage *capturedImage) {
                        [weakSelf uploadImage:capturedImage];
                    };
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                });
            }];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:cancel];
    [self presentViewController:alertC animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *tempImage = info[UIImagePickerControllerOriginalImage];
    if (!tempImage) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self uploadImage:tempImage];
    });
    
}
-(void)uploadImage:(UIImage *)tempImage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        kShowLoading
    });
//    UIImage *fixImage = [self fixImageOrientation:tempImage];
    NSData *imageData = UIImageJPEGRepresentation(tempImage, 0.9);
    __block NSData *result = [self compressImageToTargetKB:300 oldData:imageData];
    [[PLPNetRequestManager plpJsonManager] UPLOADURL:@"twelveca/ocr" imageData:result paramsInfo:@{@"name":@"am",@"light":self.light} successBlk:^(id  _Nonnull responseObject) {
        kHideLoading
        NSDictionary *dic = responseObject[@"viustwelveNc"];
        AuthSectionModel *model = [self generateSectionMoodel:dic[@"xathtwelveosisNc"]];
        self.seiatwelvebstractNc = dic[@"paaltwelveympicsNc"];
        AuthSectionModel *sectionModel = self.dataSource.firstObject;
        AuthOptionalModel *first = sectionModel.xathtwelveosisNc.firstObject;
        first.showCamera = false;
        first.captureImage = tempImage;
        first.cellHeight = 330;
        self.nextButton.hidden = false;
        if(self.dataSource.count == 1) {
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    } failureBlk:^(NSError * _Nonnull error) {
    }];
}


- (NSData *)compressImageToTargetKB:(NSInteger )numOfKB oldData:(NSData *)data{
    UIImage *image = [[UIImage alloc] initWithData:data];
    CGFloat compressionQuality = 0.9f;
    CGFloat compressionCount = 0;
    NSData *imageData = UIImageJPEGRepresentation(image,compressionQuality);
    while (imageData.length >= 1000 * numOfKB && compressionCount < 15) {
        compressionQuality = compressionQuality * 0.9;
        compressionCount ++;
        imageData = UIImageJPEGRepresentation(image, compressionQuality);
    }
    return imageData;
}
-(void)tapItemIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    AuthSectionModel *temp = _dataSource[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    if (model.type == kAuthCellType_Select) {
        if (!model.showCamera) {
            return;
        }
        AuthSelectAlertView *view = [[AuthSelectAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        NSMutableArray *array = [NSMutableArray array];
        for (AuthItemModel *item in model.tubotwelvedrillNc) {
            [array addObject:item.roantwelveizeNc];
        }
        view.itemArray = array;
        view.tapItemBlk = ^(AuthItemModel * _Nonnull itemModel, NSInteger index) {
            model.selectedModel = model.tubotwelvedrillNc[index];
            model.captureImage = nil;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [view popAlertViewOnBottom];
    } else if (model.type == kAuthCellType_Date) {
        AuthDateAlertView *view = [[AuthDateAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 350)];
        view.model = model;
        view.tapItemBlk = ^(NSString * _Nonnull date) {
            model.valueStr = date;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [view popAlertViewOnBottom];
    }
}

#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf
    AuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AuthSectionModel *temp = _dataSource[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    cell.model = model;
    cell.tapItemBlk = ^(kAuthCellType type) {
        [weakSelf.view endEditing:YES];
        [weakSelf tapItemIndexPath:indexPath];
    };
    __weak AuthTableViewCell *weakCell = cell;
    cell.editCompletedBlk = ^(NSString * _Nonnull text) {
        model.valueStr = text;
    };
    cell.editValueChangeBlk = ^(NSString * _Nonnull text) {
        model.valueStr = text;
    };
    cell.tapCameraBlk = ^{
        [weakSelf tapCameraIndexPath:indexPath];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthSectionModel *temp = _dataSource[indexPath.section];
    AuthOptionalModel *model = temp.xathtwelveosisNc[indexPath.row];
    if (model.showCamera) {
        [self tapCameraIndexPath:indexPath];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AuthSectionModel *model = _dataSource[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 54)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, view.width - 30, 54)];
    view2.backgroundColor = kWhiteColor;
    [view addSubview:view2];
    
    if (model.more) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(view2.width - 60 - 10, (view2.height - 40) / 2.0, 60, 40);
        [button setTitle:@"More" forState:UIControlStateNormal];
        [button setTitleColor:kBlackColor_333333 forState:UIControlStateNormal];
        [button setImage:kImageName(@"auth_base_arrow_down") forState:UIControlStateNormal];
        [button setImage:kImageName(@"auth_base_arrow_up") forState:UIControlStateSelected];
        button.tag = 100 + section;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        CGFloat spacing = 2.0;
        CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        CGSize imageSize = button.imageView.frame.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width - spacing, 0, imageSize.width);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, -titleSize.width);
        [button addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = model.currentStatus;
        [view2 addSubview:button];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(14, (view2.height - 13) / 2.0, 3, 13)];
    lineView.backgroundColor = kBlueColor_0053FF;
    [view2 addSubview:lineView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (view2.height - 25) / 2.0, view2.width - 20, 25)];
    [view2 addSubview:titleLabel];
    
    titleLabel.text = [NSString stringWithFormat:@"%@",model.fldgtwelveeNc];
    [titleLabel pp_setPropertys:@[kBoldFontSize(18),kBlackColor_333333]];
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    if (model.more && !model.currentStatus) {
        corners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view2.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = path.CGPath;
    view2.layer.mask = maskLayer;
    return view;
}
-(void)moreButtonAction:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    AuthSectionModel *model = _dataSource[index];
    model.currentStatus = !model.currentStatus;
    button.selected = model.currentStatus;
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 12)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AuthSectionModel *model = _dataSource[section];
    if (model.more) {
        if (model.currentStatus) {
            return model.xathtwelveosisNc.count;
        }
        return 0;
    }
    return model.xathtwelveosisNc.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthSectionModel *sectionModel = _dataSource[indexPath.section];
    AuthOptionalModel *model = sectionModel.xathtwelveosisNc[indexPath.row];
    if (model.showEmail) {
        return model.cellHeightEmail;
    }
    return model.cellHeight;
}
-(void)BASE_GenerateSubview
{
    kWeakSelf
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
    BasicHeadView *progressView = [[BasicHeadView alloc] initWithFrame:CGRectMake(15, 16, _headerView.width - 2 * 15, 85) index:2];
    self.progressView = progressView;
    [_headerView addSubview:progressView];
    self.timerView = [[BasicTimerView alloc] initWithFrame:CGRectMake(15, 16 + progressView.bottom, progressView.width, 114)];
    _timerView.timerFinishBlk = ^{
        [weakSelf timerFinish];
    };
//    _headerView.backgroundColor = UIColor.redColor;
    _headerView.height = progressView.bottom + 12;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenW, kScreenH - kTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[AuthTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight + 16, 0);
    [self.view addSubview:self.tableView];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(14, kScreenH - 47 - kBottomSafeHeight - 16, kScreenW - 28, 47);
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    nextButton.backgroundColor = kBlueColor_0053FF;
    nextButton.layer.cornerRadius = nextButton.height / 2.0;
    [nextButton addTarget:self action:@selector(handleNextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    nextButton.hidden = YES;
    self.nextButton = nextButton;
    [self.view addSubview:nextButton];
}
-(void)timerFinish
{
    [self.timerView removeFromSuperview];
    self.headerView.height = self.progressView.bottom + 12;
    self.tableView.tableHeaderView = _headerView;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
