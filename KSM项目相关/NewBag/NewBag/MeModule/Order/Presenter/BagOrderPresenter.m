//
//  BagOrderPresenter.m
//  NewBag
//
//  Created by Jacky on 2024/3/31.
//

#import "BagOrderPresenter.h"
#import "BagOrderService.h"
#import "BagOrderModel.h"
@interface BagOrderPresenter()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSMutableArray <BagOrderListModel *>*dataArray;

@end
@implementation BagOrderPresenter
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
    BagOrderService *service = [[BagOrderService alloc] initWithState:tag page:_page pageSize:20];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            [self.delegate endRefresh];
            NSDictionary *data = request.responseObject;
            BagOrderModel *model = [BagOrderModel yy_modelWithDictionary:data[@"viusfourteenNc"]];
            [self.delegate hiddenFooter:model.xathfourteenosisNc.count < 20 ? YES : NO];
            if (self.delegate &&  [self.delegate respondsToSelector:@selector(updateUIWithDataArray:)]) {
                //刷新 UI
                [self.dataArray addObjectsFromArray:model.xathfourteenosisNc];
                [self.delegate updateUIWithDataArray:self.dataArray];
            }
            NSLog(@"");
        }else{
            [self.delegate showToast:request.response_message duration:1.5f];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.delegate endRefresh];
        [self.delegate hiddenFooter:YES];

    }];
}
- (NSMutableArray<BagOrderListModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
