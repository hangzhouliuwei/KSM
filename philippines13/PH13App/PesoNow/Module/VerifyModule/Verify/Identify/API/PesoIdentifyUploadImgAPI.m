//
//  PesoIdentifyUploadImgAPI.m
//  PesoApp
//
//  Created by Jacky on 2024/9/13.
//

#import "PesoIdentifyUploadImgAPI.h"
#import <AFNetworking/AFNetworking.h>
@interface PesoIdentifyUploadImgAPI()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *dic;
@end
@implementation PesoIdentifyUploadImgAPI
- (id)initWithImage:(UIImage *)image param:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _image = image;
        _dic = dic;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return @"thirteenca/ocr";
}
- (BOOL)showLoading
{
    return YES;
}
- (AFConstructingBlock)constructingBodyBlock {
    
    WEAKSELF
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = [UIImage scaleBiteDataImage:weakSelf.image toKBite:1024];
        NSString *formKey = @"am";
        NSString *name = @"imageFile.jpg";
        NSString *type = @"image/jpeg";

        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)requestArgument
{
    return _dic ? : @{};
}
@end
