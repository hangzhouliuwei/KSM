//
//  PesoBankAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoBankAPI.h"

@implementation PesoBankAPI
{
    NSString *_product_id;
}
- (instancetype)initWithData:(NSString *)data
{
if (self = [super init]) {
    _product_id = data;
}
return self;
}
- (NSString *)requestUrl {
  return @"thirteenca/card";
}
- (BOOL)showLoading
{
return YES;
}
- (YTKRequestMethod)requestMethod {
return YTKRequestMethodPOST;
}

- (id)requestArgument {
return @{
    @"lietthirteenusNc":(_product_id),
};
}
@end
