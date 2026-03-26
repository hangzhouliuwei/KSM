//
//  PUBDomainManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2024/5/22.
//

#import "PUBDomainManager.h"
#import "PUBRSATool.h"
#import "PUBEnvironmentManager.h"

static NSString * const checkImageUrl = @"https://pubipp.s3.ap-southeast-1.amazonaws.com/a.jpg";
static NSString *const checkDomainNameUrl1 = @"https://ipbupjs.s3.ap-southeast-1.amazonaws.com/pubip.json";
static NSString *const checkDomainNameUrl2 = @"https://prfjngnrkk.blob.core.windows.net/ppubieryg/pubip.json";
@interface PUBDomainManager ()
@property(nonatomic, strong) UIImageView *domainImageView;
@end

@implementation PUBDomainManager
SINGLETON_M(PUBDomainManager)

-(void)domainNameCheckResult:(ReturnBoolBlock)result
{
    WEAKSELF
    [HttPPUBRequest getWithPath:checkPing params:@{} success:^(NSDictionary * _Nonnull responseDataDic, PUBBaseResponseModel * _Nonnull model) {
        if(result){
            result(NO);
        }
        
    } failure:^(NSError * _Nonnull error) {
        STRONGSELF
        [strongSelf checkDomainNameImageResult:^(BOOL value) {
            if(result){
                result(value);
            }
            
        }];
        
    } showLoading:YES];
    
}

- (void)checkDomainNameImageResult:(ReturnBoolBlock)result
{
    NSString *imageUrl = checkImageUrl;
    WEAKSELF
    [[SDImageCache sharedImageCache] removeImageForKey:imageUrl withCompletion:^{
        STRONGSELF
        [strongSelf.domainImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image){
                if(result){
                    result(NO);
                }
            }else{
                [strongSelf checkDomainNameResult:^(BOOL value) {
                    if(result){
                        result(value);
                    }
                }];
            }
           
        }];
    }];
}

- (void)checkDomainNameResult:(ReturnBoolBlock)result
{
    WEAKSELF
    [self checkTwoDomainNameUrl:checkDomainNameUrl1 Result:^(BOOL value1, BOOL value2) {
        STRONGSELF
        if(value1){
            if(result){
                result(value2);
            }
        }else{
            [strongSelf checkTwoDomainNameUrl:checkDomainNameUrl2 Result:^(BOOL value1, BOOL value2) {
                if(value1){
                    if(result){
                        result(value2);
                    }
                }else{
                    if(result){
                       result(NO);
                   }
                }
            }];
        }
    
    }];
    
}


- (void)checkTwoDomainNameUrl:(NSString*)url Result:(ReturnTwoBoolBlock)result
{

    [self checkDomainNameUrl:url Request:^(BOOL value1, BOOL value2) {
        if(result){
            result(value1,value2);
        }
    }];
}

-(void)checkDomainNameUrl:(NSString*)url Request:(ReturnTwoBoolBlock)result
{
    if([PUBTools isBlankString:url]){
        if(result){
            result(NO,NO);
        }
    }
    WEAKSELF
    [HttPPUBRequest getDomainNameWithUrl:url params:@{} success:^(NSDictionary * _Nonnull responseDataDic) {
        STRONGSELF
        if(responseDataDic && [responseDataDic isKindOfClass:[NSDictionary class]]){
            NSString *urlStr = responseDataDic[@"url"];
            NSLog(@"lw=======>urlStr%@",urlStr);
            if([PUBTools isBlankString:urlStr]){
                if(result){
                    result(NO,NO);
                }
                return;
            }
           NSString *DomainName = [PUBRSATool decryptContentWithContent:urlStr publicKey:checkPublicKey];
            if(result){
                NSLog(@"lw========>url%@%@", PUBEnvironment.host,DomainName);
                result(YES,[DomainName isEqualToString:PUBEnvironment.host] ? NO : YES);
            }
            [strongSelf upDataDomainName:urlStr];
        }
    } failure:^(NSError * _Nonnull error) {
        if(result){
            result(NO,NO);
        }
        
    } showLoading:YES];
    
}

- (void)upDataDomainName:(NSString*)domainName
{
    if([PUBTools isBlankString:domainName])return;
    NSLog(@"lw=======>%@",domainName);
    [PUBCache cacheYYObject:domainName withKey:PUBhost];
    [HttPPUBRequest resetNetworkType];
}

#pragma mark - lazy

-(UIImageView *)domainImageView{
    if(!_domainImageView){
        _domainImageView = [[UIImageView alloc] init];
    }
    return _domainImageView;
}

@end
