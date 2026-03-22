//
//  XTOCRVC.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTOCRVC.h"
#import "UIImage+XTCategory.h"
#import "XTUpApi.h"
#import "XTSetAltView.h"
#import <YFPopView/YFPopView.h>
#import "XTVerifyViewModel.h"
#import "XTLocationManger.h"
#import "XTVerifyHeadView.h"
#import "XTOcrModel.h"
#import "XTPhotoModel.h"
#import "XTListModel.h"
#import "XTPhotoCell.h"
#import "XTTextCell.h"
#import "XTSelectCell.h"
#import "XTSelectView.h"
#import "UIImage+XTCategory.h"
#import "XTRequestCenter.h"
#import "XTSelectDayView.h"

@interface XTOCRVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) XTVerifyViewModel *viewModel;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *submitBtn;
@property(nonatomic,copy) NSString *startTime;

@end

@implementation XTOCRVC

- (instancetype)initWithProductId:(NSString *)productId
                          orderId:(NSString *)orderId {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([NSString xt_isEmpty:[XTLocationManger xt_share].xt_longitude] || [NSString xt_isEmpty:[XTLocationManger xt_share].xt_latitude]) {
        [[XTLocationManger xt_share] xt_startLocation];
    }
    self.startTime = [[XTUtility xt_share] xt_nowTimeStamp];
    self.xt_title = @"Identifcation";
    self.xt_title_color = [UIColor whiteColor];
    self.view.backgroundColor = XT_RGB(0xF7F7F7, 1.0f);
    [self xt_UI];
    @weakify(self)
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [self.viewModel xt_photo:self.productId success:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self.tableView reloadData];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}
-(void)xt_UI {
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-XT_Bottom_Height-20);
        make.height.equalTo(@48);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.xt_navView.mas_bottom);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-20);
    }];
    
    self.tableView.tableHeaderView = [[XTVerifyHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 94) type:XT_Verify_Identifcation];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.viewModel.ocrModel.model){
        return 0;
    }
    if(section == 0){
        return 1;
    }
    if([NSString xt_isEmpty:self.viewModel.ocrModel.model.xt_relation_id]){
        return 0;
    }
    return self.viewModel.ocrModel.model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    if(indexPath.section == 0){
        static NSString *cellId = @"XTPhotoCell";
        XTPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[XTPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = self.viewModel.ocrModel.model;
        cell.block = ^(XTDicBlock block) {
            @strongify(self)
            [self selectRelation:self.viewModel.ocrModel.model.note tit:@"Please Select" value:self.viewModel.ocrModel.model.value block:block];
        };
        cell.photoBlock = ^{
            @strongify(self)
            [self goPhoto];
        };
        return cell;
    }
    XTListModel *model = self.viewModel.ocrModel.model.list[indexPath.row];
    if([model.xt_cate isEqualToString:@"AASIXTENBG"] || [model.xt_cate isEqualToString:@"AASIXTENBL"]){
        static NSString *cellId = @"XTPhotoCell";
        XTTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[XTTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = model;
        model.cell = cell;
        return cell;
    }
    static NSString *cellId = @"XTSelectCell";
    XTSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XTSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = model;
    model.cell = cell;
    cell.selectBlock = ^(XTDicBlock block) {
        @strongify(self)
        if([model.xt_code isEqualToString:@"birthday"]){
            [self xt_selectDay:model block:^(NSDictionary *dic) {
                if(block){
                    block(dic);
                }
                [self xt_nextCell:model];
            }];
            return;
        }
        [self selectRelation:model.noteList tit:model.xt_title value:model.value block:^(NSDictionary *dic) {
            @strongify(self)
            if(block){
                block(dic);
            }
            [self xt_nextCell:model];
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 325;
    }
    return 70;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView xt_frame:CGRectMake(0, 0, self.view.width, 20) color:self.view.backgroundColor];
    if(section == 0){
        [view xt_rect:view.bounds corners:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(20, 20)];
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(void)xt_nextCell:(XTListModel *)model {
    NSInteger index = [self.viewModel.ocrModel.model.list indexOfObject:model];
    if((index + 1) < self.viewModel.ocrModel.model.list.count) {
        UITableViewCell *nextCell = self.viewModel.ocrModel.model.list[index + 1].cell;
        if([nextCell isKindOfClass:[XTSelectCell class]]) {
            if(!((XTSelectCell *)nextCell).model.isHiddenCell && [NSString xt_isEmpty:((XTSelectCell *)nextCell).model.value]) {
                [((XTSelectCell *)nextCell) becomeFirst];
            }
        }
        else if([nextCell isKindOfClass:[XTTextCell class]] && [NSString xt_isEmpty:((XTTextCell *)nextCell).model.value]) {
            if(!((XTTextCell *)nextCell).model.isHiddenCell) {
                [((XTTextCell *)nextCell) becomeFirst];
            }
        }
    }
}

-(void)xt_selectDay:(XTListModel *)model block:(XTDicBlock)block{
    XTSelectDayView *view = [[XTSelectDayView alloc] initTit:model.xt_title];
    [view xt_value:model.value];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)selectRelation:(NSArray *)arr tit:tit value:(NSString *)value block:(XTDicBlock)block{
    XTSelectView *view = [[XTSelectView alloc] initTit:tit arr:arr];
    [view xt_value:value];
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:view];
    __weak YFPopView *weakView = popView;
    popView.animationStyle = YFPopViewAnimationStyleBottomToTop;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    view.closeBlock = ^{
        [weakView removeSelf];
    };
    view.sureBlock = ^(NSDictionary *dic) {
        if(block){
            block(dic);
        }
    };
}

-(void)goPhoto {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(self)
    UIAlertAction *picAct = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self xt_checkAuthorization:UIImagePickerControllerSourceTypeCamera block:^{
            @strongify(self)
            [self goImagePickerVC:UIImagePickerControllerSourceTypeCamera];
        }];
    }];
    [alertVC addAction:picAct];
    
    UIAlertAction *photoAct = [UIAlertAction actionWithTitle:@"Photo album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self xt_checkAuthorization:UIImagePickerControllerSourceTypePhotoLibrary block:^{
            @strongify(self)
            [self goImagePickerVC:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
    }];
    [alertVC addAction:photoAct];
    
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancelAct];
    [self xt_presentViewController:alertVC animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
}

