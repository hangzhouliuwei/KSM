//
//  PesoOrderVM.m
//  PesoApp
//
//  Created by Jacky on 2024/9/18.
//

#import "PesoOrderVM.h"
#import "PesoOrderAPI.h"
#import "PesoOrderModel.h"
@interface PesoOrderVM()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSMutableArray <PesoOrderListModel *>*dataArray;

@end
@implementation PesoOrderVM
- (instancetype)init
{
    if (self = [super init]) {
        _page = 1;
    }
    return self;
}
- (void)loadGetOrderRequestFirstPage:(BOOL)first tag:(NSInteger)tag success:(void (^)(id _Nonnull))success fail:(void (^)(void))fail
{
    if (first) {
        _page = 1;
        [self.dataArray removeAllObjects];
    }else{
        _page +=1;
    }
    PesoOrderAPI *service = [[PesoOrderAPI alloc] initWithNumber:tag page:_page pageSize:20];
    [service startWithCompletionBlockWithSuccess:^(__kindof PesoBaseAPI * _Nonnull request) {
        if (request.responseCode == 0) {
            PesoOrderModel *model = [PesoOrderModel yy_modelWithDictionary: request.responseDic];
            [self.dataArray addObjectsFromArray:model.xaththirteenosisNc];
            //            if (tag == 6) {
            //                PesoOrderListModel *xx = [PesoOrderListModel new];
            //                xx.moosthirteenyllabismNc = @"aaa";
            //                xx.istathirteencNc = @"$33333";
            //                xx.laarthirteenckianNc = @"Outstanding";
            //                xx.imotthirteenenceNc = @"#ffffff";
            //                xx.maanthirteenNc = @"Refund";
            //                xx.exerthirteeniencelessNc = @"Aug 22,2024";
            //                xx.shkathirteenriNc = @"#fd5353";
            //                [self.dataArray addObject:xx];
            //            }
            
            
            BOOL hiddenFooter = model.xaththirteenosisNc.count < 20 ? YES : NO;
            RACTuple *tuple = [[RACTuple alloc] init];
            tuple = [tuple tupleByAddingObject:self.dataArray];
            tuple = [tuple tupleByAddingObject:@(hiddenFooter)];
            if (success) {
                success(tuple);
            }
            NSLog(@"");
        }else{
            [PesoUtil showToast:request.responseMessage];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (fail) {
            fail();
        }
//        [self.delegate endRefresh];
//        [self.delegate hiddenFooter:YES];

    }];
}
- (NSMutableArray<PesoOrderListModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
