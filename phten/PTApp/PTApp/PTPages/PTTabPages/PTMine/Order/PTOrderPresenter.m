//
//  PTOrderPresenter.m
//  PTApp
//
//  Created by Jacky on 2024/8/28.
//

#import "PTOrderPresenter.h"
#import "PTOrderAPI.h"
#import "PTOrderModel.h"
@interface PTOrderPresenter()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSMutableArray <PTOrderListModel *>*dataArray;

@end
@implementation PTOrderPresenter
- (instancetype)init
{
    if (self = [super init]) {
        _page = 1;
    }
    return self;
}
- (void)sendGetOrderRequestFirstPage:(BOOL)first tag:(NSInteger)tag{
    if (first) {
        _page = 1;
        [self.dataArray removeAllObjects];
    }else{
        _page +=1;
    }
    PTOrderAPI *service = [[PTOrderAPI alloc] initWithNumber:tag page:_page pageSize:20];
    [service startWithCompletionBlockWithSuccess:^(__kindof PTBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate endRefresh];
            PTOrderModel *model = [PTOrderModel yy_modelWithDictionary: request.response_dic];
            [self.delegate hiddenFooter:model.xatenthosisNc.count < 20 ? YES : NO];
            if (self.delegate &&  [self.delegate respondsToSelector:@selector(updateUIWithDataArray:)]) {
                //刷新 UI
                [self.dataArray addObjectsFromArray:model.xatenthosisNc];
                [self.delegate updateUIWithDataArray:self.dataArray];
            }
            NSLog(@"");
        }else{
            [self.delegate showToast:request.response_message duration:2.0];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.delegate endRefresh];
        [self.delegate hiddenFooter:YES];

    }];
}
- (NSMutableArray<PTOrderListModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