-(void)xt_checkAuthorization:(UIImagePickerControllerSourceType)sourceType block:(XTBlock)block{
    if(sourceType == UIImagePickerControllerSourceTypeCamera) {
        [XTUtility xt_checkAVCaptureAuthorization:^(BOOL resultBool) {
            if(resultBool) {
                block();
            }
        }];
    }
    else if(sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [XTUtility xt_checkAVCaptureAuthorization:^(BOOL resultBool) {
            if(resultBool) {
                block();
            }
        }];
    }
}

-(void)goImagePickerVC:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    [self xt_presentViewController:imagePicker animated:YES completion:nil modalPresentationStyle:UIModalPresentationFullScreen];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    ///最大1.5M
    NSData *imgData = [originalImage xt_compressWithLengthLimit:1.5f * 1024.0f * 1024];
    NSString *path = [[XTUtility xt_share] xt_saveImg:imgData path:@""];
    [self goUPLoad:path];
    [picker dismissViewControllerAnimated:YES completion:^{

    }];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)goUPLoad:(NSString *)path {
    @weakify(self)
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    [self.viewModel xt_upload_ocr_image:path typeId:self.viewModel.ocrModel.model.value success:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self.tableView reloadData];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)xt_back {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    XTSetAltView *altView = [[XTSetAltView alloc] initWithAlt:@"Are you sure you want to\n leave?"];
    altView.center = self.view.center;
    YFPopView *popView = [[YFPopView alloc] initWithAnimationView:altView];
    popView.animationStyle = YFPopViewAnimationStyleFade;
    popView.autoRemoveEnable = YES;
    [popView showPopViewOn:self.view];
    __weak YFPopView *weakView = popView;
    @weakify(self)
    altView.sureBlock = ^{
        [weakView removeSelf];
        weakView.didDismiss = ^(YFPopView *popView) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        };
    };
    altView.cancelBlock = ^{
        [weakView removeSelf];
    };
}

-(void)goSubmit {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(XTListModel *model in self.viewModel.ocrModel.model.list) {
        if(!model.xt_optional && [NSString xt_isEmpty:model.value]) {
            [XTUtility xt_showTips:model.xt_subtitle view:self.view];
            return;
        }
        if(![NSString xt_isEmpty:model.value]) {
            [dic setObject:XT_Object_To_Stirng(model.value) forKey:XT_Object_To_Stirng(model.xt_code)];
        }
    }
    [[XTRequestCenter xt_share] xt_device];
    
    [dic setObject:XT_Object_To_Stirng(self.productId) forKey:@"lietsixusNc"];
    [dic setObject:XT_Object_To_Stirng(self.viewModel.ocrModel.model.xt_relation_id) forKey:@"seiasixbstractNc"];
    
    NSDictionary *point = @{
        @"deamsixatoryNc":XT_Object_To_Stirng(self.startTime),
        @"munisixumNc":XT_Object_To_Stirng(self.productId),
        @"hyrasixrthrosisNc":@"24",
        @"boomsixofoNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_latitude),
        @"unulsixyNc":XT_Object_To_Stirng([[XTUtility xt_share] xt_nowTimeStamp]),
        @"cacosixtomyNc":XT_Object_To_Stirng([XTDevice xt_share].xt_idfv),
        @"unevsixoutNc":XT_Object_To_Stirng([XTLocationManger xt_share].xt_longitude),
    };
    [dic setObject:point forKey:@"point"];
    [XTUtility xt_showProgress:self.view message:@"loading..."];
    @weakify(self)
    [self.viewModel xt_photo_next:dic success:^(NSString *str) {
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
        [self goNext:str];
    } failure:^{
        @strongify(self)
        [XTUtility xt_atHideProgress:self.view];
    }];
}

-(void)goNext:(NSString *)str{
//    if([XTUserManger xt_share].xt_user.xt_is_aduit){
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
    @weakify(self)
    if([NSString xt_isEmpty:str]) {
        [XTUtility xt_showProgress:self.view message:@"loading..."];
        [self.viewModel xt_push:self.orderId success:^(NSString *str) {
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
            [[XTRoute xt_share] goHtml:str success:^(BOOL success) {
                @strongify(self)
                if(success){
                    [self xt_removeSelf];
                }
            }];
            
        } failure:^{
            @strongify(self)
            [XTUtility xt_atHideProgress:self.view];
        }];
        return;
    }
    [[XTRoute xt_share] goVerifyItem:str productId:self.productId orderId:self.orderId success:^(BOOL success) {
        @strongify(self)
        if(success){
            [self xt_removeSelf];
        }
    }];
}

-(void)xt_removeSelf {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [arr removeObject:self];
    self.navigationController.viewControllers = arr;
}

- (XTVerifyViewModel *)viewModel {
    if(!_viewModel){
        _viewModel = [XTVerifyViewModel new];
    }
    return _viewModel;
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 50;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    if(!_submitBtn) {
        _submitBtn = [UIButton xt_btn:@"Next" font:XT_Font_B(24) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        _submitBtn.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        @weakify(self)
        _submitBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self goSubmit];
            return [RACSignal empty];
        }];
    }
    return _submitBtn;
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
