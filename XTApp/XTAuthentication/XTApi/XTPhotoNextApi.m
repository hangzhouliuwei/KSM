//
//  XTPhotoNextApi.m
//  XTApp
//
//  Created by xia on 2024/9/10.
//

#import "XTPhotoNextApi.h"

@interface XTPhotoNextApi()

@property(nonatomic,strong) NSDictionary *dic;

@end

@implementation XTPhotoNextApi


- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if(self) {
        self.dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/photo_next"];
}

-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return self.dic;
}

@end
