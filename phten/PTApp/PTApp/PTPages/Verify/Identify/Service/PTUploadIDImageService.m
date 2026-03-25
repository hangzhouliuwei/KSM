//
//  PTUploadIDImageService.m
//  PTApp
//
//  Created by Jacky on 2024/8/21.
//

#import "PTUploadIDImageService.h"

#import "AFNetworking.h"
@interface PTUploadIDImageService()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *dic;

@end
@implementation PTUploadIDImageService

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
    return PTUploadOcr;
}
- (BOOL)isShowLoading
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

- (NSString *)responseFileId {
    NSDictionary *dict = self.responseJSONObject[@"resultObject"];
    return dict[@"file_id"];
}
- (id)requestArgument
{
    return _dic ? : @{};
}
@end

