//
//  XTSelectView.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTSelectView.h"
#import "XTSelectViewCell.h"
#import "XTNoteModel.h"
#import "XTOcrNoteModel.h"

#define rowH 42

@interface XTSelectView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) XTNoteModel *indexModel;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray <XTNoteModel *>*list;

@end

@implementation XTSelectView

- (instancetype)initTit:(NSString *)tit arr:(NSArray <XTNoteModel *>*)arr {
    self = [super initWithFrame:CGRectMake(0, 0, XT_Screen_Width, XT_Screen_Height)];
    if(self) {
        self.list = arr;
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        
        UIView *view = [UIView xt_frame:CGRectMake(0, 0, self.width, 0) color:[UIColor whiteColor]];
        [self addSubview:view];
        
        UILabel *titLab = [UILabel xt_lab:CGRectMake(15, 0, view.width - 30, 45) text:tit font:XT_Font_M(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [view addSubview:titLab];
        [view addSubview:[UIView xt_frame:CGRectMake(15, titLab.height, titLab.width, 1) color:XT_RGB(0xE2E2E2, 1.0f)]];
        
        [view addSubview:self.tableView];
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titLab.frame) + 20, view.width, rowH * 4);
        
        UIButton *submit = [UIButton xt_btn:@"Confirm" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        submit.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        [view addSubview:submit];
        submit.frame = CGRectMake(20, CGRectGetMaxY(self.tableView.frame), view.width - 40, 48);
        submit.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(!self.indexModel) {
                if(self.closeBlock) {
                    self.closeBlock();
                }
                return [RACSignal empty];
            }
            if(self.sureBlock) {
                if([self.indexModel isKindOfClass:[XTOcrNoteModel class]]) {
                    self.sureBlock(@{
                        @"name":XT_Object_To_Stirng(self.indexModel.xt_name),
                        @"value":XT_Object_To_Stirng(self.indexModel.xt_type),
                        @"url":XT_Object_To_Stirng(((XTOcrNoteModel *)self.indexModel).xt_bg_img),
                    });
                }
                else{
                    self.sureBlock(@{
                        @"name":XT_Object_To_Stirng(self.indexModel.xt_name),
                        @"value":XT_Object_To_Stirng(self.indexModel.xt_type),
                    });
                }
                
            }
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        view.height = CGRectGetMaxY(submit.frame) + 20 + XT_Bottom_Height;
        view.y = self.height - view.height;
        [view xt_rect:view.bounds corners:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(15, 15)];
    }
    return self;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"XTSelectViewCell";
    XTSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[XTSelectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    XTNoteModel *model = self.list[indexPath.row];
    cell.model = model;
    cell.isSelect = model == self.indexModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowH;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexModel = self.list[indexPath.row];
    [self.tableView reloadData];
}

- (void)xt_value:(NSString *)value {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    for(XTNoteModel *model in self.list) {
        if([model.xt_type isEqualToString:value]) {
            self.indexModel = model;
            break;
        }
    }
    [self.tableView reloadData];
}

#pragma mark 列表
- (UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = rowH;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];//如果cell不能铺满屏幕，下面的分割线没有
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
