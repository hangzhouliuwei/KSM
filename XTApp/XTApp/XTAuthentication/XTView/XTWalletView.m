//
//  XTWalletView.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTWalletView.h"
#import "XTBankItemModel.h"
#import "XTWalletCell.h"
#import "XTNoteModel.h"

@interface XTWalletView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIView *footView;

@end

@implementation XTWalletView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        self.tableView.tableHeaderView = self.headView;
        self.tableView.tableFooterView = self.footView;
    }
    return self;
}

- (void)setModel:(XTBankItemModel *)model {
    _model = model;
    self.textField.text = model.xt_account;
    if([NSString xt_isEmpty:model.xt_channel]){
        self.indexModel = model.note.firstObject;
    }
    else {
        for(XTNoteModel *item in model.note) {
            if([item.xt_type isEqualToString:model.xt_channel]) {
                self.indexModel = item;
                break;
            }
        }
    }
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.note.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XTWalletCell";
    XTWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XTWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    XTNoteModel *model = self.model.note[indexPath.row];
    cell.model = model;
    cell.isSelect = self.indexModel == model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XTNoteModel *model = self.model.note[indexPath.row];
    self.indexModel = model;
    [self.tableView reloadData];
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)headView {
    if(!_headView) {
        UIView *view = [UIView xt_frame:CGRectMake(0, 0, XT_Screen_Width, 25) color:[UIColor clearColor]];
        
        UILabel *lab = [UILabel xt_lab:CGRectZero text:@"Select your recipient E-wallet" font:XT_Font_SD(15) textColor:XT_RGB(0x333333, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [view addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(14);
            make.top.equalTo(view);
            make.height.equalTo(@21);
        }];
        
        _headView = view;
    }
    return _headView;
}

- (UIView *)footView {
    if(!_footView) {
        UIView *view = [UIView xt_frame:CGRectMake(0, 0, XT_Screen_Width, 0) color:[UIColor clearColor]];
        UILabel *lab = [UILabel xt_lab:CGRectMake(14, 8, view.width - 28, 21) text:@"E-wallet Account" font:XT_Font(15) textColor:XT_RGB(0x01A652, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        [view addSubview:lab];
        
        UITextField *textField = [UITextField xt_textField:NO placeholder:@"Please enter your E-wallet account" font:XT_Font(15) textColor:[UIColor blackColor] withdelegate:self];
        [view addSubview:textField];
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 10;
        textField.layer.borderColor = XT_RGB(0xdddddd, 1.0f).CGColor;
        textField.layer.borderWidth = 1;
        textField.frame = CGRectMake(14, CGRectGetMaxY(lab.frame) + 6, lab.width, 48);
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = [UIView xt_frame:CGRectMake(0, 0, 10, 48) color:[UIColor clearColor]];
        self.textField = textField;
        
        UILabel *subLab = [UILabel xt_lab:CGRectMake(14, CGRectGetMaxY(textField.frame) + 12, lab.width, 0) text:@"Please confirm the account belongs to yourself and be correct, it will be used as a receipt account to receice the funds." font:XT_Font(11) textColor:XT_RGB(0x999999, 1.0f) alignment:NSTextAlignmentLeft tag:0];
        subLab.numberOfLines = 0;
        [view addSubview:subLab];
        subLab.height = [subLab sizeThatFits:CGSizeMake(subLab.width, 0)].height;
        
        view.height = CGRectGetMaxY(subLab.frame) + 10;
        _footView = view;
    }
    return _footView;
}

@end
