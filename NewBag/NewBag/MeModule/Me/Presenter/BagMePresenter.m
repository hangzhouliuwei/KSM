//
//  BagMePresenter.m
//  NewBag
//
//  Created by Jacky on 2024/3/27.
//

#import "BagMePresenter.h"
#import "BagMeService.h"
#import "BagMeModel.h"
@interface BagMePresenter()

@end
@implementation BagMePresenter

- (void)sendGetMeDetailRequest
{
    BagMeService *service = [BagMeService new];
    [service startWithCompletionBlockWithSuccess:^(__kindof BagBaseRequest * _Nonnull request) {
        if (request.response_code == 0) {
            NSDictionary *data = request.responseObject;
            BagMeModel *model = [BagMeModel yy_modelWithDictionary:data[@"viusfourteenNc"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUIWithModel:)]) {
                [self.delegate updateUIWithModel:model];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
@end
