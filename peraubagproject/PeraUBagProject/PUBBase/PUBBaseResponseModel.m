//
//  PUBBaseResponseModel.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import "PUBBaseResponseModel.h"

@implementation PUBBaseResponseModel
- (instancetype)initModelWithDic:(NSDictionary *)dic path:(NSString *)path {
    self = [super init];
    if (self) {
        self.path = path;
        self.code = [NSString stringWithFormat:@"%@",dic[@"paramorphism_eg"]];
        self.desc = dic[@"electioneer_eg"];
        self.success = [self.code isEqualToString:@"00"]||[self.code isEqualToString:@"0"];
        if ([PUBTools isBlankObject:dic[@"inequity_eg"]]) {
            return self;
        }
        if ([dic[@"inequity_eg"] isKindOfClass:[NSString class]]) {
            self.dataStr = NotNull(dic[@"inequity_eg"]);
        }
        if ([dic[@"inequity_eg"] isKindOfClass:[NSNumber class]]) {
            self.dataNumber = dic[@"inequity_eg"];
        }
        if ([dic[@"inequity_eg"] isKindOfClass:[NSArray class]]) {
            self.dataArr = dic[@"inequity_eg"];
        }
        if ([dic[@"inequity_eg"] isKindOfClass:[NSDictionary class]]) {
            self.dataDic = dic[@"inequity_eg"];
        }
    }
    return self;
}

@end
