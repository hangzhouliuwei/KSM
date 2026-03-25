//
//  PUBEnvironmentManager.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/15.
//

#import "PUBEnvironmentManager.h"
#import "PUBRSATool.h"

@implementation PUBEnvironmentManager
SINGLETON_M(PUBEnvironmentManager)
@synthesize host = _host;

- (NSString *)host {
        NSString * value = [PUBCache getcacheYYObjectWithKey:PUBhost];
        if (value == nil || value.length == 0) {
            //_host = @"https://api.peraubagios.com";
            _host = @"http://api-pubi.ph.dev.ksmdev.top";
        } else {
            if([value hasPrefix:@"http"]||[value hasPrefix:@"https"]){
                _host = value;
            }else{
                _host = [PUBRSATool decryptContentWithContent:value publicKey:checkPublicKey];
            }
        }
   
    return _host;
}

- (void)setHost:(NSString *)host {
    if (host == nil || host.length == 0) {
        return;
    }
    
    [PUBCache cacheYYObject:host withKey:PUBhost];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}


@end
