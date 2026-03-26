//
//  XTUpApi.m
//  XTApp
//
//  Created by xia on 2024/7/11.
//

#import "XTUpApi.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@interface XTUpApi ()

@property(nonatomic,copy) NSString *path;
@property(nonatomic,copy) NSString *typeId;

@end

@implementation XTUpApi

- (instancetype)initPath:(NSString *)path typeId:(NSString *)typeId{
    self = [super init];
    if(self) {
        self.path = path;
        self.typeId = typeId;
    }
    return self;
}

- (NSString *)requestUrl {
    return [self urlAppendQueryParameterToUrl:@"sixca/ocr"];
}

- (AFConstructingBlock)constructingBodyBlock
{
    return ^(id<AFMultipartFormData> formData) {
        NSString *fileName = [self.path lastPathComponent];
        NSString *name = @"am";
        NSString *type = @"image/jpeg";
        NSURL *url = [NSURL fileURLWithPath:self.path];
        [formData appendPartWithFileURL:url name:name fileName:fileName mimeType:type error:nil];
    };
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
- (id)requestArgument{
    return @{
        @"light":XT_Object_To_Stirng(self.typeId),
    };
}

@end
