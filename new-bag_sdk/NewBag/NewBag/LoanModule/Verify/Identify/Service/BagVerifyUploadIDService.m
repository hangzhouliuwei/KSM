//
//  BagVerifyUploadIDService.m
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import "BagVerifyUploadIDService.h"
#import "AFNetworking.h"
@interface BagVerifyUploadIDService()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *dic;

@end
@implementation BagVerifyUploadIDService

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
    return @"fca/ocr";
}
- (BOOL)isShowLoading
{
    return YES;
}
- (AFConstructingBlock)constructingBodyBlock {
    
    WEAKSELF
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(weakSelf.image, 0.25);
        NSString *formKey = @"am";
        NSString *name = @"imageFile.jpg";
        NSString *type = @"image/jpeg";

        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (NSString *)responseFileId {
    NSDictionary *dict = self.responseJSONObject[@"resultObject"];
    return dict[@"file_id"];
}
- (id)requestArgument
{
    return _dic ? : @{};
}
@end
